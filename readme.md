# Grafana and Prometheus Observability 📈

Observability and monitoring is critical for keeping track of the health status of your cloud environment, kubernetes cluster and workloads. Grafana and Prometheus gives you monitoring dashboards allowing engineering teams to make debugging predictable and simplicity by eliminating guess work when a failure occurs in production. 

# Grafana vs Prometheus ☁️

- Prometheus 

http://localhost:9090

prometheus is a metrics engine database. Prometheus works by scraping metics from targets every few seconds and stores metrics in a time-series database (TSDB). Prometheus has its own query language called PromQL. 

- Grafana 

http://localhost:3000

Grafana does not collect metrics it connects data to sources and builds dashboards and visualize metrics. Its often supported by CloudWatch, Datadog, Prometheus, Loki and ElastiSearch 

Prometheus scrapes metics and sends PromQL queries to Grafana for visualization 

