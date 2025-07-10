# Contributing to Pine Script Trading Signals & Strategy Engine

Thank you for your interest in contributing to our Pine Script indicators and strategy development platform! This guide provides detailed information on how to contribute effectively to our collaborative trading signals project.

## 🎯 Contribution Overview

Our project focuses on creating high-quality trading signals through:
- **Data Point Extraction** from indicators
- **Strategy Composition** using weighted scoring
- **TTS Framework Integration** for automated trading
- **Signal Classification** into specialized filter types

## 🏗️ Development Architecture

### Signal Classification System

All signals are classified into four main categories:

1. **Bias Filters** - Trend and direction-based signals
   - Determine market direction
   - Identify trend strength
   - Filter directional trades

2. **Momentum Filters** - Strength and speed-based signals
   - Measure market momentum
   - Identify acceleration/deceleration
   - Time momentum-based entries

3. **Execution Filters** - Entry and exit timing signals
   - Precise entry/exit timing
   - Confirmation signals
   - Risk management triggers

4. **Confluence Filters** - Multi-factor validation signals
   - Combine multiple indicators
   - Validate signal strength
   - Reduce false positives

### TTS Framework Integration

All signals must follow the TTS (Template Trailing Strategy) convention:
- `1` = Start Long Deal (Buy/Long Entry)
- `-1` = Start Short Deal (Sell/Short Entry)
- `2` = End Long Deal (Close Long Position)
- `-2` = End Short Deal (Close Short Position)
- `0` = No Signal (Neutral state)

## 📋 Types of Contributions

### 1. Data Point Requests
Create new signals for existing indicators.

**When to use:**
- Adding new signal logic to existing indicators
- Extracting additional data points from indicators
- Implementing new filter types

**Process:**
1. Create a [Data Point Request issue](.github/ISSUE_TEMPLATE/data-point-request.md)
2. Specify indicator, signal type, and requirements
3. Await approval and assignment
4. Implement in `working/` directory
5. Submit pull request

### 2. Strategy Model Requests
Create new strategy configurations using multiple data points.

**When to use:**
- Combining multiple indicators into strategies
- Implementing weighted scoring systems
- Creating composite trading signals

**Process:**
1. Create a [Strategy Model issue](.github/ISSUE_TEMPLATE/strategy-model.md)
2. Define indicators, weights, and logic
3. Await approval and assignment
4. Implement in `working/strategy/`
5. Submit pull request

### 3. Indicator Development
Create new indicators or major enhancements.

**When to use:**
- Developing completely new indicators
- Major feature additions to existing indicators
- Creating new indicator categories

**Process:**
1. Create a feature request issue
2. Discuss approach and requirements
3. Develop in `working/` directory
4. Ensure TTS compatibility
5. Submit pull request

### 4. Bug Fixes & Optimizations
Fix issues and improve performance.

**When to use:**
- Fixing compilation errors
- Resolving repainting issues
- Optimizing performance
- Correcting signal logic

**Process:**
1. Create a bug report issue
2. Identify root cause
3. Fix in `working/` directory
4. Test thoroughly
5. Submit pull request

## 🔧 Technical Requirements

### Pine Script Standards

#### Version and Syntax
```pinescript
//@version=6
indicator("Your Indicator Name", overlay=true)
```

#### Critical Rules
- **Single Line Functions**: No multi-line function calls
- **Variable Assignment**: Use `=` for initial declaration, `:=` for reassignment
- **Array Safety**: Always check `array.size()` before accessing
- **Type Consistency**: Ensure both branches of conditionals return same type
- **Memory Management**: Implement proper cleanup patterns

#### Example of Correct vs Incorrect Syntax
```pinescript
// ✅ Correct
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low, bgcolor=color.blue)

// ❌ Incorrect
box.new(
    left=bar_index-2,
    top=high,
    right=bar_index+10,
    bottom=low,
    bgcolor=color.blue
)
```

### TTS Signal Implementation

