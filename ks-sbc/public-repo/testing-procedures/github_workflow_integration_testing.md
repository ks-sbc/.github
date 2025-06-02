# Manual Test Plan: GitHub Workflow Integration for DRUIDS

**Purpose:** This document outlines the manual testing procedures for validating key GitHub Actions workflows integrated with the DRUIDS repositories. These tests ensure that automated processes are functioning correctly, supporting KSBC's collaboration, project management, and information handling protocols.

**Procedure:** This is a manual test plan. For each workflow test case:
1.  Ensure all prerequisites are met.
2.  Carefully follow the "Manual Trigger Simulation" steps.
3.  Observe the system and wait for the workflow to complete (time varies per workflow).
4.  Follow the "Verification Steps" to check for the "Expected Outcome."
5.  Mark "Pass" or "Fail" and add any relevant notes, especially for failures or unexpected behavior.

**Reporting Discrepancies:** If any workflow does not execute as expected or if outcomes differ, report the issue to the DRUIDS administration team or the KSBC technical lead. Include the workflow name, trigger, steps taken, expected outcome, actual outcome, and any error messages from GitHub Actions logs.

---

## Prerequisites for Testing

*   **Repository Access:** Tester must have appropriate permissions (e.g., write access, ability to create discussions/issues, manage labels) on the target GitHub repository where DRUIDS is hosted.
*   **GitHub Familiarity:** Tester should be familiar with GitHub UI for discussions, issues, pull requests, project boards, and viewing Actions logs.
*   **Sample Data:** Some tests may require creating sample discussions, issues, or branches with specific content or labels.
*   **Notifications:** Access to the notification system (e.g., email, Slack) if testing notification workflows.
*   **Patience:** GitHub Actions can take a few moments to trigger and run. Check the "Actions" tab in the GitHub repository for workflow progress.

---

## Test Environment:
*   **Target GitHub Repository:** ______________ (e.g., `ks-sbc/public-repo` or a test fork)
*   **Branch for Testing (if applicable):** ______________
*   **Tester:** ______________
*   **Date:** ______________

---

## GitHub Workflow Test Cases

