# How to Use This Repository

## Quick Start Guide

### 1. Create Your GitHub Repository
```bash
# In your Pine Script codebase directory
git init
git add .
git commit -m "Initial setup"
git remote add origin https://github.com/yourusername/your-repo-name.git
git push -u origin main
```

### 2. Team Members Request Data Points
1. Go to **Issues** → **New Issue** 
2. Choose **"Data Point Request"** template
3. Fill out:
   - Which indicator to modify
   - What signal type (bias/momentum/execution/confluence)
   - What conditions trigger the signal
4. Submit and wait for approval

### 3. Team Members Request Strategy Models  
1. Go to **Issues** → **New Issue**
2. Choose **"Strategy Model"** template  
3. Fill out:
   - Which indicators to combine
   - How to weight each signal
   - Entry/exit thresholds
4. Submit and wait for approval

### 4. You Approve and Assign
1. Review the issue request
2. Add labels: `data-point` or `strategy`
3. Assign to a team member
4. Move to "To Do" in project board

### 5. Development Process
```bash
# Team member workflow:
git checkout -b feature/issue-description
cd working/  # Always work in working/ directory
# Make changes to indicator
# Test in TradingView
git add .
git commit -m "Add data point: description"
git push origin feature/issue-description
# Create Pull Request
```

### 6. Code Review and Merge
1. Review the PR using the template checklist
2. Test the Pine Script code
3. Approve and merge to main
4. Indicator moves from `working/` to `indicators/`

## Key Directories

- **`working/`** - Development workspace (team works here)
- **`indicators/`** - Production indicators (don't edit directly)
- **`.github/`** - Issue templates and PR templates

## Signal Types

When requesting data points, choose one:

- **Bias Filter** - Determines trend direction (bullish/bearish)
- **Momentum Filter** - Measures signal strength/speed  
- **Execution Filter** - Times entry/exit points
- **Confluence Filter** - Combines multiple factors

## TTS Integration

All signals use this standard:
- `1` = Long Entry
- `-1` = Short Entry
- `2` = Long Exit  
- `-2` = Short Exit
- `0` = No Signal

Required Pine Script code:
```pinescript
plot(signal_value, "TTS Signal", display=display.data_window)
```

## That's It!

The templates guide your team through everything else. The GitHub Actions automatically validate Pine Script syntax and TTS integration.