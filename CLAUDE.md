# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a comprehensive Pine Script indicators development repository with an intelligent automation ecosystem. The project focuses on creating TradingView indicators with advanced features like Fair Value Gap (FVG) detection, Ghost Volume Intelligence, Oracle Alliance signals, and market cycle analysis.

## Key Architecture

### Core Development Philosophy
- **Primary workspace**: Always work in the `Pinescript-Coding-Suite/working/` directory, not directly in production `indicators/`
- **Intelligent automation**: Scripts enhance development but never constrain AI autonomy
- **Pine Script v6 focus**: Repository includes v6 extension development alongside indicators

### Directory Structure
```
Pinescript-Coding-Suite/
└── working/               # PRIMARY WORKSPACE - where all development happens
    ├── fvg/               # FVG indicator development
    ├── ghost/             # Ghost Volume Intelligence development
    ├── oracle/            # Oracle Alliance signals development
    ├── sessions/          # Session-based analysis development
    ├── vortex/           # Vortex engine development
    ├── strategy/         # Trading strategy development
    └── testing/          # Experimental features

indicators/               # Production indicators organized by category
├── fvg/                 # Fair Value Gap indicators
├── ghost/               # Ghost Volume Intelligence
├── oracle/              # Oracle Alliance indicators
├── sessions/            # Time-based analysis
├── vortex/             # Vortex engine analysis
├── cycles/             # Market cycle analysis
└── libraries/          # Reusable Pine Script libraries

pinescript-coding-suite/      # Comprehensive documentation and tooling
├── docs/               # Development guides and automation docs
├── scripts/            # Automation scripts (optional to use)
├── database/           # Solution database and analytics
└── pine-script-v6-extension/  # VS Code extension development
```

## Common Development Commands

### VS Code Extension Development
```bash
cd pinescript-coding-suite/pine-script-v6-extension
pnpm install                    # Install dependencies
pnpm run compile               # Build the extension
pnpm run start                 # Start development with VS Code
pnpm run lint                  # Lint TypeScript code
pnpm run build-docs            # Generate documentation
pnpm run vsce-package          # Package extension
```

### Pine Script Development Workflow
```bash
# ALWAYS work in the Pinescript-Coding-Suite/working/ directory first
cp indicators/fvg/fvg.pine Pinescript-Coding-Suite/working/fvg/
# Make your changes in Pinescript-Coding-Suite/working/fvg/fvg.pine

# Optional automation (only use if valuable):
./scripts/pine_master.sh develop Pinescript-Coding-Suite/working/fvg/fvg.pine minor
./scripts/pine_tracker.sh add fvg "Feature description"
```

### Testing and Validation
No specific test framework is configured. Testing is primarily done through:
- TradingView platform compilation
- Manual backtesting on various timeframes
- Forward testing on live markets

## Comprehensive Pine Script Development Rules

### 1. Mandatory Pine Script v6 Syntax Rules

#### Core Requirements
1. **Version Declaration**: Always start with `//@version=6`
2. **Script Declaration**: Must include `indicator()`, `strategy()`, or `library()` after version
3. **Single Line Functions**: ALL function calls must be on single lines - no multi-line continuation
4. **Assignment Operators**: Use `=` for initial declaration, `:=` for reassignment

#### Version Pattern Validation
- **Pattern**: `^(\/\/)(@)(version)(=)([456])`
- **Supported versions**: 4, 5, 6 (but always use 6)
- **Script types**: `indicator`, `library`, `strategy`

### 2. Type System & Safety Rules

#### Type Consistency
- **Rule**: Both branches of conditionals must return same type
- **Example**: `condition ? 1 : 1.0` // ❌ Error: int vs float
- **Correct**: `condition ? 1 : 1` or `condition ? 1.0 : 1.0`

#### Type Forms (Critical for Libraries)
- **Simple types**: Use `simple int length` for library function parameters
- **Series types**: Default for most variables, explicit use rarely needed
- **Pattern**: `[simple|series] <type> <variable_name> = <value>`

