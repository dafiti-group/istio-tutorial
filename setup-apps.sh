#!/usr/bin/env sh

# set -gx ISTIO_HOME "$PWD/istio" 
# set -gx PATH "$ISTIO_HOME/bin" $PATH 

export ISTIO_HOME=$PWD/istio
export PATH=$ISTIO_HOME/bin:$PATH

kubectl create namespace tutorial
kubectl config set-context $(kubectl config current-context) --namespace=tutorial

istioctl kube-inject -f customer/kubernetes/Deployment.yml > outs/customer.yaml
istioctl kube-inject -f preference/kubernetes/Deployment.yml > outs/preference.yaml
istioctl kube-inject -f recommendation/kubernetes/Deployment.yml > outs/recommendation.yaml
istioctl kube-inject -f recommendation/kubernetes/Deployment-v2.yml > outs/recommendation-v2.yaml

kubectl apply -n tutorial -f outs/

kubectl create -f customer/kubernetes/Service.yml -n tutorial
kubectl create -f preference/kubernetes/Service.yml -n tutorial
kubectl create -f recommendation/kubernetes/Service.yml -n tutorial
kubectl create -f customer/kubernetes/Gateway.yml -n tutorial
