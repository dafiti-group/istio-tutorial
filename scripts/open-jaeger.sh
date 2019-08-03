#! /bin/bash
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 15032:16686 &

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open http://localhost:15032/jaeger/search
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open http://localhost:15032/jaeger/search
fi

