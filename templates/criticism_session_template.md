<%*
// Templater script for Criticism/Self-Criticism Session
let sessionDate = await tp.system.prompt("Session Date", tp.date.now("YYYY-MM-DD"));

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

let facilitator = await tp.system.prompt("Facilitator Name", "To Be Determined");
let sessionType = await tp.system.suggester(
  ["Individual", "Collective", "Committee"], 
  ["Individual", "Collective", "Committee"],
  false,
  "Select Session Type"
);
let attendeesInput = "";
if (sessionType === "Collective" || sessionType === "Committee") {
  attendeesInput = await tp.system.prompt("Attendees (comma-separated)", "");
}

let docTitle = "Criticism Session - " + sessionDate + " - " + sessionType;
let suggestedFilename = "Criticism Session - " + sessionDate + " - " + sessionType.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
session_date: <% sessionDate %>
facilitator: "<% facilitator %>"
session_type: "<% sessionType %>"
security: <% securityLevel %>
classification_date: <% classificationDate %>
<% if (attendeesInput) { %>attendees: [<% attendeesInput.split(',').map(item => `"${item.trim()}"`).join(', ') %>]<% } %>
tags: [criticism-session, demcent]
---

# Criticism/Self-Criticism Session: <% sessionType %> - <% sessionDate %>

## Session Details
- **Date:** <% sessionDate %>
- **Facilitator:** <% facilitator %>
- **Type:** <% sessionType %>
<% if (attendeesInput) { %>- **Attendees:** <% attendeesInput %><% } %>

## Purpose/Focus of the Session

*Clearly state the main objectives or focus areas for this criticism/self-criticism session.*

## Points of Criticism Raised

*(For each major point or theme discussed, create a subsection or bullet points)*

### Theme/Point 1: [Name of Theme/Point]
- **Specific examples/observations:**
  - *Detail specific instances or behaviors observed.*
- **Analysis/Impact:**
  - *Analyze the root causes and the impact of these issues on individuals, the collective, or the work.*

*(Add more themes/points as needed)*

## Points of Self-Criticism Offered

*(For each major point or theme of self-criticism, create a subsection or bullet points)*

### Self-Criticism Theme 1: [Name of Theme/Point]
- **Specific examples/observations:**
  - *Detail specific instances or behaviors acknowledged.*
- **Analysis/Impact:**
  - *Analyze the root causes and the impact of these issues.*

*(Add more themes/points as needed)*

## Discussion Summary

*Summarize the key discussion points, agreements, and disagreements.*

## Actionable Steps for Improvement

- [ ] Action Item 1 (e.g., Develop new training material) (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 14) %>)
- [ ] Action Item 2 (e.g., Schedule follow-up meeting) (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 7) %>)
- [ ] Action Item 3 (Assigned: @name) (due:: <% tp.date.now("YYYY-MM-DD", 21) %>)

## Overall Reflections/Summation

*Provide any concluding thoughts, overall assessment of the session, and next steps for the summation of this process.*