#### Explicit Typing Requirements
- **Required for**: NA initialization
- **Example**: `int myVar = na` (not `myVar = na`)
- **Array types**: Use `array<int>` or `int[]` syntax
- **Matrix types**: Use `matrix<float>` syntax
- **Map types**: Use `map<string, int>` syntax

### 3. Array & Collection Safety

#### Array Bounds Checking
- **Rule**: Always check `array.size()` before `array.get()`
- **Pattern to avoid**: `array.get(arr, hardcoded_index)`
- **Correct approach**:
```pine
if array.size(myArray) > index
    value = array.get(myArray, index)
```

#### Pine Script v6 Array Features
- **Negative indices**: `array.get(arr, -1)` // Last element
- **Negative indices**: `array.get(arr, -2)` // Second to last
- **Array types**: Support for all object types (line, label, box, etc.)

### 4. Performance & Memory Management

#### Object Cleanup (Critical)
- **Objects requiring cleanup**: line, label, box, table, linefill, polyline
- **Cleanup condition**: `barstate.islastconfirmedhistory`
- **Reason**: Prevent memory leaks on realtime bars
- **Pattern**:
```pine
if barstate.islastconfirmedhistory
    myLine.delete()
```

#### Boolean Optimizations
- **Short-circuit evaluation**: Available in v6 for improved performance
- **Efficient expressions**: Use boolean logic optimally

### 5. Pine Script v6 Specific Features

#### Dynamic Requests
- **Feature**: Variable symbols in `request.security`
- **Syntax**: `request.security(variable_symbol, timeframe, expression)`
- **Version**: Introduced in v6

#### Enhanced Text Features
- **Exact point sizes**: Use `text_size = 16` instead of `size.large`
- **Text formatting constants**: `text.format_bold`, `text.format_italic`
- **Combinable**: `text_formatting = text.format_bold + text.format_italic`

### 6. Common Error Prevention

#### Series/Simple Type Mismatch
- **Error**: Cannot use series form with TA function length parameters
- **Pattern**: `ta.ema(close, series int length)` ❌
- **Solution**: `ta.ema(close, simple int length)` ✅

#### Array Index Out of Bounds
- **Error**: Direct array access without size validation
- **Pattern**: `array.get(arr, 5)` without checking size ❌
- **Solution**: Always validate with `array.size()` first ✅

#### Type Form Mixing
- **Error**: Cannot mix different type forms in expressions
- **Solution**: Ensure both sides use same type form (both series OR both simple)

### 7. Security & Data Integrity

#### Repainting Prevention
- **Rule**: Avoid repainting behaviors
- **Practice**: Validate historical access patterns
- **Preference**: Use confirmed bar data over realtime when possible

#### Version Migration Considerations
- **v4 to v5**: Use `indicator` instead of `study`, `request.security` instead of `security`
- **v5 to v6**: Use exact point values for text size, leverage negative array indices

### 8. API Type Definitions

#### Complete Type Support
- **Basic types**: `int`, `float`, `bool`, `string`, `color`
- **Object types**: `line`, `label`, `box`, `table`, `linefill`, `polyline`
- **Collection types**: `array<type>`, `matrix<type>`, `map<keyType, valueType>`
- **Chart types**: `chart.point`

#### Array Syntax Options
- **Traditional**: `int[]`, `float[]`, `bool[]`
- **Modern**: `array<int>`, `array<float>`, `array<bool>`
- **Objects**: `array<line>`, `array<label>`, `array<box>`

### 9. Pre-Code Development Checklist

#### Mandatory Syntax Verification
- [ ] Script begins with `//@version=6`
- [ ] Correct script type: `indicator()`, `strategy()`, or `library()`
- [ ] All variables declared before use (`=` then `:=`)
- [ ] One statement per line (no line continuation)
- [ ] Proper indentation following language rules

#### Type Safety Verification
- [ ] Array bounds checked with `array.size()` before access
- [ ] Type consistency in ternary operators and expressions
- [ ] Proper use of `simple` vs `series` type forms
- [ ] Explicit typing for NA initialization (`int myVar = na`)
- [ ] Consistent type forms in expressions (avoid mixing series/simple)

