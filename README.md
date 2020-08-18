# Set of Scripts to view K8s resources on TAS4K8s

To use the following scripts you will need the following. These scripts are tested against MAC OSX only but should work on any linux distrubution.

* TAS4K8s installed - [Download TAS4K8s!](https://network.pivotal.io/products/tas-for-kubernetes/)
* kp CLI - [Download kp!](https://network.pivotal.io/products/build-service/)
* kubectl CLI - [Download kubectl!](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* kapp (Kubernetes Application Management Tool) - [Download kapp!](https://get-kapp.io/)
* CF CLI (Cloud Foundry CLI) - [Download kapp!](https://get-kapp.io/)

![alt tag](https://i.ibb.co/SKZdjmT/apps-man-tas4k8s.png)

_All scripts will show output and exit if you wish to tail log output then you can use "-f" flag for kubectl and kapp commands in the scripts_

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

Get detailed output of what was installed for the kapp "**cf**" and current status

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

### view-api-resources-for-app.sh

View all resources 

Parameters:

* application name: required
  
Usage Example:

```bash
$ ./view-api-resources-for-app.sh test-node-app

Using application name: test-node-app
Using application GUID as: 5eaa3aad-3c98-469e-bebb-41074e49244e

*** This script can take some time to complete ***

NAME                                               ENDPOINTS          AGE
endpoints/s-7899e4a1-abbd-42d3-ae58-e8e2dc9c13c9   172.24.10.2:8080   3d18h
NAME                                         READY   STATUS    RESTARTS   AGE
pod/test-node-app-development-80a4f91cea-0   2/2     Running   0          3d18h
NAME                                             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/s-7899e4a1-abbd-42d3-ae58-e8e2dc9c13c9   ClusterIP   10.100.200.49   <none>        8080/TCP   3d18h
NAME                                                                     CONTROLLER                                              REVISION   AGE
controllerrevision.apps/test-node-app-development-80a4f91cea-65649f9fc   statefulset.apps/test-node-app-development-80a4f91cea   1          3d18h
NAME                                                    READY   AGE
statefulset.apps/test-node-app-development-80a4f91cea   1/1     3d18h
NAME                                                               AGE
podmetrics.metrics.k8s.io/test-node-app-development-80a4f91cea-0   0s

...

```

### cf-api-server-logs.sh

Inspect logs from the cf-api-server pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
$ ./cf-api-server-logs.sh 
{"timestamp":"2020-08-18T05:13:26.497412807Z","message":"Started GET \"/v2/service_usage_events\" for user: usage_service_client, ip: 127.0.0.1 with vcap-request-id: 9baab644-95a9-4047-b006-7b8d10a2ad2e::1422266c-6695-4b75-b554-6c8ad4704e6f at 2020-08-18 05:13:26 UTC","log_level":"info","source":"cc.api","data":{"request_guid":"9baab644-95a9-4047-b006-7b8d10a2ad2e::1422266c-6695-4b75-b554-6c8ad4704e6f"},"thread_id":47334664681180,"fiber_id":47334690531200,"process_id":1,"file":"/cloud_controller_ng/middleware/request_logs.rb","lineno":28,"method":"call"}
{"timestamp":"2020-08-18T05:13:26.502778656Z","message":"Completed 200 vcap-request-id: 9baab644-95a9-4047-b006-7b8d10a2ad2e::1422266c-6695-4b75-b554-6c8ad4704e6f","log_level":"info","source":"cc.api","data":{"request_guid":"9baab644-95a9-4047-b006-7b8d10a2ad2e::1422266c-6695-4b75-b554-6c8ad4704e6f"},"thread_id":47334664681180,"fiber_id":47334690531200,"process_id":1,"file":"/cloud_controller_ng/middleware/request_logs.rb","lineno":40,"method":"call"}

...
```

### cf-api-deployment-updater-logs.sh

Inspect logs from the cf-api-deployment-updater pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
 $ ./cf-api-deployment-updater-logs.sh
{"timestamp":"2020-08-18T05:14:58.289558783Z","message":"Update loop took 0.01242199s","log_level":"info","source":"cc.deployment_updater.scheduler","data":{},"thread_id":47350767764980,"fiber_id":47350820702480,"process_id":1,"file":"/cloud_controller_ng/lib/cloud_controller/deployment_updater/scheduler.rb","lineno":50,"method":"update"}
{"timestamp":"2020-08-18T05:14:58.289720885Z","message":"Sleeping 0.98757801s","log_level":"info","source":"cc.deployment_updater.scheduler","data":{},"thread_id":47350767764980,"fiber_id":47350820702480,"process_id":1,"file":"/cloud_controller_ng/lib/cloud_controller/deployment_updater/scheduler.rb","lineno":54,"method":"update"}
{"timestamp":"2020-08-18T05:14:59.277803405Z","message":"run-deployment-update","log_level":"info","source":"cc.deployment_updater.update","data":{},"thread_id":47350767764980,"fiber_id":47350820702480,"process_id":1,"file":"/cloud_controller_ng/lib/cloud_controller/deployment_updater/dispatcher.rb","lineno":10,"method":"dispatch"}

...
```

### cf-api-worker-logs.sh

Inspect logs from the cf-api-worker pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
$ ./cf-api-worker-logs.sh
{"timestamp":"2020-08-18T05:10:23.275826495Z","message":"about to run job VCAP::CloudController::Jobs::Runtime::PendingBuildCleanup","log_level":"info","source":"cc.background","data":{},"thread_id":47354019587580,"fiber_id
":47354069220700,"process_id":1,"file":"/cloud_controller_ng/app/jobs/logging_context_job.rb","lineno":16,"method":"block in perform"}
{"timestamp":"2020-08-18T05:10:23.279190110Z","message":"2020-08-18T05:10:23+0000: [Worker(cf-api-worker-587dfb8c8d-s7xvc)] Job VCAP::CloudController::Jobs::Runtime::PendingBuildCleanup (id=2472) (queue=pending_builds) COMP
LETED after 0.0034","log_level":"info","source":"cc-worker","data":{},"thread_id":47354019587580,"fiber_id":47354069220700,"process_id":1,"file":"/usr/local/lib/ruby/gems/2.5.0/gems/delayed_job-4.1.8/lib/delayed/worker.rb",
"lineno":285,"method":"say"}

...
```

### eirini-logs-all-containers.sh

Inspect logs from the eirini pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
$ ./eirini-logs-all-containers.sh 
{"timestamp":"2020-08-18T05:15:51.014005200Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24633"}}
{"timestamp":"2020-08-18T05:16:06.012922159Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24634"}}
{"timestamp":"2020-08-18T05:16:21.012885700Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24635"}}
{"timestamp":"2020-08-18T05:16:36.017085825Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24636"}}
{"timestamp":"2020-08-18T05:16:51.013891708Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24637"}}
{"timestamp":"2020-08-18T05:17:06.011956494Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24638"}}
{"timestamp":"2020-08-18T05:17:21.019021522Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24639"}}
{"timestamp":"2020-08-18T05:17:36.013446559Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24640"}}
{"timestamp":"2020-08-18T05:17:51.013603822Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24641"}}
{"timestamp":"2020-08-18T05:18:06.013220746Z","level":"debug","source":"handler","message":"handler.list-apps.requested","data":{"session":"24642"}}
{"upstream_cluster":"inbound|8080|http|eirini.cf-system.svc.cluster.local","x_b3_traceid":"b8d103ba8f162ef50848a4e6a70f0ed8","downstream_remote_address":"172.24.17.18:56474","x_forwarded_proto":"http","authority":"eirini.cf-system.svc.cluster.local:8080","path":"/apps","protocol":"HTTP/1.1","upstream_service_time":"21","upstream_local_address":"-","duration":"21","downstream_local_address":"172.24.17.17:8080","upstream_transport_failure_reason":"-","response_code":"200","response_flags":"-","response_tx_duration":"0","requested_server_name":"outbound_.8080_._.eirini.cf-system.svc.cluster.local","bytes_received":"0","organization_id":"-","app_id":"-","x_b3_spanid":"d2770aea8321cf7a","process_type":"-","x_b3_parentspanid":"0848a4e6a70f0ed8","space_id":"-","user_agent":"HTTPClient/1.0 (2.8.3, ruby 2.5.5 (2019-03-15))","start_time":"2020-08-18T05:15:51.013Z","method":"GET","request_id":"d0ff8605-933b-43b0-b041-3f6fccbb2deb","upstream_host":"127.0.0.1:8080","x_forwarded_for":"-","referer":"-","bytes_sent":"1241","response_duration":"21"}

...
```

### routecontroller-logs.sh

Inspect logs from the routecontroller pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
$ ./routecontroller-logs.sh 
2020-08-18T05:19:36.449Z        INFO    controllers.Route       Service cf-workloads/s-3114e912-09b4-4b14-802b-aa8eb52d17cb has been updated    {"route": "cf-workloads/aba82ec5-094e-44f5-a126-31ed75dc078c"}
2020-08-18T05:19:36.457Z        INFO    controllers.Route       VirtualService cf-workloads/vs-1e8791159d4b43f76e2196d00d30bde2d329d6a919328cd64f83d7584941e61e has been updated        {"route": "cf-workloads/aba82ec5-094e-44f5-a126-31ed75dc078c"}
2020-08-18T05:19:36.461Z        INFO    controllers.Route       Service cf-workloads/s-078598cb-c9e1-4034-b600-ee8287294b8a has been updated    {"route": "cf-workloads/5699e42f-5b1a-4f60-99e5-251d799babb0"}
2020-08-18T05:19:36.467Z        INFO    controllers.Route       VirtualService cf-workloads/vs-5077e47207094e035908c0b73787ed6378a85fea84fdce364f53c7b3402d5c2b has been updated        {"route": "cf-workloads/5699e42f-5b1a-4f60-99e5-251d799babb0"}

...
```

### uaa-logs.sh

Inspect logs from the UAA pods for namespace cf-system

Parameters:

* None
  
Usage Example:

```bash
$./uaa-logs.sh 
[UAA] [2020-08-18 05:20:27.836] uaa - 1 [http-nio-8080-exec-4] ....  INFO --- Audit: ClientAuthenticationSuccess ('Client authentication success'): principal=usage_service_client, origin=[remoteAddress=127.0.0.1, clientId=usage_service_client], identityZoneId=[uaa]
[UAA_AUDIT] [2020-08-18 05:20:27.851] uaa - 1 [http-nio-8080-exec-4] ....  INFO --- Audit: TokenIssuedEvent ('["cloud_controller.read","uaa.resource","cloud_controller.admin"]'): principal=usage_service_client, origin=[caller=usage_service_client, details=(remoteAddress=127.0.0.1, clientId=usage_service_client)], identityZoneId=[uaa]
[UAA] [2020-08-18 05:20:27.851] uaa - 1 [http-nio-8080-exec-4] ....  INFO --- Audit: TokenIssuedEvent ('["cloud_controller.read","uaa.resource","cloud_controller.admin"]'): principal=usage_service_client, origin=[caller=usage_service_client, details=(remoteAddress=127.0.0.1, clientId=usage_service_client)], identityZoneId=[uaa]
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:27 +0000] 19 19 1589 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:27 +0000] 3 3 1309 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:28 +0000] 1 1 3 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:31 +0000] 0 0 3 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:41 +0000] 0 0 3 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:43 +0000] 0 0 3 - vcap_request_id:-
[ACCESS] 127.0.0.1 - [18/Aug/2020:05:20:51 +0000] 0 0 3 - vcap_request_id:-

...
```

### kpack-controller-logs.sh

Inspect logs from the kpack-controller pods for namespace kpack

Parameters:

* None
  
Usage Example:

```bash
$ ./kpack-controller-logs.sh 
{"level":"info","ts":"2020-08-18T05:18:13.395Z","logger":"controller","caller":"controller/controller.go:443","msg":"Reconcile succeeded. Time taken: 75.916µs","commit":"68925ea","knative.dev/traceid":"786662b6-a3bd-4f43-bb0b-d5849853b4f2","knative.dev/key":"cf-workloads-staging/75eab41b-2759-40d6-9e09-b826c4c49a6b-build-1-l496d"}
{"level":"info","ts":"2020-08-18T05:18:13.396Z","logger":"controller","caller":"controller/controller.go:443","msg":"Reconcile succeeded. Time taken: 188.581µs","commit":"68925ea","knative.dev/traceid":"5c361b85-c6ad-4c98-8ddb-4cd035c70b0c","knative.dev/key":"cf-workloads-staging/5f1d01f1-d8ad-4692-a058-5ce6511e4587-build-2-mrptn"}
{"level":"info","ts":"2020-08-18T05:18:13.396Z","logger":"controller","caller":"controller/controller.go:443","msg":"Reconcile succeeded. Time taken: 71.543µs","commit":"68925ea","knative.dev/traceid":"46f9ef94-4ce4-4279-a603-a5bacf173df5","knative.dev/key":"cf-workloads-staging/aae5b272-600b-4e79-ac58-62685089e45d-build-1-57m2g"}

...
```

### kpack-webhook-logs.sh

Inspect logs from the kpack-webhook pods for namespace kpack

Parameters:

* None
  
Usage Example:

```bash
$ ./kpack-webhook-logs.sh 
{"level":"info","ts":"2020-08-17T19:18:17.675Z","logger":"webhook","caller":"controller/controller.go:443","msg":"Reconcile succeeded. Time taken: 60.15032ms","commit":"68925ea","knative.dev/traceid":"5e6d547d-c321-4d8e-be95-b63d02ad7a0c","knative.dev/key":"validation.webhook.kpack.pivotal.io"}
{"level":"info","ts":"2020-08-18T05:18:17.612Z","logger":"webhook","caller":"defaulting/defaulting.go:185","msg":"Updating webhook","commit":"68925ea","knative.dev/traceid":"94cf9151-6ddf-4ee7-9926-56cf82ea457a","knative.dev/key":"defaults.webhook.kpack.pivotal.io"}

...
```

### all-log-cache-containers.sh

Inspect logs of all the containers in the log-cache pods

Parameters:

* None
  
Usage Example:

```bash
$ ./all-log-cache-containers.sh 
Target cluster 'https://strawberry.run.haas-236.pez.pivotal.io:8443' (nodes: ed8a7c50-0b02-4413-b76f-ac4d216f4557, 6+)

# starting tailing 'log-cache-69677ddd4b-lzst5 > cf-auth-proxy' logs
# starting tailing 'log-cache-69677ddd4b-lzst5 > log-cache' logs
log-cache-69677ddd4b-lzst5 > log-cache | Config.NodeAddrs        []string       NODE_ADDRS              false      []
log-cache-69677ddd4b-lzst5 > log-cache | TLS.CAPath              string         CA_PATH                 true       /ca/tls.crt

...
```

### any-kapp-cf-system-component-logs.sh

Inspect logs of all the containers in the log-cache pods

Parameters:

* component name: required
* optional parameters: optional
  
Usage Example: 

```bash
$ kubectl get pods -n cf-system
NAME                                                  READY   STATUS      RESTARTS   AGE
ccdb-migrate-gt62r                                    0/2     Completed   0          4d22h
cf-api-clock-9f6bc7fc5-bzrkm                          2/2     Running     0          4d22h
cf-api-controllers-6db7ddff9b-gr6lz                   2/2     Running     4          4d22h
cf-api-deployment-updater-65c74c9bbb-528kv            2/2     Running     2          4d22h
cf-api-server-789f8f6486-rvgvr                        5/5     Running     2          4d22h
cf-api-server-789f8f6486-vmgnt                        5/5     Running     2          4d22h
cf-api-worker-587dfb8c8d-s7xvc                        2/2     Running     0          4d22h
deploy-apps-manager-rmnd4                             0/5     Completed   4          4d22h
eirini-8b4869fb4-5rbdq                                2/2     Running     0          4d22h
eirini-events-68dffd8c4b-4jqst                        2/2     Running     0          4d22h
eirini-lrp-controller-686d669cc5-wxm5v                2/2     Running     0          4d22h
eirini-task-reporter-5f45ccf8cd-xqf4v                 2/2     Running     0          4d22h
fluentd-5gznn                                         2/2     Running     3          4d22h
fluentd-g4t76                                         2/2     Running     4          4d22h
fluentd-jm2gj                                         2/2     Running     4          4d22h
fluentd-mj856                                         2/2     Running     4          4d22h
fluentd-pt85k                                         2/2     Running     4          4d22h
fluentd-rrv5q                                         2/2     Running     3          4d22h
fluentd-vccfl                                         2/2     Running     4          4d22h
log-cache-69677ddd4b-lzst5                            5/5     Running     2          4d22h
metric-proxy-79f89f584b-c896j                         2/2     Running     0          4d22h
routecontroller-957d57f8f-hcwjb                       2/2     Running     5          4d22h
uaa-6555474dbb-rqx58                                  3/3     Running     0          4d22h
usage-service-migrations-pxhm9                        0/2     Completed   0          4d22h
usage-service-scheduler-deployment-6dcd4ff77f-gd2c2   2/2     Running     0          4d22h
usage-service-server-deployment-859c8ffd67-c2q7g      2/2     Running     0          4d22h
usage-service-server-deployment-859c8ffd67-cqsgm      2/2     Running     0          4d22h
usage-service-worker-deployment-799cc4bf9b-q9gsc      2/2     Running     0          4d22h

$ ./any-kapp-cf-system-component-logs.sh fluentd- -f
Target cluster 'https://strawberry.run.haas-236.pez.pivotal.io:8443' (nodes: ed8a7c50-0b02-4413-b76f-ac4d216f4557, 6+)

# starting tailing 'fluentd-g4t76 > istio-proxy' logs
fluentd-g4t76 > istio-proxy | [Envoy (Epoch 0)] [2020-08-18 23:32:50.996][13][warning][config] [bazel-out/k8-opt/bin/external/envoy/source/common/config/_virtual_includes/grpc_stream_lib/common/config/grpc_stream.h:91] gRPC config stream closed: 13, 
fluentd-g4t76 > istio-proxy | {"app_id":"-","x_b3_spanid":"-","process_type":"-","x_b3_parentspanid":"-","space_id":"-","user_agent":"-","start_time":"2020-08-18T23:19:51.091Z","method":"-","request_id":"-","upstream_host":"172.24.17.23:8082","x_forwarded_for":"-","referer":"-","bytes_sent":"1896","response_duration":"-","upstream_cluster":"outbound|8082||log-cache-syslog.cf-system.svc.cluster.local","x_b3_traceid":"-","downstream_remote_address":"172.24.17.10:58258","x_forwarded_proto":"-","authority":"-","path":"-","protocol":"-","upstream_service_time":"-","upstream_local_address":"172.24.17.10:37648","duration":"780052","downstream_local_address":"10.100.200.85:8082","upstream_transport_failure_reason":"-","response_code":"0","response_flags":"-","response_tx_duration":"-","requested_server_name":"log-cache-syslog","bytes_received":"2620","organization_id":"-"}

...
```

<hr size="2" />
Pas Apicella [pasa at vmware.com] is an Advisory Application Platform Architect at VMware APJ
