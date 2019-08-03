#! /bin/bash
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open http://localhost:3000/d/UbsSZTDik/istio-workload-dashboard?orgId=1&refresh=10s
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open http://localhost:3000/d/UbsSZTDik/istio-workload-dashboard?orgId=1&refresh=10s
fi
