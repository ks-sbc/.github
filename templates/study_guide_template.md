<%*
// Templater script for creating new study guide
let title = await tp.system.prompt("Study Guide Title", "Untitled Study Guide");

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
        // The loop will continue if prompt is cancelled.
    }
}
let classificationDate = tp.date.now("YYYY-MM-DD");

let issueNumber = await tp.system.prompt("Related GitHub Issue Number (optional)", "");
let tagsInput = await tp.system.prompt("Tags (comma separated, e.g., theory, marxism, study-guide)", "study-guide");
let tagArray = tagsInput.split(',').map(t => t.trim()).filter(t => t.length > 0);

let now = tp.date.now("YYYY-MM-DD"); // This is 'created' date

// Suggest a filename
let suggestedFilename = "Study Guide - " + title.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% title %>"
created: <% now %>
security: <% securityLevel %>
classification_date: <% classificationDate %>
issue: "<% issueNumber ? issueNumber : '' %>"
tags: [<% tagArray.map(t => `"${t}"`).join(', ') %>]
---

# <% title %>

## Political Context

[Theoretical basis and necessity]

## Learning Objectives

- [Objective 1]
- [Objective 2]
- [Objective 3]

## Key Concepts

### Concept 1

[Explanation]

### Concept 2

[Explanation]

## Study Questions

1. [Question 1]
2. [Question 2]
3. [Question 3]

## Related Materials

- [Related resource 1](link)
- [Related resource 2](link)

## Historical Context

[Historical significance]

---
<% if (issueNumber) { %>*This study guide was developed based on [GitHub Issue #<% issueNumber %>](https://github.com/ksbc/content-repo/issues/<% issueNumber %>).*<% } %>
