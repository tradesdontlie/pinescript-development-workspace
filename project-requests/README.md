# Project Requests & Development Hub

This directory serves as a centralized workspace for team members to prepare and organize project requests before submitting them as GitHub issues or pull requests.

## 📁 Directory Structure

```
project-requests/
├── data-points/         # Data point signal requests
├── strategy-models/     # Trading strategy development requests
├── development-plans/   # Feature and indicator development plans
├── bug-reports/        # Bug analysis and documentation
└── analysis-reports/   # Multi-indicator analysis and documentation
```

## 🎯 Purpose

**Before creating GitHub issues or PRs**, team members should:
1. Use this workspace to prepare comprehensive requests
2. Analyze existing indicators for data point extraction
3. Document strategy models and development plans
4. Organize bug reports with proper investigation
5. Create detailed analysis reports

## 📋 Workflow Guidelines

### 1. Data Points (`data-points/`)
**For requesting new signal extraction from existing indicators**

**Process:**
1. Create a folder: `data-points/[indicator-name]-[signal-type]/`
2. Copy template from `.github/ISSUE_TEMPLATE/data-point-request.md`
3. Fill out complete specifications
4. Test signal logic if possible
5. Submit as GitHub issue with `data-point` label

**Example Structure:**
```
data-points/
├── fvg-momentum-signals/
│   ├── request.md              # Complete data point request
│   ├── signal-analysis.md      # Technical analysis
│   └── test-scenarios.md       # Testing requirements
└── ghost-volume-filters/
    ├── request.md
    └── performance-analysis.md
```

### 2. Strategy Models (`strategy-models/`)
**For comprehensive trading strategy development**

**Process:**
1. Create folder: `strategy-models/[strategy-name]/`
2. Use `.github/ISSUE_TEMPLATE/strategy-model.md` template
3. Document multi-indicator integration
4. Define signal weighting and scoring
5. Submit as GitHub issue with `strategy` label

**Example Structure:**
```
strategy-models/
├── scalping-composite/
│   ├── strategy-plan.md        # Complete strategy design
│   ├── signal-mapping.md       # Indicator signal integration
│   ├── risk-management.md      # Risk and position sizing
│   └── backtesting-plan.md     # Testing methodology
└── swing-momentum/
    ├── strategy-plan.md
    └── indicator-selection.md
```

### 3. Development Plans (`development-plans/`)
**For new indicator creation and major feature development**

**Process:**
1. Create folder: `development-plans/[feature-name]/`
2. Use `.github/ISSUE_TEMPLATE/indicator-development.md` template
3. Document technical specifications
4. Plan implementation phases
5. Submit as GitHub issue with `enhancement` label

**Example Structure:**
```
development-plans/
├── smart-money-detector/
│   ├── feature-spec.md         # Complete feature specification
│   ├── technical-design.md     # Implementation details
│   ├── integration-plan.md     # How it fits with existing code
│   └── testing-strategy.md     # Quality assurance plan
└── ltf-pattern-engine/
    ├── feature-spec.md
    └── architecture-design.md
```

### 4. Bug Reports (`bug-reports/`)
**For thorough bug investigation and documentation**

**Process:**
1. Create folder: `bug-reports/[bug-description]/`
2. Use `.github/ISSUE_TEMPLATE/bug-report.md` template
3. Include detailed reproduction steps
4. Provide Pine Script error logs
5. Submit as GitHub issue with `bug` label

**Example Structure:**
```
bug-reports/
├── fvg-repainting-issue/
│   ├── bug-report.md           # Complete bug documentation
│   ├── reproduction-steps.md   # How to reproduce
│   ├── error-logs.md          # Pine Script compilation errors
│   └── proposed-fix.md        # Potential solution
└── ghost-memory-leak/
    ├── bug-report.md
    └── investigation-notes.md
```

### 5. Analysis Reports (`analysis-reports/`)
**For multi-indicator analysis and research documentation**

**Process:**
1. Create folder: `analysis-reports/[analysis-topic]/`
2. Document findings and recommendations
3. Include charts and data analysis
4. Prepare for feature requests or strategy development

**Example Structure:**
```
analysis-reports/
├── fvg-ghost-correlation/
│   ├── analysis-summary.md     # Key findings
│   ├── data-analysis.md       # Statistical analysis
│   ├── charts-screenshots/    # Visual evidence
│   └── recommendations.md     # Next steps
└── timeframe-optimization/
    ├── analysis-summary.md
    └── performance-metrics.md
```

## 🚀 Quick Start Guide

### For Team Members

1. **Before submitting any GitHub issue:**
   - Create appropriate folder in this directory
   - Fill out relevant template completely
   - Document your analysis and testing
   - Organize all supporting materials

2. **Use Claude Code for assistance:**
   ```bash
   # Example: Analyze indicator for data points
   "Claude, analyze the FVG indicator and identify 3 potential momentum signals"
   
   # Example: Create strategy documentation
   "Claude, help me document a multi-indicator scalping strategy"
   ```

3. **Review checklist before GitHub submission:**
   - [ ] Complete template filled out
   - [ ] Technical specifications documented
   - [ ] Testing requirements defined
   - [ ] Supporting analysis included
   - [ ] Clear acceptance criteria

### For Automation (Future)

This structure supports future automation for:
- **Automated data point extraction** from indicators
- **Strategy model generation** from multiple indicators
- **Testing framework integration** for request validation
- **Claude Code analysis** of indicator combinations

## 📝 Templates Reference

All GitHub issue templates are available in `.github/ISSUE_TEMPLATE/`:
- `data-point-request.md` - For signal extraction requests
- `strategy-model.md` - For trading strategy development
- `indicator-development.md` - For new indicator creation
- `feature-request.md` - For general feature requests
- `bug-report.md` - For bug reporting

## 🔄 Integration with GitHub Workflow

### Issue Creation Process
1. **Prepare** in `project-requests/`
2. **Organize** documentation and analysis
3. **Submit** GitHub issue using appropriate template
4. **Link** to your preparation folder in the issue
5. **Track** development progress

### Pull Request Process
1. **Develop** in `Pinescript-Coding-Suite/working/`
2. **Reference** original request from `project-requests/`
3. **Test** according to documented requirements
4. **Submit** PR with link to request documentation

## 💡 Best Practices

1. **Be Comprehensive** - Document thoroughly before submission
2. **Test First** - Validate ideas before requesting development
3. **Organize Clearly** - Use consistent folder and file naming
4. **Reference Existing** - Link to related indicators and strategies
5. **Plan Testing** - Define how success will be measured

## 🔗 Related Documentation

- [Pine Script v6 Rules](../Pinescript-Coding-Suite/extracted_rules/)
- [Development Workflow](../CLAUDE.md)
- [GitHub Templates](../.github/ISSUE_TEMPLATE/)
- [Working Directory](../Pinescript-Coding-Suite/working/)

---

**Remember:** This workspace is for preparation and organization. All final submissions should go through the official GitHub issue and PR process with proper labels and templates.