# Set of Scripts to view K8s resources on TAS4K8s

To use the following scripts you will need the following. These scripts are tested against MAC OSX only but should work on any linux distrubution.

* TAS4K8s installed - [Download TAS4K8s!](https://network.pivotal.io/products/tas-for-kubernetes/)
* kp CLI - [Download kp!](https://network.pivotal.io/products/build-service/)
* kubectl CLI - [Download kubectl!](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* kapp (Kubernetes Application Management Tool) - [Download kapp!](https://get-kapp.io/)

### what-on-k8s-app-name.sh

The following example shows how to see what an app from "**cf app {name}**" looks like on K8s in terms of what is created for each "cf push" of an app instance.

Parameters:

* application name: required

Usage Example:

```bash
$ ./what-on-k8s-app-name.sh my-go-app

Using application name: my-go-app
Using application GUID as: aae5b272-600b-4e79-ac58-62685089e45d

Pods ...

NAME                                 READY   STATUS    RESTARTS   AGE
my-go-app-development-a338727770-0   2/2     Running   0          142m
my-go-app-development-a338727770-1   2/2     Running   0          47m

Service ...

NAME                                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
s-bc265dea-f9b5-4b2c-8c09-9705c4b86ee2   ClusterIP   10.100.200.152   <none>        8080/TCP   143m

Stateful Set ...

NAME                               READY   AGE
my-go-app-development-a338727770   2/2     142m

Build ...

NAME                                                 IMAGE                                                                                                                                                            SUCCEEDED
aae5b272-600b-4e79-ac58-62685089e45d-build-1-57m2g   harbor.run.haas-236.pez.pivotal.io/tas-app-images/aae5b272-600b-4e79-ac58-62685089e45d@sha256:65ee3bd9d44fd830529080c34b8eb26addf18d8118f96c62500eccfb680e5d84   True
```

### access-app-logs-from-istio-proxy-container.sh

View the logs from the envoy proxy container that exists as part of the application pod

Parameters:

* application name: required
  
Usage Example:

```bash
$ ./access-app-logs-from-istio-proxy-container.sh my-go-app
2020-08-17T04:50:11.547181Z	info	Envoy proxy is ready
[Envoy (Epoch 0)] [2020-08-17 04:58:44.849][13][warning][config] [bazel-out/k8-opt/bin/external/envoy/source/common/config/_virtual_includes/grpc_stream_lib/common/config/grpc_stream.h:91] gRPC config stream closed: 13,
[Envoy (Epoch 0)] [2020-08-17 05:03:46.005][13][warning][config] [bazel-out/k8-opt/bin/external/envoy/source/common/config/_virtual_includes/grpc_stream_lib/common/config/grpc_stream.h:91] gRPC config stream closed: 13,
...

```

### host-route-check-istio-ip.sh

Check the IP address used for the ingress gateway is configured against the application route.

Parameters:

* application route: required
  
Usage Example:

```bash
$ ./host-route-check-istio-ip.sh my-go-app.apps.system.run.haas-236.pez.pivotal.io
my-go-app.apps.system.run.haas-236.pez.pivotal.io has address 10.195.75.155
```

### logs-istio-ingressgateway.sh

Inspect the logs of the ingress gateway. 

Parameters:

* None
  
Usage Example:

```bash
$ ./logs-istio-ingressgateway.sh
Target cluster 'https://strawberry.run.haas-236.pez.pivotal.io:8443' (nodes: ed8a7c50-0b02-4413-b76f-ac4d216f4557, 6+)

# starting tailing 'istio-ingressgateway-jv9w7 > ingress-sds' logs
istio-ingressgateway-jv9w7 > ingress-sds | 2020-08-14T01:15:47.073127Z	warn	secretFetcherLog	failed load server cert/key pair from secret system-registry-credentials: server cert or private key is empty
istio-ingressgateway-jv9w7 > ingress-sds | 2020-08-14T01:15:47.103950Z	info	sdsServiceLog	SDS gRPC server for ingress gateway controller starts, listening on "/var/run/ingress_gateway/sds"
istio-ingressgateway-jv9w7 > ingress-sds |
istio-ingressgateway-jv9w7 > ingress-sds | 2020-08-14T01:15:47.104012Z	info	sdsServiceLog	Start SDS grpc server for ingress gateway proxy
istio-ingressgateway-jv9w7 > ingress-sds | 2020-08-14T01:15:47.115615Z	info	citadel agent monitor has started.
istio-ingressgateway-jv9w7 > ingress-sds | 2020-08-14T01:15:47.121538Z	info	monitor	Monitor server started.
...
```

### view-buildpacks.sh

Viw the current buildpacks available as part of TAS4K8s. This requires "kp" CLI to be installed

Parameters:

* None
  
Usage Example:

```bash
$ ./view-buildpacks.sh
NAME                  READY
cf-buildpack-store    True

BUILDPACKAGE ID                  VERSION
paketo-buildpacks/java           1.14.0
paketo-buildpacks/go             0.0.8
paketo-buildpacks/dotnet-core    0.0.5
paketo-buildpacks/php            0.0.7
paketo-buildpacks/nodejs         0.0.3
paketo-buildpacks/procfile       1.3.8
```

### istio-virtualservice.sh

Inspect the cirtual services created for every application route which includes internal applications created as part of TAS4K8s installs

Parameters:

* None
  
Usage Example:

```bash
$ ./istio-virtualservice.sh
NAME                                                                  GATEWAYS                           HOSTS                                                     AGE
vs-1e8791159d4b43f76e2196d00d30bde2d329d6a919328cd64f83d7584941e61e   [cf-system/istio-ingressgateway]   [search-server.system.run.haas-236.pez.pivotal.io]        3d4h
vs-4be54d2fcd62bde980d0c841fb17961743cd0ee491a29088e46bc73f051bca5f   [cf-system/istio-ingressgateway]   [console.system.run.haas-236.pez.pivotal.io]              3d4h
vs-5077e47207094e035908c0b73787ed6378a85fea84fdce364f53c7b3402d5c2b   [cf-system/istio-ingressgateway]   [invitations.system.run.haas-236.pez.pivotal.io]          3d4h
vs-664570b0be12a3a6427ca40bf5630f58488580b0a4d117a5dcb9e85215255c5a   [cf-system/istio-ingressgateway]   [my-go-app.apps.system.run.haas-236.pez.pivotal.io]       161m
vs-adc196b2eb542d38e13d6518c3bbeeca5f6ba6950c44bb18646b4a2fd9293c2c   [cf-system/istio-ingressgateway]   [test-node-app.apps.system.run.haas-236.pez.pivotal.io]   3d
```

### inspect-cf-app.sh

Get detailed output of what was installed for the kapp "cf" and current status

Parameters:

* None
  
Usage Example:

```bash
 $ ./inspect-cf-app.sh 
Target cluster 'https://strawberry.run.haas-236.pez.pivotal.io:8443' (nodes: ed8a7c50-0b02-4413-b76f-ac4d216f4557, 6+)

Resources in app 'cf'

Namespace             Name                                                                 Kind                            Owner    Conds.  Rs  Ri         Age  
(cluster)             adapters.config.istio.io                                             CustomResourceDefinition        kapp     2/2 t   ok  -          3d  
^                     attributemanifests.config.istio.io                                   CustomResourceDefinition        kapp     2/2 t   ok  -          3d  
^                     authorizationpolicies.security.istio.io                              CustomResourceDefinition        kapp     2/2 t   ok  -          3d  
^                     build-service                                                        Namespace                       kapp     -       ok  -          3d  
^                     build-service-webhook                                                MutatingWebhookConfiguration    kapp     -       ok  -          3d  
^                     builders.build.pivotal.io                                            CustomResourceDefinition        kapp     2/2 t   ok  -          3d  
^                     builds.build.pivotal.io                                              CustomResourceDefinition        kapp     2/2 t   ok  -          3d  
^                     cf-api-controllers                                                   ClusterRole                     kapp     -       ok  -          3d  
^                     cf-blobstore                                                         Namespace                       kapp     -       ok  -          3d  
^                     cf-buildpack-store                                                   Store                           kapp     1/1 t   ok  -          3d  
^                     cf-db                                                                Namespace                       kapp     -       ok  -          3d  
^                     cf-system                                                            Namespace                       kapp     -       ok  -          3d  
^                     cf-workloads                                                         Namespace                       kapp     -       ok  -          3d  
^                     cf-workloads-app-psp                                                 PodSecurityPolicy               kapp     -       ok  -          3d  

....

```

<hr size="2" />
Pas Apicella [pasa at vmware.com] is an Advisory Application Platform Architect at VMware APJ
