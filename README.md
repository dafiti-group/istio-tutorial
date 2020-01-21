for i in install/kubernetes/helm/istio-init/files/crd*yaml
      kubectl apply -f $i
end

kubectl apply -f install/kubernetes/istio-demo.yaml

kubectl config set-context (kubectl config current-context) --namespace=istio-system

set -gx ISTIO_HOME $PWD
set -gx PATH "$ISTIO_HOME/bin" $PATH

kubectl create namespace tutorial
kubectl config set-context (kubectl config current-context) --namespace=tutorial

istioctl kube-inject -f customer/kubernetes/Deployment.yml > outs/customer.yaml
istioctl kube-inject -f preference/kubernetes/Deployment.yml > outs/preference.yaml
istioctl kube-inject -f recommendation/kubernetes/Deployment.yml > outs/recommendation.yaml

k apply -n tutorial -f outs/

kubectl create -f customer/kubernetes/Service.yml -n tutorial
kubectl create -f preference/kubernetes/Service.yml -n tutorial
kubectl create -f recommendation/kubernetes/Service.yml -n tutorial
kubectl create -f customer/kubernetes/Gateway.yml -n tutorial