#### Performance & Memory
- [ ] Object cleanup implemented for drawing objects
- [ ] Cleanup guards use `barstate.islastconfirmedhistory`
- [ ] Array operations validated for bounds
- [ ] Efficient boolean expressions implemented

#### Pine Script v6 Features
- [ ] Leverage negative array indices where beneficial
- [ ] Use exact point values for text sizing
- [ ] Consider dynamic requests for variable symbols
- [ ] Implement enhanced text formatting if needed

### 10. Code Examples: Correct vs Incorrect Patterns

#### Basic Structure
```pine
// ✅ Correct
//@version=6
indicator("My Indicator", overlay=true)
box.new(left=bar_index-2, top=high, right=bar_index+10, bottom=low, bgcolor=color.blue)

// ❌ Incorrect - multi-line function call
box.new(
    left=bar_index-2,
    top=high,
    right=bar_index+10,
    bottom=low,
    bgcolor=color.blue
)
```

#### Variable Assignment
```pine
// ✅ Correct variable assignment
myVar = 10        // Initial declaration
myVar := 20       // Reassignment

// ❌ Incorrect
myVar := 10       // Error: Use = for initial declaration
```

#### Array Safety
```pine
// ✅ Correct array access
if array.size(myArray) > 0
    lastValue = array.get(myArray, -1)  // v6 negative index
    firstValue = array.get(myArray, 0)

// ❌ Incorrect - no bounds checking
lastValue = array.get(myArray, array.size(myArray) - 1)  // Risk of bounds error
```

#### Type Safety
```pine
// ✅ Correct type consistency
result = condition ? 1 : 0           // Both int
result = condition ? 1.0 : 0.0       // Both float

// ❌ Incorrect type mixing
result = condition ? 1 : 0.0         // int vs float error
```

#### Object Cleanup
```pine
// ✅ Correct object lifecycle
var line myLine = na
if someCondition
    myLine := line.new(x1=bar_index, y1=high, x2=bar_index+1, y2=low)
    
if barstate.islastconfirmedhistory and not na(myLine)
    myLine.delete()

// ❌ Incorrect - no cleanup
line.new(x1=bar_index, y1=high, x2=bar_index+1, y2=low)  // Memory leak
```

#### Library Function Parameters
```pine
// ✅ Correct - simple type for library export
export myFunction(simple int length, series float source) =>
    ta.ema(source, length)  // length must be simple for ta.ema

// ❌ Incorrect - series type incompatible with ta functions
export myFunction(series int length, series float source) =>
    ta.ema(source, length)  // Error: ta.ema requires simple int length
```

#### Pine Script v6 Features
```pine
// ✅ Correct v6 features
// Negative array indices
lastElement = array.get(myArray, -1)
secondLast = array.get(myArray, -2)

// Exact text sizing
label.new(bar_index, high, "Text", size=16)  // v6: exact points

// Dynamic requests
variableSymbol = "AAPL"
data = request.security(variableSymbol, "1D", close)

// ❌ Incorrect - old v5 patterns
label.new(bar_index, high, "Text", size=size.large)  // v5 constant
```

## Claude Code Integration with Pine Script Language Server

### Real-Time Syntax Validation

Claude Code can leverage your Pine Script extension's language server through the `mcp__ide__getDiagnostics` tool for:

#### **Automatic Error Detection**
```bash
# Claude Code can check all Pine Script files for syntax errors
# This returns real-time diagnostics from the language server
```

#### **Common Language Server Commands**

**1. Check All Files for Errors**
```bash
# Claude Code automatically scans all open .pine files
# Reports: syntax errors, type mismatches, undefined variables
```

**2. File-Specific Validation**
```bash
# Target specific files: working/fvg/my_indicator.pine
# Get line-by-line error analysis with exact positions
```

**3. Pre-Development Validation**
```bash
# Before starting work: scan existing codebase
# Identify breaking changes from Pine Script updates
```

#### **Language Server Error Patterns Claude Code Detects**

