# Kubernetes-Observability 📈

I designed and implemented a secure Kubernetes platform automated through a Jenkins CI/CD server with security scans embedded into the pipeline. Integrating a shift-left security and runtime validation 

 # CI/CD Orchestration (Jenkins) ⚙️
 - Automated build, scan, and deployment pipeline

- Enforced security gates before workload deployment

- Integrated container and cluster validation into delivery lifecycle

# Container Security (Shift-Left) 🔐
- Trivy (Image vulnerability HIGH/Critical)

- SNYK (Dependency and container security analysis, prevents images with vulnerabilities from reaching the cluster)

# Dynamic & Runtime security ⚡️
 - OWASP ZAP (DAST scanning for exposed endpoints)
 
 - Validates application layer security risk

# Kubernetes Security and Compliance 📋
- Kubescape (Cluster hardening and compliance checks)

Benchmarked against: 

MITRE ATT&CK framework
NSA Kubernetes Hardening Guide 
OWASP top 10

# Observability Stack 

Prometheus and Grafana the primary observability and metrics tools used within the a Kubernetes cluster. These work well together in production but carry out different task. Grafana give you direct visualization of metrics while prometheus acts as a metrics engine database. 

# Grafana 📊

Grafana is metrics observability platform that can be integrated with many other tools.

- prometheus 
- loki 
- CloudWatch 
- ElastiSearch 

http://localhost:3000

# Prometheus 🧰

Prometheus is a metrics engine database that scrapes metrics at scheduled intervals and sends metrics to Time Series Database (TSDB) and uses PromQL as a query language to send queries to Grafana for visualization 

http://localhost:9090 
