#!/bin/bash

# Simplified versioning script for Makefile integration
# Usage: ./create_version.sh <file> [type]

set -e

FILE="$1"
VERSION_TYPE="${2:-minor}"

# Validate inputs
if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

case "$VERSION_TYPE" in
    "major"|"minor"|"patch")
        ;;
    *)
        echo "❌ Invalid version type: $VERSION_TYPE (use: major, minor, patch)"
        exit 1
        ;;
esac

# Extract file info
DIR=$(dirname "$FILE")
BASE_NAME=$(basename "$FILE" .pine)
CLEAN_NAME=$(echo "$BASE_NAME" | sed -E 's/_v[0-9]+\.[0-9]+\.[0-9]+$//')

# Create versions directory
VERSIONS_DIR="${DIR}/versions"
mkdir -p "$VERSIONS_DIR"

# Find latest version
LATEST_VERSION="0.0.0"
if ls "${VERSIONS_DIR}"/${CLEAN_NAME}_v*.pine 1> /dev/null 2>&1; then
    LATEST_VERSION=$(ls "${VERSIONS_DIR}"/${CLEAN_NAME}_v*.pine | 
                    sed -E "s/.*_v([0-9]+\.[0-9]+\.[0-9]+)\.pine/\1/" | 
                    sort -V | tail -1)
fi

# Parse version numbers
MAJOR=$(echo "$LATEST_VERSION" | cut -d. -f1)
MINOR=$(echo "$LATEST_VERSION" | cut -d. -f2)
PATCH=$(echo "$LATEST_VERSION" | cut -d. -f3)

# Increment version
case "$VERSION_TYPE" in
    "major")
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    "minor")
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    "patch")
        PATCH=$((PATCH + 1))
        ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
BACKUP_FILE="${VERSIONS_DIR}/${CLEAN_NAME}_v${NEW_VERSION}.pine"

# Copy file to versions directory
cp "$FILE" "$BACKUP_FILE"

# Update VERSION_HISTORY.md
VERSION_HISTORY="${VERSIONS_DIR}/VERSION_HISTORY.md"
if [ ! -f "$VERSION_HISTORY" ]; then
    echo "# Version History for ${CLEAN_NAME}" > "$VERSION_HISTORY"
    echo "" >> "$VERSION_HISTORY"
fi

# Add version entry
echo "## v${NEW_VERSION} - $(date '+%Y-%m-%d')" >> "$VERSION_HISTORY"
echo "- **Type**: ${VERSION_TYPE} version" >> "$VERSION_HISTORY"
echo "- **File**: ${CLEAN_NAME}_v${NEW_VERSION}.pine" >> "$VERSION_HISTORY"
echo "" >> "$VERSION_HISTORY"

echo "✅ Version v${NEW_VERSION} created: $(basename "$BACKUP_FILE")"
echo "📁 Location: $BACKUP_FILE"