---
name: Strategy Model Request
about: Request a new strategy model configuration using indicator data points
title: "[STRATEGY] "
labels: ["strategy", "enhancement"]
assignees: []
---

## 🎯 Strategy Model Request

### Strategy Overview
**Strategy Name:** 
**Strategy Type:** 
- [ ] Single Indicator Strategy
- [ ] Multi-Indicator Composite Strategy
- [ ] Weighted Signal Strategy
- [ ] Confluence-Based Strategy

**Trading Style:**
- [ ] Scalping (1-5 minute timeframes)
- [ ] Day Trading (5-60 minute timeframes)
- [ ] Swing Trading (1-4 hour timeframes)
- [ ] Position Trading (daily+ timeframes)

### Required Indicators & Data Points

#### Primary Indicators
**Indicator 1:**
- **Name:** 
- **File Path:** `indicators/[category]/[filename].pine`
- **Data Points Required:**
  - [ ] Data Point 1: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 2: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 3: `[name]` - Type: `[bias/momentum/execution/confluence]`

**Indicator 2:**
- **Name:** 
- **File Path:** `indicators/[category]/[filename].pine`
- **Data Points Required:**
  - [ ] Data Point 1: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 2: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 3: `[name]` - Type: `[bias/momentum/execution/confluence]`

**Indicator 3:**
- **Name:** 
- **File Path:** `indicators/[category]/[filename].pine`
- **Data Points Required:**
  - [ ] Data Point 1: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 2: `[name]` - Type: `[bias/momentum/execution/confluence]`
  - [ ] Data Point 3: `[name]` - Type: `[bias/momentum/execution/confluence]`

### Signal Configuration

#### Filter Classifications
**Bias Filters (Trend/Direction):**
```
Data Point Name | Indicator | Weight | Configuration
----------------|-----------|--------|---------------
[name]          | [FVG]     | 0.3    | [settings]
[name]          | [Ghost]   | 0.2    | [settings]
```

**Momentum Filters (Strength/Speed):**
```
Data Point Name | Indicator | Weight | Configuration
----------------|-----------|--------|---------------
[name]          | [Oracle]  | 0.4    | [settings]
[name]          | [Vortex]  | 0.3    | [settings]
```

**Execution Filters (Entry/Exit Timing):**
```
Data Point Name | Indicator | Weight | Configuration
----------------|-----------|--------|---------------
[name]          | [Sessions]| 0.6    | [settings]
[name]          | [Cycles]  | 0.4    | [settings]
```

**Confluence Filters (Multi-factor Validation):**
```
Data Point Name | Indicator | Weight | Configuration
----------------|-----------|--------|---------------
[name]          | [Multiple]| 0.8    | [settings]
[name]          | [Combined]| 0.5    | [settings]
```

### Strategy Logic

#### Entry Conditions
**Long Entry Requirements:**
- **Bias Filters:** `[minimum_score]` or higher
- **Momentum Filters:** `[minimum_score]` or higher
- **Execution Filters:** `[minimum_score]` or higher
- **Confluence Requirement:** `[minimum_total_score]` across all filters

**Short Entry Requirements:**
- **Bias Filters:** `[minimum_score]` or lower
- **Momentum Filters:** `[minimum_score]` or lower
- **Execution Filters:** `[minimum_score]` or lower
- **Confluence Requirement:** `[minimum_total_score]` across all filters

#### Exit Conditions
**Long Exit Triggers:**
- [ ] Any bias filter drops below `[threshold]`
- [ ] Momentum filter signals weakness below `[threshold]`
- [ ] Execution filter signals exit above `[threshold]`
- [ ] Stop loss hit at `[percentage]%`
- [ ] Take profit hit at `[percentage]%`
- [ ] Time-based exit after `[bars]` bars

**Short Exit Triggers:**
- [ ] Any bias filter rises above `[threshold]`
- [ ] Momentum filter signals weakness above `[threshold]`
- [ ] Execution filter signals exit below `[threshold]`
- [ ] Stop loss hit at `[percentage]%`
- [ ] Take profit hit at `[percentage]%`
- [ ] Time-based exit after `[bars]` bars

### Scoring System

#### Weighted Scoring Configuration
**Total Weight Distribution:**
- **Bias Filters:** `[percentage]%` (Total: 1.0)
- **Momentum Filters:** `[percentage]%` (Total: 1.0)
- **Execution Filters:** `[percentage]%` (Total: 1.0)
- **Confluence Filters:** `[percentage]%` (Total: 1.0)

**Individual Data Point Weights:**
```
Category          | Data Point | Weight | Justification
------------------|------------|--------|---------------
Bias              | [name]     | 0.4    | [reason]
Bias              | [name]     | 0.3    | [reason]
Momentum          | [name]     | 0.6    | [reason]
Execution         | [name]     | 0.8    | [reason]
Confluence        | [name]     | 0.5    | [reason]
```

#### Threshold Configuration
**Entry Thresholds:**
- **Minimum Composite Score:** `[value]` (range: -1.0 to 1.0)
- **Individual Filter Minimums:**
  - Bias: `[value]`
  - Momentum: `[value]`
  - Execution: `[value]`
  - Confluence: `[value]`

**Exit Thresholds:**
- **Maximum Composite Score:** `[value]` (range: -1.0 to 1.0)
- **Individual Filter Maximums:**
  - Bias: `[value]`
  - Momentum: `[value]`
  - Execution: `[value]`
  - Confluence: `[value]`

### Risk Management

#### Position Sizing
**Method:**
- [ ] Fixed lot size: `[amount]`
- [ ] Percentage of account: `[percentage]%`
- [ ] ATR-based sizing: `[multiplier]` × ATR
- [ ] Volatility-adjusted sizing

