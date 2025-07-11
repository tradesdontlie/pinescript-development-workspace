# Pine Script Development Makefile

.PHONY: help validate-all validate-working new-indicator copy-to-working clean-objects check-memory lint version-file promote-to-production pre-commit

# Default target
help:
	@echo "Pine Script Development Commands:"
	@echo ""
	@echo "🔍 Validation & Quality:"
	@echo "  make validate-all       - Validate all Pine Script files"
	@echo "  make validate-working   - Validate files in working directory"
	@echo "  make check-memory       - Check for memory management issues"
	@echo "  make lint              - Run comprehensive linting"
	@echo ""
	@echo "🛠️ Development Workflow:"
	@echo "  make new-indicator      - Create new indicator template"
	@echo "  make copy-to-working    - Copy indicator to working directory"
	@echo "  make dev               - Setup development environment"
	@echo ""
	@echo "📦 Versioning & Release:"
	@echo "  make version-file FILE=path TYPE=patch|minor|major"
	@echo "                         - Create semantic version of file"
	@echo "  make promote-to-production FILE=path"
	@echo "                         - Move validated file to production"
	@echo "  make pre-commit        - Complete pre-commit validation"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  make clean-objects     - Clean up temporary objects"

# Validate all Pine Script files
validate-all:
	@echo "🔍 Validating all Pine Script files..."
	@find . -name "*.pine" -type f -exec python scripts/validate_pine_script.py {} \;

# Validate working directory files
validate-working:
	@echo "🔍 Validating working directory files..."
	@find working/ -name "*.pine" -type f -exec python scripts/validate_pine_script.py {} \;

# Create new indicator template
new-indicator:
	@read -p "Enter indicator name: " name; \
	read -p "Enter category (fvg/ghost/oracle/sessions/vortex): " category; \
	mkdir -p "working/$$category"; \
	echo '//@version=6' > "working/$$category/$$name.pine"; \
	echo 'indicator("'$$name'", overlay=true)' >> "working/$$category/$$name.pine"; \
	echo '' >> "working/$$category/$$name.pine"; \
	echo '// Input parameters' >> "working/$$category/$$name.pine"; \
	echo 'length = input.int(20, "Length", minval=1)' >> "working/$$category/$$name.pine"; \
	echo '' >> "working/$$category/$$name.pine"; \
	echo '// Main calculation' >> "working/$$category/$$name.pine"; \
	echo 'result = ta.sma(close, length)' >> "working/$$category/$$name.pine"; \
	echo '' >> "working/$$category/$$name.pine"; \
	echo '// Plot' >> "working/$$category/$$name.pine"; \
	echo 'plot(result, "'$$name'", color=color.blue)' >> "working/$$category/$$name.pine"; \
	echo '' >> "working/$$category/$$name.pine"; \
	echo '// Object cleanup (if using drawing objects)' >> "working/$$category/$$name.pine"; \
	echo 'if barstate.islastconfirmedhistory' >> "working/$$category/$$name.pine"; \
	echo '    // Clean up objects here' >> "working/$$category/$$name.pine"; \
	echo '    //object.delete()' >> "working/$$category/$$name.pine"
	@echo "✅ Created new indicator: working/$$category/$$name.pine"

# Copy indicator to working directory
copy-to-working:
	@read -p "Enter source file path: " source; \
	read -p "Enter target category: " category; \
	mkdir -p "working/$$category"; \
	cp "$$source" "working/$$category/"; \
	echo "✅ Copied $$source to working/$$category/"

# Check for memory management issues
check-memory:
	@echo "🧠 Checking memory management patterns..."
	@for file in $$(find . -name "*.pine" -type f); do \
		if grep -q -E "(line\.new|label\.new|box\.new|table\.new|linefill\.new|polyline\.new)" "$$file"; then \
			echo "📄 $$file: Contains drawing objects"; \
			if ! grep -q "barstate.islastconfirmedhistory" "$$file"; then \
				echo "  ⚠️  Missing cleanup pattern"; \
			else \
				echo "  ✅ Has cleanup pattern"; \
			fi; \
		fi; \
	done

# Run comprehensive linting
lint: validate-all check-memory
	@echo "🔧 Running comprehensive Pine Script linting..."
	@echo "✅ Linting complete"

# Clean up temporary objects
clean-objects:
	@echo "🧹 Cleaning temporary objects..."
	@find . -name "*.tmp" -delete
	@find . -name ".DS_Store" -delete
	@echo "✅ Cleanup complete"

# Quick development workflow
dev: validate-working
	@echo "🚀 Development environment ready"

# Semantic versioning for Pine Script files
version-file:
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make version-file FILE=working/fvg/my_indicator.pine TYPE=patch"; \
		exit 1; \
	fi
	@if [ ! -f "$(FILE)" ]; then \
		echo "❌ Error: File not found: $(FILE)"; \
		exit 1; \
	fi
	@echo "📦 Creating semantic version for $(FILE)..."
	@bash scripts/create_version.sh "$(FILE)" "$(or $(TYPE),minor)"

# Promote file from working to production with validation
promote-to-production:
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make promote-to-production FILE=working/ghost/my_indicator.pine"; \
		exit 1; \
	fi
	@echo "🔍 Validating file before promotion..."
	@python scripts/validate_pine_script.py "$(FILE)" || (echo "❌ Validation failed. Fix errors before promotion." && exit 1)
	@echo "🧠 Checking memory management..."
	@bash scripts/check_file_memory.sh "$(FILE)" || (echo "❌ Memory management issues found." && exit 1)
	@echo "📦 Creating version before promotion..."
	@bash scripts/create_version.sh "$(FILE)" minor
	@echo "🚀 Promoting to production..."
	@bash scripts/promote_file.sh "$(FILE)"

# Complete pre-commit validation workflow
pre-commit: validate-working check-memory
	@echo "✅ Pre-commit validation complete - ready for commit"