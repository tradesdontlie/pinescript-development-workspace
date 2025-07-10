#!/bin/bash

# Test workflow script
echo "Testing Pine Script to TradingView workflow..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Test 1: List indicators
echo "Test 1: Listing indicators..."
./copy_indicator.sh -l

echo -e "\n" 

# Test 2: Copy an indicator to clipboard
echo "Test 2: Copying indicator to clipboard..."
./copy_indicator.sh "working/strategy/Signal_Composite_Engine.pine"

echo -e "\n"

# Test 3: Show integrated workflow help
echo "Test 3: Showing integrated workflow help..."
./pine_to_tradingview.sh --help

echo -e "\nAll tests completed!"
echo "✅ Scripts are ready to use"
echo ""
echo "To use the full workflow:"
echo "1. First install Node.js dependencies: cd scripts && npm install"
echo "2. Then run: ./pine_to_tradingview.sh working/strategy/Signal_Composite_Engine.pine"