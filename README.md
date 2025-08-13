# Pine Script Development Workspace

A professional Pine Script development environment for creating TradingView indicators, strategies, and libraries with comprehensive tooling and best practices.

## 📁 Repository Structure

```
pinescript-codebase/
│
├── 🚧 development/              # ACTIVE DEVELOPMENT AREA
│   ├── indicators/              # Work-in-progress indicators
│   ├── strategies/              # Developing trading strategies
│   └── libraries/               # Building reusable libraries
│
├── ✅ production/               # FINALIZED & TESTED CODE
│   ├── indicators/              # Production-ready indicators
│   ├── strategies/              # Battle-tested strategies
│   └── libraries/               # Stable, reusable libraries
│
├── 🛠️ Pinescript-Coding-Suite/
│   ├── scripts/                 # Validation & automation tools
│   ├── extracted_rules/         # Pine Script v6 rule database
│   └── pine-script-v6-extension/ # VS Code extension
│
├── 📚 docs/                     # Documentation
├── 🔧 scripts/                  # Setup scripts
└── 📋 project-requests/         # Feature planning
```

### Development vs Production

#### 🚧 **Development Area** (`development/`)
- **Purpose**: Active development, testing, and experimentation
- **Status**: Work-in-progress, may contain bugs
- **Testing**: In progress, not fully validated
- **Usage**: Create and iterate on new Pine Script code here

#### ✅ **Production Area** (`production/`)
- **Purpose**: Finalized, thoroughly tested code ready for live use
- **Status**: Stable, bug-free, optimized
- **Testing**: Complete multi-timeframe and symbol validation
- **Usage**: Only promoted code that passes all quality checks

## 🚀 Quick Start

### Environment Setup

```bash
# Clone the repository
git clone https://github.com/tradesdontlie/pinescript-development-workspace.git
cd pinescript-development-workspace

# Install Pine Script VS Code Extension (if using VS Code/Cursor)
# Using the included extension file:
code --install-extension ./Pinescript-Coding-Suite/pine-script-v6-extension/pinescript-v6-vscode-0.1.0.vsix

# Or from marketplace (alternative):
code --install-extension salbert11.pinescript-helper
```

## 📝 Development Workflow

### Step 1: Start New Development

```bash
# Create new indicator in development
mkdir -p development/indicators/my_new_indicator
touch development/indicators/my_new_indicator/indicator.pine

# Or use Makefile to create from template
make new-indicator
# Choose location: development/indicators/
```

### Step 2: Development Process

1. **Write code** in `development/` area
2. **Test locally** in TradingView Pine Editor
3. **Validate** with repository tools:
   ```bash
   make validate-dev  # Validates development folder
   make check-memory  # Check for memory leaks
   make lint         # Full quality check
   ```
4. **Iterate** until all tests pass

### Step 3: Promote to Production

```bash
# When code is fully tested and validated
make promote-to-production FILE=development/indicators/my_indicator/indicator.pine

# This will:
# 1. Run final validation
# 2. Create versioned backup
# 3. Move to production/indicators/
# 4. Update documentation
```

## 🛠️ Makefile Commands

### Development Commands
```bash
make dev                 # Setup development environment
make new-indicator       # Create new indicator from template
make new-strategy       # Create new strategy from template
make new-library        # Create new library from template
make validate-dev       # Validate all development files
```

### Production Commands
```bash
make validate-prod      # Validate production files
make promote-to-production FILE=path/to/file.pine
make version-file FILE=path TYPE=major|minor|patch
```

### Quality Assurance
```bash
make lint              # Complete code quality check
make check-memory      # Memory management validation
make validate-all      # Validate entire repository
make pre-commit        # Pre-commit validation
```

## 📊 Pine Script Development Guide

### Core Pine Script v6 Rules

#### 1. **Mandatory Syntax**
```pine
//@version=6                    // Always first line
indicator("Name", overlay=true)  // Required declaration

// ✅ Correct: Single line function calls
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low)

// ❌ Wrong: Multi-line function calls
box.new(
    left=bar_index-2,
    top=high
)
```

#### 2. **Type Safety**
```pine
// Consistent types required
result = condition ? 1 : 0      // ✅ Both int
result = condition ? 1 : 0.0    // ❌ Mixed types

// Explicit NA typing
int myVar = na                   // Required
```

#### 3. **Memory Management**
```pine
// Clean up drawing objects
var line myLine = na
if condition
    myLine := line.new(x1=bar_index, y1=high, x2=bar_index+1, y2=low)
    
// Required cleanup
if barstate.islastconfirmedhistory and not na(myLine)
    myLine.delete()
```

## 🎯 Project Organization

### Indicator Development Structure
```
development/indicators/
└── my_indicator/
    ├── indicator.pine          # Main indicator file
    ├── README.md              # Documentation
    ├── test_results.md        # Testing documentation
    └── versions/              # Version history
        ├── v0.1.0.pine
        └── VERSION_HISTORY.md
```