#### Required Signal Template
```pinescript
// ===== TTS SIGNAL TEMPLATE =====
enable_tts = input.bool(true, "Enable TTS Signals", group="📡 TTS Signals")
signal_sensitivity = input.float(1.0, "Signal Sensitivity", minval=0.1, maxval=2.0, step=0.1, group="📡 TTS Signals")

// Replace with your indicator's logic
your_long_condition = [your_bullish_logic]
your_short_condition = [your_bearish_logic]
your_exit_condition = [your_exit_logic]

// Signal state management
var int signal_state = 0
var int bars_since_signal = 0
signal_value = 0
bars_since_signal += 1

if enable_tts and bars_since_signal >= 3
    if your_long_condition and signal_state == 0
        signal_value := 1
        signal_state := 1
        bars_since_signal := 0
    else if your_short_condition and signal_state == 0
        signal_value := -1
        signal_state := -1
        bars_since_signal := 0
    else if your_exit_condition and signal_state != 0
        signal_value := 0
        signal_state := 0
        bars_since_signal := 0

// TTS output (exact title required)
plot(enable_tts ? signal_value : na, "TTS Signal", display=display.data_window)
```

## 📁 Development Workflow

### Directory Structure
```
working/                          # YOUR DEVELOPMENT WORKSPACE
├── fvg/                         # FVG indicator development
├── ghost/                       # Ghost Volume Intelligence
├── oracle/                      # Oracle Alliance signals
├── sessions/                    # Session-based analysis
├── vortex/                      # Vortex engine development
├── strategy/                    # Strategy development
└── testing/                     # Experimental features

indicators/                       # PRODUCTION (don't edit directly)
├── fvg/
├── ghost/
├── oracle/
├── sessions/
├── vortex/
├── cycles/
└── libraries/
```

### Development Process

#### 1. Setup
```bash
# Fork and clone repository
git clone https://github.com/yourusername/pinescript-codebase.git
cd pinescript-codebase

# Create feature branch
git checkout -b feature/your-feature-name

# Always work in working/ directory
cd working/
```

#### 2. Development
```bash
# Copy existing indicator if modifying
cp ../indicators/fvg/fvg.pine fvg/

# Make your changes in working/ directory
# Test in TradingView platform
# Ensure no compilation errors
```

#### 3. Testing Requirements
- **Compilation**: Must compile without errors
- **Functionality**: Signals generate as expected
- **Performance**: Calculation time under 500ms
- **Repainting**: No signal repainting issues
- **Integration**: TTS framework compatibility

#### 4. Pull Request
```bash
# Add and commit changes
git add .
git commit -m "Add [data point/strategy]: Brief description"

# Push to your fork
git push origin feature/your-feature-name

# Create pull request using our template
```

## 🧪 Testing Standards

### Manual Testing Checklist
- [ ] Code compiles without errors in TradingView
- [ ] Visual elements display correctly
- [ ] Signals generate as expected
- [ ] No repainting issues observed
- [ ] Performance acceptable on various timeframes

### Integration Testing
- [ ] TTS integration working with Strategy Template
- [ ] Alerts functioning correctly
- [ ] Data window values correct
- [ ] No conflicts with other indicators

### Performance Testing
- [ ] Tested on multiple timeframes (1m, 5m, 15m, 1h, 4h, 1d)
- [ ] Tested on different symbols (forex, crypto, stocks)
- [ ] Tested in trending markets
- [ ] Tested in ranging markets
- [ ] Tested during high volatility periods

## 📊 Data Point Implementation Guide

### Step 1: Identify Signal Logic
Before implementing, clearly define:
- **When should it go LONG?** (bullish condition)
- **When should it go SHORT?** (bearish condition)
- **When should it EXIT?** (exit condition)

### Step 2: Choose Signal Type
Classify your signal:
- **Bias Filter**: Trend direction, market sentiment
- **Momentum Filter**: Speed, acceleration, strength
- **Execution Filter**: Entry/exit timing, confirmation
- **Confluence Filter**: Multi-factor validation

