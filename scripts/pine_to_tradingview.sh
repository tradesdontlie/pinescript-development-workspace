#!/bin/bash

# Pine Script to TradingView Workflow Script
# Integrated workflow for copying indicators and pasting to TradingView Pine Editor

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_usage() {
    echo -e "${BLUE}Pine Script to TradingView Workflow${NC}"
    echo -e "${BLUE}Usage: $0 <indicator_path> [options]${NC}"
    echo ""
    echo "This script will:"
    echo "  1. Copy Pine Script indicator to clipboard"
    echo "  2. Launch TradingView with Pine Editor"
    echo "  3. Automatically paste and format the code"
    echo ""
    echo "Options:"
    echo "  -h, --help       Show this help message"
    echo "  -l, --list       List available indicators"
    echo "  -s, --save NAME  Save script with given name"
    echo "  -v, --verbose    Verbose output"
    echo "  --headless       Run browser in headless mode"
    echo "  --screenshot     Take screenshot after pasting"
    echo "  --no-paste       Only copy to clipboard (don't automate pasting)"
    echo "  --timeout MS     Set timeout in milliseconds (default: 30000)"
    echo ""
    echo "Examples:"
    echo "  $0 indicators/fvg/fvg.pine"
    echo "  $0 working/ghost/ghost.pine --save \"Ghost Volume Pro\""
    echo "  $0 indicators/oracle/oa.pine --screenshot"
    echo "  $0 -l  # List all available indicators"
}

list_indicators() {
    echo -e "${BLUE}Available Pine Script indicators:${NC}"
    echo ""
    echo -e "${YELLOW}Production indicators:${NC}"
    find "$PROJECT_ROOT/indicators" -name "*.pine" -type f | sort | while read -r file; do
        rel_path="${file#$PROJECT_ROOT/}"
        echo "  $rel_path"
    done
    echo ""
    echo -e "${YELLOW}Working directory:${NC}"
    find "$PROJECT_ROOT/working" -name "*.pine" -type f | sort | while read -r file; do
        rel_path="${file#$PROJECT_ROOT/}"
        echo "  $rel_path"
    done
}

check_dependencies() {
    # Check if copy script exists
    if [[ ! -f "$SCRIPT_DIR/copy_indicator.sh" ]]; then
        echo -e "${RED}Error: copy_indicator.sh not found${NC}"
        exit 1
    fi
    
    # Check if paste script exists
    if [[ ! -f "$SCRIPT_DIR/paste_to_pine_editor.js" ]]; then
        echo -e "${RED}Error: paste_to_pine_editor.js not found${NC}"
        exit 1
    fi
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        echo -e "${RED}Error: Node.js is required but not installed${NC}"
        echo "Please install Node.js from https://nodejs.org/"
        exit 1
    fi
    
    # Check if puppeteer is available
    if ! node -e "require('puppeteer')" &> /dev/null; then
        echo -e "${YELLOW}Warning: Puppeteer not found. Installing...${NC}"
        npm install puppeteer
    fi
}

copy_indicator() {
    local indicator_path="$1"
    local verbose="$2"
    
    echo -e "${CYAN}📋 Copying indicator to clipboard...${NC}"
    
    local copy_args=("$indicator_path")
    if [[ "$verbose" == "true" ]]; then
        copy_args+=("--verbose")
    fi
    
    if "$SCRIPT_DIR/copy_indicator.sh" "${copy_args[@]}"; then
        echo -e "${GREEN}✅ Indicator copied to clipboard${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to copy indicator${NC}"
        return 1
    fi
}

paste_to_editor() {
    local save_name="$1"
    local headless="$2"
    local screenshot="$3"
    local timeout="$4"
    
    echo -e "${CYAN}🌐 Launching TradingView Pine Editor...${NC}"
    
    local paste_args=("paste-clipboard")
    
    if [[ -n "$save_name" ]]; then
        paste_args+=("--save" "$save_name")
    fi
    
    if [[ "$headless" == "true" ]]; then
        paste_args+=("--headless")
    fi
    
    if [[ -n "$timeout" ]]; then
        paste_args+=("--timeout=$timeout")
    fi
    
    if node "$SCRIPT_DIR/paste_to_pine_editor.js" "${paste_args[@]}"; then
        echo -e "${GREEN}✅ Code pasted to Pine Editor${NC}"
        
        if [[ "$screenshot" == "true" ]]; then
            echo -e "${CYAN}📸 Taking screenshot...${NC}"
            node "$SCRIPT_DIR/paste_to_pine_editor.js" screenshot
        fi
        
        return 0
    else
        echo -e "${RED}❌ Failed to paste to Pine Editor${NC}"
        return 1
    fi
}

main() {
    local indicator_path=""
    local save_name=""
    local verbose=false
    local headless=false
    local screenshot=false
    local no_paste=false
    local timeout=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                print_usage
                exit 0
                ;;
            -l|--list)
                list_indicators
                exit 0
                ;;
            -s|--save)
                save_name="$2"
                shift 2
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            --headless)
                headless=true
                shift
                ;;
            --screenshot)
                screenshot=true
                shift
                ;;
            --no-paste)
                no_paste=true
                shift
                ;;
            --timeout)
                timeout="$2"
                shift 2
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
    
    # Check dependencies
    check_dependencies
    
    # Convert relative path to absolute if needed
    if [[ "$indicator_path" != /* ]]; then
        indicator_path="$PROJECT_ROOT/$indicator_path"
    fi
    
    # Validate file exists
    if [[ ! -f "$indicator_path" ]]; then
        echo -e "${RED}Error: File not found: $indicator_path${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}🚀 Starting Pine Script to TradingView workflow${NC}"
    echo -e "${BLUE}Indicator: $(basename "$indicator_path")${NC}"
    
    # Step 1: Copy indicator to clipboard
    if ! copy_indicator "$indicator_path" "$verbose"; then
        exit 1
    fi
    
    # Step 2: Paste to Pine Editor (unless --no-paste is specified)
    if [[ "$no_paste" != "true" ]]; then
        if ! paste_to_editor "$save_name" "$headless" "$screenshot" "$timeout"; then
            exit 1
        fi
        
        echo -e "${GREEN}🎉 Workflow completed successfully!${NC}"
        echo -e "${BLUE}Your Pine Script indicator is now in TradingView${NC}"
    else
        echo -e "${GREEN}✅ Indicator copied to clipboard${NC}"
        echo -e "${BLUE}You can now manually paste it into TradingView Pine Editor${NC}"
    fi
}

main "$@"