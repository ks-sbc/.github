---
# Obsidian PR Draft Template
# This template helps you draft PRs in Obsidian before submitting to GitHub
document_id: 
title: 
type: pull-request-draft
security: 
author: 
date_created: 
pr_branch_type: # proposal/implement/contributor/hotfix
target_branch: # staging/main
status: draft # draft/ready/submitted
---

# PR Draft: {{title}}

## Meta Bind Control Panel

```meta-bind-button
label: "📋 Copy PR Body"
id: "copy-pr-body"
hidden: false
style: primary
action:
  type: "copyToClipboard"
  text: |
    ## Description
    {{description}}
    
    ## Changes
    {{changes}}
    
    ## Testing
    {{testing}}
```

```meta-bind-button
label: "✅ Validate PR"
id: "validate-pr"
hidden: false
style: default
action:
  type: "command"
  command: "druids:validate-pr-draft"
```

```meta-bind-button
label: "🚀 Export to GitHub"
id: "export-pr"
hidden: false  
style: success
action:
  type: "createNote"
  folderPath: ".github/pr-queue"
  fileName: "{{date}}-{{title}}"
  openNote: true
```

## PR Metadata

**Branch Type**: `INPUT[inlineSelect(option(proposal), option(implement), option(contributor), option(hotfix)):pr_branch_type]`

**Security Level**: `INPUT[inlineSelect(option(L0), option(L1), option(L2)):security_level]`

**Target Branch**: `INPUT[inlineSelect(option(staging), option(main)):target_branch]`

## Description
`INPUT[textArea:description]`

## Changes Made
`INPUT[textArea:changes]`

## Testing Performed
`INPUT[textArea:testing]`

## Checklist

`INPUT[toggle:follows_style_guide]` Code follows style guidelines
`INPUT[toggle:self_reviewed]` Self-review completed
`INPUT[toggle:tests_added]` Tests added and passing
`INPUT[toggle:docs_updated]` Documentation updated

## Democratic Centralist Alignment

### For Proposal Branches
`INPUT[textArea:proposal_rationale]`

### For Implementation Branches
Link to approved proposal: `INPUT[text:proposal_link]`

## TPPS Cycle
- **Theory**: `INPUT[text:theory]`
- **Plan**: `INPUT[text:plan]`
- **Practice**: `INPUT[text:practice]`
- **Summation**: `INPUT[text:summation]`

---

## Instructions

1. Fill out all fields in this template
2. Click "Validate PR" to check completeness
3. Click "Copy PR Body" to get formatted text for GitHub
4. Click "Export to GitHub" to queue for automated submission
5. Or manually create PR on GitHub with copied content