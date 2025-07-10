---
name: Data Point Request
about: Request a new data point signal for indicators
title: "[DATA POINT] "
labels: ["data-point", "enhancement"]
assignees: []
---

## 📊 Data Point Request

### Indicator Information
**Indicator Name:** 
**Indicator Category:** (FVG, Ghost, Oracle, Sessions, Vortex, Cycles, etc.)
**Indicator File Path:** `indicators/[category]/[filename].pine`

### Data Point Details

#### Signal Identification
**Data Point Name:** 
**Signal Type:** 
- [ ] Bias Filter (Trend/Direction based)
- [ ] Momentum Filter (Strength/Speed based) 
- [ ] Execution Filter (Entry/Exit timing)
- [ ] Confluence Filter (Multi-factor validation)

#### Signal Logic
**Description:** 
<!-- Describe what this data point detects and when it should trigger -->

**Trigger Conditions:**
- **Long Entry:** 
- **Short Entry:** 
- **Exit Conditions:** 

**Signal Values:**
- **Long Signal:** `1` (Start Long Deal)
- **Short Signal:** `-1` (Start Short Deal)
- **Exit Signal:** `2` (End Long) / `-2` (End Short)
- **Neutral:** `0` (No Signal)

### Technical Specifications

#### Input Parameters
```
Parameter Name | Type | Default | Description
---------------|------|---------|-------------
[param1]       | bool | true    | [description]
[param2]       | int  | 14      | [description]
[param3]       | float| 1.0     | [description]
```

#### Dependencies
**Required Variables/Functions:**
- [ ] Variable 1: `[description]`
- [ ] Variable 2: `[description]`
- [ ] Function 1: `[description]`

**External Dependencies:**
- [ ] Libraries: `[library name/version]`
- [ ] Imports: `[import statements]`

### Signal Configuration

#### Filters & Thresholds
**Minimum Requirements:**
- **Volume Confirmation:** [ ] Required / [ ] Optional
- **Time Filter:** [ ] Session-based / [ ] Always active
- **Trend Filter:** [ ] Required / [ ] Optional
- **Size/Strength Filter:** Minimum value: `[value]`

#### Signal Management
**State Management:**
- [ ] Prevent duplicate signals
- [ ] Cooldown period: `[number]` bars
- [ ] Signal cancellation logic

**Alert Configuration:**
- [ ] Basic alerts (Long/Short/Exit)
- [ ] Webhook-ready JSON format
- [ ] Custom alert messages

### Use Case & Purpose

#### Trading Application
**Primary Use:** 
<!-- Explain the main trading purpose of this data point -->

**Market Conditions:**
- **Best Performance:** 
- **Avoid During:** 
- **Optimal Timeframes:** 

#### Integration Requirements
**Strategy Engine Integration:**
- [ ] Standalone signal
- [ ] Composite signal component
- [ ] Confluence requirement

**Expected Signal Frequency:**
- [ ] High frequency (multiple per session)
- [ ] Medium frequency (daily signals)
- [ ] Low frequency (weekly signals)

### Additional Features

#### Visual Elements
- [ ] Signal markers on chart
- [ ] Background highlighting
- [ ] Signal strength indicators
- [ ] Debug/diagnostic plots

#### Advanced Features
- [ ] Multi-timeframe analysis
- [ ] Dynamic threshold adjustment
- [ ] Signal strength scoring
- [ ] Historical performance metrics

### Testing Requirements

#### Validation Criteria
**Backtesting:**
- [ ] Test on multiple timeframes
- [ ] Test on different symbols
- [ ] Test in various market conditions

**Performance Metrics:**
- [ ] Signal accuracy rate
- [ ] False positive rate
- [ ] Signal latency
- [ ] Repainting validation

### Implementation Notes

#### Technical Considerations
```pinescript
// Example signal logic structure
your_long_condition = [condition_logic]
your_short_condition = [condition_logic]
your_exit_condition = [condition_logic]

// TTS Signal Integration
plot(enable_tts ? signal_value : na, "TTS Signal", display=display.data_window)
```

#### Code Quality Requirements
- [ ] Follow Pine Script v6 syntax
- [ ] Implement proper error handling
- [ ] Add comprehensive comments
- [ ] Use consistent naming conventions

### Acceptance Criteria

#### Definition of Done
- [ ] Signal logic implemented and tested
- [ ] TTS integration working correctly
- [ ] Visual elements properly displayed
- [ ] Alert system functional
- [ ] Documentation updated
- [ ] Code review completed
- [ ] Performance validation passed

#### Review Checklist
- [ ] Code follows repository standards
- [ ] Signal values match TTS convention
- [ ] No repainting issues
- [ ] Memory management implemented
- [ ] Error handling present

### Additional Context

#### Related Issues/PRs
<!-- Link to related issues or pull requests -->

#### Screenshots/Charts
<!-- Add any relevant charts or visual examples -->

#### References
<!-- Add any relevant documentation or research -->

---

**Submission Guidelines:**
1. Fill out all required sections
2. Test your data point logic before submission
3. Ensure TTS signal integration is correct
4. Add relevant labels and assignees
5. Link to any related issues or PRs

**Note:** This data point will be reviewed and tested before integration into the main codebase. Please ensure all requirements are met for faster approval.