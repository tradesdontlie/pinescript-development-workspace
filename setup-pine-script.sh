#!/bin/bash

echo "🌲 Pine Script Development Setup"
echo "================================="
echo ""

# Check if Cursor is installed
if ! command -v cursor &> /dev/null; then
    echo "❌ Cursor not found. Setting up Cursor CLI..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if [ -d "/Applications/Cursor.app" ]; then
            echo "📝 Adding Cursor CLI to PATH..."
            export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"
            echo 'export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
            echo 'export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"' >> ~/.bash_profile
            echo "✅ Cursor CLI configured!"
        else
            echo "❌ Please install Cursor from https://cursor.sh/"
            exit 1
        fi
    else
        echo "❌ Please install Cursor and set up CLI manually"
        exit 1
    fi
fi

echo ""
echo "🔍 Checking for Pine Script extension..."

# Check if custom Pine Script extension exists
if [ -f "pinescript-v6-vscode-0.1.0.vsix" ]; then
    echo "📦 Installing custom Pine Script v6 extension..."
    cursor --install-extension pinescript-v6-vscode-0.1.0.vsix
    echo "✅ Custom Pine Script extension installed!"
else
    echo "⚠️  Custom extension not found. You may need to install a Pine Script extension manually."
fi

echo ""
echo "🧹 Checking for conflicting extensions..."

# Remove conflicting extensions
CONFLICTING_EXTENSIONS=(
    "ex-codes.pine-script-syntax-highlighter"
    "0xjcf.pine-script-syntax"
    "frizlabz.pinescript-v5-vscode"
)

for ext in "${CONFLICTING_EXTENSIONS[@]}"; do
    if cursor --list-extensions | grep -q "$ext"; then
        echo "🗑️  Removing conflicting extension: $ext"
        cursor --uninstall-extension "$ext"
    fi
done

echo ""
echo "📁 Workspace settings are already configured in .vscode/settings.json"
echo "📋 Extension recommendations are configured in .vscode/extensions.json"

echo ""
echo "✅ Pine Script development environment setup complete!"
echo ""
echo "🧪 Test your setup:"
echo "   1. Open any .pine file"
echo "   2. Check bottom-right corner shows 'pine' language mode"
echo "   3. You should see syntax highlighting and autocomplete"
echo ""
echo "📚 Your Pine Script files are in:"
echo "   - Pinescript-Coding-Suite/working/ (for development)"
echo "   - Pinescript-Coding-Suite/indicators/ (production)"
echo "" 