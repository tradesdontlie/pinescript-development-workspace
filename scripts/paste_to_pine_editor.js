#!/usr/bin/env node

/**
 * Pine Script Paste Automation Script
 * Automates pasting Pine Script indicators into TradingView Pine Editor
 */

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Configuration
const CONFIG = {
    headless: false, // Set to true for headless mode
    timeout: 30000,
    viewport: {
        width: 1400,
        height: 900
    },
    tradingViewUrl: 'https://www.tradingview.com/chart/',
    selectors: {
        monacoEditor: '.monaco-editor',
        pineEditorTab: '[data-name="pine-editor"]',
        pineEditorContent: '.pine-editor-monaco',
        publishButton: 'button[data-name="publish-indicator"]'
    }
};

class PineEditorAutomator {
    constructor() {
        this.browser = null;
        this.page = null;
    }

    async launch() {
        console.log('🚀 Launching browser...');
        this.browser = await puppeteer.launch({
            headless: CONFIG.headless,
            defaultViewport: CONFIG.viewport,
            args: ['--no-sandbox', '--disable-setuid-sandbox']
        });
        
        this.page = await this.browser.newPage();
        await this.page.setViewport(CONFIG.viewport);
        
        // Set up clipboard permissions
        await this.page.evaluateOnNewDocument(() => {
            Object.defineProperty(navigator, 'permissions', {
                value: {
                    query: () => Promise.resolve({ state: 'granted' })
                }
            });
        });
    }

    async navigateToTradingView() {
        console.log('🌐 Navigating to TradingView...');
        await this.page.goto(CONFIG.tradingViewUrl, {
            waitUntil: 'networkidle2',
            timeout: CONFIG.timeout
        });
        
        // Wait for the page to load completely
        await this.page.waitForTimeout(3000);
    }

    async waitForPineEditor() {
        console.log('⏳ Waiting for Pine Editor to load...');
        
        try {
            // Wait for the Pine Editor tab to be available
            await this.page.waitForSelector(CONFIG.selectors.pineEditorTab, {
                timeout: CONFIG.timeout
            });
            
            // Click on Pine Editor tab if it's not already active
            await this.page.click(CONFIG.selectors.pineEditorTab);
            
            // Wait for Monaco editor to be ready
            await this.page.waitForSelector(CONFIG.selectors.monacoEditor, {
                timeout: CONFIG.timeout
            });
            
            console.log('✅ Pine Editor is ready');
            return true;
            
        } catch (error) {
            console.error('❌ Pine Editor not found or failed to load:', error.message);
            return false;
        }
    }

    async selectAllText() {
        console.log('🔍 Selecting all text in Pine Editor...');
        
        // Focus on the Monaco editor
        await this.page.click(CONFIG.selectors.monacoEditor);
        await this.page.waitForTimeout(500);
        
        // Select all text using Ctrl+A (or Cmd+A on Mac)
        const isMac = process.platform === 'darwin';
        const modifier = isMac ? 'Meta' : 'Control';
        
        await this.page.keyboard.down(modifier);
        await this.page.keyboard.press('KeyA');
        await this.page.keyboard.up(modifier);
        
        console.log('✅ All text selected');
    }

    async pasteCode(code) {
        console.log('📝 Pasting Pine Script code...');
        
        // First select all existing text
        await this.selectAllText();
        
        // Paste the new code
        await this.page.keyboard.type(code);
        
        console.log('✅ Code pasted successfully');
    }

    async pasteFromClipboard() {
        console.log('📋 Pasting from clipboard...');
        
        // First select all existing text
        await this.selectAllText();
        
        // Paste from clipboard using Ctrl+V (or Cmd+V on Mac)
        const isMac = process.platform === 'darwin';
        const modifier = isMac ? 'Meta' : 'Control';
        
        await this.page.keyboard.down(modifier);
        await this.page.keyboard.press('KeyV');
        await this.page.keyboard.up(modifier);
        
        console.log('✅ Pasted from clipboard');
    }

