# Pine Script Rules & Error Patterns

This directory contains extracted Pine Script development rules, error patterns, and best practices in JSON format. These files are used by Claude Code and the development automation tools for intelligent error detection and resolution.

## Files Overview

### `pine_error_patterns.json`
Common Pine Script error patterns and their solutions:
- **series_simple_mismatch** - TA function parameter type errors
- **array_bounds** - Array index out of bounds prevention
- **type_consistency** - Type mixing in conditional expressions
- **version_declaration** - Missing version declaration
- **multiline_function** - Multi-line function call detection

### `pine_syntax_rules.json`
Pine Script v6 syntax rules and requirements:
- **Mandatory syntax rules** - Version declaration, script types, assignment operators
- **Type forms** - Simple vs series type usage
- **Memory management** - Object cleanup patterns
- **Version patterns** - Supported Pine Script versions

### `pine_v6_specific.json`
Pine Script v6 specific features and enhancements:
- **Dynamic requests** - Variable symbols in request.security
- **Enhanced text** - Exact point sizes and formatting
- **Array improvements** - Negative indices and object arrays
- **Migration guide** - v5 to v6 conversion patterns

### `pine_best_practices.json`
Development best practices and quality standards:
- **Security & data integrity** - Repainting prevention
- **Performance optimization** - Calculation time and memory usage
- **Code quality** - Naming conventions and patterns
- **Testing requirements** - Compilation and functionality standards

## Integration with Development Tools

### Claude Code Integration
These rules are automatically used by Claude Code for:
- **Error pattern matching** - Automatic detection of common issues
- **Intelligent fixes** - Rule-driven error resolution
- **Code enhancement** - Proactive optimization suggestions
- **Version compliance** - Pine Script v6 standard enforcement

### Makefile Integration
The repository's Makefile uses these rules through:
- `scripts/validate_pine_script.py` - References error patterns
- `make lint` - Comprehensive rule validation
- `make check-memory` - Memory management pattern verification

### Language Server Integration
The Pine Script extension leverages these rules for:
- **Real-time validation** - Syntax error detection
- **Context-aware suggestions** - Rule-based code completion
- **Error classification** - Severity-based error reporting

## Usage Examples

### Error Pattern Detection
```bash
# Claude Code automatically references these patterns:
1. mcp__ide__getDiagnostics → Detect "series_simple_mismatch" error
2. Reference pine_error_patterns.json → "Use 'simple int' instead of 'series int'"
3. Apply targeted fix → ta.ema(close, simple int length)
4. Verify with mcp__ide__getDiagnostics → Confirm resolution
```

### Best Practice Validation
```bash
# Automated validation workflow:
1. Scan code with diagnostics
2. Cross-reference pine_best_practices.json
3. Suggest performance optimizations
4. Apply security best practices
```

### Version Compliance Check
```bash
# Ensure Pine Script v6 compliance:
1. Check all .pine files for version compliance
2. Validate type usage patterns across libraries
3. Ensure uniform coding standards
```

## Updating Rules

When updating these rule files:

1. **Test thoroughly** - Ensure new rules don't conflict with existing code
2. **Update documentation** - Reflect changes in CLAUDE.md and README files
3. **Validate integration** - Test with Claude Code and Makefile workflows
4. **Version control** - Document changes in CHANGELOG.md

## Benefits

Using these extracted rules provides:
- **Immediate feedback** - Real-time error detection without TradingView compilation
- **Precise targeting** - Line-by-line error identification with solutions
- **Type safety** - Advanced type checking beyond basic syntax
- **Pattern recognition** - Leverage accumulated knowledge for common issues
- **Consistency** - Uniform coding standards across all indicators