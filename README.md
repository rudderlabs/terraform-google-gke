# Rudder Google Kubernetes Engine

These Terraform scripts provision a Kubernetes cluster in a new VPC and restricted access to other cloud resources owned by you.

# Key features

* Separate VPC

* Separate Kubernetes cluser

* Dedicated IAM service account used by Kubernetes nodes for granular access control. Service account is created with the following roles.
```
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
```

## Input parameters
1. Location: Location to deploy GKE cluster. This can be either a Google Cloud Region (`us-west1`) or a Google Cloud Zone (`us-west1-a`). Providing a region deploys a regional cluster that spans over multiple zones in the region. Providing a zone deploys the cluster inside a single zone. 

2. Project ID: Google Cloud Project to deploy GKE cluster.

3. Region: Google Cloud Region to create the VPC.

Please go through `variables.tf` for other config variables.

## How do you run?

1. Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) v0.12.0 or later.
1. Open `variables.tf`, and fill in any required variables that don't have a default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
1. To setup `kubectl` to access the deployed cluster, run `gcloud beta container clusters get-credentials $CLUSTER_NAME 
--region $REGION --project $PROJECT`, where `CLUSTER_NAME`, `REGION` and `PROJECT` correspond to what you set for the 
input variables.

## Access for Managed Hosting
For managed hosting, Rudder would need to access your GKE cluster. Please follow the steps and share the generated cert with us.

1. Generate a kubernetes resource for rudder user and create a certificate signing request
```shell
kubectl apply -f rudder-user.yaml
```
2. Approve certificate request
```
kubectl certificate approve rudder-csr
```
3. Generate the certificate file to be shared
```
kubectl get csr rudder-csr -o jsonpath='{.status.certificate}' | base64 --decode > rudder-k8s.crt
```

## Install Rudder

Please go through the instructions in the following repository to deploy Rudder into your GKE cluster.

https://github.com/rudderlabs/rudderstack-helm

## Credits
For best practices of provisioning the cluster, please follow Gruntwork's [recommendations](https://github.com/gruntwork-io/terraform-google-gke)
