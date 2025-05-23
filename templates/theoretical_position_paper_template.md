<%*
// Templater script for Theoretical Position Paper
let docTitle = await tp.system.prompt("Position Paper Title", "Untitled Position Paper");
let authorsInput = await tp.system.prompt("Author(s) (comma-separated)", "KSBC Collective");
let securityLevel = await tp.system.suggester(
  ["Public", "Candidate", "Cadre"], 
  ["public", "candidate", "cadre"],
  false, // allow custom values: false
  "Select Security Level"
);
let creationDate = tp.date.now("YYYY-MM-DD");

let suggestedFilename = "Position Paper - " + docTitle.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
authors: [<% authorsInput.split(',').map(item => `"${item.trim()}"`).join(', ') %>]
date: <% creationDate %>
security: <% securityLevel %>
status: "draft"
tags: [position-paper, theory]
---

# <% docTitle %>

## Abstract/Summary

*Provide a brief overview of the paper's main arguments and conclusions.*

## Introduction/Background

*Set the context for the position paper. What issues or questions does it address? What is the historical or theoretical background?*

## Main Arguments/Theses

### Thesis 1: [Title of Thesis 1]
*State the first main argument clearly.*

### Thesis 2: [Title of Thesis 2]
*State the second main argument clearly.*

*(Add more theses as needed)*

## Evidence/Analysis

*Present evidence, data, and analysis to support each thesis. This section should be well-researched and rigorously argued.*

## Counter-arguments & Rebuttals (Optional)

*Address potential counter-arguments or alternative perspectives. Provide rebuttals or explain why the proposed position is stronger.*

## Conclusion/Implications

*Summarize the main points and discuss the implications of the position. What are the practical consequences or next steps?*

## Works Cited/Further Reading (Optional)

*List any sources cited in the paper or recommended for further reading.*

---
*Authored by: <% authorsInput %>*
*Security Level: <% securityLevel %>*
