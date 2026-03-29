pipeline {
    agent any 

    stages {
        stage ('Image Pull') {
            steps {
                sh '''
                docker pull nginx:1.28.0
                '''
            }
        }
        stage ('Trivy Scan') {
            steps {
                sh '''
                echo 'Scanning for vulnerabilities...'
                trivy image --severity HIGH,CRITICAL nginx:1.28.0 || true
                '''
            }
        }
        stage ('SNYK Dependency Scan') {
            steps {
                sh '''
                echo 'Executing SNYK scan...' 
                snyk container test nginx:1.28.0 || true
                '''
            }
        }
        stage ('Kubernetes Deployment') {
            steps {
                sh '''
                echo 'Deploying workloads to US-east-1'
                set -euo pipefail  

                kubectl create deployment nginx-web --image=nginx:1.28.0 --port=80 --replicas=5 --dry-run=client -o yaml > nginx-web.yaml
                kubectl create service clusterip nginx-web --tcp=80:80 --dry-run=client -o yaml > nginx-svc.yaml
                kubectl run curl --image=curlimages/curl:7.83.0 --dry-run=client -o yaml > curl.yaml
                kubectl apply -f nginx-web.yaml
                kubectl apply -f nginx-svc.yaml 
                kubectl apply -f curl.yaml
                kubectl get pods 
                kubectl rollout status deployment nginx-web
                '''
            }
        }
        stage ('Port-forward') {
            steps {
                sh '''
                kubectl port-forward svc/nginx-web 4000:80 > pf.log 2>&1 &
                PF_PID=$!
                
                echo "=== Waiting for Service ==="
                sleep 5

                docker run --rm \
                -t zaproxy/zap-stable zap-baseline.py \
                -t http://localhost:4000 \
                -r zap-report.html || true
                kill $PF_PID
                '''
            }
        }
        stage ('Kubescape Scan') {
            steps {
                sh '''
                echo 'compliance scan (NSA + MITRE)'

                kubescape scan framework nsa,mitre .
                '''
            }

        }
        stage ('Cleanup 🗑️') {
            steps {
                sh '''
                kubectl delete -f nginx-web.yaml --ignore-not-found=true
                kubectl delete -f nginx-svc.yaml --ignore-not-found=true
                kubectl delete -f curl.yaml --ignore-not-found=true
                '''
            }
        }
    }
    post {
        success {
            echo 'Pipeline is execution successful ✅'
        }
        failure {
            echo 'Pipeline failed, please check logs ⚠️'
        }
    }
}
