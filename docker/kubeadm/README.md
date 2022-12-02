This image is used exclusively to generate tokens and certs for bootstrapping the cluster. It should not be used for any other reason.

To generate token:

```sh
docker build -t kubeadm .
docker run kubeadm token create
```

To generate cert:

```
docker build -t kubeadm .
docker run kubeadm certs certificate-key
```