    async saveScript(name = null) {
        console.log('💾 Saving Pine Script...');
        
        // Save using Ctrl+S (or Cmd+S on Mac)
        const isMac = process.platform === 'darwin';
        const modifier = isMac ? 'Meta' : 'Control';
        
        await this.page.keyboard.down(modifier);
        await this.page.keyboard.press('KeyS');
        await this.page.keyboard.up(modifier);
        
        // If a name is provided, type it
        if (name) {
            await this.page.waitForTimeout(1000);
            await this.page.keyboard.type(name);
            await this.page.keyboard.press('Enter');
        }
        
        console.log('✅ Script saved');
    }

    async takeScreenshot(name = 'pine-editor-screenshot') {
        const screenshotPath = path.join(__dirname, `../screenshots/${name}.png`);
        
        // Create screenshots directory if it doesn't exist
        const screenshotDir = path.dirname(screenshotPath);
        if (!fs.existsSync(screenshotDir)) {
            fs.mkdirSync(screenshotDir, { recursive: true });
        }
        
        await this.page.screenshot({
            path: screenshotPath,
            fullPage: true
        });
        
        console.log(`📸 Screenshot saved: ${screenshotPath}`);
        return screenshotPath;
    }

    async close() {
        if (this.browser) {
            await this.browser.close();
            console.log('🔒 Browser closed');
        }
    }
}

// Main execution function
async function main() {
    const args = process.argv.slice(2);
    const command = args[0];
    
    if (!command) {
        console.log(`
Usage: node paste_to_pine_editor.js <command> [options]

Commands:
  paste-file <file_path>     Paste Pine Script from file
  paste-clipboard           Paste from clipboard
  screenshot               Take screenshot of Pine Editor
  
Options:
  --save <name>            Save script with given name
  --headless              Run in headless mode
  --timeout <ms>          Set timeout in milliseconds

Examples:
  node paste_to_pine_editor.js paste-file ../indicators/fvg/fvg.pine
  node paste_to_pine_editor.js paste-clipboard --save "My Indicator"
  node paste_to_pine_editor.js screenshot
        `);
        return;
    }
    
    // Parse options
    const options = {
        save: null,
        headless: args.includes('--headless'),
        timeout: parseInt(args.find(arg => arg.startsWith('--timeout'))?.split('=')[1]) || CONFIG.timeout
    };
    
    const saveIndex = args.indexOf('--save');
    if (saveIndex !== -1 && args[saveIndex + 1]) {
        options.save = args[saveIndex + 1];
    }
    
    if (options.headless) {
        CONFIG.headless = true;
    }
    
    if (options.timeout) {
        CONFIG.timeout = options.timeout;
    }
    
    const automator = new PineEditorAutomator();
    
    try {
        await automator.launch();
        await automator.navigateToTradingView();
        
        if (!(await automator.waitForPineEditor())) {
            console.error('❌ Failed to load Pine Editor');
            process.exit(1);
        }
        
        switch (command) {
            case 'paste-file':
                const filePath = args[1];
                if (!filePath) {
                    console.error('❌ File path required');
                    process.exit(1);
                }
                
                const resolvedPath = path.resolve(filePath);
                if (!fs.existsSync(resolvedPath)) {
                    console.error(`❌ File not found: ${resolvedPath}`);
                    process.exit(1);
                }
                
                const code = fs.readFileSync(resolvedPath, 'utf8');
                await automator.pasteCode(code);
                break;
                
            case 'paste-clipboard':
                await automator.pasteFromClipboard();
                break;
                
            case 'screenshot':
                await automator.takeScreenshot();
                break;
                
            default:
                console.error(`❌ Unknown command: ${command}`);
                process.exit(1);
        }
        
        if (options.save) {
            await automator.saveScript(options.save);
        }
        
        // Keep browser open for a moment to see results
        if (!CONFIG.headless) {
            console.log('⏳ Waiting 5 seconds before closing...');
            await new Promise(resolve => setTimeout(resolve, 5000));
        }
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    } finally {
        await automator.close();
    }
}

// Run if called directly
if (require.main === module) {
    main().catch(console.error);
}

module.exports = PineEditorAutomator;