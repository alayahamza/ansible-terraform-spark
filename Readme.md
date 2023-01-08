# Provision an Apache Spark cluster using Ansible and terraform

## Available with linode images:

- Ubuntu
    - [standalone-multi-vm-ubuntu20.04-linode](https://github.com/alayahamza/ansible-terraform-spark/tree/standalone-multi-vm-ubuntu20.04-linode)
    - [standalone-multi-vm-ubuntu22.04-linode](https://github.com/alayahamza/ansible-terraform-spark/tree/standalone-multi-vm-ubuntu22.04-linode)
- CentOs
    - [standalone-multi-vm-centos7-linode](https://github.com/alayahamza/ansible-terraform-spark/tree/standalone-multi-vm-centos7-linode)
    - [standalone-multi-vm-centos9-linode](https://github.com/alayahamza/ansible-terraform-spark/tree/standalone-multi-vm-centos9-linode)

## Prerequisites:

- :link: [linode account](https://www.linode.com/)
- :
  link: [Create a linode API token](https://www.linode.com/docs/products/tools/api/guides/manage-api-tokens/#create-an-api-token)
- :closed_lock_with_key: ssh private and public keys
- :scroll: provide the following files:

```
ansible-terraform-spark
|__ansible-role-apache-spark
|__terraform
   |__linode_api_token    // text file containing you linode API token
   |__linode_ssh_key      // ssh private key to be used to connect to cluster nodes 
   |__linode_ssh_key.pub  // ssh public key to be used to connect to cluster nodes
   |__root_pass           // text file containing a root password of your choice 
```

### Create a Spark cluster:

- In the root folder run:

```console
$ ./spark-cluster create
```

### Change the number of workers:

- In the root folder run :

```console
$ ./spark-cluster scale 2
```

### Run SparkPi on your cluster:

- ssh to the master node and run the following command

```console
spark-submit \
    --deploy-mode cluster \
    --master spark://$(hostname -I | awk '{print $1}'):7077\
    --num-executors 1 \
    --driver-memory 1G \
    --num-executors 1 \
    --executor-memory 1G \
    --executor-cores 1 \
    --class org.apache.spark.examples.SparkPi \
    /opt/spark/examples/jars/spark-examples*.jar  
```

### Destroy the cluster:

- In the root folder run :

```console
$ ./spark-cluster destroy
```
