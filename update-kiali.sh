#!/usr/bin/env sh

export JAEGER_URL="http://jaeger-query:16686"
export GRAFANA_URL="http://grafana:3000"
export PROMETHEUS_URL="http://prometheus:9090"

echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
    chart: kiali
    heritage: Tiller
    release: istio
data:
  config.yaml: |
    istio_namespace: istio-system
    auth: 
      strategy: "login"
    server:
      port: 20001
    web_root: /kiali
    external_services:
        tracing:
            url: http://jaeger-query:16686
        jaeger:
            url: http://jaeger-query:16686
        grafana:
            url:  http://grafana:3000
        prometheus:
            url: http://prometheus:9090" | kubectl apply -f -; kubectl delete pod -l app=kiali -n istio-system