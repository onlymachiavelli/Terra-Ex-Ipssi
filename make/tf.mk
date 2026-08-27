.PHONY: tf.fmt.ci tf.fmt tf.init tf.init.lock tf.validate tf.plan tf.apply tf.destroy tf.output
tf.fmt:
	@terraform -chdir=$(INFRA_DIR) fmt -recursive -diff
tf.fmt.ci:
	@terraform -chdir=$(INFRA_DIR) fmt -recursive -check

tf.init:
	@for d in $(INFRA_DIR)/infra/modules/*/ $(TF_ENV_DIR); do \
		echo "$(INFO_COLOR)==> terraform init: $$d$(RESET_COLOR)"; \
		terraform -chdir=$$d init -backend=false -input=false; \
	done

tf.init.lock:
	@echo "$(INFO_COLOR)==> terraform init (backend, locked): $(TF_ENV_DIR)$(RESET_COLOR)"
	@terraform -chdir=$(TF_ENV_DIR) init -input=false

tf.validate: tf.init
	@for d in $(INFRA_DIR)/infra/modules/*/ $(TF_ENV_DIR); do \
		echo "$(INFO_COLOR)==> terraform validate: $$d$(RESET_COLOR)"; \
		terraform -chdir=$$d validate; \
	done

tf.plan: tf.init.lock
	@terraform -chdir=$(TF_ENV_DIR) plan

tf.apply: tf.init.lock
	@terraform -chdir=$(TF_ENV_DIR) apply

tf.destroy:
	@terraform -chdir=$(TF_ENV_DIR) destroy

tf.output:
	@terraform -chdir=$(TF_ENV_DIR) output