**Syntax Errors**
- Missing parentheses, brackets, or operators
- Invalid Pine Script v6 syntax patterns
- Incorrect function call formatting

**Type Errors**
- Series/simple type mismatches
- Array type inconsistencies  
- Function parameter type violations

**Semantic Errors**
- Undefined variables or functions
- Invalid array access patterns
- Object lifecycle violations

#### **Automated Workflow Integration**

**Pre-Edit Validation**
1. Claude Code scans file before making changes
2. Identifies existing errors to avoid conflicts
3. Ensures changes don't introduce new errors

**Post-Edit Verification**
1. Immediately checks diagnostics after edits
2. Reports any new errors introduced
3. Suggests fixes based on error patterns

**Development Workflow Enhancement**
```bash
# Claude Code can now:
1. Read file → Check diagnostics → Plan fixes
2. Make targeted edits → Verify no new errors
3. Report completion with clean diagnostics
```

#### **Pine Script Extension Features Claude Code Leverages**

**Language Server Protocol (LSP) Features:**
- Real-time syntax highlighting validation
- Function signature verification
- Variable scope analysis
- Type checking integration

**VS Code Extension Integration:**
- Custom Pine Script v6 syntax rules
- Built-in function libraries
- Context-aware error messages
- Intelligent code completion validation

#### **Example Claude Code Workflows**

**Error Detection and Fixing**
```bash
# 1. Scan for errors
mcp__ide__getDiagnostics

# 2. Identify specific issues
# Example: "Mismatched input 'end of line without line continuation' expecting ')'"

# 3. Read problematic file
Read /path/to/file.pine

# 4. Fix syntax error
Edit /path/to/file.pine (fix parentheses)

# 5. Verify fix
mcp__ide__getDiagnostics (confirm error resolved)
```

**Pre-Development Health Check**
```bash
# Before starting new feature development:
1. Check all working/ directory files for existing errors
2. Report any blocking issues that need resolution first
3. Ensure clean starting point for new development
```

**Quality Assurance Integration**
```bash
# After completing development:
1. Run full diagnostic scan
2. Ensure zero syntax/type errors
3. Validate Pine Script v6 compliance
4. Confirm language server satisfaction
```

#### **Advanced Language Server Integration**

**Error Classification by Severity**
- **Error**: Syntax/type errors that prevent compilation
- **Warning**: Potential issues or deprecated patterns
- **Info**: Style suggestions or optimization hints

**Line-Precise Error Reporting**
- Exact line and character position
- Context-aware error messages
- Suggested fix patterns when available

**Multi-File Analysis**
- Cross-file dependency checking
- Library import validation
- Consistent typing across files

### Smart Error Resolution with Extracted Rules

Claude Code combines language server diagnostics with the extracted rule sets from `Pinescript-Coding-Suite/extracted_rules/` for intelligent error resolution:

#### **Error Pattern Matching**
When diagnostics detect errors, Claude Code cross-references with:
- `pine_error_patterns.json` - Common error patterns and solutions
- `pine_syntax_rules.json` - Version-specific syntax requirements  
- `pine_v6_specific.json` - Pine Script v6 features and migration patterns

#### **Intelligent Error Resolution Workflow**
```bash
1. mcp__ide__getDiagnostics → Detect "series_simple_mismatch" error
2. Reference pine_error_patterns.json → "Use 'simple int' instead of 'series int'"
3. Apply targeted fix → ta.ema(close, simple int length)
4. Verify with mcp__ide__getDiagnostics → Confirm resolution
```

#### **Rule-Driven Development Patterns**

**Type Safety Integration**
```pine
// Detected error: "Cannot mix different type forms in expression"
// Rule reference: pine_best_practices.json → "form_consistency"
// Auto-solution: Ensure both branches return same type

// ❌ Before (detected by diagnostics)
result = condition ? 1 : 1.0  // Error: int vs float

// ✅ After (fixed using rules)
result = condition ? 1 : 1    // Both int
```

