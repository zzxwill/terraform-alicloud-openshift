resource "alicloud_disk" "poc" {
  availability_zone = alicloud_instance.poc[0].availability_zone
  category          = var.disk_category
  size              = var.disk_size
  count             = var.ecs_instance_count
}

resource "alicloud_disk_attachment" "instance-attachment" {
  count       = var.ecs_instance_count
  disk_id     = element(alicloud_disk.poc.*.id, count.index)
  instance_id = element(alicloud_instance.poc.*.id, count.index)
}
