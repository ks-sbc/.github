<%*
// Templater script for Project Proposal
let proposalTitle = await tp.system.prompt("Proposal Title", "Untitled Proposal");

let securityLevel = null;
const securityOptions = ["Public", "Candidate", "Cadre"];
const securityValues = ["public", "candidate", "cadre"];
while (securityLevel == null) { // Loop until a selection is made
    securityLevel = await tp.system.suggester(
        securityOptions, 
        securityValues, 
        false, 
        "Select Security Level (Required)"
    );
    if (securityLevel == null) {
        // Optional: new Notice("Security level selection is mandatory.");
    }
}
let classificationDate = tp.date.now("YYYY-MM-DD");

let proposer = await tp.system.prompt("Proposer", "Current User"); // Placeholder, actual user might need different handling
let submissionDate = tp.date.now("YYYY-MM-DD");
let relatedIssue = await tp.system.prompt("Related GitHub Issue # (optional)", "");

// Suggest a filename
let suggestedFilename = "Proposal - " + proposalTitle.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% proposalTitle %>"
proposer: "<% proposer %>"
submission_date: <% submissionDate %>
security: <% securityLevel %>
classification_date: <% classificationDate %>
status: "draft"
related_issue: "<% relatedIssue ? relatedIssue : '' %>"
tags: [proposal]
---

# Proposal: <% proposalTitle %>

**Proposer:** <% proposer %>
**Submission Date:** <% submissionDate %>
<% if (relatedIssue) { %>**Related GitHub Issue:** #<% relatedIssue %><% } %>

---

## 1. Problem Statement

*What problem does this proposal aim to solve?*

## 2. Proposed Solution

*Describe the proposed solution in detail.*

## 3. Justification & Alignment with Principles

*How does this solution address the problem? How does it align with KSBC's democratic centralist principles and strategic objectives?*

## 4. Required Resources

*What resources (personnel, time, financial, etc.) are needed for this proposal?*

## 5. Initial Tasks & Timeline (High-Level)

- [ ] Define detailed project plan for "<% proposalTitle %>" (Priority:: High) (due:: <% tp.date.now("YYYY-MM-DD", 7) %>)
- [ ] Assemble project team (Priority:: High) (due:: <% tp.date.now("YYYY-MM-DD", 10) %>)
- [ ] Initial research/scoping phase (Priority:: Medium) (due:: <% tp.date.now("YYYY-MM-DD", 21) %>)

---
*This proposal is currently in **draft** status.*
```
