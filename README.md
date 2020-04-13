# Vagrant/Terraform + Ansible = K8s - Cluster Up And Running

Esse projeto tem a finalidade de subir um cluster de kubernetes automaticamente e com a maior flexibilidade possível, para isso juntamos a força do vagrant (pode ser substituído por terraform) e o ansible para deixarmos a configuração necessária como código e assim agilizarmos o setup.

Já é possível subir um cluster com varios masters e workers, porém a config com loadbalancers ainda está em desenvolvimento.

## Desenho da arquitetura inicial

![Cluster K8s](/resources/k8s-cluster-draft.png)

Para subir um cluster com varios masters e workers basta conferir a configuração do arquivo Vagrantfile.

```
# Vagrantfile
IMAGE_NAME = "ubuntu/xenial64"
NUM_LOAD_BALANCE = 0
NUM_MASTERS = 1
NUM_NODES = 2
```

```shell
$ vagrant up
```