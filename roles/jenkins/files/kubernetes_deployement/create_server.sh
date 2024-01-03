config_file="whanos.yml"

name=$1
image_url="${2#*://}"
replicas=$(grep 'replicas:' whanos.yml | awk '{print $2}')
ports=$(grep 'ports:' whanos.yml | awk '{print $2}')

if [ -z "$replicas" ]; then
    replicas=1
fi

cat > deployment.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $1
spec:
  replicas: $replicas
  selector:
    matchLabels:
      app: $1
  template:
    metadata:
      labels:
        app: $1
    spec:
      containers:
        - name: $1
          image: $image_url
EOF

if [ -n "$ports" ]; then
cat >> deployment.yaml <<EOF
          ports:
            - containerPort: $ports
EOF
cat >> service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: $name
spec:
  type: ClusterIP
  ports:
    - port: $ports
  selector:
    app: $name
EOF
test='/$2'
cat >> ingress.yaml <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $name-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: $test
spec:
  ingressClassName: nginx
  rules:
    - http:
        paths:
          - path: /$name(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: $name
                port:
                  number: $ports
EOF
fi

kubectl replace --force -f deployment.yaml
if [ -n "$ports" ]; then
  kubectl replace --force -f service.yaml
  kubectl replace --force -f ingress.yaml
fi


url=$(kubectl get service ingress-nginx-controller --namespace=ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "See your app at http://$url/$name"