**Maximum Exposure:**
- **Single Position:** `[percentage]%` of account
- **Total Portfolio:** `[percentage]%` of account
- **Maximum Simultaneous Positions:** `[number]`

#### Stop Loss Configuration
**Stop Loss Method:**
- [ ] Fixed percentage: `[percentage]%`
- [ ] ATR-based: `[multiplier]` × ATR
- [ ] Indicator-based: Data point threshold
- [ ] Trailing stop: `[percentage]%` or `[multiplier]` × ATR

**Take Profit Configuration:**
- [ ] Fixed percentage: `[percentage]%`
- [ ] Risk-reward ratio: `1:[ratio]`
- [ ] ATR-based: `[multiplier]` × ATR
- [ ] Partial profits: `[percentage]%` at `[level]`, remaining at `[level]`

### Time & Session Filters

#### Trading Hours
**Allowed Trading Sessions:**
- [ ] Asian Session (UTC): `[start_time]` - `[end_time]`
- [ ] European Session (UTC): `[start_time]` - `[end_time]`
- [ ] American Session (UTC): `[start_time]` - `[end_time]`
- [ ] Custom Session: `[start_time]` - `[end_time]`

**Restricted Times:**
- [ ] News Events: `[minutes]` before/after major news
- [ ] Market Open: First `[minutes]` minutes
- [ ] Market Close: Last `[minutes]` minutes
- [ ] Weekend Gap: `[hours]` after Sunday open

### Performance Expectations

#### Backtesting Targets
**Success Metrics:**
- **Win Rate:** Target: `[percentage]%`, Minimum: `[percentage]%`
- **Profit Factor:** Target: `[ratio]`, Minimum: `[ratio]`
- **Average Risk/Reward:** Target: `1:[ratio]`, Minimum: `1:[ratio]`
- **Maximum Drawdown:** Target: `[percentage]%`, Maximum: `[percentage]%`
- **Sharpe Ratio:** Target: `[ratio]`, Minimum: `[ratio]`

**Testing Requirements:**
- [ ] Minimum 1 year historical data
- [ ] Multiple market conditions (trending, ranging, volatile)
- [ ] Multiple timeframes validation
- [ ] Out-of-sample testing period

### Implementation Details

#### Strategy Engine Integration
**Signal Composition Logic:**
```pinescript
// Example composite scoring
bias_score = (fvg_bias * 0.4) + (ghost_bias * 0.3) + (oracle_bias * 0.3)
momentum_score = (ghost_momentum * 0.6) + (vortex_momentum * 0.4)
execution_score = (sessions_timing * 0.8) + (cycles_timing * 0.2)
confluence_score = (multi_indicator_confluence * 0.5) + (volume_confluence * 0.5)

// Final composite score
composite_score = (bias_score * 0.3) + (momentum_score * 0.3) + 
                  (execution_score * 0.2) + (confluence_score * 0.2)
```

**TTS Integration:**
```pinescript
// Strategy signal generation
signal_value = 0
if composite_score >= entry_threshold and position_state == 0
    signal_value := composite_score > 0 ? 1 : -1
else if position_state != 0 and composite_score <= exit_threshold
    signal_value := position_state > 0 ? 2 : -2

plot(signal_value, "Strategy Signal", display=display.data_window)
```

### Validation & Testing

#### Required Tests
**Unit Tests:**
- [ ] Individual data point validation
- [ ] Weight calculation accuracy
- [ ] Signal generation logic
- [ ] State management verification

**Integration Tests:**
- [ ] Multi-indicator signal combination
- [ ] TTS framework compatibility
- [ ] Alert system functionality
- [ ] Performance metrics calculation

**Performance Tests:**
- [ ] Backtesting on historical data
- [ ] Forward testing on live data
- [ ] Stress testing with high volatility
- [ ] Robustness testing with parameter variations

### Documentation Requirements

#### Strategy Documentation
- [ ] Strategy overview and methodology
- [ ] Indicator selection rationale
- [ ] Weight assignment justification
- [ ] Risk management explanation
- [ ] Performance analysis results

#### Implementation Guide
- [ ] Setup instructions
- [ ] Configuration parameters
- [ ] Troubleshooting guide
- [ ] Optimization recommendations

### Acceptance Criteria

#### Definition of Done
- [ ] All required indicators implemented with data points
- [ ] Weighted scoring system functioning correctly
- [ ] Entry/exit logic properly implemented
- [ ] Risk management controls active
- [ ] Backtesting results meet minimum requirements
- [ ] TTS integration working correctly
- [ ] Alert system operational
- [ ] Documentation complete
- [ ] Code review passed
- [ ] Performance validation completed

#### Review Checklist
- [ ] Strategy logic mathematically sound
- [ ] All data points properly weighted
- [ ] Signal generation follows TTS convention
- [ ] Risk management adequate
- [ ] Performance metrics realistic
- [ ] Code follows repository standards

### Additional Context

#### Market Analysis
**Target Markets:**
- [ ] Forex pairs: `[list]`
- [ ] Crypto pairs: `[list]`
- [ ] Stock indices: `[list]`
- [ ] Commodities: `[list]`

**Market Conditions:**
- **Optimal:** `[description]`
- **Avoid:** `[description]`
- **Adaptability:** `[description]`

#### Related Strategies
<!-- Link to similar or related strategy models -->

#### Research References
<!-- Add any relevant research or methodology sources -->

---

**Submission Guidelines:**
1. Complete all required sections thoroughly
2. Ensure all referenced indicators and data points exist
3. Validate weight calculations sum to 1.0
4. Test strategy logic before submission
5. Include realistic performance expectations
6. Add relevant labels and assignees

**Note:** This strategy model will undergo thorough review and testing before implementation. Complex strategies may require iterative development and optimization.