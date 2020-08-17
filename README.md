# Set of Scripts to view K8s resources on TAS4K8s

## what-on-k8s-app-name.sh

Usage Example

```
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

## access-app-logs-from-istio-proxy-container.sh

Usage Example

```
$ ./access-app-logs-from-istio-proxy-container.sh my-go-app
2020-08-17T04:50:11.547181Z	info	Envoy proxy is ready
[Envoy (Epoch 0)] [2020-08-17 04:58:44.849][13][warning][config] [bazel-out/k8-opt/bin/external/envoy/source/common/config/_virtual_includes/grpc_stream_lib/common/config/grpc_stream.h:91] gRPC config stream closed: 13,
[Envoy (Epoch 0)] [2020-08-17 05:03:46.005][13][warning][config] [bazel-out/k8-opt/bin/external/envoy/source/common/config/_virtual_includes/grpc_stream_lib/common/config/grpc_stream.h:91] gRPC config stream closed: 13,
...

```

## host-route-check-istio-ip.sh

Usage Example

```
$ ./host-route-check-istio-ip.sh my-go-app.apps.system.run.haas-236.pez.pivotal.io
my-go-app.apps.system.run.haas-236.pez.pivotal.io has address 10.195.75.155
```

## logs-istio-ingressgateway.sh

Usage Example

```
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

## view-buildpacks.sh

Usage Example

```
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

<hr size="2" />
Pas Apicella [pasa at vmware.com] is an Advisory Application Platform Architect at VMware APJ