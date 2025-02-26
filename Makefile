PYTHON = python3.11
VENV_DIR = .venv
REQUIREMENTS = requirements.txt
DBT_PACKAGES = dbt_packages/
ENV_FILE = .env

install: check_python check_venv check_env $(VENV_DIR)/bin/activate
	@echo "To activate the virtual environment, run:"
	@echo "source $(VENV_DIR)/bin/activate"

check_python:
	@if ! command -v $(PYTHON) &> /dev/null; then \
		echo "Errorr : $(PYTHON) isnt installed, please consider installing the right version or change it in the Makefile if you are sure this will work"; \
		exit 1; \
	fi

check_venv:
	@if ! $(PYTHON) -m venv --help &> /dev/null; then \
		echo "Error : venv isnt available. Make sure $(PYTHON) is installed with venv support."; \
		exit 1; \
	fi

check_env:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Error : $(ENV_FILE) is missing. Please create it and add the necessary environment variables."; \
		exit 1; \
	fi

$(VENV_DIR)/bin/activate: $(REQUIREMENTS)
	$(PYTHON) -m venv $(VENV_DIR)
	. $(VENV_DIR)/bin/activate && pip install -U pip
	. $(VENV_DIR)/bin/activate && pip install -r $(REQUIREMENTS)
	touch $(VENV_DIR)/bin/activate
	source $(ENV_FILE)
	dbt deps

clean:
	rm -rf $(VENV_DIR)
	rm -rf $(DBT_PACKAGES)
