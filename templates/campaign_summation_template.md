<%*
// Templater script for Campaign Summation
let campaignName = await tp.system.prompt("Campaign/Initiative Name", "Untitled Campaign");

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

let startDate = await tp.system.prompt("Campaign Start Date (YYYY-MM-DD)", "");
let endDate = await tp.system.prompt("Campaign End Date (YYYY-MM-DD)", tp.date.now("YYYY-MM-DD"));
let campaignLead = await tp.system.prompt("Campaign Lead/Committee", "To Be Determined");
// let creationDate = tp.date.now("YYYY-MM-DD"); // Not directly used in frontmatter title but good for 'date' if needed

let docTitle = "Summation: " + campaignName;
let suggestedFilename = "Summation - " + campaignName.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
campaign_name: "<% campaignName %>"
start_date: <% startDate %>
end_date: <% endDate %>
campaign_lead: "<% campaignLead %>"
security: <% securityLevel %>
classification_date: <% classificationDate %>
status: "completed"
tags: [summation, campaign-review]
---

# Summation: <% campaignName %>

## Campaign Overview
- **Campaign/Initiative Name:** <% campaignName %>
- **Start Date:** <% startDate %>
- **End Date:** <% endDate %>
- **Campaign Lead/Committee:** <% campaignLead %>

## Original Goals & Objectives

*What were the initial goals and objectives of this campaign/initiative? Be specific.*

## Key Activities Undertaken

*List the major activities, tactics, and phases of the campaign.*

## Outcomes & Results

*Describe the outcomes and results achieved. Include both quantitative (e.g., metrics, numbers) and qualitative (e.g., impact on consciousness, organizational capacity) data where possible.*

## What Went Well (Successes, Strengths)

*Identify what aspects of the campaign were successful and what strengths were demonstrated.*

## Challenges Encountered & Weaknesses Identified

*Detail any challenges, obstacles, or weaknesses observed during the campaign.*

## Lessons Learned (Key Takeaways)

*What are the most important lessons learned from this campaign? These should inform future work.*

## Financial Summary (if applicable)

*Provide a summary of income and expenses related to the campaign, if relevant.*

## Recommendations for Future Campaigns/Work

*Based on this summation, what specific recommendations can be made for future similar campaigns or related organizational work?*

## Appendices (Optional)

*Include any supporting data, participant lists, detailed reports, etc.*
