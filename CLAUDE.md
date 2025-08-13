# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Pine Script development workspace for creating professional TradingView indicators, strategies, and libraries. The repository provides comprehensive tooling, validation scripts, and extracted Pine Script v6 rules to ensure high-quality development.

## Repository Structure

```
development/                     # ACTIVE DEVELOPMENT AREA
├── indicators/                  # Work-in-progress indicators
├── strategies/                  # Developing trading strategies
└── libraries/                   # Building reusable libraries

production/                      # FINALIZED & TESTED CODE
├── indicators/                  # Production-ready indicators
├── strategies/                  # Battle-tested strategies
└── libraries/                   # Stable, reusable libraries

Pinescript-Coding-Suite/
├── scripts/                     # Validation and automation tools
├── extracted_rules/             # Pine Script v6 rule database
│   ├── pine_syntax_rules.json
│   ├── pine_error_patterns.json
│   ├── pine_best_practices.json
│   └── pine_v6_specific.json
└── pine-script-v6-extension/   # VS Code extension (.vsix)
```

## Common Development Commands

### Makefile Commands
```bash
# Core development
make dev                        # Setup development environment
make new-indicator             # Create new indicator with template
make new-strategy              # Create new strategy with template
make new-library               # Create new library with template
make validate-dev              # Validate files in development directory
make lint                      # Full validation + memory checks

# Version management
make version-file FILE=development/indicators/my_indicator.pine TYPE=minor
make promote-to-production FILE=development/indicators/my_indicator.pine

# Validation
make check-memory              # Check for drawing object cleanup
make validate-all              # Validate entire repository
make validate-prod             # Validate production files only
```

### Pine Script Validation
```bash
# Python validator with rule integration
python Pinescript-Coding-Suite/scripts/validate_pine_script.py <file.pine>

# Memory management checker
bash Pinescript-Coding-Suite/scripts/check_file_memory.sh <file.pine>
```

## Pine Script v6 Development Rules

### 1. Mandatory Syntax

```pine
//@version=6                    // ALWAYS first line
indicator("Name", overlay=true)  // Required declaration

// ✅ CORRECT: Single line function calls
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low)

// ❌ WRONG: Multi-line function calls
box.new(
    left=bar_index-2,
    top=high
)
```

### 2. Variable Assignment

```pine
myVar = 10        // Initial declaration uses =
myVar := 20       // Reassignment uses :=
```

### 3. Type Safety

```pine
// Both branches must return same type
result = condition ? 1 : 0      // ✅ Both int
result = condition ? 1 : 0.0    // ❌ Mixed types

// Explicit typing for NA
int myVar = na                   // Required
```

### 4. Array Safety

```pine
// ALWAYS check bounds before access
if array.size(myArray) > index
    value = array.get(myArray, index)

// Pine v6 negative indices
lastElement = array.get(myArray, -1)
```

### 5. Memory Management

```pine
// Drawing objects MUST be cleaned up
var line myLine = na
if condition
    myLine := line.new(x1=bar_index, y1=high, x2=bar_index+1, y2=low)
    
// Required cleanup pattern
if barstate.islastconfirmedhistory and not na(myLine)
    myLine.delete()
```

### 6. Library Functions

```pine
// TA functions require simple type for length
export myFunction(simple int length, series float source) =>
    ta.ema(source, length)  // ✅ Correct
    
// NOT series int length - causes error
```

### 7. Pine v6 Features

```pine
// Negative array indices
last = array.get(arr, -1)
secondLast = array.get(arr, -2)

// Exact text sizing (not size.large)
label.new(bar_index, high, "Text", size=16)

// Dynamic security requests
symbol = "AAPL"
data = request.security(symbol, "D", close)
```

## Error Pattern Recognition

The repository includes extracted Pine Script rules in `Pinescript-Coding-Suite/extracted_rules/`:

- **pine_syntax_rules.json**: Version-specific syntax patterns
- **pine_error_patterns.json**: Common errors and solutions
- **pine_best_practices.json**: Performance and style guidelines
- **pine_v6_specific.json**: v6-specific features and migrations

When encountering errors, cross-reference with these rule files for immediate solutions.

## IDE Integration

### Language Server Diagnostics
Use `mcp__ide__getDiagnostics` to get real-time Pine Script validation:
- Syntax errors with line-precise locations
- Type mismatches and inconsistencies
- Undefined variables and functions
- Memory management issues

### VS Code Extension
The repository includes a Pine Script v6 extension (`pine-script-v6-extension/pinescript-v6-vscode-0.1.0.vsix`) providing:
- Syntax highlighting
- IntelliSense completion
- Real-time error detection
- Function signatures

## Development Workflow

1. **Create new file**: Always use `.pine` extension in `development/` directory
2. **Use templates**: `make new-indicator/strategy/library` provides proper v6 structure
3. **Validate continuously**: `make validate-dev` during development
4. **Check memory**: `make check-memory` for indicators with drawing objects
5. **Version appropriately**: `make version-file` at milestones
6. **Promote when ready**: `make promote-to-production` after full validation to move to `production/`

## Critical Pine Script Patterns

### TTS Signal Standard
```pine
// Trading signals follow TTS standard
// 1 = Long Entry, -1 = Short Entry
// 2 = Long Exit, -2 = Short Exit, 0 = No Signal
signal = 0
signal := longCondition ? 1 : signal
signal := shortCondition ? -1 : signal
plot(signal, "TTS Signal", display=display.data_window)
```

### Multi-Timeframe Pattern
```pine
htf_data = request.security(syminfo.tickerid, "D", close)
htf_ema = request.security(syminfo.tickerid, "D", ta.ema(close, 20))
```

### Session Analysis Pattern
```pine
nySession = input.session("0930-1600", "NY Session")
inSession = time(timeframe.period, nySession)
sessionHigh = ta.highest(high, barssince(na(inSession[1])))
```

## Common Error Solutions

### "Mismatched input" Error
- Check for multi-line function calls (not allowed)
- Ensure all parentheses are closed on same line

### "Cannot use series" Error
- Change `series int length` to `simple int length` for TA functions

### "Type mismatch" Error
- Ensure both branches of ternary operators return same type
- Use explicit typing for NA values

### "Array index out of bounds"
- Always validate with `array.size()` before `array.get()`

### Memory Leak Issues
- Implement cleanup for all drawing objects
- Use `barstate.islastconfirmedhistory` guard

## Testing Guidelines

Testing is done through:
1. TradingView platform compilation
2. Multi-timeframe validation (1m, 5m, 1H, 1D minimum)
3. Symbol testing across different markets
4. Forward testing on live data

## Important Notes

- **Development vs Production**: All new code starts in `development/`, only tested code goes to `production/`
- **Primary workspace**: Always develop in `development/` directories first
- **File extension**: Always use `.pine` extension for proper IDE support
- **Version compliance**: Strictly follow Pine Script v6 syntax rules
- **Memory safety**: Clean up all drawing objects to prevent leaks
- **Type consistency**: Maintain consistent types in all expressions
- **Quality gates**: Code must pass all validation before promotion to production