#! /bin/bash
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 &

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open "http://localhost:9090/graph?g0.range_input=15m&g0.stacked=1&g0.expr=&g0.tab=0"
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open "http://localhost:9090/graph?g0.range_input=15m&g0.stacked=1&g0.expr=&g0.tab=0"
fi

