#! /bin/bash
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 2>&1 &
sleep 1
DASHBOARD="http://localhost:9090/graph?g0.range_input=15m&g0.stacked=1&g0.expr=&g0.tab=0"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open $DASHBOARD
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open $DASHBOARD
fi

