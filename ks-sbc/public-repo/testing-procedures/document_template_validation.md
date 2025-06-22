# Manual Test Script: Document Template Functionality Validation for DRUIDS

**Purpose:** This document outlines the manual steps to validate the functionality of key document templates within DRUIDS. This ensures that templates correctly populate metadata, insert boilerplate content, execute any dynamic scripts, and save files as expected, supporting consistency and efficiency in KSBC documentation.

**Procedure:** This is a manual checklist. For each template listed:
1.  Attempt to create a new document using the specified template mechanism (e.g., QuickAdd command, Templater command, manual template insertion).
2.  Verify each aspect listed (frontmatter, boilerplate, dynamic behavior, save location).
3.  Mark "Pass" or "Fail" in the provided checkbox for each aspect.
4.  Add any relevant notes, especially for failures or unexpected behavior.

**Reporting Issues:** If any template does not function as expected, report the issue to the DRUIDS administration team or the relevant KSBC committee responsible for templates. Include the template name, the specific step/aspect that failed, the expected behavior, and the actual behavior observed.

---

## Test Environment:
*   **DRUIDS Version (Obsidian Version):** ______________
*   **Templater/QuickAdd Plugin Versions:** ______________
*   **Tester:** ______________
*   **Date:** ______________

---

## Template Validation Checklist

