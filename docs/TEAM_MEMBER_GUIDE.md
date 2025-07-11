# Team Member Guide
## How to Contribute to Pine Script Trading Signals

### 🚀 Quick Start (5 minutes)

1. **Get repository access** from project manager
2. **Read this guide** (you're doing it now!)
3. **Check the project board** for your assignments
4. **Start with your first issue**

---

## 📊 Creating Data Point Requests

### What is a Data Point?
A data point is a trading signal extracted from an indicator. Examples:
- FVG trend bias (bullish/bearish direction)
- Ghost volume momentum (buying/selling pressure)
- Oracle execution timing (entry/exit signals)

### How to Request a Data Point:

1. **Go to Issues** → **New Issue**
2. **Choose "Data Point Request" template**
3. **Fill out the form**:
   - **Indicator**: Which indicator to modify (FVG, Ghost, Oracle, etc.)
   - **Signal Type**: Choose one:
     - 🎯 **Bias Filter** - Trend direction (bullish/bearish)
     - ⚡ **Momentum Filter** - Signal strength/speed
     - 🎪 **Execution Filter** - Entry/exit timing
     - 🔄 **Confluence Filter** - Multi-factor validation
   - **Trigger Conditions**: When should the signal fire?
   - **Parameters**: What settings should be configurable?

### Example Data Point Request:
```
Title: [DATA POINT] FVG Volume Confirmation Filter

Indicator: Fair Value Gap (FVG)
Signal Type: Bias Filter
Description: Add volume confirmation to FVG signals

Trigger Conditions:
- Long: Bullish FVG + Volume > 1.5x average
- Short: Bearish FVG + Volume > 1.5x average
- Exit: FVG filled OR volume drops below average

Parameters:
- Volume multiplier (default: 1.5)
- Enable/disable volume filter
```

---

## 🎯 Creating Strategy Model Requests

### What is a Strategy Model?
A strategy that combines multiple indicators with weighted scoring. Example:
- 40% FVG bias + 30% Ghost momentum + 30% Oracle execution = composite signal

### How to Request a Strategy Model:

1. **Go to Issues** → **New Issue**
2. **Choose "Strategy Model" template**
3. **Fill out the form**:
   - **Strategy Name**: Descriptive name
   - **Indicators**: Which indicators to combine
   - **Weights**: How much influence each indicator has
   - **Thresholds**: When to enter/exit trades
   - **Risk Management**: Stop loss, take profit, position sizing

### Example Strategy Model Request:
```
Title: [STRATEGY] Multi-Timeframe FVG + Ghost Strategy

Strategy Name: FVG-Ghost Multi-TF Strategy
Indicators:
- FVG bias filter (40% weight)
- Ghost momentum filter (60% weight)

Entry Conditions:
- Composite score > 0.7 for long
- Composite score < -0.7 for short

Exit Conditions:
- Composite score crosses 0.3/-0.3
- Stop loss: 2% of account
- Take profit: 1:2 risk/reward
```

---

## 🔨 Development Process (When Assigned)

### Step 1: Get the Assignment
- Check your assigned issues in the project board
- Read the requirements carefully
- Ask questions in issue comments if unclear

### Step 2: Set Up Your Branch
```bash
git checkout main
git pull origin main
git checkout -b feature/issue-description
```

### Step 3: Work in the working/ Directory
```bash
cd working/
# Copy existing indicator if modifying
cp ../indicators/fvg/fvg.pine fvg/fvg_with_new_feature.pine
# Make your changes
```

### Step 4: Follow Pine Script v6 Rules
```pinescript
//@version=6
indicator("Your Indicator")

// ✅ Single line functions only
box.new(left=bar_index, top=high, right=bar_index+10, bottom=low)

// ✅ Proper variable assignment
myVar = 10    // Initial declaration
myVar := 20   // Reassignment

// ✅ TTS Integration (for signals)
plot(signal_value, "TTS Signal", display=display.data_window)
```

### Step 5: Test Your Code
1. **Copy to TradingView** Pine Editor
2. **Test compilation** - fix any errors
3. **Test on multiple timeframes** (1m, 5m, 15m, 1h)
4. **Test on multiple symbols** (EURUSD, BTCUSD, SPY)
5. **Verify signals make sense**

### Step 6: Submit Pull Request
```bash
git add .
git commit -m "Add feature: description"
git push origin feature/issue-description
```
Then create PR on GitHub using the template.

---

## 🎯 Signal Types Explained

### 🎯 Bias Filters (Trend Direction)
**Purpose**: Determine if market is bullish or bearish
**Examples**:
- FVG trend bias (bullish/bearish gaps)
- Moving average slopes
- Market structure analysis

**Signal Values**: -1 (bearish) to +1 (bullish)

### ⚡ Momentum Filters (Strength/Speed)  
**Purpose**: Measure how strong/fast the market is moving
**Examples**:
- Ghost volume momentum
- RSI momentum
- Volume-weighted signals

**Signal Values**: -1 (weak/selling) to +1 (strong/buying)

### 🎪 Execution Filters (Entry/Exit Timing)
**Purpose**: Time precise entry and exit points
**Examples**:
- Session-based timing
- Cycle-based entries
- Confirmation signals

**Signal Values**: -1 (exit signal) to +1 (entry signal)

### 🔄 Confluence Filters (Multi-factor Validation)
**Purpose**: Combine multiple factors to validate signals
**Examples**:
- Multi-timeframe alignment
- Volume + price confirmation
- Multiple indicator agreement

**Signal Values**: 0 (no confluence) to +1 (maximum confluence)

---

## 📡 TTS Integration (Important!)

All signals must follow the TTS (Template Trailing Strategy) standard:

### Signal Values:
- `1` = Long Entry (Start Long Deal)
- `-1` = Short Entry (Start Short Deal)
- `2` = Long Exit (End Long Deal)
- `-2` = Short Exit (End Short Deal)  
- `0` = No Signal

### Required Code:
```pinescript
// Add this to every signal indicator
plot(signal_value, "TTS Signal", display=display.data_window)
```

### TTS Template:
```pinescript
// State management
var int signal_state = 0
var int bars_since_signal = 0

// Generate signals
signal_value = 0
bars_since_signal += 1

if bars_since_signal >= 3  // Cooldown period
    if your_long_condition and signal_state != 1
        signal_value := 1
        signal_state := 1
        bars_since_signal := 0
    else if your_short_condition and signal_state != -1
        signal_value := -1
        signal_state := -1
        bars_since_signal := 0
    else if your_exit_condition and signal_state != 0
        signal_value := 0
        signal_state := 0
        bars_since_signal := 0

// TTS output
plot(signal_value, "TTS Signal", display=display.data_window)
```

---

## ✅ Quality Standards

### Before Submitting:
- [ ] Code compiles without errors in TradingView
- [ ] Tested on multiple timeframes (1m, 5m, 15m, 1h)
- [ ] Tested on multiple symbols (forex, crypto, stocks)
- [ ] Signals make logical trading sense
- [ ] No repainting issues
- [ ] TTS integration working (if applicable)
- [ ] Performance acceptable (< 500ms calculation time)

### PR Review Checklist:
- [ ] Follows Pine Script v6 syntax
- [ ] Proper TTS integration
- [ ] Good signal quality
- [ ] Well commented code
- [ ] Updated documentation

---

## 🆘 Getting Help

### Where to Ask Questions:
1. **Issue Comments** - Ask on your assigned issue
2. **PR Comments** - Ask during code review
3. **Team Meetings** - Weekly sync meetings
4. **Documentation** - Check HOW_TO_USE.md and CONTRIBUTING.md

### Common Questions:

**Q: Which indicator should I modify?**
A: Check the issue description - it specifies the exact indicator file.

**Q: How do I test TTS integration?**
A: Add your indicator to a chart, check Data Window for "TTS Signal" plot.

**Q: My code won't compile, what do I do?**
A: Check Pine Script v6 rules - no multi-line functions, use proper assignment operators.

**Q: How do I know if my signal is good quality?**
A: Test on multiple timeframes/symbols, ensure signals make trading sense.

---

## 🎯 Success Tips

1. **Start Simple** - Begin with basic signals, add complexity later
2. **Test Thoroughly** - Always test on multiple timeframes and symbols  
3. **Ask Questions** - Better to ask than submit poor quality work
4. **Follow Templates** - Use the issue and PR templates completely
5. **Read Documentation** - Most questions are answered in the guides
6. **Learn TTS** - Understanding TTS integration is crucial for signals

---

## 📋 Quick Reference

### Development Workflow:
1. Get assigned issue → 2. Create branch → 3. Work in working/ → 4. Test thoroughly → 5. Submit PR

### TTS Signal Values:
`1` = Long Entry, `-1` = Short Entry, `2` = Long Exit, `-2` = Short Exit, `0` = No Signal

### Signal Types:
🎯 Bias, ⚡ Momentum, 🎪 Execution, 🔄 Confluence

### Required Plot:
```pinescript
plot(signal_value, "TTS Signal", display=display.data_window)
```

That's it! You're ready to contribute to our Pine Script trading signals project! 🚀