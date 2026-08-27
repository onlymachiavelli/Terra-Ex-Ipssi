.PHONY: create.inv ansi.ping ansi.site

SCRIPT_DIR := $(CURDIR)/chore/utils

create.inv:
	@cd $(SCRIPT_DIR) && bash create_inventory.sh $(ENV) $(TF_ENV_DIR) instance_public_ip

ansi.ping: create.inv
	@ansible all -i $(ANSI_DIR)/inventory.ini -m ping

ansi.site: create.inv
	@ansible-playbook -i $(ANSI_DIR)/inventory.ini $(ANSI_DIR)/site.yml
