#!/bin/bash

# Pine Script Indicator Copy Script
# Copies Pine Script indicator content to clipboard for TradingView

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo -e "${BLUE}Usage: $0 <indicator_path> [options]${NC}"
    echo -e "${BLUE}Copy Pine Script indicator to clipboard${NC}"
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -v, --verbose   Verbose output"
    echo "  -l, --list      List available indicators"
    echo ""
    echo "Examples:"
    echo "  $0 indicators/fvg/fvg.pine"
    echo "  $0 working/ghost/ghost.pine"
    echo "  $0 -l  # List all .pine files"
}

list_indicators() {
    echo -e "${BLUE}Available Pine Script indicators:${NC}"
    echo ""
    echo -e "${YELLOW}Production indicators:${NC}"
    if [[ -d "$PROJECT_ROOT/cursor-memory-bank/indicators" ]]; then
        find "$PROJECT_ROOT/cursor-memory-bank/indicators" -name "*.pine" -type f | sort | while read -r file; do
            rel_path="${file#$PROJECT_ROOT/}"
            echo "  $rel_path"
        done
    else
        echo "  No production indicators directory found"
    fi
    echo ""
    echo -e "${YELLOW}Working directory:${NC}"
    find "$PROJECT_ROOT/working" -name "*.pine" -type f | sort | while read -r file; do
        rel_path="${file#$PROJECT_ROOT/}"
        echo "  $rel_path"
    done
    echo ""
    echo -e "${YELLOW}Back up code:${NC}"
    find "$PROJECT_ROOT/cursor-memory-bank/Back up old code" -name "*.pine" -type f | sort | while read -r file; do
        rel_path="${file#$PROJECT_ROOT/}"
        echo "  $rel_path"
    done
}

copy_to_clipboard() {
    local file_path="$1"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        pbcopy < "$file_path"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v xclip &> /dev/null; then
            xclip -selection clipboard < "$file_path"
        elif command -v xsel &> /dev/null; then
            xsel --clipboard --input < "$file_path"
        else
            echo -e "${RED}Error: No clipboard utility found. Install xclip or xsel.${NC}"
            return 1
        fi
    else
        echo -e "${RED}Error: Unsupported operating system.${NC}"
        return 1
    fi
}

validate_pine_script() {
    local file_path="$1"
    
    # Check if file starts with //@version=
    if ! head -1 "$file_path" | grep -q "^//@version="; then
        echo -e "${YELLOW}Warning: File doesn't start with //@version= declaration${NC}"
        return 1
    fi
    
    # Check for basic Pine Script structure
    if ! grep -q "indicator\|strategy\|library" "$file_path"; then
        echo -e "${YELLOW}Warning: File doesn't contain indicator(), strategy(), or library() declaration${NC}"
        return 1
    fi
    
    return 0
}

main() {
    local verbose=false
    local indicator_path=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                print_usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -l|--list)
                list_indicators
                exit 0
                ;;
            -*)
                echo -e "${RED}Error: Unknown option $1${NC}"
                print_usage
                exit 1
                ;;
            *)
                if [[ -z "$indicator_path" ]]; then
                    indicator_path="$1"
                else
                    echo -e "${RED}Error: Multiple file paths provided${NC}"
                    print_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    if [[ -z "$indicator_path" ]]; then
        echo -e "${RED}Error: No indicator path provided${NC}"
        print_usage
        exit 1
    fi
    
    # Convert relative path to absolute if needed
    if [[ "$indicator_path" != /* ]]; then
        indicator_path="$PROJECT_ROOT/$indicator_path"
    fi
    
    # Validate file exists
    if [[ ! -f "$indicator_path" ]]; then
        echo -e "${RED}Error: File not found: $indicator_path${NC}"
        exit 1
    fi
    
    # Validate it's a Pine Script file
    if [[ ! "$indicator_path" =~ \.pine$ ]]; then
        echo -e "${RED}Error: File must have .pine extension${NC}"
        exit 1
    fi
    
    if [[ "$verbose" == true ]]; then
        echo -e "${BLUE}Processing file: $indicator_path${NC}"
    fi
    
    # Validate Pine Script structure
    if ! validate_pine_script "$indicator_path"; then
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    # Copy to clipboard
    if copy_to_clipboard "$indicator_path"; then
        echo -e "${GREEN}✓ Pine Script copied to clipboard successfully!${NC}"
        
        if [[ "$verbose" == true ]]; then
            echo -e "${BLUE}File: $(basename "$indicator_path")${NC}"
            echo -e "${BLUE}Size: $(wc -l < "$indicator_path") lines${NC}"
            echo -e "${BLUE}Ready to paste into TradingView Pine Editor${NC}"
        fi
    else
        echo -e "${RED}Error: Failed to copy to clipboard${NC}"
        exit 1
    fi
}

main "$@"