*(Note: Specific template names and their exact expected content/behavior should be filled in based on KSBC's final template designs. The following are examples based on common needs and the Phase 2 task list.)*

### 1. Template: Meeting Minutes

**Creation Method:** (e.g., QuickAdd: "New Meeting Minutes", Templater: "Insert Meeting Minutes Template") _______________

| Test Step                                      | Expected Behavior / Verification Points                                                                                                                                                             | Result      | Notes                                       |
|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **1.1 Create from Template**                   | New note created using the template without errors.                                                                                                                                                 | `[ ] Pass` `[ ] Fail` |                                             |
| **1.2 Verify Frontmatter: Date**               | `date:` field is populated with the current date (e.g., `YYYY-MM-DD`). (May be dynamic via Templater: `{{date}}` or similar).                                                                       | `[ ] Pass` `[ ] Fail` |                                             |
| **1.3 Verify Frontmatter: Title Prompt**       | User is prompted to enter a meeting title/topic, or a placeholder like `"Meeting Title"` is present.                                                                                                | `[ ] Pass` `[ ] Fail` |                                             |
| **1.4 Verify Frontmatter: Attendees Prompt**   | Placeholder for `attendees:` (e.g., empty list `[]` or prompt).                                                                                                                                     | `[ ] Pass` `[ ] Fail` |                                             |
| **1.5 Verify Frontmatter: Tags**               | Default tags like `#meeting-minutes`, `#L1` (or appropriate default classification) are present.                                                                                                    | `[ ] Pass` `[ ] Fail` | *Verify default classification.*            |
| **1.6 Verify Boilerplate: Headings**           | Standard headings like "Agenda," "Discussion Points," "Action Items," "Decisions Made" are present.                                                                                                 | `[ ] Pass` `[ ] Fail` |                                             |
| **1.7 Verify Boilerplate: Action Item Format** | Placeholder or format for action items is present (e.g., `- [ ] Action: [Assignee] - [Task] (Due: YYYY-MM-DD)`).                                                                                    | `[ ] Pass` `[ ] Fail` |                                             |
| **1.8 Verify Save Location**                   | Document is saved in the expected default location (e.g., `Meetings/YYYY/` or prompts user for location if designed that way).                                                                      | `[ ] Pass` `[ ] Fail` | *Confirm expected save behavior.*           |

### 2. Template: Theoretical Position Paper

**Creation Method:** (e.g., QuickAdd: "New Theory Paper") _______________

| Test Step                                    | Expected Behavior / Verification Points                                                                                                                                                              | Result      | Notes                                       |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **2.1 Create from Template**                 | New note created without errors.                                                                                                                                                                     | `[ ] Pass` `[ ] Fail` |                                             |
| **2.2 Verify Frontmatter: Title Prompt**     | User is prompted for paper title, or placeholder `title: "Paper Title"` exists.                                                                                                                      | `[ ] Pass` `[ ] Fail` |                                             |
| **2.3 Verify Frontmatter: Author(s)**        | `author:` field populated with current user (if Templater script exists for this) or is a placeholder.                                                                                               | `[ ] Pass` `[ ] Fail` |                                             |
| **2.4 Verify Frontmatter: Date**             | `date:` field is current date.                                                                                                                                                                       | `[ ] Pass` `[ ] Fail` |                                             |
| **2.5 Verify Frontmatter: Tags**             | Default tags like `#theory`, `#position-paper`, and appropriate security tier (e.g., `#L1` or `#L2` based on creation context) are present.                                                           | `[ ] Pass` `[ ] Fail` | *Verify default classification.*            |
| **2.6 Verify Boilerplate: Structure**        | Standard academic/paper headings like "Abstract," "Introduction," "Arguments/Analysis," "Counter-Arguments," "Conclusion," "References" are present.                                                 | `[ ] Pass` `[ ] Fail` |                                             |
| **2.7 Verify Save Location**                 | Saved in appropriate default folder (e.g., `Theory_Papers/Drafts/`) or prompts for location.                                                                                                         | `[ ] Pass` `[ ] Fail` | *Confirm expected save behavior.*           |

### 3. Template: Criticism / Self-Criticism Report

**Creation Method:** (e.g., Templater: "Insert C/SC Report") _______________

| Test Step                                    | Expected Behavior / Verification Points                                                                                                                                                              | Result      | Notes                                       |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **3.1 Create from Template**                 | New note created without errors.                                                                                                                                                                     | `[ ] Pass` `[ ] Fail` |                                             |
| **3.2 Verify Frontmatter: Subject Prompt**   | User prompted for subject of critique or placeholder `subject: "Critique Subject"` exists.                                                                                                           | `[ ] Pass` `[ ] Fail` |                                             |
| **3.3 Verify Frontmatter: Date**             | `date:` field is current date.                                                                                                                                                                       | `[ ] Pass` `[ ] Fail` |                                             |
| **3.4 Verify Frontmatter: Tags**             | Default tags like `#criticism`, `#self-criticism`, appropriate security tier (likely `#L1` or `#L2`).                                                                                                 | `[ ] Pass` `[ ] Fail` | *Verify default classification.*            |
| **3.5 Verify Boilerplate: Sections**         | Sections like "Context/Background," "Observation/Critique Points," "Analysis/Impact," "Constructive Suggestions/Solutions," "Self-Reflection (if applicable)" are present.                            | `[ ] Pass` `[ ] Fail` |                                             |
| **3.6 Verify Boilerplate: Tone Guidance**    | May include a small note/comment reminding user about constructive and objective tone.                                                                                                               | `[ ] Pass` `[ ] Fail` |                                             |
| **3.7 Verify Save Location**                 | Saved in appropriate folder (e.g., `Critiques/` or related project folder) or prompts.                                                                                                               | `[ ] Pass` `[ ] Fail` | *Confirm expected save behavior.*           |

### 4. Template: Study Guide

**Creation Method:** (e.g., QuickAdd: "New Study Guide") _______________

| Test Step                                    | Expected Behavior / Verification Points                                                                                                                                                              | Result      | Notes                                       |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **4.1 Create from Template**                 | New note created without errors.                                                                                                                                                                     | `[ ] Pass` `[ ] Fail` |                                             |
| **4.2 Verify Frontmatter: Topic Prompt**     | User prompted for study topic/text, or placeholder `topic: "Study Topic"` exists.                                                                                                                    | `[ ] Pass` `[ ] Fail` |                                             |
| **4.3 Verify Frontmatter: Tags**             | Default tags like `#study-guide`, relevant subject tags (user might be prompted), appropriate security tier (e.g., `#L0` or `#L1`).                                                                  | `[ ] Pass` `[ ] Fail` | *Verify default classification.*            |
| **4.4 Verify Boilerplate: Structure**        | Sections like "Key Concepts," "Summary of Readings," "Discussion Questions," "Further Resources" are present.                                                                                         | `[ ] Pass` `[ ] Fail` |                                             |
| **4.5 Verify Save Location**                 | Saved in appropriate folder (e.g., `Study_Guides/` or related course/subject folder) or prompts.                                                                                                     | `[ ] Pass` `[ ] Fail` | *Confirm expected save behavior.*           |

### 5. Template: Project Proposal

**Creation Method:** (e.g., QuickAdd: "New Project Proposal") _______________

| Test Step                                    | Expected Behavior / Verification Points                                                                                                                                                              | Result      | Notes                                       |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **5.1 Create from Template**                 | New note created without errors.                                                                                                                                                                     | `[ ] Pass` `[ ] Fail` |                                             |
| **5.2 Verify Frontmatter: Project Name**     | User prompted for project name, or placeholder `project_name: "Project Name"` exists.                                                                                                                | `[ ] Pass` `[ ] Fail` |                                             |
| **5.3 Verify Frontmatter: Proposer(s)**      | `proposer:` field populated with current user or placeholder.                                                                                                                                        | `[ ] Pass` `[ ] Fail` |                                             |
| **5.4 Verify Frontmatter: Date**             | `date:` field is current date.                                                                                                                                                                       | `[ ] Pass` `[ ] Fail` |                                             |
| **5.5 Verify Frontmatter: Status & Tags**    | Default `status: draft-proposal`, tags like `#project-proposal`, `#plan` (as it's a planning document), appropriate security tier.                                                                  | `[ ] Pass` `[ ] Fail` | *Verify default classification.*            |
| **5.6 Verify Boilerplate: Sections**         | Sections like "Problem Statement/Justification," "Proposed Solution/Activities," "Objectives/Deliverables," "Resources Required," "Timeline," "Success Metrics/KPIs," "Potential Risks" are present. | `[ ] Pass` `[ ] Fail` |                                             |
| **5.7 Verify Save Location**                 | Saved in appropriate folder (e.g., `Project_Proposals/Drafts/`) or prompts.                                                                                                                          | `[ ] Pass` `[ ] Fail` | *Confirm expected save behavior.*           |

---

*(Add more templates as defined by KSBC, e.g., Summation Report, Plan Document, etc., following a similar structure.)*

**End of Checklist**
