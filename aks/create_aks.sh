##!/usr/bin/env bash
### change to your desired values
LOCATION="canadacentral" 
RG_NAME="aks-ll-rg"
CLUSTER_NAME="aks-ll"
NODE_SIZE="Standard_B2s"
NODE_COUNT="3"
NODE_DISK_SIZE="30"
VERSION="1.16.7"

### create the cluster
az group create --name $RG_NAME --location $LOCATION
az aks create --resource-group $RG_NAME --name $CLUSTER_NAME \
  --kubernetes-version $VERSION \
  --location $LOCATION \
  --skip-subnet-role-assignment \
  --node-vm-size $NODE_SIZE \
  --load-balancer-sku standard \
  --service-principal $SERVICE_PRINCIPAL \
  --client-secret $SERVICE_SECRET \
  --node-count $NODE_COUNT --node-osdisk-size $NODE_DISK_SIZE

# connect to the cluster
az aks get-credentials --resource-group $RG_NAME --name $CLUSTER_NAME