*(Note: Specific workflow names, triggers, and expected outcomes should be aligned with the final implementation of KSBC's GitHub Actions. The following are examples based on the Phase 2.3 task list.)*

### 1. Workflow: Discussion-to-Issue Creation

*   **Purpose:** To automatically create a GitHub Issue from a new GitHub Discussion to ensure discussion points requiring action are formally tracked.
*   **Trigger:** A new Discussion is created in a specific category (e.g., "Proposals" or "Action Items"). Alternatively, a specific label (e.g., `create-issue`) is added to a discussion.
    *   *Clarify exact trigger mechanism with DRUIDS admin.*

| Test Step                      | Details                                                                                                                                                                                            | Result      | Notes                                       |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **1.1 Manual Trigger Simulation** | 1. Navigate to the "Discussions" tab in the GitHub repository. <br> 2. Create a new discussion in the designated category (e.g., "Proposals") with a title like "Test Discussion for Issue Creation" and some body content. <br> *OR* <br> 2b. If label-triggered, create a discussion and then add the specified label (e.g., `create-issue`). |             |                                             |
| **1.2 Expected Outcome**         | 1. A new GitHub Issue is automatically created. <br> 2. The Issue title should be derived from the Discussion title (e.g., "Discuss: Test Discussion for Issue Creation"). <br> 3. The Issue body should contain a link back to the original Discussion and potentially some of its content. <br> 4. The Issue might be assigned default labels (e.g., `needs-triage`, `from-discussion`). |             |                                             |
| **1.3 Verification Steps**       | 1. Go to the "Issues" tab of the repository. <br> 2. Look for the newly created issue. <br> 3. Open the issue and verify its title, body content (link to discussion), and any labels. <br> 4. Check the "Actions" tab for successful completion of the relevant workflow run. | `[ ] Pass` `[ ] Fail` |                                             |

### 2. Workflow: Project Board Automation (e.g., New Issue to "To Do")

*   **Purpose:** To automatically add new issues (or issues with specific labels) to a designated column on a KSBC project board.
*   **Trigger:** A new GitHub Issue is created, OR an issue is labeled with a specific tag (e.g., `project-alpha-candidate`).

| Test Step                      | Details                                                                                                                                                                                             | Result      | Notes                                       |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **2.1 Manual Trigger Simulation** | 1. Create a new GitHub Issue with a title like "Test Issue for Project Board." <br> *OR* <br> 1b. If label-triggered, create a new issue and then add the specified label (e.g., `project-alpha-candidate`). |             |                                             |
| **2.2 Expected Outcome**         | 1. The newly created (or labeled) issue automatically appears as a card in a specific column (e.g., "To Do," "Triage," or "Project Alpha Tasks") on the designated KSBC project board.             |             |                                             |
| **2.3 Verification Steps**       | 1. Navigate to the relevant GitHub Project board. <br> 2. Check the specified column for the new card representing the issue. <br> 3. Ensure the card details link back to the issue. <br> 4. Check "Actions" tab for workflow logs. | `[ ] Pass` `[ ] Fail` | *Specify Project Board & Column name.*      |

### 3. Workflow: Security Validation (e.g., Gitleaks, Markdown Linting)

*   **Purpose:** To automatically scan code/content for security vulnerabilities (like exposed secrets) or lint Markdown files for consistency upon commits/pull requests.
*   **Trigger:** A commit is pushed to any branch, or a Pull Request is opened/updated.

| Test Step                      | Details                                                                                                                                                                                                                                                                   | Result      | Notes                                       |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **3.1a Simulation (Secrets)**  | 1. Create a new branch locally. <br> 2. Add a new text file. In this file, add a line that looks like a fake secret (e.g., `AWS_ACCESS_KEY_ID=AKIAABCDEFGHIJKLMNOPQ`). <br> 3. Commit this file and push the branch to the GitHub repository. <br> 4. (Optional) Open a Pull Request from this branch. |             | *Use FAKE secrets for testing!*             |
| **3.1b Simulation (Linting)**  | 1. Create a new branch locally. <br> 2. Add/edit a Markdown file with intentional linting errors (e.g., incorrect heading levels, mixed list types, based on KSBC's linting rules). <br> 3. Commit and push the branch. <br> 4. (Optional) Open a Pull Request.                 |             |                                             |
| **3.2 Expected Outcome**         | **For Secrets:** <br> 1. The workflow run (e.g., Gitleaks) should FAIL. <br> 2. A status check on the commit/PR should indicate failure. <br> 3. Details of the failure (e.g., "secrets detected") should be in the workflow logs or PR checks. <br> **For Linting:** <br> 1. The workflow run (e.g., Markdown linter) should FAIL (or pass with warnings, depending on setup). <br> 2. Details of linting errors should be in logs/PR checks. |             |                                             |
| **3.3 Verification Steps**       | 1. Go to the "Actions" tab and find the relevant workflow run. Check its status and logs. <br> 2. If a PR was opened, check the "Checks" tab on the PR page for status. <br> 3. For Gitleaks, ensure no actual secrets were committed. Delete the test branch/file afterwards. | `[ ] Pass` `[ ] Fail` |                                             |

### 4. Workflow: Publication (e.g., L0 Document to Website/Wiki)

*   **Purpose:** To automatically publish specific L0 documents or content from the DRUIDS vault to a public-facing platform (e.g., a GitHub Pages site, a wiki).
*   **Trigger:** A commit is made to a specific folder (e.g., `ks-sbc/public-repo/L0_Publish/`) on a specific branch (e.g., `main` or `release`).

| Test Step                      | Details                                                                                                                                                                                                                           | Result      | Notes                                       |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **4.1 Manual Trigger Simulation** | 1. Ensure the target publication platform (e.g., GitHub Pages for the repo) is set up. <br> 2. Create/edit a Markdown file within the designated L0 publication folder (e.g., `L0_Publish/my_public_article.md`) with simple content. <br> 3. Commit this change directly to the trigger branch (e.g., `main`) or merge a PR with this change into the trigger branch. |             |                                             |
| **4.2 Expected Outcome**         | 1. The workflow runs successfully. <br> 2. The content from `my_public_article.md` is visible on the public platform (e.g., `https://ksbc.github.io/public-repo/my_public_article`). <br> 3. Formatting should be reasonably preserved. |             |                                             |
| **4.3 Verification Steps**       | 1. Check the "Actions" tab for successful workflow completion. <br> 2. Navigate to the public platform URL where the content is expected. <br> 3. Verify the content is present and correctly rendered. Allow a few minutes for propagation. | `[ ] Pass` `[ ] Fail` | *Specify exact publication path/URL.*       |

### 5. Workflow: Notification Systems (e.g., New L0 Announcement)

*   **Purpose:** To send notifications (e.g., email, Slack) when specific events occur, such as a new L0 announcement being published.
*   **Trigger:** A new file is added to a specific "Announcements" folder and committed to the `main` branch, OR a specific label like `notify-members` is added to an issue/discussion.

| Test Step                      | Details                                                                                                                                                                                                                                   | Result      | Notes                                       |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|---------------------------------------------|
| **5.1 Manual Trigger Simulation** | 1. Create a new Markdown file in the designated "Announcements" folder (e.g., `L0_Announcements/test_announcement.md`) with a message. <br> 2. Commit this file to the `main` branch. <br> *OR* <br> 2b. Add the `notify-members` label to a test issue. |             |                                             |
| **5.2 Expected Outcome**         | 1. The workflow runs successfully. <br> 2. A notification is received via the configured channel (e.g., test email address, specific Slack channel). <br> 3. The notification content should reflect the announcement or event.             |             |                                             |
| **5.3 Verification Steps**       | 1. Check the "Actions" tab for successful workflow completion. <br> 2. Check the target email inbox or Slack channel for the notification. <br> 3. Verify the content and timing of the notification.                                       | `[ ] Pass` `[ ] Fail` | *Requires access to notification channel.*    |

---

*(Add more workflow test cases as they are defined and implemented for DRUIDS.)*

**End of Test Plan**
