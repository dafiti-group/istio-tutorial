#!/usr/bin/env sh

echo 'kubectl taint nodes --all node-role.kubernetes.io/master-'

export ISTIO_HOME=$PWD/istio
export PATH=$ISTIO_HOME/bin:$PATH

istioctl manifest apply --set profile=demo

#  for i in istio/install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
#  
#  kubectl apply -f istio/install/kubernetes/*
#  
#  kubectl config set-context $(kubectl config current-context) --namespace=istio-system

