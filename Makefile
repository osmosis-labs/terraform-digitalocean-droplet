init:
	terraform init

plan:
	terraform fmt && terraform plan -out tf.plan

apply:
	terraform apply tf.plan

refresh:
	terraform apply -refresh-only

output:
	terraform output

pre:
	pre-commit run -a

docs:
	docker run --rm --volume "${PWD}:/terraform-docs" -u $(shell id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs