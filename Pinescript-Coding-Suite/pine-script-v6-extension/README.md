# Pine Script v6 VS Code Extension

This directory contains the custom Pine Script v6 VS Code extension for enhanced development experience.

## Installation

### Option 1: Install from .vsix file
```bash
# Using Cursor CLI
cursor --install-extension pinescript-v6-vscode-0.1.0.vsix

# Using VS Code CLI
code --install-extension pinescript-v6-vscode-0.1.0.vsix
```

### Option 2: Install from marketplace
```bash
# Alternative marketplace extension
cursor --install-extension salbert11.pinescript-helper
```

## Features

- **Pine Script v6 Syntax Highlighting** - Enhanced syntax support for latest Pine Script version
- **Intelligent Code Completion** - Context-aware IntelliSense for Pine Script functions
- **Error Detection** - Real-time syntax validation and error highlighting
- **Function Signatures** - Hover information for Pine Script built-in functions
- **Language Server Integration** - Advanced Pine Script language support

## Removing Conflicting Extensions

Before installing, remove conflicting Pine Script extensions:

```bash
cursor --uninstall-extension ex-codes.pine-script-syntax-highlighter
cursor --uninstall-extension 0xjcf.pine-script-syntax
cursor --uninstall-extension frizlabz.pinescript-v5-vscode
```

## Development

If you want to develop this extension further:

1. **Setup Development Environment**
   ```bash
   cd pine-script-v6-extension
   pnpm install
   ```

2. **Build Extension**
   ```bash
   pnpm run compile
   ```

3. **Start Development**
   ```bash
   pnpm run start
   ```

4. **Lint Code**
   ```bash
   pnpm run lint
   ```

5. **Generate Documentation**
   ```bash
   pnpm run build-docs
   ```

6. **Package Extension**
   ```bash
   pnpm run vsce-package
   ```

## Integration with Repository

This extension integrates with the repository's Pine Script development workflow:

- **Language Server Protocol** - Provides diagnostics via `mcp__ide__getDiagnostics`
- **Rule Integration** - Works with `extracted_rules/` for error pattern detection
- **Makefile Integration** - Supports automated validation workflows
- **Claude Code Integration** - Enhanced AI-assisted development

## File Associations

The extension automatically recognizes:
- `.pine` files - Pine Script indicators/strategies
- `.ps` files - Alternative Pine Script extension

## Verification

After installation, verify the extension is working:

1. **Open any `.pine` file**
2. **Check language mode** - Should show "pine" in bottom-right corner
3. **Test autocomplete** - Type `plot(` and verify suggestions appear
4. **Check syntax highlighting** - Pine Script keywords should be colored

## Troubleshooting

- **Extension not working?** Restart Cursor/VS Code completely
- **No syntax highlighting?** Check file extension is `.pine` and language mode is correct
- **No autocomplete?** Verify no conflicting extensions are installed
- **Performance issues?** Check extension logs in developer console