**Array Bounds Safety**
```pine
// Detected error: "Array index out of bounds"
// Rule reference: pine_error_patterns.json → "array_bounds"
// Auto-solution: Add size validation

// ❌ Before
value = array.get(myArray, 5)  // Direct access

// ✅ After (rule-guided fix)
if array.size(myArray) > 5
    value = array.get(myArray, 5)
```

**Pine Script v6 Migration**
```pine
// Detected error: Using deprecated v5 patterns
// Rule reference: pine_v6_specific.json → "enhanced_text"
// Auto-solution: Upgrade to v6 syntax

// ❌ Before
label.new(bar_index, high, "Text", size=size.large)

// ✅ After (rule-guided upgrade)
label.new(bar_index, high, "Text", size=16)  // v6: exact points
```

#### **Advanced Rule Integration Features**

**Contextual Error Classification**
- **Syntax Errors**: pine_syntax_rules.json provides version-specific patterns
- **Type Errors**: pine_api_rules.json offers complete type system reference
- **Performance Issues**: pine_best_practices.json suggests optimization patterns

**Proactive Code Enhancement**
```bash
# Beyond error fixing - rule-driven improvements
1. Scan code with diagnostics
2. Cross-reference pine_best_practices.json
3. Suggest performance optimizations
4. Apply security best practices
```

**Multi-File Consistency Checking**
```bash
# Use rules to ensure consistency across files
1. Check all .pine files for version compliance
2. Validate type usage patterns across libraries
3. Ensure uniform coding standards
```

### Benefits for Pine Script Development

1. **Immediate Feedback**: Real-time error detection without TradingView compilation
2. **Precise Targeting**: Line-by-line error identification with rule-based solutions
3. **Type Safety**: Advanced type checking beyond basic syntax
4. **IDE Integration**: Seamless workflow with your existing setup
5. **Quality Assurance**: Automated validation in development pipeline
6. **Smart Resolution**: Rule-driven error fixing and code enhancement
7. **Pattern Recognition**: Leverage extracted knowledge for common issues
8. **Version Compliance**: Automatic Pine Script v6 standard enforcement

## Key Indicators and Features

### FVG (Fair Value Gap) Indicators
- **Main**: `indicators/fvg/fvg.pine` - Multi-timeframe FVG detection with session filters
- **Features**: 1st presentation FVGs, weekly/monthly FVGs, silver bullet timing
- **Working**: `Pinescript-Coding-Suite/working/fvg/` for active development

### Ghost Volume Intelligence
- **Main**: `indicators/ghost/Ghost_Volume_Intelligence_Pro.pine`
- **Features**: Advanced volume analysis with T1/T2 integration
- **Working**: `Pinescript-Coding-Suite/working/ghost/` for active development

### Signal Composite Engine (SCE)
- **Location**: `Pinescript-Coding-Suite/working/strategy/Signal_Composite_Engine.pine`
- **Status**: v0.1.0 - needs weighted scoring and multi-signal support
- **Next steps**: See `SCE_Next_Steps.md` for roadmap

## Optional Automation Tools

The repository includes sophisticated automation scripts that enhance development but are **completely optional**:

### Core Scripts (Use Only When Valuable)
- `scripts/pine_master.sh` - Development workflow, versioning, error detection
- `scripts/pine_tracker.sh` - Feature tracking, success/failure logging
- `scripts/json_mermaid_integration.py` - Analytics and pattern recognition

### When to Use Automation
- ✅ Starting complex features
- ✅ Encountering unknown errors (solution database lookup)
- ✅ Completing significant milestones
- ✅ Need pattern recognition from past solutions

### When NOT to Use Automation
- ❌ Minor edits or parameter tweaks
- ❌ Simple syntax fixes
- ❌ During rapid iteration phases
- ❌ Known errors with memorized solutions

## Development Best Practices

### Workflow
1. Always copy indicators to `Pinescript-Coding-Suite/working/` before modification
2. Follow Pine Script v6 syntax rules strictly
3. Test on multiple timeframes and symbols
4. Use automation scripts sparingly - only when they add value
5. Version at meaningful milestones, not every change

