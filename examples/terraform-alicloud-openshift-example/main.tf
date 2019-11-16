# ---------------------------------------------------------------------------------------------------------------------
# BASIC TERRAFORM EXAMPLE
# See test/terraform_aws_example.go for how to write automated tests for this code.
# ---------------------------------------------------------------------------------------------------------------------
module "openshift" {
  source = "../../modules"
}
