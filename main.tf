# Configure the Alicloud Provider
provider "alicloud" {
  region               = var.region
  configuration_source = "github.com/zzxwill/terraform-alicloud-openshift"
}

data "alicloud_images" "poc" {
  most_recent = true
  owners      = "system"
  name_regex  = "^centos_7_06"
}

# Use a publick key to create a ssh key resource in Alicloud
resource "alicloud_key_pair" "poc" {
  key_name   = var.key_name
  public_key = var.public_key
}

#
resource "alicloud_instance" "poc" {
  provider                   = "alicloud"
  image_id                   = data.alicloud_images.poc.images[0].id
  internet_charge_type       = "PayByTraffic"
  instance_type              = "ecs.g6.2xlarge"
  system_disk_category       = "cloud_efficiency"
  security_groups            = [alicloud_security_group.poc.id]
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  count                      = var.ecs_instance_count
  instance_name              = format("%s-%s", var.instance_name, format(var.number_format, count.index))
  key_name                   = alicloud_key_pair.poc.key_name
  # password = var.password
  host_name = format("%s%s", var.instance_name, format(var.number_format, count.index))

}

locals {
  instance_id = element(alicloud_instance.poc.*.public_ip, 0)
}

resource "null_resource" "openshift" {
  provisioner "local-exec" {
    command = "sleep 30 && scp -o StrictHostKeyChecking=no okd.sh root@${local.instance_id}:/opt && ssh root@${local.instance_id} sh /opt/okd.sh ${local.instance_id}"
  }

  connection {
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = element(alicloud_instance.poc.*.public_ip, 0)
  }

  //  provisioner "file" {
  //    source      = "okd.sh"
  //    destination = "/opt/okd.sh"
  //  }
  //
  //  provisioner "remote-exec" {
  //    inline = [
  //      "nohup sh /opt/okd.sh ${alicloud_instance.poc.0.public_ip} &"
  //    ]
  //  }

  depends_on = [alicloud_instance.poc]
}

resource "alicloud_vpc" "vpc" {
  name       = "poc"
  cidr_block = var.cidr_block_vpc
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = var.cidr_block_vswitch
  availability_zone = var.availability_zone
}
