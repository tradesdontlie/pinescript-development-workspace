# 🌲 Pine Script Development Setup Guide

## 🚀 Quick Setup for New Team Members

After cloning this repository, run the automated setup:

```bash
./setup-pine-script.sh
```

This script will:
- ✅ Configure Cursor CLI
- ✅ Install the custom Pine Script v6 extension
- ✅ Remove conflicting extensions
- ✅ Verify workspace settings

## 📋 What's Automatically Configured

### **File Associations**
All `.pine`, `.ps`, and `.pinescript` files automatically use Pine Script language mode.

### **Extension Recommendations**
When you open this project in Cursor, you'll get prompted to install:
- `tradesdontlie.pinescript-v6-vscode` (Custom Pine Script v6 extension)
- `salbert11.pinescript-helper` (Pine Script helper tools)

### **Workspace Settings**
Located in `.vscode/settings.json`:
- Pine Script syntax highlighting
- 4-space indentation
- Format on save
- Pine Script specific editor settings

## 🛠️ Manual Setup (if automated setup fails)

### 1. Install Cursor CLI
```bash
# macOS
export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"
echo 'export PATH="/Applications/Cursor.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
```

### 2. Install Pine Script Extension
```bash
# If you have the .vsix file
cursor --install-extension pinescript-v6-vscode-0.1.0.vsix

# Or install from marketplace
cursor --install-extension salbert11.pinescript-helper
```

### 3. Remove Conflicting Extensions
```bash
cursor --uninstall-extension ex-codes.pine-script-syntax-highlighter
cursor --uninstall-extension 0xjcf.pine-script-syntax
cursor --uninstall-extension frizlabz.pinescript-v5-vscode
```

## ✅ Verify Your Setup

1. **Open any `.pine` file**
2. **Check bottom-right corner** - should show "pine" language mode
3. **Test autocomplete** - type `plot(` and you should see suggestions
4. **Check syntax highlighting** - Pine Script keywords should be colored

## 🐛 Troubleshooting

### Extension Not Working?
- Restart Cursor completely
- Check Extensions panel (`Cmd+Shift+X`) - ensure Pine Script extension is enabled
- Manually set language: `Cmd+Shift+P` → "Change Language Mode" → "Pine Script"

### No Syntax Highlighting?
- Check file extension is `.pine`
- Verify language mode in bottom-right corner
- Try: `View` → `Command Palette` → `Developer: Reload Window`

### CLI Not Working?
- Close and reopen terminal
- Verify Cursor is installed in `/Applications/Cursor.app`
- Try running setup script again

## 📁 Project Structure

```
├── .vscode/
│   ├── settings.json          # Workspace settings (auto file association)
│   └── extensions.json        # Recommended extensions
├── Pinescript-Coding-Suite/
│   ├── working/              # Development workspace
│   └── indicators/           # Production indicators
├── pinescript-v6-vscode-0.1.0.vsix  # Custom extension
└── setup-pine-script.sh     # Automated setup script
```

## 🎯 Why This Works Automatically

1. **`.vscode/settings.json`** - Contains workspace-specific settings that apply to anyone who opens the project
2. **`.vscode/extensions.json`** - Recommends extensions when project is opened
3. **`setup-pine-script.sh`** - One-command setup for complete configuration
4. **Workspace Settings Override User Settings** - Ensures consistent experience across team

This setup ensures that anyone who clones this repository gets the exact same Pine Script development experience! 🎉 