# User Acceptance Testing (UAT) Procedures for DRUIDS

**Document Version:** 1.0
**Date:** YYYY-MM-DD

## 0. Table of Contents
1.  Objectives of UAT
2.  Target User Groups
3.  UAT Test Scenarios
    *   3.1. General Member Scenarios
    *   3.2. Candidate Scenarios
    *   3.3. Cadre Scenarios
4.  Success Criteria
5.  UAT Process
    *   5.1. Tester Recruitment and Orientation
    *   5.2. Test Environment Setup
    *   5.3. Test Execution Period
    *   5.4. Data Collection
    *   5.5. Review and Sign-off
6.  Feedback Form Template
7.  Roles and Responsibilities

## 1. Objectives of UAT

User Acceptance Testing (UAT) for DRUIDS aims to:

*   **Validate Usability:** Ensure that DRUIDS is intuitive and easy to use for all defined user roles.
*   **Confirm Workflow Efficacy:** Verify that key workflows (e.g., document creation, TPPS cycle, task management, security protocols) meet the practical needs of KSBC members.
*   **Support Democratic Centralist Principles:** Confirm that DRUIDS features and documentation practices facilitate open discussion, clear decision recording, unified action, and appropriate information access.
*   **Identify Bugs and Issues:** Uncover any remaining bugs, errors, or usability problems in a real-world usage context.
*   **Validate Documentation:** Ensure that user guides (Beginner's, General Member, Candidate, Cadre) and training materials are clear, accurate, and helpful.
*   **Build User Confidence:** Increase user confidence and acceptance of the DRUIDS system prior to full rollout.

## 2. Target User Groups

UAT participants will be selected from KSBC's membership, representing the primary user roles:

*   **General Members:**
    *   **Criteria:** Members who primarily consume information, access study materials, and stay informed of KSBC activities. Should include members with varying levels of technical proficiency.
*   **Candidates:**
    *   **Criteria:** Members actively involved in study, contributing to L1 materials, and potentially assisting with specific tasks or documentation.
*   **Cadres:**
    *   **Criteria:** Members with leadership and oversight responsibilities, involved in strategic planning, decision-making, and handling sensitive (L2) information.

A diverse group within each category should be selected to ensure comprehensive feedback.

## 3. UAT Test Scenarios

Testers will be provided with scenarios relevant to their roles. They should utilize the provided user guides and training vault materials as needed.

### 3.1. General Member Scenarios

| Scenario ID | Description                                                                                                                               | Relevant Documentation / Training                                                                                               |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| GM-001      | Find and open the "Beginner's Guide to DRUIDS."                                                                                           | `documentation/user-onboarding/beginners_guide.md`                                                                              |
| GM-002      | Locate the latest public announcement regarding upcoming KSBC events.                                                                       | `(Simulated L0 Announcement Area in DRUIDS)`                                                                                    |
| GM-003      | Access an L0 study material document on "KSBC Core Principles" (example document).                                                        | `training-vault/Examples/L0 - Public Examples/Example Public Document.md`                                                       |
| GM-004      | Use the search function to find a document mentioning "community engagement."                                                               | `training-vault/ (search across example docs)`                                                                                  |
| GM-005      | Navigate the `training-vault` to understand its basic folder structure.                                                                   | `training-vault/00 - Welcome and Instructions/START HERE.md`, `training-vault/02 - Basic Navigation/basic_obsidian_navigation_tutorial.md` |

### 3.2. Candidate Scenarios

| Scenario ID | Description                                                                                                                                                                 | Relevant Documentation / Training                                                                                                                               |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CAND-001    | Access the "Candidate Guide" and locate the section on L1 security materials.                                                                                               | `documentation/user-onboarding/candidate_guide.md`                                                                                                              |
| CAND-002    | Find the "Example Candidate Document" in the training vault and identify its stated security classification.                                                                  | `training-vault/Examples/L1 - Candidate Examples/Example Candidate Document.md`, `training-vault/01 - Core Concepts/Understanding Security Tiers.md`            |
| CAND-003    | Create a new document in the `training-vault/04 - Exercises/` folder using the "Meeting Minutes" template (simulated). Fill in basic details: title, date, one agenda item. | `training-vault/03 - Working with Documents/working_with_documents_tutorial.md`, (Simulated template access via copy-paste or instruction)                  |
| CAND-004    | Add a task to the `[[TPPS_Scenario_Files/2_Plan_Example.md]]` in the training vault as per the TPPS scenario instructions.                                                   | `training-vault/04 - Exercises/TPPS_Scenario_Instructions.md`                                                                                                   |
| CAND-005    | Create a new note, add L1 classification metadata (simulated or by instruction), and link it to the `[[TPPS_Scenario_Files/1_Theoretical_Paper_Example.md]]`.                | `training-vault/03 - Working with Documents/working_with_documents_tutorial.md`, `security_procedures_manual.md` (for classification understanding) |

### 3.3. Cadre Scenarios

| Scenario ID | Description                                                                                                                                                                                             | Relevant Documentation / Training                                                                                                                                |
|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CAD-001     | Access the "Cadre Guide" and review the procedures for handling L2 materials.                                                                                                                           | `documentation/user-onboarding/cadre_guide.md`                                                                                                                   |
| CAD-002     | (Simulated) Assume an L2 document needs to be created based on `[[TPPS_Scenario_Files/4_Summation_Example.md]]`. Describe the steps you would take to create, encrypt (conceptually), and store this new L2 "Decision Record" document, including appropriate metadata. | `security_procedures_manual.md`, `cadre_guide.md`                                                                                                                |
| CAD-003     | Review the `[[TPPS_Scenario_Files/2_Plan_Example.md]]`. Identify a task and simulate updating its status (e.g., moving a card on a conceptual Kanban board or updating a task list item).                 | `documentation/workflow-tutorials/updating_tasks_and_project_status.md` (conceptual application)                                                                 |
| CAD-004     | Attempt to create a new L0 document but try to apply L2 metadata (e.g., `classification: L2` in frontmatter). Note any system warnings or procedural flags this action should raise based on DRUIDS design. | `security_procedures_manual.md`, `training-vault/03 - Working with Documents/working_with_documents_tutorial.md`                                               |
| CAD-005     | (If GPG plugin is testable) Create a test file, encrypt it using a known test GPG key, and then decrypt it.                                                                                             | `security_procedures_manual.md` (GPG section), `gpg-encrypt` plugin documentation (if available).                                                                |

## 4. Success Criteria

For each scenario, successful completion is generally defined by:

*   **Task Completion:** The tester can complete the core task described in the scenario.
*   **Accuracy:** The task is performed correctly according to DRUIDS procedures and KSBC principles (e.g., correct metadata, correct file location).
*   **Usability:** The tester can perform the task without undue difficulty, confusion, or excessive time.
*   **Documentation Utility:** The tester finds the relevant user guides and training materials helpful in completing the task.
*   **Security Adherence:** For L1/L2 scenarios, security procedures are understood and (where simulated) correctly applied.

Specific success criteria may be added to individual scenarios as needed.

## 5. UAT Process

1.  **Tester Recruitment and Orientation:**
    *   Identify and recruit testers from each target user group.
    *   Conduct an orientation session explaining the purpose of UAT, the DRUIDS system (briefly), how to use the training vault, the test scenarios, and the feedback process.
    *   Provide access to all relevant documentation, including this UAT plan and the user guides.

2.  **Test Environment Setup:**
    *   Ensure testers have access to the DRUIDS GitHub repository (or a dedicated test instance).
    *   Ensure testers can clone/pull the repository to set up their local Obsidian vault.
    *   Provide clear instructions on setting up Obsidian with necessary KSBC configurations/plugins for the UAT (or point to a pre-configured test vault).
    *   The `ks-sbc/public-repo/training-vault/` will serve as the primary environment for many UAT tasks.

3.  **Test Execution Period:**
    *   Define a clear start and end date for UAT (e.g., 1-2 weeks).
    *   Encourage testers to perform scenarios relevant to their role and any other exploratory testing they deem useful.

4.  **Data Collection:**
    *   Testers will use the "Feedback Form Template" (see section 6) for each scenario they test.
    *   A central point for submitting completed feedback forms will be established (e.g., a dedicated email address, a shared folder).
    *   Regular check-ins or Q&A sessions may be held during the UAT period.

5.  **Review and Sign-off:**
    *   After the UAT period, the UAT coordinator will collect and consolidate all feedback.
    *   The DRUIDS development/implementation team will review the feedback, prioritize issues, and plan for necessary changes.
    *   A summary report of UAT findings will be presented to KSBC leadership.
    *   Sign-off will indicate that UAT objectives have been met and DRUIDS is ready for the next phase (e.g., wider rollout, further refinement).

## 6. Feedback Form Template

```markdown
**UAT Feedback Form - DRUIDS**

**Tester Name:**
**Date:**
**User Group (General Member, Candidate, Cadre):**
**Scenario ID / Task Description:** (Copy from UAT Plan, or describe exploratory task)

---

**1. Did you complete the task successfully?**
   ( ) Yes
   ( ) No

**2. Ease of Completion (1=Very Difficult, 5=Very Easy):**
   ( ) 1   ( ) 2   ( ) 3   ( ) 4   ( ) 5

**3. Approximate Time Taken:** (e.g., 5 minutes, 30 minutes)

**4. Issues Encountered:**
   (Describe any bugs, errors, usability problems, confusing instructions, documentation gaps, etc.)

**5. Suggestions for Improvement:**
   (How could this task/feature/document be made better?)

**6. Documentation/Training Material Feedback (if used for this scenario):**
   - Was the documentation helpful? (Yes/No/Partially)
   - Was it easy to find the information you needed? (Yes/No/Partially)
   - Specific comments on documentation:

**7. Other Comments:**

---
```

## 7. Roles and Responsibilities

*   **UAT Coordinator(s):**
    *   Overall planning and management of the UAT process.
    *   Recruiting and orienting testers.
    *   Collecting and consolidating feedback.
    *   Liaising between testers and the DRUIDS development/implementation team.
    *   Preparing the final UAT summary report.
*   **Testers:**
    *   Attend orientation.
    *   Set up their test environment.
    *   Execute assigned and exploratory test scenarios.
    *   Provide timely and detailed feedback using the feedback form.
    *   Report critical issues immediately.
*   **DRUIDS Development/Implementation Team:**
    *   Provide support to testers regarding environment setup and technical queries.
    *   Address critical bugs found during UAT.
    *   Review and analyze UAT feedback for system improvements.

---
This UAT process is designed to be collaborative and constructive, ensuring DRUIDS effectively meets the needs of KSBC.
