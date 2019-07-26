#! /bin/bash
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &

open http://localhost:3000/d/_GZa3UHWk/istio-mesh-dashboard?orgId=1
