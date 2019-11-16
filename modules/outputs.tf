output "OpenShift" {
  value = "https://${alicloud_instance.poc.0.public_ip}:8443/console"
}

output "Username" {
  value = "admin"
}

output "Password" {
  value = "123456"
}