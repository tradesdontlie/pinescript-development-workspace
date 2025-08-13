# Pine Script Development Workspace

A professional Pine Script development environment for creating TradingView indicators, strategies, and libraries with comprehensive tooling and best practices.

## 📁 Repository Structure

```
pinescript-development-workspace/
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
code --install-extension TradesDontLie.pinescript-v6-vscode
```

## 📝 Development Workflow

### Step 1: Create Your Project Structure

```bash
# For a new indicator
mkdir -p development/indicators/my_indicator
touch development/indicators/my_indicator/indicator.pine

# For a new strategy
mkdir -p development/strategies/my_strategy
touch development/strategies/my_strategy/strategy.pine

# For a new library
mkdir -p development/libraries/my_library
touch development/libraries/my_library/library.pine
```

### Step 2: Basic Pine Script Template

#### Indicator Template
```pine
//@version=6
indicator("My Indicator", overlay=true)

// Input parameters
length = input.int(20, "Length", minval=1)
source = input.source(close, "Source")

// Calculations
signal = ta.ema(source, length)

// Plotting
plot(signal, "Signal", color=color.blue, linewidth=2)

// Alerts (optional)
alertcondition(ta.crossover(close, signal), "Bullish Cross", "Price crossed above signal")
```

#### Strategy Template
```pine
//@version=6
strategy("My Strategy", overlay=true, initial_capital=10000)

// Inputs
length = input.int(20, "MA Length")

// Calculations
ma = ta.sma(close, length)

// Entry conditions
longCondition = ta.crossover(close, ma)
shortCondition = ta.crossunder(close, ma)

// Execute trades
if longCondition
    strategy.entry("Long", strategy.long)
if shortCondition
    strategy.entry("Short", strategy.short)

// Plotting
plot(ma, "MA", color=color.blue)
```

#### Library Template
```pine
//@version=6
library("MyLibrary")

// Export a function
export calculateMA(series float source, simple int length) =>
    ta.sma(source, length)

// Export another function
export detectCrossover(series float source, series float target) =>
    ta.crossover(source, target)
```

### Step 3: Development Process

1. **Write your code** in the appropriate `development/` folder
2. **Test in TradingView**: Copy your code to Pine Editor and test
3. **Validate syntax**: Ensure no compilation errors
4. **Test thoroughly**: Multiple timeframes and symbols
5. **Document your work**: Add README.md with explanation

### Step 4: Promote to Production

When your code is fully tested and ready:

1. **Final testing checklist**:
   - ✅ No compilation errors
   - ✅ Tested on multiple timeframes (1m, 5m, 15m, 1H, 4H, 1D)
   - ✅ Tested on multiple symbols
   - ✅ No repainting issues
   - ✅ Memory management implemented (if using drawing objects)
   - ✅ Documentation complete

2. **Move to production**:
```bash
# Copy your tested code to production
cp -r development/indicators/my_indicator production/indicators/
```

## 📊 Pine Script v6 Essential Rules

### 1. **Mandatory Syntax**
```pine
//@version=6                    // Always first line
indicator("Name", overlay=true)  // Required declaration

// ✅ Correct: Single line function calls
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low)

// ❌ Wrong: Multi-line function calls - NOT ALLOWED
box.new(
    left=bar_index-2,
    top=high
)
```

### 2. **Variable Assignment**
```pine
myVar = 10        // Initial declaration uses =
myVar := 20       // Reassignment uses :=
```

### 3. **Type Safety**
```pine
// Both branches must return same type
result = condition ? 1 : 0      // ✅ Both int
result = condition ? 1 : 0.0    // ❌ Mixed types - ERROR

// Explicit NA typing required
int myVar = na                   // ✅ Correct
myVar = na                       // ❌ Wrong
```

### 4. **Array Safety**
```pine
// ALWAYS check bounds before access
if array.size(myArray) > index
    value = array.get(myArray, index)

// Pine v6 feature: negative indices
lastElement = array.get(myArray, -1)  // Last element
```

