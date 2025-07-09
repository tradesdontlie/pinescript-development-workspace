# Contributing to Pine Script CodeBase

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_ORG/pinescript-codebase.git
cd pinescript-codebase
```

### 2. Create a Feature Branch
Always create a new branch from `main` for your work:
```bash
git checkout main
git pull origin main
git checkout -b feature/indicator-name-description
```

## Branch Naming Convention

- `feature/indicator-fvg-weekly-filter` - New features
- `fix/ghost-t1-calculation` - Bug fixes
- `enhance/oracle-signals` - Enhancements
- `docs/strategy-template-guide` - Documentation

## Development Workflow

### 1. Check Your Assignment
- Go to the GitHub Project board
- Find your assigned issue/card
- Read requirements carefully
- Ask questions in issue comments if needed

### 2. Development Guidelines

#### For Indicators:
- Work in the `working/` directory first
- Use the versioning scripts:
  ```bash
  ./scripts/pine_master.sh develop working/indicator/file.pine minor
  ```
- Test thoroughly on TradingView
- Document any new features

#### For Strategies:
- Use the strategy templates in `Strategy Templates/`
- Follow the signal adapter pattern
- Test with multiple timeframes

### 3. Code Standards

#### Pine Script v5 Requirements:
```pine
//@version=5
indicator("Name", overlay=true)

// Constants at top
const int LOOKBACK = 20

// Input parameters
length = input.int(14, "Length", minval=1)

// Main logic with clear comments
// ...
```

#### Required Comments:
- Function purpose
- Complex logic explanation
- Parameter descriptions
- Known limitations

### 4. Testing Requirements

Before submitting PR:
- [ ] No compilation errors
- [ ] Tested on multiple timeframes
- [ ] Tested on different symbols
- [ ] Performance acceptable (< 500ms)
- [ ] No repainting issues

### 5. Pull Request Process

#### PR Title Format:
```
[INDICATOR-NAME] Brief description of changes
```

Examples:
- `[FVG] Add weekly timeframe filter`
- `[GHOST] Fix T1/T2 calculation bug`
- `[ORACLE] Enhance signal generation`

#### PR Description Template:
```markdown
## Summary
Brief description of what was changed and why.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Enhancement
- [ ] Documentation

## Testing
- [ ] Tested on 15m timeframe
- [ ] Tested on 1H timeframe
- [ ] Tested on Daily timeframe
- [ ] Tested with SPY, AAPL, EUR/USD

## Screenshots
[Add TradingView screenshots if applicable]

## Checklist
- [ ] Code follows project standards
- [ ] No compilation warnings
- [ ] Documentation updated
- [ ] Version incremented appropriately
```

### 6. Code Review Process

#### What Reviewers Look For:
1. **Functionality**: Does it work as specified?
2. **Performance**: No unnecessary loops or calculations
3. **Readability**: Clear variable names and structure
4. **Compatibility**: Works with existing codebase
5. **Documentation**: Comments and docs updated

#### Responding to Feedback:
- Address all comments
- Push fixes to same branch
- Reply to each comment when resolved
- Request re-review when ready

## File Organization

### Working Directory Structure:
```
working/
├── fvg/          # FVG indicator development
├── ghost/        # Ghost indicator development
├── oracle/       # Oracle indicator development
├── strategy/     # Strategy development
├── libraries/    # Shared libraries
└── testing/      # Test scripts
```

### Version Management:
- Use semantic versioning (MAJOR.MINOR.PATCH)
- Update VERSION_HISTORY.md
- Tag releases appropriately

## Common Issues & Solutions

### Pine Script Errors:
1. **Cannot use 'resolution'**: Use 'timeframe.period' instead
2. **Mutable variables**: Use `var` keyword for persistence
3. **Array index out of bounds**: Check array.size() first

### Git Issues:
1. **Merge conflicts**: Always pull latest before starting
2. **Large files**: Use .gitignore for test data
3. **Accidental commits**: Use `git reset` before pushing

## Getting Help

1. **Technical Questions**: Comment on your issue
2. **Pine Script Help**: Check `/docs/` folder
3. **Urgent Issues**: Tag project manager in PR
4. **General Discussion**: Use GitHub Discussions

## Resources

- [Pine Script v5 Documentation](https://www.tradingview.com/pine-script-docs/en/v5/)
- [Project Wiki](https://github.com/YOUR_ORG/pinescript-codebase/wiki)
- [Error Solutions Database](/database/solutions/) 