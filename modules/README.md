# AliCloud Terraform OpenShift module

也可访问 [中文](README_CN.md)

A Terraform module for deploying OpenShift on AliCloud ECS.

These types of resources are supported:

* [ECS](https://www.terraform.io/docs/providers/alicloud/r/instance.html)
* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)


## Terraform versions

Terraform `~>  v0.12.5`

## Usage

### 1) Export AliCloud access key and secret key as environment variables.
```shell script
export ALICLOUD_ACCESS_KEY=xxx
export ALICLOUD_SECRET_KEY=xxx

```

### 2) Include the module in `main.tf`
```hcl
module "openshift" {
  source = "../../modules"
}
```

### 3) Set your own public key in `variables.tf`
```hcl
variable "key_name" {
  default = "poc"
}

variable "public_key" {
  default = "ssh-rsa xxx"
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region  | The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile | string  | ""  | yes  |
| instance_name  | Name used on all instances as prefix. Like TF-ECS-Instance-1, TF-ECS-Instance-2.  | string  | "TF-ECS-Instance"  | yes  |
| number_format  | The number format used to output. | string  | %02d  | yes  |
| ecs_instance_count  | Count of ECS instances | int  | 1 | yes  |
| availability_zone  | The Zone to start the instance in. It is ignored and will be computed when set vswitch_id. | string  | ""  | yes  |
| internet_max_bandwidth_out  | Maximum outgoing bandwidth to the public network | int  | 1  | no  |
| key_name  | The name of key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid. | string  | ""  | yes  |
| public_key  | Public key text | string  | ""  | yes  |
| cidr_block_vpc  | VPC CIDR block  | string  | "10.0.0.0/18"  | yes  |
| cidr_block_vswitch  | VSwitch CIDR block  | string  | "10.0.0.0/20"  | yes  |
| disk_category  | Filter the results by a specific disk category. Can be either `cloud`, `cloud_efficiency`, `cloud_ssd`, `ephemeral_ssd`. | string  | "cloud_efficiency"  | no |
| disk_size  | The system disk size used to launch one or more ecs instances.  | string  | "40"  |  no |
| disk_count  | The count of the system disks  | int  | 1  |  yes |

## Outputs

| Name | Description |
|------|-------------|
| OpenShift  | OpenShift URL  |
| Username  | The user name to login in OpenShift  |
| Password  | The password to login in OpenShift  |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [zzxwill](https://github.com/zzxwill) with code source in [terraform-alicloud-openshift](https://github.com/zzxwill/terraform-alicloud-openshift).

## License

MIT Licensed. See LICENSE for full details.