## Swimlane Practical AWS EKS Setup
This repo subdir contains everything AWS EKS infrastructure related to host the swimlane practice app.

## Install eksctl
```bash
# Download & extract.
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Move to bin dir.
sudo mv /tmp/eksctl /usr/local/bin

# Verify
10:35:50 frank@frank-t420 docker ±|master ✗|→ eksctl version
0.22.0
```

## Create EKS Cluster
```bash
# Create EKS cluster
eksctl create cluster -f cluster.yaml
```

## Configure kubectl
```bash
# Export kube config.
aws eks --profile=default --region us-east-1 update-kubeconfig --name swimlane-1

# Verify
04:52:36 frank@frank-t420 eks ±|master ✗|→ kubectl get nodes -o wide
NAME                            STATUS   ROLES    AGE     VERSION              INTERNAL-IP     EXTERNAL-IP     OS-IMAGE         KERNEL-VERSION                  CONTAINER-RUNTIME
ip-192-168-4-84.ec2.internal    Ready    <none>   7m55s   v1.16.8-eks-e16311   192.168.4.84    3.230.3.98      Amazon Linux 2   4.14.181-140.257.amzn2.x86_64   docker://19.3.6
ip-192-168-46-59.ec2.internal   Ready    <none>   7m58s   v1.16.8-eks-e16311   192.168.46.59   54.159.204.83   Amazon Linux 2   4.14.181-140.257.amzn2.x86_64   docker://19.3.6
```