### Step 3: Implement Signal Logic
```pinescript
// Example for FVG Bias Filter
your_long_condition = bullish_fvg_detected and volume > ta.sma(volume, 20) * 1.5 and fvg_size >= min_fvg_size
your_short_condition = bearish_fvg_detected and volume > ta.sma(volume, 20) * 1.5 and fvg_size >= min_fvg_size
your_exit_condition = fvg_filled or ta.change(ta.ema(close, 50)) < 0
```

## 🎯 Strategy Model Implementation Guide

### Step 1: Define Strategy Components
```pinescript
// Strategy configuration
strategy_name = "Multi-Indicator Composite Strategy"
strategy_description = "Combines FVG, Ghost, and Oracle signals with weighted scoring"
```

### Step 2: Configure Data Points
```pinescript
// Data point weights
fvg_weight = input.float(0.4, "FVG Weight", minval=0, maxval=1, group="Weights")
ghost_weight = input.float(0.3, "Ghost Weight", minval=0, maxval=1, group="Weights")
oracle_weight = input.float(0.3, "Oracle Weight", minval=0, maxval=1, group="Weights")
```

## 🔍 Code Review Process

### Review Criteria
- **Pine Script Compliance**: Follows v6 syntax rules
- **TTS Integration**: Proper signal implementation
- **Performance**: Efficient calculations
- **Signal Quality**: Logic correctness and no repainting
- **Documentation**: Clear comments and explanations

### Approval Process
1. **Automated Checks**: Syntax and basic validation
2. **Technical Review**: Code quality and performance
3. **Signal Testing**: Functionality and integration
4. **Final Approval**: Maintainer approval
5. **Merge**: Integration into main branch

## 📈 Performance Guidelines

### Signal Performance Standards
- **Win Rate**: Target 60%+ (backtesting)
- **Profit Factor**: Target 1.5+ (backtesting)
- **Maximum Drawdown**: Under 20%
- **Signal Frequency**: 1-10 signals per day optimal
- **Risk/Reward**: Minimum 1:1.5 ratio

### Code Performance Standards
- **Calculation Time**: Under 500ms per bar
- **Memory Usage**: Efficient object management
- **Scalability**: Works on all timeframes
- **Optimization**: No unnecessary calculations

## 🚨 Common Issues and Solutions

### Pine Script Compilation Issues
```pinescript
// ❌ Common Error: Multi-line function calls
box.new(
    left=bar_index-2,
    top=high
)

// ✅ Correct: Single line
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low, bgcolor=color.blue)

// ❌ Common Error: Wrong assignment operator
myVar := 10  // Error on initial declaration

// ✅ Correct: Use = for initial declaration
myVar = 10   // Initial declaration
myVar := 20  // Reassignment
```

### TTS Integration Issues
```pinescript
// ❌ Common Error: Wrong plot title
plot(signal_value, "My Signal", display=display.data_window)

// ✅ Correct: Exact title required
plot(signal_value, "TTS Signal", display=display.data_window)
```

## 🔄 Getting Help

### Support Channels
- **GitHub Issues**: Technical questions and bug reports
- **Pull Request Reviews**: Code-specific discussions
- **Documentation**: Check existing guides first
- **Community**: Engage with other contributors

### Learning Resources
- **[TTS Implementation Guide](cursor-memory-bank/Strategy Templates/open source/TTS_Signal_Implementation_Guide.md)** - Complete signal integration guide
- **[Signal Template](cursor-memory-bank/Strategy Templates/open source/Signal Template.pine)** - Template for signal indicators
- **[Development Docs](cursor-memory-bank/docs/)** - Technical documentation

---

**Ready to contribute?** Start by creating a [Data Point Request](.github/ISSUE_TEMPLATE/data-point-request.md) or [Strategy Model](.github/ISSUE_TEMPLATE/strategy-model.md) issue!

Thank you for contributing to our Pine Script Trading Signals & Strategy Engine! 🚀 