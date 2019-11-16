
# Create security group
resource "alicloud_security_group" "poc" {
  name        = "default"
  provider    = "alicloud"
  vpc_id      = alicloud_vpc.vpc.id
  description = "default"
}


resource "alicloud_security_group_rule" "tcp_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.poc.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "icmp" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.poc.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "all" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.poc.id
  cidr_ip           = "0.0.0.0/0"
}
