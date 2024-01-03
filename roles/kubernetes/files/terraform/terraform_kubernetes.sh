#!/bin/bash

######################################################################################################################
echo "Login to GCP"
# Authenticate with GCP
auth_file="service_account.json"

email=$(grep -E '^\s*client_email\s*=\s*"([^"]+)"' "$auth_file" | awk -F '"' '{print $2}')

gcloud auth activate-service-account $email --key-file=$auth_file

echo "Login to GCP successfully"
######################################################################################################################
echo "Create terraform configuration file"

auth_file="service_account.json"

email=$(grep -E '^\s*"client_email"\s*:\s*"\s*([^"]+)\s*",' "$auth_file" | awk -F '"' '{print $4}')
project_id=$(grep -E '^\s*"project_id"\s*:\s*"\s*([^"]+)\s*",' "$auth_file" | awk -F '"' '{print $4}')

cat > terraform_config.tf <<EOF
provider "google" {
  credentials = file("$auth_file")
  project     = "$project_id"
  region      = "europe-west1-b"
}
resource "google_container_cluster" "my_cluster" {
  name     = "my-gke-cluster"
  location = "europe-west1-b"
  node_pool {
    name       = "default-pool"
    node_count = 2
    version    = "1.27.3-gke.100"
  }
}
output "cluster_endpoint" {
  value = google_container_cluster.my_cluster.endpoint
}
EOF

echo "Terraform configuration file generated successfully."
######################################################################################################################
echo "Terraform init and apply"

terraform init
terraform apply -auto-approve

echo "Terraform init and apply successfully"
######################################################################################################################
echo "Create kubeconfig file"

terraform_file="terraform_config.tf"

# Extract variables with double quotes
project=$(grep -E '^\s*project\s*=\s*"([^"]+)"' "$terraform_file" | awk -F '"' '{print $2}')
name="my-gke-cluster"
location=$(grep -E '^\s*resource\s*"google_container_cluster"\s*"my_cluster"\s*{' "$terraform_file" -A 4 | grep -E '^\s*location\s*=\s*"([^"]+)"' | awk -F '"' '{print $2}')

gcloud container clusters get-credentials $name --zone $location --project $project

echo "Create kubeconfig file successfully"
######################################################################################################################
echo "Create kubernetes resources"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

echo "Create kubernetes resources successfully"
