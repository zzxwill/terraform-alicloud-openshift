# AliCloud Terraform OpenShift module

For English, please visit [English](README.md)

在阿里云 ECS 里一键部署 OpenShift 的 Terraform module.

![alt text](https://github.com/zzxwill/terraform-alicloud-openshift/raw/master/openshift.png)

使用了以下资源:

* [ECS](https://www.terraform.io/docs/providers/alicloud/r/instance.html)
* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)

## Terraform 版本

Terraform `~>  v0.12.5`

## 使用方法

### 1) 设置阿里云 access key 环境变量.

```shell script
export ALICLOUD_ACCESS_KEY=xxx
export ALICLOUD_SECRET_KEY=xxx

```

### 2) 在 `main.tf` 里包含 `OpenShift` module

```hcl
module "openshift" {
  source = "../../modules"
}
```

### 3) 在 `variables.tf` 设置公钥等信息。

```hcl
variable "key_name" {
  default = "poc"
}

variable "public_key" {
  default = "ssh-rsa xxx"
}
```

### 4) `terraform` 命令执行该 module


```shell script
terraform init
terraform apply
```

你将看到如下输出：

```text
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

OpenShift = https://x.x.x.x:8443/console
Password = 123456
Username = admin
```

### 5) OpenShift 环境已经准备就绪，尽情玩耍吧。

![alt text](https://github.com/zzxwill/terraform-alicloud-openshift/raw/master/openshift_console.jpg)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## 输入

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

## 输出

| Name | Description |
|------|-------------|
| OpenShift  | OpenShift URL  |
| Username  | The user name to login in OpenShift  |
| Password  | The password to login in OpenShift  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## 作者

Openshift 一键部署 module 又 [zzxwill](https://github.com/zzxwill) 开发和维护，源代码为 [terraform-alicloud-openshift](https://github.com/zzxwill/terraform-alicloud-openshift).

## License

MIT Licensed.