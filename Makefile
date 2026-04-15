.PHONY: all lock version-bump-major version-bump-minor version-bump-patch
PROJECT_NAME := trustwise-mcp-server

# Default Target
all: ## Display help message
	@$(MAKE) help

lock:
	uv lock

# --- Version Bump Targets ---

CURRENT_VERSION := $(shell grep '^version' pyproject.toml | head -1 | sed 's/.*"\(.*\)"/\1/')
MAJOR := $(shell echo $(CURRENT_VERSION) | cut -d. -f1)
MINOR := $(shell echo $(CURRENT_VERSION) | cut -d. -f2)
PATCH := $(shell echo $(CURRENT_VERSION) | cut -d. -f3)
HELM_CHARTS := $(shell find helm -name 'Chart.yaml' 2>/dev/null)

version: ## Display current version
	@echo "Current version: $(CURRENT_VERSION)"

version-bump-major: ## Bump major version (e.g. 3.2.1 -> 4.0.0), commit, tag and push to develop
	@BRANCH=$$(git rev-parse --abbrev-ref HEAD) && \
	if [ "$$BRANCH" != "develop" ]; then \
		echo "Error: must be on develop branch (currently on $$BRANCH)"; \
		exit 1; \
	fi
	@git pull origin develop
	$(eval NEW_VERSION := $(shell echo $$(($(MAJOR)+1))).0.0)
	@echo "Bumping version: $(CURRENT_VERSION) -> $(NEW_VERSION)"
	@sed -i 's/^version = ".*"/version = "$(NEW_VERSION)"/' pyproject.toml
	@$(MAKE) lock
	@for chart in $(HELM_CHARTS); do \
		echo "Updating $$chart"; \
		yq -i '.version = "$(NEW_VERSION)"' "$$chart"; \
		yq -i '.appVersion = "$(NEW_VERSION)"' "$$chart"; \
	done
	@git add pyproject.toml uv.lock $(HELM_CHARTS)
	@git commit -m "chore: bump version to $(NEW_VERSION)"
	@git tag -a "$(NEW_VERSION)" -m "Release $(NEW_VERSION)"
	@git push origin develop
	@git push origin "$(NEW_VERSION)"
	@echo "Pushed $(NEW_VERSION) commit and tag to develop"

version-bump-minor: ## Bump minor version (e.g. 3.2.1 -> 3.3.0), commit, tag and push to develop
	@BRANCH=$$(git rev-parse --abbrev-ref HEAD) && \
	if [ "$$BRANCH" != "develop" ]; then \
		echo "Error: must be on develop branch (currently on $$BRANCH)"; \
		exit 1; \
	fi
	@git pull origin develop
	$(eval NEW_VERSION := $(MAJOR).$(shell echo $$(($(MINOR)+1))).0)
	@echo "Bumping version: $(CURRENT_VERSION) -> $(NEW_VERSION)"
	@sed -i 's/^version = ".*"/version = "$(NEW_VERSION)"/' pyproject.toml
	@$(MAKE) lock
	@for chart in $(HELM_CHARTS); do \
		echo "Updating $$chart"; \
		yq -i '.version = "$(NEW_VERSION)"' "$$chart"; \
		yq -i '.appVersion = "$(NEW_VERSION)"' "$$chart"; \
	done
	@git add pyproject.toml uv.lock $(HELM_CHARTS)
	@git commit -m "chore: bump version to $(NEW_VERSION)"
	@git tag -a "$(NEW_VERSION)" -m "Release $(NEW_VERSION)"
	@git push origin develop
	@git push origin "$(NEW_VERSION)"
	@echo "Pushed $(NEW_VERSION) commit and tag to develop"

version-bump-patch: ## Bump patch version (e.g. 3.2.1 -> 3.2.2), commit, tag and push to develop
	@BRANCH=$$(git rev-parse --abbrev-ref HEAD) && \
	if [ "$$BRANCH" != "develop" ]; then \
		echo "Error: must be on develop branch (currently on $$BRANCH)"; \
		exit 1; \
	fi
	@git pull origin develop
	$(eval NEW_VERSION := $(MAJOR).$(MINOR).$(shell echo $$(($(PATCH)+1))))
	@echo "Bumping version: $(CURRENT_VERSION) -> $(NEW_VERSION)"
	@sed -i 's/^version = ".*"/version = "$(NEW_VERSION)"/' pyproject.toml
	@$(MAKE) lock
	@for chart in $(HELM_CHARTS); do \
		echo "Updating $$chart"; \
		yq -i '.version = "$(NEW_VERSION)"' "$$chart"; \
		yq -i '.appVersion = "$(NEW_VERSION)"' "$$chart"; \
	done
	@git add pyproject.toml uv.lock $(HELM_CHARTS)
	@git commit -m "chore: bump version to $(NEW_VERSION)"
	@git tag -a "$(NEW_VERSION)" -m "Release $(NEW_VERSION)"
	@git push origin develop
	@git push origin "$(NEW_VERSION)"
	@echo "Pushed $(NEW_VERSION) commit and tag to develop"

# Display help
help: ## Display this help message
	@echo "Usage: make \033[36m[target]\033[0m \nTargets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'