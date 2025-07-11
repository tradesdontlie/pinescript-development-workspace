# Pine Script Trading Signals & Strategy Engine

A collaborative development platform for creating TradingView indicators, extracting trading signals, and building strategy models.

## 🚀 Quick Start for Team Members

### 1. **Project Requests & Planning**

**Before submitting GitHub issues or PRs**, use the organized workspace:

```bash
# Navigate to project requests workspace
cd project-requests/

# For data point extraction requests
cd data-points/
# Create folder: your-indicator-signal-name/
# Fill out: request.md, signal-analysis.md, test-scenarios.md

# For strategy development requests  
cd strategy-models/
# Create folder: your-strategy-name/
# Document: strategy-plan.md, signal-mapping.md, risk-management.md

# For new feature development
cd development-plans/
# Create folder: your-feature-name/
# Plan: feature-spec.md, technical-design.md, integration-plan.md
```

**See [Project Requests Guide](project-requests/README.md) for complete workflow.**

### 2. **Environment Setup** 

#### **Automated Setup (Recommended)**
```bash
# Run the automated setup script
./setup-pine-script.sh
```

This script will:
- ✅ Configure Cursor CLI
- ✅ Install the custom Pine Script v6 extension
- ✅ Remove conflicting extensions
- ✅ Verify workspace settings

#### **Manual Setup (if automated setup fails)**

**Step 1: Install Cursor CLI**
```bash
# macOS
export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"
echo 'export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
```

**Step 2: Install Pine Script Extension**
```bash
# Install custom extension (if .vsix file is available)
cursor --install-extension pinescript-v6-vscode-0.1.0.vsix

# Or install from marketplace
cursor --install-extension salbert11.pinescript-helper
```

**Step 3: Remove Conflicting Extensions**
```bash
cursor --uninstall-extension ex-codes.pine-script-syntax-highlighter
cursor --uninstall-extension 0xjcf.pine-script-syntax
cursor --uninstall-extension frizlabz.pinescript-v5-vscode
```

#### **Verify Your Setup**
1. **Open any `.pine` file**
2. **Check bottom-right corner** - should show "pine" language mode
3. **Test autocomplete** - type `plot(` and you should see suggestions
4. **Check syntax highlighting** - Pine Script keywords should be colored

#### **Troubleshooting**
- **Extension not working?** Restart Cursor completely
- **No syntax highlighting?** Check file extension is `.pine` and language mode
- **CLI not working?** Close/reopen terminal and verify Cursor installation

### 2. **Understanding the Project Structure**
```
📁 Repository Structure
├── 🏦 pinescript-coding-suite/  # 🎯 MAIN TRADING WORKSPACE
│   ├── 📊 indicators/      # Production-ready indicators
│   ├── 🛠️ working/         # Development workspace (work here first)
│   ├── 🎯 strategies/      # Trading strategies
│   ├── 📦 libraries/       # Reusable Pine Script libraries
│   └── 🔧 scripts/         # Trading automation tools
├── 📚 docs/               # Documentation and guides
├── 🔧 scripts/            # Project automation and utilities
├── 📋 project-requests/   # Team request workspace (see below)
└── 📋 archive/            # Archived files
```

### 2. **Development Workflow**
1. **Work in `pinescript-coding-suite/working/` directory**
2. **Use GitHub Issues** for new data point requests
3. **Submit Pull Requests** when ready for review
4. **Test thoroughly** before submitting

### 3. **Getting Started**
- **Workflow Overview**: See [`docs/WORKFLOW_DIAGRAM.md`](docs/WORKFLOW_DIAGRAM.md) for complete development flow
- **Project Planning**: Use [`project-requests/`](project-requests/) to organize requests before GitHub submission
- **New team members**: Read [`docs/TEAM_MEMBER_GUIDE.md`](docs/TEAM_MEMBER_GUIDE.md)
- **How to contribute**: See [`docs/HOW_TO_USE.md`](docs/HOW_TO_USE.md)
- **Development guidelines**: Check [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md)

---

## 🎯 Project Goals

### **Data Point Extraction**
Convert existing indicators into tradeable signals that can be consumed by strategy engines.

