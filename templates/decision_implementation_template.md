<%*
// Templater script for Decision Implementation Plan
let decisionTitle = await tp.system.prompt("Decision/Proposal Title being implemented", "Untitled Implementation Plan");
let decisionDate = await tp.system.prompt("Date of Decision/Approval (YYYY-MM-DD)", tp.date.now("YYYY-MM-DD"));
let implementationLead = await tp.system.prompt("Implementation Lead/Committee", "To Be Determined");
let targetCompletionDate = await tp.system.prompt("Target Completion Date (YYYY-MM-DD)", tp.date.now("YYYY-MM-DD", 30)); // Default 30 days from now
let creationDate = tp.date.now("YYYY-MM-DD"); // Used for 'date' if needed, not for title here

let docTitle = "Implementation Plan: " + decisionTitle;
let suggestedFilename = "Implementation Plan - " + decisionTitle.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
decision_title: "<% decisionTitle %>"
decision_date: <% decisionDate %>
implementation_lead: "<% implementationLead %>"
target_completion_date: <% targetCompletionDate %>
status: "planning"
tags: [implementation-plan, decision]
---

# <% docTitle %>

## 1. Decision Being Implemented
- **Decision/Proposal Title:** <% decisionTitle %>
- **Date of Decision/Approval:** <% decisionDate %>

## 2. Implementation Lead & Team
- **Lead:** <% implementationLead %>
- **Team Members (if applicable):**
  - *[Name/Role]*
  - *[Name/Role]*

## 3. Background/Context of Decision
*Briefly summarize the original proposal/decision and why it was approved.*

## 4. Objectives of Implementation
*What are the specific, measurable, achievable, relevant, and time-bound (SMART) goals for this implementation?*
- Objective 1:
- Objective 2:

## 5. Key Tasks/Phases
- [ ] **Phase 1: Initial Setup & Planning** (Due: <% tp.date.now("YYYY-MM-DD", 7) %>)
  - [ ] Task 1.1: Define detailed sub-tasks (Assigned: @name) (Project: #project-tag)
  - [ ] Task 1.2: Identify required resources (Assigned: @name) (Project: #project-tag)
- [ ] **Phase 2: Execution** (Due: <% tp.date.now("YYYY-MM-DD", 21) %>)
  - [ ] Task 2.1: [Specific Action] (Assigned: @name) (Project: #project-tag)
  - [ ] Task 2.2: [Specific Action] (Assigned: @name) (Project: #project-tag)
- [ ] **Phase 3: Review & Verification** (Due: <% targetCompletionDate %>)
  - [ ] Task 3.1: Verify all objectives met (Assigned: @name) (Project: #project-tag)
  - [ ] Task 3.2: Prepare completion report (Assigned: @name) (Project: #project-tag)

## 6. Resource Allocation
- **Personnel:**
  - *[Role/Name]: [Responsibilities]*
- **Budget (if applicable):**
  - *[Item]: [Allocated Amount]*

## 7. Timeline/Milestones
- **Milestone 1:** Phase 1 Completion - <% tp.date.now("YYYY-MM-DD", 7) %>
- **Milestone 2:** Phase 2 Completion - <% tp.date.now("YYYY-MM-DD", 21) %>
- **Milestone 3:** Full Implementation & Review - <% targetCompletionDate %>

## 8. Metrics for Success/Verification
*How will the success of this implementation be measured? What are the key performance indicators (KPIs)?*
- Metric 1:
- Metric 2:

## 9. Potential Risks & Mitigation Strategies
- **Risk 1:** [Description of risk]
  - **Mitigation:** [Strategy to address risk]
- **Risk 2:** [Description of risk]
  - **Mitigation:** [Strategy to address risk]

## 10. Communication Plan
*How will progress and updates be communicated to relevant stakeholders?*
- Regular updates to [Committee/Group]
- Final report submission to [Body]

---
*This plan is currently in **planning** status.*