### Strategy Development Structure
```
development/strategies/
└── my_strategy/
    ├── strategy.pine          # Main strategy file
    ├── README.md             # Strategy documentation
    ├── backtest_results.md   # Backtesting data
    └── risk_params.md        # Risk management settings
```

### Library Development Structure
```
development/libraries/
└── my_library/
    ├── library.pine          # Library code
    ├── README.md            # API documentation
    ├── examples/            # Usage examples
    └── tests/               # Test cases
```

## 📈 Quality Standards

### Development Phase Requirements
- [ ] Pine Script v6 syntax compliance
- [ ] No compilation errors in TradingView
- [ ] Basic functionality working
- [ ] Initial testing on primary timeframe

### Production Promotion Requirements
- [ ] All development requirements met
- [ ] Multi-timeframe testing (1m, 5m, 15m, 1H, 4H, 1D)
- [ ] Symbol testing (minimum 3 different markets)
- [ ] Memory management validated
- [ ] Documentation complete
- [ ] Version tagged appropriately
- [ ] No repainting issues
- [ ] Alert conditions tested (if applicable)

## 🔧 Common Pine Script Patterns

### Signal Generation (TTS Standard)
```pine
//@version=6
indicator("Signal Generator")

// TTS Standard: 1=Long, -1=Short, 2=Exit Long, -2=Exit Short, 0=No Signal
signal = 0
signal := bullishCross ? 1 : signal
signal := bearishCross ? -1 : signal
signal := exitCondition ? 2 : signal

plot(signal, "TTS Signal", display=display.data_window)
```

### Multi-Timeframe Analysis
```pine
//@version=6
indicator("MTF Analysis")

// Request higher timeframe data
htf_close = request.security(syminfo.tickerid, "D", close)
htf_ema = request.security(syminfo.tickerid, "D", ta.ema(close, 20))

plot(htf_close, "Daily Close")
plot(htf_ema, "Daily EMA")
```

### Session-Based Analysis
```pine
//@version=6
indicator("Session Analysis")

// Define trading session
nySession = input.session("0930-1600", "NY Session")
inSession = time(timeframe.period, nySession)

// Calculate session metrics
sessionHigh = ta.highest(high, barssince(na(inSession[1])))
sessionLow = ta.lowest(low, barssince(na(inSession[1])))

plot(inSession ? sessionHigh : na, "Session High", color=color.green)
plot(inSession ? sessionLow : na, "Session Low", color=color.red)
```

## 🐛 Troubleshooting

### Common Pine Script Errors

#### "Mismatched input"
- Check for multi-line function calls (not allowed)
- Ensure parentheses close on same line

#### "Cannot use series"
- Use `simple int` for TA function length parameters
- Not `series int length`

#### "Type mismatch"
- Both branches of ternary must return same type
- Use explicit typing for NA values

#### Memory Issues
- Implement cleanup for all drawing objects
- Use `barstate.islastconfirmedhistory` guard

## 📚 Best Practices

### Development Phase
1. **Start small**: Build core functionality first
2. **Test frequently**: Validate in TradingView often
3. **Document as you go**: Update README with logic
4. **Version control**: Create versions at milestones
5. **Use validation tools**: Run `make validate-dev` regularly

### Production Standards
1. **No debug code**: Remove all print statements
2. **Optimized performance**: Minimize calculations
3. **Clear documentation**: Complete README and examples
4. **Proper versioning**: Semantic versioning (major.minor.patch)
5. **Comprehensive testing**: All timeframes and markets

## 🤝 Contributing

### Workflow
1. Create feature in `development/`
2. Test thoroughly
3. Document completely
4. Pass all validation checks
5. Submit for review
6. Promote to `production/` when approved

### Code Review Checklist
- [ ] Pine Script v6 compliance
- [ ] Memory management implemented
- [ ] Documentation complete
- [ ] Testing results included
- [ ] No repainting issues
- [ ] Performance optimized

## 📖 Resources

### Documentation
- [Pine Script v6 Reference](https://www.tradingview.com/pine-script-reference/v6/)
- [TradingView Pine Script Docs](https://www.tradingview.com/pine-script-docs/)
- [Community Scripts](https://www.tradingview.com/scripts/)

### Repository Tools
- **Validation Scripts**: `Pinescript-Coding-Suite/scripts/`
- **Rule Database**: `Pinescript-Coding-Suite/extracted_rules/`
- **VS Code Extension**: `Pinescript-Coding-Suite/pine-script-v6-extension/`

## 🚨 Important Notes

- **Development first**: All new code starts in `development/`
- **Quality gates**: Must pass all checks before production
- **No shortcuts**: Production code must be thoroughly tested
- **Documentation required**: No undocumented production code
- **Version everything**: Track changes systematically

---

*This workspace follows Pine Script v6 standards and TradingView best practices for professional indicator development.*