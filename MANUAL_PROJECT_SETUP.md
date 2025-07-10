# Manual GitHub Project Setup Guide

Since the CLI authentication is being difficult, here's how to set up your project manually in the web interface (it's actually faster!):

## 🚀 Step 1: Go to Your Project

**Link**: https://github.com/users/tradesdontlie/projects/2

## ⚙️ Step 2: Add Custom Fields

Click the **"+"** button next to the column headers to add these fields:

### 1. Priority Field
- **Field name**: Priority
- **Field type**: Single select
- **Options**:
  - 🔥 High (red color)
  - 📊 Medium (yellow color)
  - 💡 Low (green color)

### 2. Type Field
- **Field name**: Type
- **Field type**: Single select
- **Options**:
  - 📊 Data Point (blue color)
  - 🎯 Strategy Model (purple color)
  - 🔧 Indicator (orange color)
  - 🐛 Bug (red color)
  - 📚 Documentation (gray color)

### 3. Category Field
- **Field name**: Category
- **Field type**: Single select
- **Options**:
  - 📈 FVG (green color)
  - 👻 Ghost (purple color)
  - 🔮 Oracle (blue color)
  - ⏰ Sessions (yellow color)
  - 🌪️ Vortex (orange color)
  - 🔄 Cycles (pink color)
  - 🎯 Strategy (red color)
  - 📚 Other (gray color)

### 4. Signal Type Field
- **Field name**: Signal Type
- **Field type**: Single select
- **Options**:
  - 🎯 Bias Filter (blue color)
  - ⚡ Momentum Filter (yellow color)
  - 🎪 Execution Filter (green color)
  - 🔄 Confluence Filter (purple color)
  - ❌ N/A (gray color)

### 5. Complexity Field
- **Field name**: Complexity
- **Field type**: Single select
- **Options**:
  - 🟢 Simple (green color)
  - 🟡 Medium (yellow color)
  - 🔴 Complex (red color)

## 🤖 Step 3: Set Up Automations

1. **Click the "⚙️" settings icon** in your project
2. **Go to "Workflows"**
3. **Add these automations**:

### Auto-add Issues to Project
- **Trigger**: Item added to project
- **Action**: Set Status to "Todo"

### Auto-assign In Progress
- **Trigger**: Issue assigned
- **Action**: Set Status to "In Progress"

### Auto-move to Review
- **Trigger**: Pull request opened
- **Action**: Set Status to "In Review"

### Auto-move to Done
- **Trigger**: Pull request merged
- **Action**: Set Status to "Done"

## 👥 Step 4: Add Team Members

1. **Go to your repository**: https://github.com/tradesdontlie/pinescript-codebase
2. **Settings** → **Manage access**
3. **Invite collaborators** with "Write" permission

## ✅ You're Done!

Your project is now ready for your team to:
1. Create data point requests using the issue templates
2. Create strategy model requests
3. Get assigned work through the project board
4. Submit PRs that automatically move through the workflow

## 🎯 Quick Test

Create a test issue to see the workflow:
1. **Go to Issues** → **New Issue**
2. **Choose "Data Point Request"**
3. **Fill it out and submit**
4. **Go to your project** - the issue should appear
5. **Assign it to yourself** - it should move to "In Progress"

This manual setup takes about 5 minutes and works perfectly!