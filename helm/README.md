## Swimlane Practical Helm Chart
This repo subdir contains everything Helm related to the swimlane practice app.


### Install
```bash
# Install chart using helm v3
10:22:10 frank@frank-t420 helm ±|master ✗|→ helm install swimlane-app swimlane-app/
NAME: swimlane-app
LAST DEPLOYED: Wed Jul  1 22:22:13 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

# Verify
10:22:39 frank@frank-t420 helm ±|master ✗|→ kubectl get svc
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes     ClusterIP   10.100.0.1      <none>        443/TCP          3d5h
mongodb        ClusterIP   10.100.162.35   <none>        27017/TCP        116m
swimlane-app   NodePort    10.100.177.21   <none>        3000:30000/TCP   28s

10:22:42 frank@frank-t420 helm ±|master ✗|→ kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
mongodb-deployment-0            1/1     Running   0          61m
swimlane-app-7f5cdf55c5-sfqzr   0/1     Running   0          33s

# Package chart
10:25:28 frank@frank-t420 helm ±|master ✗|→ pwd;ll
/home/frank/Projects/Practical/devOpsPractical/helm
total 8.0K
-rw-rw-r-- 1 frank frank 1.1K Jul  1 22:25 README.md
drwxr-xr-x 4 frank frank 4.0K Jul  1 21:57 swimlane-app/
10:25:31 frank@frank-t420 helm ±|master ✗|→ helm package swimlane-app/
Successfully packaged chart and saved it to: /home/frank/Projects/Practical/devOpsPractical/helm/swimlane-app-0.1.0.tgz
10:25:35 frank@frank-t420 helm ±|master ✗|→ ll
total 12K
-rw-rw-r-- 1 frank frank 1.1K Jul  1 22:25 README.md
drwxr-xr-x 4 frank frank 4.0K Jul  1 21:57 swimlane-app/
-rw-rw-r-- 1 frank frank 1.3K Jul  1 22:25 swimlane-app-0.1.0.tgz

```