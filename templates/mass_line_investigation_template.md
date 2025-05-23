<%*
// Templater script for Mass Line Investigation
let investigationTopic = await tp.system.prompt("Investigation Topic/Title", "Untitled Investigation");
let investigatorsInput = await tp.system.prompt("Investigator(s) (comma-separated)", "KSBC Collective");
let investigationDate = await tp.system.prompt("Date of Investigation (YYYY-MM-DD)", tp.date.now("YYYY-MM-DD"));
let targetGroup = await tp.system.prompt("Target Group/Community for Investigation", "To Be Determined");
let creationDate = tp.date.now("YYYY-MM-DD"); // Not directly used in docTitle but good for record

let docTitle = "Mass Line: " + investigationTopic;
let suggestedFilename = "Mass Line - " + investigationTopic.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
investigation_topic: "<% investigationTopic %>"
investigators: [<% investigatorsInput.split(',').map(item => `"${item.trim()}"`).join(', ') %>]
investigation_date: <% investigationDate %>
target_group: "<% targetGroup %>"
status: "in-progress"
tags: [mass-line, investigation]
---

# <% docTitle %>

## 1. Investigation Overview
- **Topic:** <% investigationTopic %>
- **Investigator(s):** <% investigatorsInput %>
- **Date of Investigation:** <% investigationDate %>
- **Target Group/Community:** <% targetGroup %>

## 2. Purpose/Goals of Investigation
*Clearly define the objectives of this mass line investigation. What does the organization aim to learn or achieve?*

## 3. Methodology
*Describe how the information was gathered. Examples:*
- *Interviews (individual, group)*
- *Surveys (online, paper)*
- *Participant observation*
- *Analysis of existing data/documents*

## 4. Key Questions Asked/Areas Explored
*List the main questions posed or topics covered during the investigation.*
- Question 1:
- Question 2:
- Area 1:

## 5. Summary of Findings/Raw Data
*Provide a summary of the raw data collected. This could be qualitative (e.g., common themes from interviews) or quantitative (e.g., survey results). If extensive, link to separate data files or appendices.*

## 6. Analysis of Findings
*Analyze the collected data. Identify key themes, patterns, contradictions, and insights. What do the findings mean?*
- **Theme 1:** [Description]
- **Theme 2:** [Description]

## 7. Conclusions Drawn
*Based on the analysis, what are the main conclusions of this investigation?*
- Conclusion 1:
- Conclusion 2:

## 8. Proposed Actions/Recommendations
*Based on the conclusions, what actions or recommendations are proposed?*
- [ ] Action 1: [Description of proposed action] (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 14) %>)
- [ ] Action 2: [Description of proposed action] (Assigned: @name) (Project: #project-tag) (due:: <% tp.date.now("YYYY-MM-DD", 21) %>)

## 9. Feedback Loop Plan
*How will the findings and proposed actions be reported back to the target group/community, or how will engagement continue?*

---
*Investigation status: in-progress*
