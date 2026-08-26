.PHONY: tf.fmt.ci tf.fmt tf.init tf.validate
tf.fmt:
	@terraform -chdir=$(INFRA_DIR) fmt -recursive -diff
tf.fmt.ci:
	@terraform -chdir=$(INFRA_DIR) fmt -recursive -check

tf.init:
	@for d in $(INFRA_DIR)/infra/modules/*/ $(TF_ENV_DIR); do \
		echo "$(INFO_COLOR)==> terraform init: $$d$(RESET_COLOR)"; \
		terraform -chdir=$$d init -backend=false -input=false; \
	done

tf.validate: tf.init
	@for d in $(INFRA_DIR)/infra/modules/*/ $(TF_ENV_DIR); do \
		echo "$(INFO_COLOR)==> terraform validate: $$d$(RESET_COLOR)"; \
		terraform -chdir=$$d validate; \
	done
