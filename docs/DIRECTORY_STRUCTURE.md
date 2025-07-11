# Repository Directory Structure

## 📁 Clean Organization for Team Collaboration

### **Root Directory**
```
📁 Pine Script Trading Signals & Strategy Engine/
├── 🏦 pinescript-coding-suite/          # 🎯 MAIN TRADING WORKSPACE
│   ├── 📊 indicators/              # Production-ready indicators
│   ├── 🛠️ working/                 # Development workspace
│   ├── 🎯 strategies/              # Trading strategies
│   ├── 📦 libraries/               # Reusable components
│   ├── 🔧 scripts/                 # Trading automation tools
│   ├── 📚 docs/                    # Advanced development docs
│   ├── 🗃️ database/                # Solution database
│   └── 🔧 pine-script-v6-extension/ # VS Code extension
├── 📚 docs/                       # Team documentation
├── 🔧 scripts/                    # Project automation tools
├── 📋 archive/                    # Archived/outdated files
├── 🖼️ screenshots/                # Visual documentation
├── 📄 README.md                   # Main project guide
└── 📄 CLAUDE.md                   # AI assistant instructions
```

---

## 🏦 **pinescript-coding-suite/** - Main Trading Workspace

**Purpose**: Everything trading-related is organized within this directory

### 📊 **pinescript-coding-suite/indicators/** - Production Indicators

**Purpose**: Stable, tested indicators ready for live trading

```
pinescript-coding-suite/indicators/
├── fvg/                           # Fair Value Gap
│   ├── fvg.pine                   # Main FVG indicator
│   ├── versions/                  # Version history
│   └── final-versions/            # Stable releases
├── ghost/                         # Ghost Volume Intelligence
│   ├── Ghost_Volume_Intelligence_Pro.pine
│   ├── final-versions/
│   └── versions/
├── oracle/                        # Oracle Alliance
├── sessions/                      # Session Analysis
├── vortex/                        # Vortex Engine
├── cycles/                        # Market Cycles
└── libraries/                     # Shared libraries
```

**Team Usage**: 
- ✅ **Copy FROM here** to working/ for modifications
- ❌ **Never edit directly** - use working/ instead
- ✅ **Reference for** existing functionality

---

### 🛠️ **pinescript-coding-suite/working/** - Development Workspace

**Purpose**: Active development area where all coding happens

```
pinescript-coding-suite/working/
├── fvg/                           # FVG development
├── ghost/                         # Ghost development
├── oracle/                        # Oracle development
├── sessions/                      # Sessions development
├── vortex/                        # Vortex development
├── cycles/                        # Cycles development
├── strategy/                      # Strategy development
├── testing/                       # Experimental features
└── README.md                      # Development guidelines
```

**Team Usage**:
- ✅ **Work HERE first** - all development starts here
- ✅ **Create feature branches** for new development
- ✅ **Test thoroughly** before submitting PRs
- ✅ **Submit PRs** from working/ to indicators/

---

## 📚 **docs/** - Documentation Hub

**Purpose**: All project documentation in one place

```
docs/
├── TEAM_MEMBER_GUIDE.md           # How to contribute
├── HOW_TO_USE.md                  # Quick start guide
├── CONTRIBUTING.md                # Development guidelines
├── PROJECT_SETUP_GUIDE.md         # Project configuration
├── ADVANCED_PROJECT_FEATURES.md   # Advanced features
├── CUSTOM_VIEWS_SETUP.md          # GitHub Project views
├── DIRECTORY_STRUCTURE.md         # This file
└── [future documentation]
```

**Team Usage**:
- ✅ **Read first** - essential guides for team members
- ✅ **Reference during** development
- ✅ **Update when** adding new features

---

## 🔧 **scripts/** - Automation Tools

**Purpose**: Helpful scripts for project management and automation

```
scripts/
├── automation/                    # Project automation scripts
│   ├── setup_advanced_automations.sh
│   ├── setup_project.sh
│   ├── setup_project_fields.sh
│   └── configure_project_items.sh
├── utilities/                     # Utility scripts
│   └── CREATE_GITHUB_REPO.sh
└── README.md                      # Scripts documentation
```

