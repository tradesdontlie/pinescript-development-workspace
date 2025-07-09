# Pine Script to TradingView Automation

This directory contains scripts to automate copying Pine Script indicators and pasting them into TradingView's Pine Editor using Puppeteer.

## Quick Start

1. **Install dependencies:**
   ```bash
   cd scripts
   npm install
   ```

2. **Copy and paste an indicator:**
   ```bash
   ./pine_to_tradingview.sh indicators/fvg/fvg.pine
   ```

3. **Copy only (no automated pasting):**
   ```bash
   ./copy_indicator.sh indicators/ghost/Ghost_Volume_Intelligence_Pro.pine
   ```

## Scripts Overview

### 1. `copy_indicator.sh`
Copies Pine Script indicator content to clipboard.

**Usage:**
```bash
./copy_indicator.sh <indicator_path> [options]
```

**Options:**
- `-h, --help` - Show help message
- `-v, --verbose` - Verbose output
- `-l, --list` - List available indicators

**Examples:**
```bash
./copy_indicator.sh indicators/fvg/fvg.pine
./copy_indicator.sh working/ghost/ghost.pine --verbose
./copy_indicator.sh -l  # List all indicators
```

### 2. `paste_to_pine_editor.js`
Automates pasting Pine Script code into TradingView Pine Editor using Puppeteer.

**Usage:**
```bash
node paste_to_pine_editor.js <command> [options]
```

**Commands:**
- `paste-file <file_path>` - Paste Pine Script from file
- `paste-clipboard` - Paste from clipboard
- `screenshot` - Take screenshot of Pine Editor

**Options:**
- `--save <name>` - Save script with given name
- `--headless` - Run in headless mode
- `--timeout <ms>` - Set timeout in milliseconds

**Examples:**
```bash
node paste_to_pine_editor.js paste-file ../indicators/fvg/fvg.pine
node paste_to_pine_editor.js paste-clipboard --save "My Indicator"
node paste_to_pine_editor.js screenshot
```

### 3. `pine_to_tradingview.sh`
Integrated workflow script that combines copying and pasting operations.

**Usage:**
```bash
./pine_to_tradingview.sh <indicator_path> [options]
```

**Options:**
- `-h, --help` - Show help message
- `-l, --list` - List available indicators
- `-s, --save NAME` - Save script with given name
- `-v, --verbose` - Verbose output
- `--headless` - Run browser in headless mode
- `--screenshot` - Take screenshot after pasting
- `--no-paste` - Only copy to clipboard (don't automate pasting)
- `--timeout MS` - Set timeout in milliseconds

**Examples:**
```bash
./pine_to_tradingview.sh indicators/fvg/fvg.pine
./pine_to_tradingview.sh working/ghost/ghost.pine --save "Ghost Volume Pro"
./pine_to_tradingview.sh indicators/oracle/oa.pine --screenshot
```

## Workflow Process

The automation follows this process:

1. **Copy to Clipboard**: Reads Pine Script file and copies content to system clipboard
2. **Launch TradingView**: Opens TradingView chart page with Pine Editor
3. **Navigate to Editor**: Waits for Pine Editor to load and focuses on it
4. **Select All**: Selects all existing code in the editor
5. **Paste Code**: Pastes the new Pine Script code from clipboard
6. **Save (Optional)**: Saves the script with a specified name
7. **Screenshot (Optional)**: Takes a screenshot for verification

## Technical Details

### Pine Editor Detection
The script detects the Pine Editor using these selectors:
- `.monaco-editor` - Main Monaco editor container
- `.pine-editor-monaco` - Pine Script specific editor class
- `[data-name="pine-editor"]` - Pine Editor tab

### Keyboard Shortcuts Used
- **Select All**: `Ctrl+A` (Windows/Linux) or `Cmd+A` (Mac)
- **Paste**: `Ctrl+V` (Windows/Linux) or `Cmd+V` (Mac)
- **Save**: `Ctrl+S` (Windows/Linux) or `Cmd+S` (Mac)

### Browser Automation
- Uses Puppeteer to control Chrome/Chromium browser
- Supports both headless and headed modes
- Handles clipboard operations through browser API
- Implements proper waiting mechanisms for page loading

## Error Handling

The scripts include comprehensive error handling for:
- File not found errors
- Pine Script validation (checks for version declaration)
- Browser launch failures
- Page load timeouts
- Element not found errors
- Clipboard operation failures

## Dependencies

### System Requirements
- Node.js (v14 or higher)
- Chrome/Chromium browser
- System clipboard access

### Node.js Dependencies
- `puppeteer` - Browser automation
- `fs` - File system operations
- `path` - Path manipulation

### Shell Dependencies
- `bash` - Shell script execution
- `pbcopy` (Mac) or `xclip`/`xsel` (Linux) - Clipboard operations
- `find` - File search operations

## Configuration

### Browser Settings
Modify `CONFIG` object in `paste_to_pine_editor.js`:
```javascript
const CONFIG = {
    headless: false,        // Set to true for headless mode
    timeout: 30000,         // 30 second timeout
    viewport: {
        width: 1400,
        height: 900
    },
    tradingViewUrl: 'https://www.tradingview.com/chart/'
};
```

### Selectors
Update selectors if TradingView changes their UI:
```javascript
selectors: {
    monacoEditor: '.monaco-editor',
    pineEditorTab: '[data-name="pine-editor"]',
    pineEditorContent: '.pine-editor-monaco',
    publishButton: 'button[data-name="publish-indicator"]'
}
```

## Troubleshooting

### Common Issues

1. **Script not found**: Ensure you're running from the correct directory
2. **Permission denied**: Make scripts executable with `chmod +x`
3. **Node.js not found**: Install Node.js from https://nodejs.org/
4. **Puppeteer fails**: Try installing Chromium manually or use different browser
5. **Clipboard issues**: Ensure system clipboard access is available

### Debug Mode
Run with verbose output to see detailed information:
```bash
./pine_to_tradingview.sh indicators/fvg/fvg.pine --verbose
```

### Screenshots
Use `--screenshot` option to capture the final state:
```bash
./pine_to_tradingview.sh indicators/fvg/fvg.pine --screenshot
```

## Security Considerations

- Scripts only access TradingView's public Pine Editor
- No authentication credentials are stored or transmitted
- Clipboard operations are limited to Pine Script content
- Browser runs in sandboxed mode with minimal permissions

## Contributing

When modifying these scripts:
1. Test with multiple indicators
2. Verify cross-platform compatibility
3. Update error handling for new edge cases
4. Document any new configuration options
5. Maintain backward compatibility where possible

## License

These automation scripts are part of the Pine Script development repository and follow the same license terms.