### Code Quality
- Maintain consistent indentation and style
- Use descriptive variable names
- Add comments for complex logic
- Follow existing patterns in the codebase
- Ensure proper object lifecycle management

### Error Prevention
- Always validate array access with size checks
- Use proper type consistency in conditionals
- Guard drawing object deletions with barstate checks
- Follow single-line function call rule strictly

## Maximizing Claude Code with Pine Script VS Code Extension

### VS Code Extension Integration
Your Pine Script VS Code extension provides these features that Claude Code can leverage:

1. **Language Server Features:**
   - Syntax highlighting and validation
   - Code completion and IntelliSense
   - Function signature help
   - Error detection and diagnostics

2. **Available Commands (accessible via Command Palette):**
   - `Pine Script Options` - Context-sensitive options
   - `Typify Variables` - Automatic type inference
   - `Generate Docstring` - Documentation generation
   - `Open Built-in Script` - Access standard library
   - `New Indicator/Strategy/Library` - Template creation

3. **Themes and Syntax:**
   - 20+ Pine Script-specific themes available
   - Optimized syntax highlighting for Pine Script v6
   - Custom icons and file association (.pine, .ps files)

### Claude Code Best Practices for Pine Script

#### 1. Always Use File Extensions
```bash
# ✅ Correct - use .pine extension
working/fvg/my_indicator.pine

# ❌ Incorrect - missing extension
working/fvg/my_indicator
```

#### 2. Leverage Extension Features
When working with Pine Script files, Claude Code can:
- Use the `mcp__ide__getDiagnostics` tool to get real-time error feedback
- Execute Pine Script validation through the extension
- Access IntelliSense data for better code completion

#### 3. Follow the Extension's Patterns
The extension expects:
- Files in `.pine` or `.ps` format
- Proper Pine Script v6 syntax
- Compliance with the comprehensive rules in `.cursor/rules/`

#### 4. Use Diagnostic Information
```bash
# Claude Code can check diagnostics for Pine Script files
# This provides real-time error detection and syntax validation
```

### Workflow Integration

#### Step 1: File Creation
When creating new Pine Script files:
```bash
# Use the extension's template commands
# Or create files with proper .pine extension
# Claude Code will automatically get syntax support
```

#### Step 2: Development
During development:
- Claude Code follows the Cursor rules automatically
- Real-time diagnostics provide immediate feedback
- Extension provides context-aware suggestions

#### Step 3: Validation
Before completion:
- Use diagnostic tools to verify syntax
- Leverage extension's validation features
- Ensure compliance with Pine Script v6 standards

### Claude Code Specific Advantages

1. **Rule Adherence**: Claude Code automatically follows your comprehensive Cursor rules
2. **Context Awareness**: Understands Pine Script syntax and patterns
3. **Error Prevention**: Proactively follows best practices to prevent common errors
4. **Extension Integration**: Can leverage VS Code extension features through MCP tools

### Recommended Development Flow

1. **Create/Open .pine file** in `working/` directory
2. **Let Claude Code use extension features** for syntax validation
3. **Follow Pine Script v6 rules** from your Cursor configuration
4. **Use diagnostic tools** for real-time error checking
5. **Validate with extension** before moving to production

## Important Notes

- This repository is **not** a git repository
- The VS Code extension is actively developed alongside indicators
- The `pinescript-coding-suite/` contains extensive documentation and learning materials
- Pine Script compilation errors are the primary feedback mechanism
- The automation system learns from solutions to improve future development
- Your Pine Script VS Code extension provides language server features Claude Code can leverage
- The `.cursor/rules/` directory contains comprehensive Pine Script v6 rules that Claude Code follows automatically

## Context and Intelligence

The repository includes a sophisticated context system with:
- **Solution Database**: Past error patterns and successful fixes
- **Analytics System**: Tool effectiveness metrics and success tracking
- **Documentation**: Comprehensive guides for Pine Script development
- **Version History**: Semantic versioning for all major indicators

This system is designed to amplify AI agent capabilities while maintaining complete development autonomy.