#!/usr/bin/env node

/**
 * Launch TradingView for Manual Login
 * Opens TradingView in a browser for manual login, then waits for user to proceed
 */

const puppeteer = require('puppeteer');
const readline = require('readline');

const CONFIG = {
    headless: false,
    viewport: {
        width: 1400,
        height: 900
    },
    tradingViewUrl: 'https://www.tradingview.com/chart/',
    selectors: {
        monacoEditor: '.monaco-editor',
        pineEditorTab: '[data-name="pine-editor"]',
        pineEditorContent: '.pine-editor-monaco'
    }
};

class TradingViewLauncher {
    constructor() {
        this.browser = null;
        this.page = null;
        this.rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
    }

    async launch() {
        console.log('🚀 Launching TradingView for manual login...');
        
        this.browser = await puppeteer.launch({
            headless: false,
            defaultViewport: CONFIG.viewport,
            args: [
                '--no-sandbox', 
                '--disable-setuid-sandbox',
                '--disable-web-security',
                '--disable-features=VizDisplayCompositor'
            ]
        });
        
        this.page = await this.browser.newPage();
        await this.page.setViewport(CONFIG.viewport);
        
        // Navigate to TradingView
        console.log('🌐 Navigating to TradingView...');
        await this.page.goto(CONFIG.tradingViewUrl, {
            waitUntil: 'networkidle2',
            timeout: 30000
        });
        
        console.log('✅ TradingView loaded successfully!');
        console.log('');
        console.log('📋 Instructions:');
        console.log('1. Please log into your TradingView account in the browser window');
        console.log('2. Make sure you can see the Pine Editor at the bottom of the page');
        console.log('3. If Pine Editor is not visible, click on the "Pine Editor" tab');
        console.log('4. Once logged in and Pine Editor is ready, press Enter here to continue...');
        console.log('');
        
        return new Promise((resolve) => {
            this.rl.question('Press Enter when you\'re logged in and Pine Editor is ready: ', () => {
                resolve();
            });
        });
    }

    async waitForPineEditor() {
        console.log('⏳ Checking for Pine Editor...');
        
        try {
            // Wait for Pine Editor to be available
            await this.page.waitForSelector(CONFIG.selectors.monacoEditor, {
                timeout: 10000
            });
            
            console.log('✅ Pine Editor found!');
            return true;
            
        } catch (error) {
            console.log('❌ Pine Editor not found. Please make sure:');
            console.log('   - You are logged into TradingView');
            console.log('   - The Pine Editor tab is visible and active');
            console.log('   - You have a chart open');
            return false;
        }
    }

    async testClipboardPaste() {
        console.log('📋 Testing clipboard paste functionality...');
        
        // Focus on the Monaco editor
        await this.page.click(CONFIG.selectors.monacoEditor);
        await this.page.waitForTimeout(1000);
        
        // Select all text
        const isMac = process.platform === 'darwin';
        const modifier = isMac ? 'Meta' : 'Control';
        
        await this.page.keyboard.down(modifier);
        await this.page.keyboard.press('KeyA');
        await this.page.keyboard.up(modifier);
        
        console.log('✅ Selected all text in Pine Editor');
        
        // Paste from clipboard
        await this.page.keyboard.down(modifier);
        await this.page.keyboard.press('KeyV');
        await this.page.keyboard.up(modifier);
        
        console.log('✅ Pasted from clipboard');
        
        return true;
    }

    async takeScreenshot(name = 'tradingview-test') {
        const screenshotPath = `../screenshots/${name}.png`;
        
        await this.page.screenshot({
            path: screenshotPath,
            fullPage: true
        });
        
        console.log(`📸 Screenshot saved: ${screenshotPath}`);
        return screenshotPath;
    }

    async waitForUser(message) {
        return new Promise((resolve) => {
            this.rl.question(`${message} (Press Enter to continue): `, () => {
                resolve();
            });
        });
    }

    async close() {
        this.rl.close();
        if (this.browser) {
            await this.browser.close();
            console.log('🔒 Browser closed');
        }
    }
}

async function main() {
    const launcher = new TradingViewLauncher();
    
    try {
        // Step 1: Launch browser and wait for login
        await launcher.launch();
        
        // Step 2: Verify Pine Editor is available
        if (!(await launcher.waitForPineEditor())) {
            console.log('❌ Pine Editor not ready. Please check your setup.');
            process.exit(1);
        }
        
        // Step 3: Test clipboard functionality
        console.log('');
        console.log('🧪 Now let\'s test the clipboard functionality...');
        await launcher.waitForUser('Make sure you have copied the ghost.pine indicator to your clipboard');
        
        await launcher.testClipboardPaste();
        
        // Step 4: Take screenshot
        await launcher.takeScreenshot('after-paste-test');
        
        // Step 5: Keep browser open for manual inspection
        console.log('');
        console.log('✅ Test completed! The browser will stay open for you to inspect the results.');
        console.log('');
        console.log('Next steps:');
        console.log('1. Check if the Pine Script code was pasted correctly');
        console.log('2. Verify the syntax highlighting and formatting');
        console.log('3. Test compilation by clicking the "Compile" button');
        console.log('');
        
        await launcher.waitForUser('Press Enter when you\'re done inspecting');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    } finally {
        await launcher.close();
    }
}

// Run the launcher
main().catch(console.error);