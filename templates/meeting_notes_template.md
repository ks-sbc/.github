<%*
// Templater script for Meeting Notes
let meetingTitle = await tp.system.prompt("Meeting Title", "Untitled Meeting");

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

let meetingDate = await tp.system.prompt("Meeting Date", tp.date.now("YYYY-MM-DD"));
let attendees = await tp.system.prompt("Attendees (comma-separated)", "");
let location = await tp.system.prompt("Location/Platform", "Online");
let timeStarted = tp.date.now("HH:mm");

// Suggest a filename based on date and title
let suggestedFilename = meetingDate + " - " + meetingTitle.replace(/[\/:?"<>|]/g, '_'); // Sanitize title
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% meetingTitle %>"
date: <% meetingDate %>
time_started: <% timeStarted %>
security: <% securityLevel %>
classification_date: <% classificationDate %>
attendees: [<% attendees.split(',').map(a => `"${a.trim()}"`).join(', ') %>]
location: "<% location %>"
status: "pending-review"
tags: [meeting-notes]
---

# <% meetingTitle %>

**Date:** <% meetingDate %>
**Time Started:** <% timeStarted %>
**Location/Platform:** <% location %>
**Attendees:** <% attendees %>

---

## Agenda

- Item 1
- Item 2

## Discussion Points

- Point 1:
  - Detail...
- Point 2:
  - Detail...

## Decisions Made

- Decision 1:
- Decision 2:

## Action Items

- [ ] Action Item 1 (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 7) %>)
- [ ] Action Item 2 (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 14) %>)
- [ ] Review and finalize these meeting minutes (Assigned: @name) (due:: <% tp.date.now("YYYY-MM-DD", 2) %>)

---
*Facilitator: [Name]*
*Note Taker: [Name]*
```
