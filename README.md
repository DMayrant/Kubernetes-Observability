# Kubernetes-Observability 📈

This system runs on a Jenkins CI/CD server with automated security scans for compliance with OWASP Top 10, NSA, CIS Benchmarks. Security scanners that were used are Sonarqube, Trivy, SNYK, and OWASP ZAP.

Prometheus and Grafana the primary observability and metrics tools used within the a Kubernetes cluster. These work well together in production but carry out different task. Grafana give you direct visualization of metrics while prometheus acts as a metrics engine database. 

# Grafana 📊

Grafana is metrics observability platform that can be integrated with many other tools.

- prometheus 
- loki 
- CloudWatch 
- ElastiSearch 

http://localhost:3000

# Prometheus 🧰

Prometheus is a metrics engine database that scrapes metrics at scheduled interval and sends them to Time Series Database (TSDB) and uses PromQL as a query language to send queries to Grafana for visualization 

http://localhost:9090 
