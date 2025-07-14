#!/usr/bin/env python3
"""
Pine Script v6 Validation Tool
Validates Pine Script files against comprehensive rules
"""

import re
import sys
import json
from pathlib import Path

class PineScriptValidator:
    def __init__(self, rules_path=None):
        self.rules = self.load_rules(rules_path)
        self.errors = []
        self.warnings = []
        
    def load_rules(self, rules_path):
        """Load validation rules from extracted rules directory"""
        if not rules_path:
            rules_path = Path(__file__).parent.parent / "Pinescript-Coding-Suite" / "extracted_rules"
        
        rules = {}
        rule_files = [
            "pine_v6_specific.json",
            "pine_best_practices.json", 
            "pine_error_patterns.json",
            "pine_syntax_rules.json"
        ]
        
        for rule_file in rule_files:
            file_path = rules_path / rule_file
            if file_path.exists():
                with open(file_path, 'r') as f:
                    rules[rule_file.split('.')[0]] = json.load(f)
        
        return rules
    
    def validate_file(self, file_path):
        """Validate a Pine Script file"""
        self.errors = []
        self.warnings = []
        
        with open(file_path, 'r') as f:
            content = f.read()
            lines = content.split('\n')
        
        # Core validation checks
        self.check_version_declaration(lines)
        self.check_script_declaration(lines)
        self.check_multiline_functions(content)
        self.check_assignment_operators(lines)
        self.check_array_safety(lines)
        self.check_object_cleanup(lines)
        self.check_type_consistency(content)
        self.check_memory_patterns(lines)
        
        return len(self.errors) == 0
    
    def check_version_declaration(self, lines):
        """Check for proper version declaration"""
        if not lines or not lines[0].strip().startswith('//@version=6'):
            self.errors.append("Line 1: Missing or incorrect version declaration. Must start with '//@version=6'")
    
    def check_script_declaration(self, lines):
        """Check for proper script declaration"""
        script_pattern = r'\b(indicator|library|strategy)\b\s*\('
        found = False
        for i, line in enumerate(lines[:10]):  # Check first 10 lines
            if re.search(script_pattern, line):
                found = True
                break
        
        if not found:
            self.errors.append("Missing script declaration. Must include indicator(), strategy(), or library()")
    
    def check_multiline_functions(self, content):
        """Check for prohibited multiline function calls"""
        # Look for function calls split across lines
        multiline_pattern = r'(\w+\.new|plot|label\.new|box\.new|line\.new)\s*\(\s*\n'
        matches = re.finditer(multiline_pattern, content, re.MULTILINE)
        
        for match in matches:
            line_num = content[:match.start()].count('\n') + 1
            self.errors.append(f"Line {line_num}: Multiline function calls not allowed. Keep function calls on single lines")
    
    def check_assignment_operators(self, lines):
        """Check proper use of = vs :="""
        for i, line in enumerate(lines, 1):
            line = line.strip()
            if re.match(r'^\w+\s*:=', line) and not re.search(r'var\s+\w+|if\s+', line):
                # Check if this looks like initial declaration
                if not any(re.search(rf'\b{line.split(":=")[0].strip()}\b\s*=', prev_line) 
                          for prev_line in lines[:i-1]):
                    self.warnings.append(f"Line {i}: Consider using '=' for initial declaration instead of ':='")
    
    def check_array_safety(self, lines):
        """Check for array bounds safety"""
        for i, line in enumerate(lines, 1):
            # Look for array.get without size check
            if re.search(r'array\.get\s*\([^,]+,\s*\d+\)', line):
                # Check if there's a size check nearby
                context_lines = lines[max(0, i-3):i+1]
                if not any(re.search(r'array\.size', context_line) for context_line in context_lines):
                    self.warnings.append(f"Line {i}: Array access without bounds checking. Consider using array.size() validation")
    
    def check_object_cleanup(self, lines):
        """Check for proper object cleanup"""
        drawing_objects = ['line.new', 'label.new', 'box.new', 'table.new', 'linefill.new', 'polyline.new']
        has_objects = any(any(obj in line for obj in drawing_objects) for line in lines)
        
        if has_objects:
            has_cleanup = any('barstate.islastconfirmedhistory' in line and '.delete()' in line for line in lines)
            if not has_cleanup:
                self.warnings.append("Drawing objects detected but no cleanup pattern found. Consider implementing object cleanup to prevent memory leaks")
    
    def check_type_consistency(self, content):
        """Check for type consistency in ternary operators"""
        ternary_pattern = r'(\w+\s*\?\s*\d+\s*:\s*\d+\.\d+|\w+\s*\?\s*\d+\.\d+\s*:\s*\d+)'
        matches = re.finditer(ternary_pattern, content)
        
        for match in matches:
            line_num = content[:match.start()].count('\n') + 1
            self.errors.append(f"Line {line_num}: Type inconsistency in ternary operator. Both branches must return same type")
    
    def check_memory_patterns(self, lines):
        """Check for memory-related patterns"""
        for i, line in enumerate(lines, 1):
            # Check for potential memory leaks
            if any(obj in line for obj in ['line.new', 'label.new', 'box.new']) and 'var' not in line:
                self.warnings.append(f"Line {i}: Consider using 'var' for object variables to prevent recreation on each bar")

def main():
    if len(sys.argv) != 2:
        print("Usage: python validate_pine_script.py <pine_file>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    validator = PineScriptValidator()
    
    is_valid = validator.validate_file(file_path)
    
    if validator.errors:
        print("ERRORS:")
        for error in validator.errors:
            print(f"  ❌ {error}")
        print()
    
    if validator.warnings:
        print("WARNINGS:")
        for warning in validator.warnings:
            print(f"  ⚠️  {warning}")
        print()
    
    if is_valid and not validator.warnings:
        print("✅ Pine Script validation passed!")
    elif is_valid:
        print("✅ Pine Script validation passed with warnings")
    else:
        print("❌ Pine Script validation failed")
        sys.exit(1)

if __name__ == "__main__":
    main()