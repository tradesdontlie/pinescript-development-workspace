#!/bin/bash

# Check memory management for a single file
# Usage: ./check_file_memory.sh <file>

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

echo "🧠 Checking memory management for: $(basename "$FILE")"

# Check if file contains drawing objects
if grep -q -E "(line\.new|label\.new|box\.new|table\.new|linefill\.new|polyline\.new)" "$FILE"; then
    echo "📄 Contains drawing objects - checking cleanup..."
    
    # Check for proper cleanup pattern
    if grep -q "barstate.islastconfirmedhistory" "$FILE"; then
        echo "✅ Proper cleanup pattern found"
        exit 0
    else
        echo "⚠️  Missing cleanup pattern for drawing objects"
        echo "💡 Add: if barstate.islastconfirmedhistory then object.delete()"
        exit 1
    fi
else
    echo "✅ No drawing objects detected - no cleanup needed"
    exit 0
fi