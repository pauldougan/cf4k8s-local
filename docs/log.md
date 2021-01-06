
## Log

## Learnings

- be patient - in some cases the documentation suggests it will be 10 minutes from running the kapp command to having a running foundry locally, give it plenty of time to stabilise, use the docker dashboard to watch the deployment. The kapp command may throw errors and it all looks like its going wrong, just ignore that and refer to the dashboard or kubectl.

### 2020-01-04 

Spin up minikube, test dashboard, start tunnel, generate manifests, run install

problem deploying eirini

```
5:08:22PM: ---- waiting on 15 changes [279/298 done] ----
5:08:27PM: ongoing: reconcile deployment/cf-api-controllers (apps/v1) namespace: cf-system
5:08:27PM:  ^ Waiting for 1 unavailable replicas
5:08:27PM:  L ok: waiting on replicaset/cf-api-controllers-b5545c6b7 (apps/v1) namespace: cf-system
5:08:27PM:  L ongoing: waiting on pod/cf-api-controllers-b5545c6b7-tct69 (v1) namespace: cf-system
5:08:27PM:     ^ Pending: PodInitializing
5:08:31PM: fail: reconcile deployment/eirini (apps/v1) namespace: cf-system
5:08:31PM:  ^ Deployment is not progressing: ProgressDeadlineExceeded (message: ReplicaSet "eirini-545bb6cd94" has timed out progressing.)

kapp: Error: waiting on reconcile deployment/eirini (apps/v1) namespace: cf-system:
  Finished unsuccessfully (Deployment is not progressing: ProgressDeadlineExceeded (message: ReplicaSet "eirini-545bb6cd94" has timed out progressing.))

``` 

