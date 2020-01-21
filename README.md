
```bash
curl -L https://istio.io/downloadIstio | sh -
mv istio-<version> istio

set -gx ISTIO_HOME $PWD/istio
set -gx PATH "$ISTIO_HOME/bin" $PATH

kind create cluster --config kind/kind-example-config.yaml

istioctl manifest apply --set profile=demo

kubectl -n istio-system patch service istio-ingressgateway -p '{"spec":{"ports":[{"name":"http2","nodePort":31460,"port":80,"protocol":"TCP","targetPort":80}]}}'

kubectl create namespace tutorial
kubectl config set-context (kubectl config current-context) --namespace=tutorial

istioctl kube-inject -f customer/kubernetes/Deployment.yml > outs/customer.yaml
istioctl kube-inject -f preference/kubernetes/Deployment.yml > outs/preference.yaml
istioctl kube-inject -f recommendation/kubernetes/Deployment.yml > outs/recommendation.yaml
istioctl kube-inject -f recommendation/kubernetes/Deployment-v2.yml > outs/recommendation-v2.yaml

kubectl apply -n tutorial -f outs/

kubectl create -f customer/kubernetes/Service.yml -n tutorial
kubectl create -f preference/kubernetes/Service.yml -n tutorial
kubectl create -f recommendation/kubernetes/Service.yml -n tutorial
kubectl create -f customer/kubernetes/Gateway.yml -n tutorial

curl 127.0.0.1/customer

kubectl -n istio-system port-forward (kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001