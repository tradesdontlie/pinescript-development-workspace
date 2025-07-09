#!/bin/bash

# GitHub Repository Auto-Setup Script
# Run this after authenticating with GitHub CLI

echo "🚀 Creating Pine Script CodeBase repository on GitHub..."

# Step 1: Create the private repository
echo "📁 Creating private repository..."
gh repo create pinescript-codebase \
  --private \
  --description "Pine Script indicators and strategies with professional development workflow" \
  --clone=false

# Step 2: Add remote and push
echo "📤 Adding remote and pushing code..."
git remote add origin https://github.com/$(gh api user --jq .login)/pinescript-codebase.git
git push -u origin main

# Step 3: Create labels
echo "🏷️ Creating project labels..."
gh label create "priority-critical" --color "D73A4A" --description "Must be done ASAP" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "priority-high" --color "FFA500" --description "Important, do soon" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "priority-medium" --color "FFFF00" --description "Normal priority" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "priority-low" --color "0E8A16" --description "Nice to have" --repo $(gh api user --jq .login)/pinescript-codebase || true

gh label create "indicator-fvg" --color "C5DEF5" --description "FVG indicator work" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "indicator-ghost" --color "D4C5F9" --description "Ghost indicator work" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "indicator-oracle" --color "C5F5C5" --description "Oracle indicator work" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "indicator-vortex" --color "F5D4C5" --description "Vortex indicator work" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "indicator-cycles" --color "F5F5C5" --description "Cycles indicator work" --repo $(gh api user --jq .login)/pinescript-codebase || true

gh label create "needs-review" --color "FFFF00" --description "Ready for PM review" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "changes-requested" --color "FFA500" --description "Needs updates" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "blocked" --color "D73A4A" --description "Waiting on something" --repo $(gh api user --jq .login)/pinescript-codebase || true
gh label create "help-wanted" --color "0E8A16" --description "Developer needs assistance" --repo $(gh api user --jq .login)/pinescript-codebase || true

# Step 4: Enable branch protection
echo "🛡️ Setting up branch protection..."
gh api repos/$(gh api user --jq .login)/pinescript-codebase/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":[]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field restrictions=null

# Step 5: Create starter issues
echo "📝 Creating starter issues..."
gh issue create \
  --title "[FVG] Add weekly timeframe filter" \
  --body "Enhance the FVG indicator to support weekly timeframe filtering for better signal accuracy." \
  --label "indicator-fvg,enhancement,priority-medium" \
  --repo $(gh api user --jq .login)/pinescript-codebase

gh issue create \
  --title "[Ghost] Optimize T1/T2 calculations" \
  --body "Review and optimize the T1/T2 signal calculations in the Ghost indicator for better performance." \
  --label "indicator-ghost,enhancement,priority-medium" \
  --repo $(gh api user --jq .login)/pinescript-codebase

gh issue create \
  --title "[Documentation] Update indicator guides" \
  --body "Review and update documentation for all indicators to ensure they're current and comprehensive." \
  --label "documentation,priority-low" \
  --repo $(gh api user --jq .login)/pinescript-codebase

gh issue create \
  --title "[Oracle] Enhance signal generation" \
  --body "Improve the Oracle indicator's signal generation algorithm for more accurate market predictions." \
  --label "indicator-oracle,enhancement,priority-medium" \
  --repo $(gh api user --jq .login)/pinescript-codebase

# Step 6: Get repository info
echo "✅ Repository created successfully!"
echo ""
echo "📊 Repository URL: https://github.com/$(gh api user --jq .login)/pinescript-codebase"
echo "📝 Issues: https://github.com/$(gh api user --jq .login)/pinescript-codebase/issues"
echo "🔄 Pull Requests: https://github.com/$(gh api user --jq .login)/pinescript-codebase/pulls"
echo ""
echo "🎉 Next steps:"
echo "1. Go to GitHub and create a Project board"
echo "2. Invite team members under Settings → Manage access"
echo "3. Share the repository URL with your team"
echo ""
echo "Repository is ready for professional Pine Script development! 🚀" 