### **Signal Classification System**
- 🎯 **Bias Filters** - Trend direction (bullish/bearish)
- ⚡ **Momentum Filters** - Signal strength/speed
- 🎪 **Execution Filters** - Entry/exit timing
- 🔄 **Confluence Filters** - Multi-factor validation

### **TTS Integration**
All signals follow the TTS (Template Trailing Strategy) standard:
- `1` = Long Entry
- `-1` = Short Entry
- `2` = Long Exit
- `-2` = Short Exit
- `0` = No Signal

---

## 📊 Current Indicators

### **FVG (Fair Value Gap)**
- **Location**: `pinescript-coding-suite/indicators/fvg/`
- **Status**: Production ready
- **Data Points Needed**: Volume confirmation, multi-timeframe alignment

### **Ghost Volume Intelligence**
- **Location**: `pinescript-coding-suite/indicators/ghost/`
- **Status**: Advanced indicator available
- **Data Points Needed**: Momentum strength, pressure quantification

### **Oracle Alliance**
- **Location**: `pinescript-coding-suite/indicators/oracle/`
- **Status**: Signal indicator available
- **Data Points Needed**: Entry timing, session alignment

### **Session Analysis**
- **Location**: `pinescript-coding-suite/indicators/sessions/`
- **Status**: Basic implementation
- **Data Points Needed**: Break detection, pattern recognition

### **Vortex Engine**
- **Location**: `pinescript-coding-suite/indicators/vortex/`
- **Status**: Engine available
- **Data Points Needed**: Momentum divergence, strength analysis

### **Market Cycles**
- **Location**: `pinescript-coding-suite/indicators/cycles/`
- **Status**: Cycle detection available
- **Data Points Needed**: Phase identification, transition alerts

---

## 🔧 Development Tools & Commands

### **Makefile: Your Pine Script Development Assistant**

This repository includes a comprehensive Makefile that automates Pine Script development workflows, validation, and quality assurance. The Makefile integrates with the project's advanced rule system and VS Code extension for intelligent development.

#### **🚀 Quick Start with Makefile**
```bash
# See all available commands
make help

# Ready your development environment
make dev

# Create a new indicator template
make new-indicator
```

#### **📋 Complete Makefile Command Reference**

**🔍 Validation & Quality Assurance**
```bash
# Validate all Pine Script files in the repository
make validate-all
# ✅ Runs Python validator against all .pine files
# ✅ Checks Pine Script v6 syntax compliance
# ✅ Validates against extracted rule patterns

# Validate only working directory (faster during development)
make validate-working
# ✅ Focuses on active development files
# ✅ Perfect for iterative development workflow

# Check memory management patterns
make check-memory
# ✅ Identifies drawing objects (line, label, box, table, etc.)
# ✅ Validates proper cleanup with barstate.islastconfirmedhistory
# ✅ Prevents memory leaks in Pine Script indicators

# Run comprehensive linting (combines validation + memory check)
make lint
# ✅ Complete code quality check
# ✅ Pine Script v6 compliance verification
# ✅ Best practice enforcement
```

**🛠️ Development Workflow**
```bash
# Create new indicator from template
make new-indicator
# 📝 Interactive prompts for:
#     - Indicator name
#     - Category (fvg/ghost/oracle/sessions/vortex)
# ✅ Creates proper Pine Script v6 structure
# ✅ Includes memory cleanup template
# ✅ Places in working/ directory

# Copy existing indicator to working directory
make copy-to-working
# 📝 Interactive prompts for:
#     - Source file path
#     - Target category
# ✅ Maintains directory organization
# ✅ Follows working-first development pattern

# Quick development environment setup
make dev
# ✅ Validates working directory
# ✅ Confirms development environment ready
```

**📦 Automated Versioning & Release Management**
```bash
# Create semantic version of a Pine Script file
make version-file FILE=working/fvg/my_indicator.pine TYPE=patch
# ✅ Creates versioned backup in versions/ directory
# ✅ Updates VERSION_HISTORY.md automatically  
# ✅ Supports major/minor/patch semantic versioning
# ✅ Lint-free validation before versioning

# Promote working file to production with full validation
make promote-to-production FILE=working/ghost/my_indicator.pine
# ✅ Validates syntax and memory management
# ✅ Creates automatic version backup
# ✅ Moves file to appropriate production directory
# ✅ Transfers version history

# Complete pre-commit validation
make pre-commit
# ✅ Validates all working files
# ✅ Checks memory management
# ✅ Ensures code quality before commits
```

