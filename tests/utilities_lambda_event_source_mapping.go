package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testLambdaEventSourceMapping(t *testing.T, variant string) {
	t.Parallel()

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	packageLambda(t, variant)

	terraform.Init(t, terraformOptions)

	// Terraform can't deterministically work out which resources to create first,
	// so we need to apply the queue module first, then the rest of the resources.
	targetTerraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
		Targets:      []string{"module.queue"},
	}
	terraform.Apply(t, targetTerraformOptions)

	terraform.Apply(t, terraformOptions)

	uuid := terraform.Output(t, terraformOptions, "uuid")
	assert.NotNil(t, uuid)
}
