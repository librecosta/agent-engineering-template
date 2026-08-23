SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

REQUIRED_FILES := \
	README.md \
	AGENTS.md \
	CHANGELOG.md \
	CONTRIBUTING.md \
	.agents/architecture.md \
	.agents/playbook.md \
	contracts/compatibility.md \
	contracts/data.md \
	contracts/upstream.md \
	docs/decisions/README.md \
	docs/decisions/0001-use-monorepo.md \
	docs/decisions/0002-prefer-executable-constraints.md

REQUIRED_DIRS := \
	.github \
	.agents \
	contracts \
	docs/decisions \
	apps \
	packages \
	migrations \
	tests

.PHONY: help setup check check-structure check-whitespace

help: ## Show available commands
	@printf "Agent Engineering Template\n\n"
	@printf "Usage:\n  make <target>\n\n"
	@printf "Targets:\n"
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Verify the minimal local toolchain
	@command -v bash >/dev/null 2>&1 || { echo "error: bash is required"; exit 1; }
	@command -v git >/dev/null 2>&1 || { echo "error: git is required"; exit 1; }
	@echo "Local toolchain is ready."

check: check-structure check-whitespace ## Run all repository-wide verification
	@echo "All checks passed."

check-structure: ## Verify required repository files and directories
	@set -euo pipefail; \
	for file in $(REQUIRED_FILES); do \
		if [[ ! -f "$$file" ]]; then \
			echo "error: required file is missing: $$file"; \
			exit 1; \
		fi; \
	done; \
	for dir in $(REQUIRED_DIRS); do \
		if [[ ! -d "$$dir" ]]; then \
			echo "error: required directory is missing: $$dir"; \
			exit 1; \
		fi; \
	done; \
	echo "Repository structure is valid."

check-whitespace: ## Reject trailing whitespace in tracked text files
	@set -euo pipefail; \
	if git grep -nI -E '[[:blank:]]+$$' -- .; then \
		echo; \
		echo "error: trailing whitespace found"; \
		exit 1; \
	fi; \
	echo "Whitespace check passed."
