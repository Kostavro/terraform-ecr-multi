package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

// Testing creation of two repositories with policies
func TestECRBasic(t *testing.T) {

	// Initialize needed variables
	ecrRepoA := fmt.Sprintf("ecr-repo-test-%s", strings.ToLower(random.UniqueId()))

	ecrRepoB := fmt.Sprintf("ecr-repo-test-%s", strings.ToLower(random.UniqueId()))
	repoLifecyclePolicy := `{\"rules\":[{\"rulePriority\":1,\"description\":\"Keep last 10 images\",\"selection\":{\"tagStatus\":\"any\",\"countType\":\"imageCountMoreThan\",\"countNumber\":10},\"action\":{\"type\":\"expire\"}}]}`
	repoPermissionsPolicy := `{\"Version\":\"2008-10-17\",\"Statement\":[{\"Sid\":\"Allow access to repositories from demo account\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"235470632765\"]},\"Action\":\"ecr:*\"}]}`

	ecrRepoMap := map[string]map[string]interface{}{
		ecrRepoA: {
			"tags": nil,
		},
		ecrRepoB: {
			"image_tag_mutability": "MUTABLE",
			"tags":                 nil,
			"lifecycle_policy":     repoLifecyclePolicy,
			"permissions_policy":   repoPermissionsPolicy,
		},
	}

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "../", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempTestFolder,
		Vars: map[string]interface{}{
			"repositories": ecrRepoMap,
		},
		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	assert.Contains(t, terraform.Output(t, terraformOptions, "ecr_repository_names"), ecrRepoA)
	assert.Contains(t, terraform.Output(t, terraformOptions, "ecr_repository_names"), ecrRepoB)
	assert.NotNil(t, terraform.Output(t, terraformOptions, "ecr_repository_arns"))
	assert.NotNil(t, terraform.Output(t, terraformOptions, "ecr_repository_registry_ids"))
	assert.NotNil(t, terraform.Output(t, terraformOptions, "ecr_repository_urls"))
}
