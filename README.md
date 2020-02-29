# This a Repo for the AKS Linkerd Demo

# Install AKS

Login to Azure 

```bash
az login
```

Edit the variables at the top of the ./aks/create_aks.sh to much your environment and run the script to deploy a single node AKS cluster

# Demo App

Instal the demo app into your cluster

```bash
cd ./demo-app
kubectl apply -f emojivoto.yml
kubectl -n emojivoto get po
```

# Linkerd

## Get Linkerd on your Dev machine

```bash
LINKERD_VERSION=stable-2.7.0
curl -sLO "https://github.com/linkerd/linkerd2/releases/download/$LINKERD_VERSION/linkerd2-cli-$LINKERD_VERSION-linux"
sudo cp ./linkerd2-cli-$LINKERD_VERSION-linux /usr/local/bin/linkerd
sudo chmod +x /usr/local/bin/linkerd
```

# Pre-installation checks 

To determine if the control plane can be installed on you AKS cluster, run the folowing:

```bash
linkerd check --pre
```
If status check is Ok, proceed

## Install Linkerd on AKS

```bash
linkerd install | kubectl apply -f -
```

# Inject Linkerd into demo-app

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```

## Verify that everything is working

linkerd -n emojivoto check --proxy

## Check TLS enabled

```bash
linkerd -n emojivoto edges deployment
linkerd -n emojivoto tap deploy
kubectl sniff web-744588c478-7jxzf -n emojivoto -f 'tcp and host not 127.0.0.1'
```





