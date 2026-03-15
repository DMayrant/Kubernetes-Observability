#!/bin/bash 
set -euo pipefail 

NS="monitoring"
DEPLOYMENT="nginx-deploy"
SA="prometheus"
POD="curl"
SERVICE="nginx-deploy"

# Resource Creation 
if kubectl get deploy "$DEPLOYMENT" &> /dev/null; then 
    echo "Deployment $DEPLOYMENT already exists"
    exit 1
fi

if kubectl get sa "$SA" &> /dev/null; then
    echo "ServiceAccount $SA already exists"
    exit 1
fi

echo "Creating manifest for workload observability 🏗️"
kubectl create sa "$SA" --dry-run=client -o yaml > serviceaccount.yaml
kubectl create deploy "$DEPLOYMENT" --image=nginx:1.29.0 --port=80 --replicas=5 --dry-run=client -o yaml > nginx-deploy.yaml
kubectl expose deploy "$DEPLOYMENT" --port=80 --target-port=80  --dry-run=client -o yaml > nginx-svc.yaml
kubectl run "$POD" --image=curlimages/curl:7.83.0 --dry-run=client -o yaml > curl.yaml

# Apply workloads and resources 
echo "Applying resources 🧰"
kubectl apply -f nginx-deploy.yaml
kubectl apply -f nginx-svc.yaml
kubectl apply -f serviceaccount.yaml
kubectl apply -f curl.yaml

# ClusterIP service check 
echo "Checking service endpoint 📡"
kubectl get svc "$SERVICE"
kubectl describe svc "$SERVICE" 

# Internal service discovery 
echo "Testing internal service discovery 🔍"
kubectl wait --for-condition=Ready pod/"POD" --timeout=60s
kubectl exec pod/"$POD" -- curl http://nginx-deploy:80

# Service Monitor
kubectl get servicemonitor -A | grep kubelet || true 
kubectl get servicemonitor kubelet -n "$NS" -o yaml > monitor.yaml

# Port-forwarding 
echo "Port forwarding to service 🚀"
kubectl port-forward svc/grafana 3000:3000 -n "$NS" &
kubectl port-forward svc/prometheus-k8s 9090:9090 -n "$NS" &

echo "grafana http://localhost:3000"
echo "prometheus http://localhost:9090"

