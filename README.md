# What is RudderStack?

[RudderStack](https://rudderstack.com/) is a **customer data pipeline** tool for collecting, routing and processing data from your websites, apps, cloud tools, and data warehouse.

More information on RudderStack can be found [here](https://github.com/rudderlabs/rudder-server).

## RudderStack Google Kubernetes Engine

These Terraform scripts provision a Kubernetes cluster in a new VPC and restricted access to other cloud resources owned by you.

# Key features

* Separate VPC

* Separate Kubernetes cluser

* Dedicated IAM service account used by Kubernetes nodes for granular access control. Service account is created with the following roles:

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
1. Open `variables.tf`, and fill in any required variables that don't have a default. Checkout the default variables `rudder_node_type` and `rudder_disk_size_gb` for configuring the nodes.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
1. To setup `kubectl` to access the deployed cluster, run `gcloud container clusters get-credentials rudder-cluster --zone ${REGION_ZONE} --project ${PROJECT}`, where `REGION_ZONE` (either specify REGION if you created regional cluster or specify ZONE) and `PROJECT` correspond to what you set for the 
input variables.
1. Make a copy of the output variables `cluster_endpoint` and `cluster_ca_certificate`

## Access for Managed Hosting

For managed hosting, RudderStack would need to access your GKE cluster. Please follow the steps and share the generated cert with us.

1. Generate a kubernetes resource for the RudderStack user and create a certificate signing request
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

## Outputs to share

Please share the following to enable Rudder managed hosting
1. `cluster_endpoint`
1. `cluster_ca_certificate`
1. `rudder-k8s.crt`

## FAQ

- I've come across the following error, how do I fix it?

   ```
    Error: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.
   ```
  
 Run the following command if you run into this error while provisioning through Terraform:
 
  ```
   gcloud auth application-default login
  ```

## Credits

For best practices of provisioning the cluster, please follow Gruntwork's [recommendations](https://github.com/gruntwork-io/terraform-google-gke)

## Contact Us

If you come across any issues while configuring or using these scripts, please feel free to start a conversation on our [Slack](https://resources.rudderstack.com/join-rudderstack-slack) channel. We will be happy to help you.
