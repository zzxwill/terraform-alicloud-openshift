package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-alicloud-openshift-example using Terratest.
func TestTerraformAlicloudOpenshiftExample(t *testing.T) {
	t.Parallel()

	expectedText := "poc"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/terraform-alicloud-openshift-example",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"public_key": expectedText,
		},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"varfile.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualTextPublickey := terraform.Output(t, terraformOptions, "public_key")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedText, actualTextPublickey)
}
