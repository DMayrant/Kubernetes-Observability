# Kube Prometheus 🖥️

gives you all of the service dashboards you need out the box

Create the namespace CRDs, and wait for them to be available before creating the manifests

```bash 
git clone https://github.com/DMayrant/kube-prometheus.git
```
```bash
cd kube-prometheus
```

```bash
kubectl create -f manifests/setup 
```

```bash
kubectl create -f manifests/
```
# To access grafana / prometheus 

```bash 
kubectl port-forward svc/grafana 3000:3000  -n monitoring 

kubectl port-forward svc/prometheus-k8s 9090:9090 -n monitoring 
```

# Scale all workloads to 0 replicas in the real world 