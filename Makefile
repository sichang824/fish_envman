.PHONY: install uninstall test help

FISH_CONFIG_PATH := $(HOME)/.config/fish
INSTALL_PATH := $(FISH_CONFIG_PATH)/functions
COMPLETION_PATH := $(FISH_CONFIG_PATH)/completions
CONF_PATH := $(FISH_CONFIG_PATH)/conf.d

help:
	@echo "Usage:"
	@echo "  make install    - Install envman to your fish configuration"
	@echo "  make uninstall  - Remove envman from your fish configuration"
	@echo "  make test       - Run test suite"

install:
	@echo "Installing envman..."
	@mkdir -p $(INSTALL_PATH)
	@mkdir -p $(COMPLETION_PATH)
	@mkdir -p $(CONF_PATH)
	@cp functions/envman.fish $(INSTALL_PATH)/
	@cp completions/envman.fish $(COMPLETION_PATH)/
	@cp conf.d/env_variables.fish $(CONF_PATH)/
	@echo "Installation complete!"

uninstall:
	@echo "Uninstalling envman..."
	@rm -f $(INSTALL_PATH)/envman.fish
	@rm -f $(COMPLETION_PATH)/envman.fish
	@rm -f $(CONF_PATH)/env_variables.fish
	@echo "Uninstallation complete!"

conf:
	@mkdir -p $(CONF_PATH)
	@printf "# Predefined environment variables\n# Format: set env_vars_NAME VALUE\n" > ./conf.d/env_variables.fish

test:
	@echo "No tests implemented yet."
