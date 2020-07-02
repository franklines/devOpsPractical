## Swimlane Practical K8S Manifests & Charts
This repo subdir contains everything K8s related to deploy the swimlane practice app.

## WARNING: -r flag on deployApp.sh script removes all PVs and PVCs on EKS Cluster. DO NOT RUN if you have other deployments on the cluster. 

```bash
# Deploy stack
./deployApp.sh -d

#10:37:56 frank@frank-t420 k8s ±|master ✗|→ ./deployApp.sh -d
#storageclass.storage.k8s.io/mongodb-storage unchanged
#secret/mongodb-secrets created
#secret/swimlane-app-secrets created
#service/mongodb created
#service/swimlane-app created
#Launching MongoDB pod via deployment - ETA ~ 5 mins...
#statefulset.apps/mongodb-deployment created
#Sleeping.... (so pod can ready up)
#Launching Swimlane App pod via deployment....
#error: the path "swimlane-app-deployment.yaml" does not exist

# Destroy stack (WARNING: NUKES ALL PVCs and PVs! DO NOT RUN ON EKS CLUSTER RUNNING OTHER APPS)
./deployApp.sh -r

#10:48:17 frank@frank-t420 k8s ±|master ✗|→ ./deployApp.sh -r
#Deleting services...
#service "swimlane-app" deleted
#service "mongodb" deleted
#Deleting deployments...
#Error from server (NotFound): deployments.apps "swimlane-app" not found
#statefulset.apps "mongodb-deployment" deleted
#Nuking all PVs & PVCS!!!
#persistentvolumeclaim "mongodb-data-mongodb-deployment-0" deleted
#persistentvolume "pvc-bb73508e-8e32-4430-b48f-2bff3b3fb223" deleted
#Deleting secrets...
#secret "swimlane-app-secrets" deleted
#secret "mongodb-secrets" deleted
#All set!


```