**Team Usage**:
- ✅ **Optional to use** - scripts enhance workflow but aren't required
- ✅ **Run when needed** - for project setup or automation
- ⚠️ **Check with team lead** before running automation scripts

---

## 🎯 **strategies/** - Trading Strategies

**Purpose**: Complete trading strategies that use multiple indicators

```
strategies/
└── Signal_Composite_Engine.pine   # Multi-signal strategy
```

**Team Usage**:
- ✅ **Final strategies** go here after development
- ✅ **Use signals** from indicators/ directory
- ✅ **Test thoroughly** before production use

---

## 📦 **libraries/** - Reusable Components

**Purpose**: Shared Pine Script libraries and utilities

```
libraries/
└── risk_management.pine           # Risk management utilities
```

**Team Usage**:
- ✅ **Import into** your indicators
- ✅ **Add new utilities** that multiple indicators can use
- ✅ **Keep generic** - specific logic goes in indicators/

---

## 📋 **archive/** - Archived Files

**Purpose**: Old files that are no longer needed but kept for reference

```
archive/
├── GITHUB_QUICK_SETUP.md          # Outdated setup guide
├── IMPLEMENTATION_GUIDE.md        # Old implementation docs
├── MANUAL_PROJECT_SETUP.md        # Manual setup instructions
├── README_REPO.md                 # Old README version
└── WORKFLOW_SETUP.md              # Old workflow docs
```

**Team Usage**:
- ✅ **Ignore these files** - they're outdated
- ✅ **Reference if needed** for historical context
- ❌ **Don't use** for current development

---

## 🖼️ **screenshots/** - Visual Documentation

**Purpose**: Screenshots and visual aids for documentation

```
screenshots/
└── [project screenshots]
```

**Team Usage**:
- ✅ **Add screenshots** of your indicators
- ✅ **Document visual** features
- ✅ **Help with** troubleshooting

---

## **Hidden/System Directories**

### **pinescript-coding-suite/** - Advanced Development Tools
- **Purpose**: Advanced AI-assisted development tools
- **Team Usage**: Optional - contains advanced automation and documentation
- **Status**: Can be ignored by most team members

### **servers-archived/** - Archived Server Code
- **Purpose**: Old server-related code
- **Team Usage**: Ignore - not relevant to Pine Script development

---

## 🎯 **Quick Navigation for Team Members**

### **🚀 I'm New - Where Do I Start?**
1. Read [`README.md`](../README.md) 
2. Check [`docs/TEAM_MEMBER_GUIDE.md`](TEAM_MEMBER_GUIDE.md)
3. Look at [`docs/HOW_TO_USE.md`](HOW_TO_USE.md)

### **🔧 I Want to Develop**
1. Copy from `indicators/` to `working/`
2. Make changes in `working/`
3. Test thoroughly
4. Submit PR

### **📊 I Want to See Current Indicators**
1. Browse `indicators/` directory
2. Check each category (fvg, ghost, oracle, etc.)
3. Review `final-versions/` for stable releases

### **📋 I Need Help**
1. Check `docs/` directory first
2. Create GitHub issue
3. Ask in team meetings

---

## 📝 **File Organization Best Practices**

### **✅ DO:**
- Work in `working/` directory
- Use descriptive file names
- Keep documentation updated
- Archive old files instead of deleting

### **❌ DON'T:**
- Edit `indicators/` directly
- Leave files scattered in root
- Skip documentation updates
- Delete files without archiving

---

## 🔄 **Directory Maintenance**

### **Weekly Tasks:**
- Clean up `working/` directory
- Archive outdated files
- Update documentation
- Organize new files properly

### **Monthly Tasks:**
- Review `archive/` directory
- Clean up unused files
- Update directory structure if needed
- Ensure all files are properly categorized

---

This structure keeps the repository organized, makes it easy for team members to find what they need, and maintains a clean development environment! 🎯