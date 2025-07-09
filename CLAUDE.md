# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a comprehensive Pine Script indicators development repository with an intelligent automation ecosystem. The project focuses on creating TradingView indicators with advanced features like Fair Value Gap (FVG) detection, Ghost Volume Intelligence, Oracle Alliance signals, and market cycle analysis.

## Key Architecture

### Core Development Philosophy
- **Primary workspace**: Always work in the `working/` directory, not directly in production `indicators/`
- **Intelligent automation**: Scripts enhance development but never constrain AI autonomy
- **Pine Script v6 focus**: Repository includes v6 extension development alongside indicators

### Directory Structure
```
working/                    # PRIMARY WORKSPACE - where all development happens
├── fvg/                   # FVG indicator development
├── ghost/                 # Ghost Volume Intelligence development
├── oracle/                # Oracle Alliance signals development
├── sessions/              # Session-based analysis development
├── vortex/               # Vortex engine development
├── strategy/             # Trading strategy development
└── testing/              # Experimental features

indicators/               # Production indicators organized by category
├── fvg/                 # Fair Value Gap indicators
├── ghost/               # Ghost Volume Intelligence
├── oracle/              # Oracle Alliance indicators
├── sessions/            # Time-based analysis
├── vortex/             # Vortex engine analysis
├── cycles/             # Market cycle analysis
└── libraries/          # Reusable Pine Script libraries

cursor-memory-bank/      # Comprehensive documentation and tooling
├── docs/               # Development guides and automation docs
├── scripts/            # Automation scripts (optional to use)
├── database/           # Solution database and analytics
└── pine-script-v6-extension/  # VS Code extension development
```

## Common Development Commands

### VS Code Extension Development
```bash
cd cursor-memory-bank/pine-script-v6-extension
pnpm install                    # Install dependencies
pnpm run compile               # Build the extension
pnpm run start                 # Start development with VS Code
pnpm run lint                  # Lint TypeScript code
pnpm run build-docs            # Generate documentation
pnpm run vsce-package          # Package extension
```

### Pine Script Development Workflow
```bash
# ALWAYS work in the working/ directory first
cp indicators/fvg/fvg.pine working/fvg/
# Make your changes in working/fvg/fvg.pine

# Optional automation (only use if valuable):
./scripts/pine_master.sh develop working/fvg/fvg.pine minor
./scripts/pine_tracker.sh add fvg "Feature description"
```

### Testing and Validation
No specific test framework is configured. Testing is primarily done through:
- TradingView platform compilation
- Manual backtesting on various timeframes
- Forward testing on live markets

## Critical Pine Script Rules

### Mandatory Pine Script v6 Syntax Rules (From Cursor Rules)
1. **Version Declaration**: Always start with `//@version=6`
2. **Script Declaration**: Must include `indicator()`, `strategy()`, or `library()` after version
3. **Single Line Functions**: ALL function calls must be on single lines - no multi-line continuation
4. **Assignment Operators**: Use `=` for initial declaration, `:=` for reassignment
5. **Type Consistency**: Both branches of conditionals must return same type
6. **Array Safety**: Always check `array.size()` before accessing elements
7. **Object Cleanup**: Use `.delete()` with `barstate.islastconfirmedhistory` guards
8. **Type Forms**: Use `simple` vs `series` correctly (e.g., `simple int length` for library functions)
9. **Memory Management**: Implement proper object lifecycle with cleanup patterns
10. **Pine v6 Features**: Leverage negative array indices, dynamic requests, exact text sizing

### Pre-Code Checklist
Before writing any Pine Script code, verify:
- [ ] Script begins with `//@version=6`
- [ ] Correct script type: `indicator()`, `strategy()`, or `library()`
- [ ] All variables declared before use (`=` then `:=`)
- [ ] Array bounds checked with `array.size()`
- [ ] Object cleanup implemented for memory management
- [ ] Type consistency in ternary operators and expressions
- [ ] Proper use of `simple` vs `series` type forms
- [ ] One statement per line (no line continuation)
- [ ] Proper indentation for code blocks

### Examples of Correct vs Incorrect Syntax
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

// ✅ Correct variable assignment
myVar = 10        // Initial declaration
myVar := 20       // Reassignment

// ❌ Incorrect
myVar := 10       // Error: Use = for initial declaration
```

## Key Indicators and Features

### FVG (Fair Value Gap) Indicators
- **Main**: `indicators/fvg/fvg.pine` - Multi-timeframe FVG detection with session filters
- **Features**: 1st presentation FVGs, weekly/monthly FVGs, silver bullet timing
- **Working**: `working/fvg/` for active development

### Ghost Volume Intelligence
- **Main**: `indicators/ghost/Ghost_Volume_Intelligence_Pro.pine`
- **Features**: Advanced volume analysis with T1/T2 integration
- **Working**: `working/ghost/` for active development

### Signal Composite Engine (SCE)
- **Location**: `working/strategy/Signal_Composite_Engine.pine`
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
1. Always copy indicators to `working/` before modification
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
- The `cursor-memory-bank/` contains extensive documentation and learning materials
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