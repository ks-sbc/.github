<%*
let title = await tp.system.prompt("Note Title", "Untitled Related Note");

// Attempt to get parentSecurityLevel passed from QuickAdd
let suggestedSecurity = "";
try {
    if (tp.variables && tp.variables.parentSecLevel && ["public", "candidate", "cadre"].includes(tp.variables.parentSecLevel)) {
        suggestedSecurity = tp.variables.parentSecLevel;
    }
} catch (e) { console.warn("Could not access parentSecurityLevel from QuickAdd variables in Templater."); }

let securityLevel = null;
const securityOptions = ["Public", "Candidate", "Cadre"];
const securityValues = ["public", "candidate", "cadre"];
// Find the index of the suggestedSecurity to pass as default to suggester
let defaultSecurityIndex = securityValues.indexOf(suggestedSecurity);
if (defaultSecurityIndex === -1) defaultSecurityIndex = 0; // Default to Public if suggestion is invalid

while (securityLevel == null) {
    securityLevel = await tp.system.suggester(
        securityOptions, 
        securityValues, 
        false, 
        "Select Security Level (Required)",
        defaultSecurityIndex // Pass index of default value
    );
}
let classificationDate = tp.date.now("YYYY-MM-DD");
let creationDate = tp.date.now("YYYY-MM-DD");

let suggestedFilename = creationDate + " - " + title.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% title %>"
date: <% creationDate %>
security: <% securityLevel %>
classification_date: <% classificationDate %>
tags: [related-note] 
---

# <% title %>

## Content

[Start writing here]

## Tasks
- [ ] 
```
