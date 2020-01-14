# Rudder Google Kubernetes Engine

These Terraform scripts provision a Kubernetes cluster in a new VPC and restricted access to other cloud resources.

# Key features

Separate VPC

Separate Kubernetes cluser

Dedicated IAM service account for granular access control


## How do you run?

1. Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) v0.12.0 or later.
1. Open `variables.tf`, and fill in any required variables that don't have a default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
1. To setup `kubectl` to access the deployed cluster, run `gcloud beta container clusters get-credentials $CLUSTER_NAME 
--region $REGION --project $PROJECT`, where `CLUSTER_NAME`, `REGION` and `PROJECT` correspond to what you set for the 
input variables.

## Generating rudder certificates for access
1. Generate a kubernetes resource for rudder user and create a certificate signing request
```shell
kubectl apply -f rudder-user.yaml
```
2. Approve certificate request
```
kubectl certificate approve rudder-csr
```
3. Generate a certificate file and share with us for managed hosting.
```
kubectl get csr rudder-csr -o jsonpath='{.status.certificate}' | base64 --decode > rudder-k8s.crt
```



## Credits
For best practices of provisioning the cluster, please follow Gruntwork's [recommendations](https://github.com/gruntwork-io/terraform-google-gke)
