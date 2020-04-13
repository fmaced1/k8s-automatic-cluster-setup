# K8s + Vagrant + Ansible = Cluster Up And Running

This example demonstrates how to access one kubernetes cluster from another. It only works if both clusters are running on the same network, on a cloud provider that provides a private ip range per network (eg: GCE, GKE, AWS).

## Desenho da arquitetura inicial

![Cluster K8s](/resources/k8s-cluster-draft.png)

Create a cluster in US (you don't need to do this if you already have a running kubernetes cluster)

```shell
$ vagrant up
$ vagrant ssh k8s-master-1
```