**🧹 Maintenance & Cleanup**
```bash
# Clean temporary files
make clean-objects
# ✅ Removes .tmp files
# ✅ Removes .DS_Store files
# ✅ Maintains clean repository
```

#### **💡 Pine Script Development Best Practices with Makefile**

**1. Start Every Development Session**
```bash
# Always begin with validation
make dev
# This ensures your working directory is clean and valid
```

**2. Create New Indicators Properly**
```bash
# Use the template system
make new-indicator
# Enter: "MyAwesome_Signal" for name
# Enter: "ghost" for category
# Result: working/ghost/MyAwesome_Signal.pine with proper v6 structure
```

**3. Pre-Commit Quality Checks**
```bash
# Before any commit or production move
make lint
# Comprehensive validation + memory management check
```

**4. Memory Management Validation**
```bash
# Essential for indicators with drawing objects
make check-memory
# Ensures proper cleanup patterns are in place
```

#### **🔧 Advanced Makefile Integration with Pine Script Rules**

The Makefile leverages the repository's sophisticated rule system:

**Rule-Based Validation**
- **`scripts/validate_pine_script.py`** integrates with `Pinescript-Coding-Suite/extracted_rules/`
- **Error Pattern Detection**: Uses `pine_error_patterns.json` for common issues
- **v6 Compliance**: Enforces `pine_v6_specific.json` requirements
- **Best Practices**: Validates against `pine_best_practices.json`

**Smart Template Generation**
```pine
# Templates include proper v6 patterns:
//@version=6
indicator("YourIndicator", overlay=true)

// Object cleanup template
if barstate.islastconfirmedhistory
    // Clean up objects here
```

**Memory Management Intelligence**
- Automatically detects: `line.new`, `label.new`, `box.new`, `table.new`, `linefill.new`, `polyline.new`
- Validates cleanup patterns with `barstate.islastconfirmedhistory`
- Prevents common Pine Script memory leak issues

#### **🤖 Automated Versioning Workflow with Claude Code**

The Makefile includes intelligent automated versioning that works seamlessly with Claude Code for professional Pine Script development:

**🔄 Automatic Version Management**
```bash
# Claude Code can automatically version your indicators
# Before editing: Ensure file is lint-free
make validate-working

# Claude automatically creates versions during development
make version-file FILE=working/fvg/my_enhanced_indicator.pine TYPE=minor
# ✅ Creates: working/fvg/versions/my_enhanced_indicator_v0.2.0.pine
# ✅ Updates: working/fvg/versions/VERSION_HISTORY.md
# ✅ Maintains: Complete development history

# When ready for production, Claude promotes with validation
make promote-to-production FILE=working/fvg/my_enhanced_indicator.pine
# ✅ Validates: Syntax, memory management, best practices
# ✅ Creates: Final version backup  
# ✅ Promotes: To indicators/fvg/ directory
# ✅ Transfers: All version history
```

**🎯 Semantic Versioning Intelligence**
- **`TYPE=patch`**: Bug fixes, small corrections (1.0.0 → 1.0.1)
- **`TYPE=minor`**: New features, enhancements (1.0.0 → 1.1.0) 
- **`TYPE=major`**: Breaking changes, major rewrites (1.0.0 → 2.0.0)

**📁 Version Organization**
```
working/fvg/my_indicator.pine          # Current development file
working/fvg/versions/                  # Version history directory
├── my_indicator_v0.1.0.pine          # Initial version
├── my_indicator_v0.2.0.pine          # Minor update
├── my_indicator_v0.2.1.pine          # Bug fix
└── VERSION_HISTORY.md                # Detailed change log
```

**🚀 Claude Code Integration Benefits**
- **Pre-Version Validation**: Always ensures lint-free code before versioning
- **Automatic Documentation**: Updates VERSION_HISTORY.md with timestamps
- **Memory Management**: Validates drawing object cleanup patterns
- **Production Safety**: Multi-layer validation before promotion
- **Development Continuity**: Never lose working versions

