<%*
// Templater script for creating new study guide
let title = await tp.system.prompt("Study Guide Title");
let securityLevel = await tp.system.suggester(
  ["Public", "Candidate", "Cadre"],
  ["public", "candidate", "cadre"]
);

let issueNumber = await tp.system.prompt("Related GitHub Issue Number");

let tags = await tp.system.prompt("Tags (comma separated)");
let tagArray = tags.split(',').map(t => t.trim());

let now = tp.date.now("YYYY-MM-DD");
-%>
---
title: "<% title %>"
created: <% now %>
security: <% securityLevel %>
issue: <% issueNumber %>
tags: [<% tagArray.join(', ') %>]
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

*This study guide was developed based on [GitHub Issue #<% issueNumber %>](https://github.com/ksbc/content-repo/issues/<% issueNumber %>).*
