#!/usr/bin/env node

/**
 * Simple TradingView Browser Launcher
 * Opens TradingView and keeps browser open for manual testing
 */

const puppeteer = require('puppeteer');

async function launchTradingView() {
    console.log('🚀 Launching TradingView browser...');
    
    const browser = await puppeteer.launch({
        headless: false,
        defaultViewport: {
            width: 1400,
            height: 900
        },
        args: [
            '--no-sandbox', 
            '--disable-setuid-sandbox',
            '--disable-web-security'
        ]
    });
    
    const page = await browser.newPage();
    await page.setViewport({ width: 1400, height: 900 });
    
    console.log('🌐 Navigating to TradingView...');
    await page.goto('https://www.tradingview.com/chart/', {
        waitUntil: 'networkidle2',
        timeout: 30000
    });
    
    console.log('✅ TradingView loaded successfully!');
    console.log('');
    console.log('📋 Instructions:');
    console.log('1. Log into your TradingView account in the browser window');
    console.log('2. Make sure you can see the Pine Editor at the bottom');
    console.log('3. If Pine Editor is not visible, click on the "Pine Editor" tab');
    console.log('4. The ghost.pine indicator is already copied to your clipboard');
    console.log('5. Click in the Pine Editor and press Ctrl+A (or Cmd+A) to select all');
    console.log('6. Then press Ctrl+V (or Cmd+V) to paste the ghost.pine code');
    console.log('');
    console.log('🔄 Browser will stay open for 10 minutes for testing...');
    console.log('   (Close this terminal or press Ctrl+C to stop early)');
    
    // Keep browser open for 10 minutes
    await new Promise(resolve => setTimeout(resolve, 600000));
    
    console.log('⏰ Time limit reached. Closing browser...');
    await browser.close();
    console.log('🔒 Browser closed');
}

launchTradingView().catch(console.error);