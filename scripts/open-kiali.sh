#! /bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open http://localhost:20001/kiali/
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open http://localhost:20001/kiali/
fi

kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001 &
