#!/bin/bash

# Promote file from working to production
# Usage: ./promote_file.sh <working_file>

WORKING_FILE="$1"

if [ ! -f "$WORKING_FILE" ]; then
    echo "❌ File not found: $WORKING_FILE"
    exit 1
fi

# Validate it's in working directory
if [[ "$WORKING_FILE" != working/* ]]; then
    echo "❌ File must be in working/ directory"
    exit 1
fi

# Extract category and filename
RELATIVE_PATH=${WORKING_FILE#working/}
CATEGORY=$(dirname "$RELATIVE_PATH")
FILENAME=$(basename "$RELATIVE_PATH")

# If the file is directly in working/ directory, ask for category
if [ "$CATEGORY" = "." ]; then
    echo "📝 File is in root working directory. Please specify category:"
    echo "Available categories: fvg, ghost, oracle, sessions, vortex, cycles, tables, testing"
    read -p "Enter category: " CATEGORY
fi

# Determine production path
PRODUCTION_DIR=""
if [ -d "indicators/$CATEGORY" ]; then
    PRODUCTION_DIR="indicators/$CATEGORY"
elif [ -d "Pinescript-Coding-Suite/indicators/$CATEGORY" ]; then
    PRODUCTION_DIR="Pinescript-Coding-Suite/indicators/$CATEGORY"
else
    echo "❌ Production category directory not found: $CATEGORY"
    echo "Available production directories:"
    find . -name indicators -type d | head -5
    exit 1
fi

# Create production directory if needed
mkdir -p "$PRODUCTION_DIR"

# Copy file to production
PRODUCTION_FILE="$PRODUCTION_DIR/$FILENAME"
cp "$WORKING_FILE" "$PRODUCTION_FILE"

echo "✅ File promoted to production:"
echo "   From: $WORKING_FILE"
echo "   To:   $PRODUCTION_FILE"

# Copy versions directory if it exists
WORKING_VERSIONS_DIR="$(dirname "$WORKING_FILE")/versions"
if [ -d "$WORKING_VERSIONS_DIR" ]; then
    PRODUCTION_VERSIONS_DIR="$PRODUCTION_DIR/versions"
    mkdir -p "$PRODUCTION_VERSIONS_DIR"
    cp -r "$WORKING_VERSIONS_DIR"/* "$PRODUCTION_VERSIONS_DIR"/
    echo "✅ Version history also promoted"
fi