#### **🎯 Example Development Workflow Using Makefile**

**Scenario: Creating a New FVG Enhancement**
```bash
# Step 1: Prepare development environment
make dev
# ✅ Validates working directory

# Step 2: Create new indicator
make new-indicator
# Enter: "FVG_Enhanced_v2"
# Enter: "fvg"
# ✅ Creates: working/fvg/FVG_Enhanced_v2.pine

# Step 3: Develop your indicator (edit the file)
# ... coding in VS Code with Pine Script extension ...

# Step 4: Validate during development
make validate-working
# ✅ Checks syntax and rule compliance

# Step 5: Check memory management (if using drawing objects)
make check-memory
# ✅ Ensures proper cleanup patterns

# Step 6: Create version before major changes
make version-file FILE=working/fvg/FVG_Enhanced_v2.pine TYPE=minor
# ✅ Creates v0.1.0 backup in versions/ directory

# Step 7: Final quality check before commit
make lint
# ✅ Comprehensive validation

# Step 8: Promote to production when ready
make promote-to-production FILE=working/fvg/FVG_Enhanced_v2.pine
# ✅ Full validation + production deployment
```

**Scenario: Working with Existing Indicators**
```bash
# Copy production indicator to working directory
make copy-to-working
# Enter: "indicators/ghost/Ghost_Volume_Intelligence_Pro.pine"
# Enter: "ghost"
# ✅ Copied to: working/ghost/

# Validate the copied file
make validate-working
# ✅ Ensures clean starting point

# After modifications, check quality
make lint
# ✅ Validates changes don't break anything
```

#### **🚨 Common Validation Errors the Makefile Catches**

**Pine Script v6 Syntax Issues**
```bash
# The validator detects:
- Missing //@version=6 declaration
- Incorrect function signatures
- Type consistency problems
- Series/simple type mismatches
```

**Memory Management Issues**
```bash
# Memory checker identifies:
- Drawing objects without cleanup
- Missing barstate.islastconfirmedhistory guards
- Potential memory leak patterns
```

**Best Practice Violations**
```bash
# Rule validation catches:
- Array access without bounds checking
- Deprecated v5 patterns in v6 code
- Performance anti-patterns
```

### **Manual Development Commands**
```bash
# Navigate to main trading workspace
cd pinescript-coding-suite/

# Manual file operations (when Makefile isn't suitable)
cp indicators/fvg/fvg.pine working/fvg/my_new_feature.pine

# Test your indicator in TradingView
# Copy content from working/ file to TradingView Pine Editor
```

### **Project Management**
- **Issues**: https://github.com/tradesdontlie/pinescript-codebase/issues
- **Project Board**: https://github.com/users/tradesdontlie/projects/2
- **Pull Requests**: https://github.com/tradesdontlie/pinescript-codebase/pulls

---

## 📋 For Team Members

### **Request New Data Points**
1. Go to [Issues](https://github.com/tradesdontlie/pinescript-codebase/issues)
2. Click "New Issue"
3. Choose "Data Point Request" template
4. Fill out the specifications

### **Submit Code Changes**
1. Work in `pinescript-coding-suite/working/` directory
2. Test thoroughly on TradingView
3. Create Pull Request with template
4. Wait for review and approval

### **Quality Standards**
- ✅ Pine Script v6 compliance
- ✅ No compilation errors
- ✅ TTS integration (where applicable)
- ✅ Multi-timeframe testing
- ✅ Clear documentation

---

## 🆘 Need Help?

- **Team Guide**: [`docs/TEAM_MEMBER_GUIDE.md`](docs/TEAM_MEMBER_GUIDE.md)
- **Technical Issues**: Create an issue with "Bug" template
- **Questions**: Ask in issue comments or team meetings
- **Project Setup**: See [`docs/PROJECT_SETUP_GUIDE.md`](docs/PROJECT_SETUP_GUIDE.md)

---

## 📈 Project Status

**Current Sprint**: Data Points Codification
- 7 data points identified and documented
- Advanced GitHub Project configured
- Team collaboration workflow established

**Next Milestone**: Core signal extraction completed

---

*This repository uses Pine Script v6 and follows TTS integration standards for all trading signals.*