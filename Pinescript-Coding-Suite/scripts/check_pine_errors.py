#!/usr/bin/env python3
"""
Basic PineScript Error Checker
Checks for common syntax errors and undefined variables
"""

import re
import sys
import os

def check_pine_script(file_path):
    """Check a Pine Script file for common errors"""
    errors = []
    warnings = []
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            lines = content.split('\n')
    except Exception as e:
        return [f"Error reading file: {e}"], []
    
    # Track defined variables
    defined_vars = set()
    input_vars = set()
    
    # Common Pine Script built-ins and keywords
    built_ins = {
        'open', 'high', 'low', 'close', 'volume', 'time', 'bar_index',
        'barstate', 'syminfo', 'timeframe', 'ta', 'math', 'str', 'array',
        'line', 'label', 'box', 'table', 'plot', 'plotshape', 'plotchar',
        'hline', 'fill', 'bgcolor', 'barcolor', 'color', 'size', 'na',
        'indicator', 'strategy', 'library', 'import', 'as', 'export',
        'int', 'float', 'bool', 'string', 'color', 'type', 'var', 'varip',
        'input', 'overlay', 'max_lines_count', 'max_labels_count', 'max_boxes_count',
        'title', 'defval', 'group', 'inline', 'tooltip', 'options', 'minval', 'maxval',
        'xloc', 'yloc', 'extend', 'style', 'width', 'text', 'textcolor',
        'bgcolor', 'border_color', 'border_width', 'text_halign', 'text_valign',
        'text_size', 'Quant', 'BaseData', 'new', 'get', 'set', 'push', 'pop',
        'size', 'shift', 'clear', 'ticker', 'dayofmonth', 'hour', 'minute',
        'second', 'year', 'month', 'dayofweek', 'format_time', 'tostring',
        'tonumber', 'split', 'contains', 'from', 'switch', 'LineStyle',
        'GetTimezone', 'GetTickerNameString', 'CalculateTimeOffset',
        'GetSecurityCandleData', 'IsDay', 'GetSessionTimes', 'GetTimeframeInMilliSeconds',
        'LineLabel', 'BoxWithLine', 'CandleDataObject', 'SessionDataObject'
    }
    
    for line_num, line in enumerate(lines, 1):
        line = line.strip()
        if not line or line.startswith('//'):
            continue
            
        # Check for variable definitions
        var_def_match = re.match(r'^(?:var\s+)?(\w+)\s*[:=]', line)
        if var_def_match:
            defined_vars.add(var_def_match.group(1))
            
        # Check for input definitions
        input_match = re.match(r'^(\w+)\s*=\s*input\.\w+', line)
        if input_match:
            input_vars.add(input_match.group(1))
            defined_vars.add(input_match.group(1))
        
        # Check for function definitions
        func_def_match = re.match(r'^(\w+)\s*\([^)]*\)\s*=>', line)
        if func_def_match:
            defined_vars.add(func_def_match.group(1))
            
        # Check for type definitions
        type_def_match = re.match(r'^type\s+(\w+)', line)
        if type_def_match:
            defined_vars.add(type_def_match.group(1))
            
        # Check for undefined variables
        var_usage = re.findall(r'\b([a-zA-Z_]\w*)\b', line)
        for var in var_usage:
            if (var not in defined_vars and 
                var not in built_ins and 
                var not in input_vars and
                not var[0].isupper() and  # Skip constants
                not re.match(r'^\d', var) and  # Skip numbers
                var not in ['if', 'else', 'for', 'while', 'switch', 'true', 'false', 'and', 'or', 'not', 'in']):
                
                # Check if it looks like a variable usage (not a function call)
                if not re.search(rf'{var}\s*\(', line):
                    errors.append(f"Line {line_num}: Undefined variable '{var}' in: {line[:60]}...")
        
        # Check for common syntax errors
        if line.count('(') != line.count(')'):
            errors.append(f"Line {line_num}: Mismatched parentheses")
            
        if line.count('[') != line.count(']'):
            errors.append(f"Line {line_num}: Mismatched brackets")
            
        if line.count('{') != line.count('}'):
            errors.append(f"Line {line_num}: Mismatched braces")
            
        # Check for missing version directive
        if line_num == 1 and '//@version=' not in content[:200]:
            warnings.append("Missing version directive (e.g., //@version=6)")
            
        # Check for common typos
        if 'colour' in line.lower():
            warnings.append(f"Line {line_num}: Use 'color' instead of 'colour'")
            
    return errors, warnings

def main():
    if len(sys.argv) != 2:
        print("Usage: python check_pine_errors.py <pine_file>")
        sys.exit(1)
        
    file_path = sys.argv[1]
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        sys.exit(1)
        
    errors, warnings = check_pine_script(file_path)
    
    print(f"\n🔍 Checking: {file_path}")
    print("=" * 50)
    
    if errors:
        print(f"\n❌ ERRORS ({len(errors)}):")
        for error in errors[:20]:  # Limit to first 20 errors
            print(f"  {error}")
        if len(errors) > 20:
            print(f"  ... and {len(errors) - 20} more errors")
    
    if warnings:
        print(f"\n⚠️  WARNINGS ({len(warnings)}):")
        for warning in warnings:
            print(f"  {warning}")
    
    if not errors and not warnings:
        print("\n✅ No obvious errors found!")
    
    print("\n" + "=" * 50)
    return len(errors)

if __name__ == "__main__":
    exit_code = main()
    sys.exit(min(exit_code, 1))  # Return 1 if errors found, 0 if clean 