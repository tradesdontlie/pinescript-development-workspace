#!/bin/bash

echo "🔧 Installing proper PineScript Language Server..."

# Create extension recommendations
mkdir -p .vscode

cat > .vscode/extensions.json << 'EOF'
{
    "recommendations": [
        "ms-vscode.vscode-json",
        "bradlc.vscode-tailwindcss"
    ],
    "unwantedRecommendations": [
        "ex-codes.pine-script-syntax-highlighter",
        "jeylanib.pinescript"
    ]
}
EOF

echo "📁 Created extension recommendations"

# Instructions for manual installation
cat << 'EOF'

🎯 TO GET PROPER PINESCRIPT LINTING:

1. Open Cursor/VS Code
2. Go to Extensions (Cmd+Shift+X)
3. Search for one of these extensions with Language Server support:
   - "Pine Script Language Server" 
   - "TradingView Pine Script"
   - Look for extensions that mention "Language Server" or "LSP"

4. Or install via command line:
   - Open Command Palette (Cmd+Shift+P)
   - Type "Extensions: Install from VSIX"
   - Browse to install a proper .vsix file

5. Current installed extensions (disable these if conflicting):
EOF

ls ~/.cursor/extensions/ | grep -i pine | sed 's/^/   - /'

cat << 'EOF'

6. After installation:
   - Reload Cursor (Cmd+R)
   - Open your .pine file
   - Check bottom-right status bar shows "Pine Script"
   - Errors should appear in Problems panel (Cmd+Shift+M)

TEMPORARY SOLUTION:
- Use: Cmd+Shift+P → "Tasks: Run Task" → "Check Pine Script Errors"
- Or run: python3 scripts/check_pine_errors.py "your-file.pine"

EOF 