### 5. **Memory Management (Critical)**
```pine
// Drawing objects MUST be cleaned up
var line myLine = na
if condition
    myLine := line.new(x1=bar_index, y1=high, x2=bar_index+1, y2=low)
    
// Required cleanup to prevent memory leaks
if barstate.islastconfirmedhistory and not na(myLine)
    myLine.delete()
```

## 🎯 Common Pine Script Patterns

### TTS Signal Standard
```pine
//@version=6
indicator("Signal Generator")

// TTS Standard: 1=Long, -1=Short, 2=Exit Long, -2=Exit Short, 0=No Signal
signal = 0
signal := bullishCondition ? 1 : signal
signal := bearishCondition ? -1 : signal
signal := exitLong ? 2 : signal
signal := exitShort ? -2 : signal

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

## 🐛 Troubleshooting Common Errors

### "Mismatched input"
**Problem**: Multi-line function calls
**Solution**: Put entire function call on one line

### "Cannot use series"
**Problem**: Using `series int` for TA function length parameter
**Solution**: Use `simple int` instead

### "Type mismatch"
**Problem**: Ternary operator branches return different types
**Solution**: Ensure both branches return same type

### "Array index out of bounds"
**Problem**: Accessing array without checking size
**Solution**: Always check `array.size()` first

### Memory Issues
**Problem**: Too many drawing objects
**Solution**: Implement cleanup with `barstate.islastconfirmedhistory`

## 📈 Quality Standards

### Development Phase
- Pine Script v6 syntax compliance
- No compilation errors
- Basic functionality working
- Initial testing on primary timeframe

### Production Requirements
- All development standards met
- Multi-timeframe testing complete
- Multiple symbol testing complete
- Memory management verified
- Documentation complete
- No repainting issues
- Performance optimized

## 🔧 Optional Validation Tools

If you want to validate your Pine Script files, you can use the included Python validator:

```bash
# Validate a specific file
python Pinescript-Coding-Suite/scripts/validate_pine_script.py development/indicators/my_indicator/indicator.pine

# Check memory management
bash Pinescript-Coding-Suite/scripts/check_file_memory.sh development/indicators/my_indicator/indicator.pine
```

## 📚 Best Practices

### Code Organization
1. **One indicator per folder** - Keep related files together
2. **Clear naming** - Use descriptive names for variables and functions
3. **Comment complex logic** - Explain the "why", not the "what"
4. **Version your work** - Keep copies of major versions

### Performance Tips
1. **Minimize calculations** - Store results in variables
2. **Use `var` for persistence** - Maintain state across bars
3. **Limit drawing objects** - Use `max_lines_count`, `max_labels_count`
4. **Avoid repainting** - Use confirmed bar data

### Testing Checklist
- [ ] Compiles without errors
- [ ] Works on 1-minute timeframe
- [ ] Works on daily timeframe
- [ ] Tested on forex pairs
- [ ] Tested on stocks
- [ ] Tested on crypto
- [ ] Alerts work correctly (if applicable)
- [ ] No repainting issues

## 📖 Resources

### Official Documentation
- [Pine Script v6 Reference](https://www.tradingview.com/pine-script-reference/v6/)
- [TradingView Pine Script Docs](https://www.tradingview.com/pine-script-docs/)
- [Community Scripts](https://www.tradingview.com/scripts/)

### Repository Resources
- **Rule Database**: `Pinescript-Coding-Suite/extracted_rules/` - Common patterns and solutions
- **VS Code Extension**: Included for enhanced development experience
- **Validation Scripts**: Optional tools for code quality checking

## 🚨 Important Notes

- **Start in development**: All new code begins in the `development/` folder
- **Test thoroughly**: Never skip testing before moving to production
- **Document your code**: Others (including future you) need to understand it
- **Follow v6 syntax**: Pine Script v6 has strict rules that must be followed
- **Memory matters**: Always clean up drawing objects to prevent issues

---

*This workspace follows Pine Script v6 standards and TradingView best practices for professional indicator development.*