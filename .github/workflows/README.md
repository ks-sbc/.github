# GitHub Actions Workflows for DRUIDS Project

This directory contains GitHub Actions workflows designed to automate various aspects of the DRUIDS project, focusing on democratic centralist processes, document management, and security.

## Workflows

1.  **`discussion-to-issue.yml`**:
    *   **Purpose:** Automatically creates a GitHub Issue from a GitHub Discussion when the discussion is labeled with `promote-to-issue`.
    *   **Outputs:** A new issue labeled `from-discussion` and `needs-triage`.
    *   **Notifications (Slack):** On successful issue creation.
    *   **Setup:** Requires the `promote-to-issue` label to be created in the repository.

2.  **`link-validation.yml`**:
    *   **Purpose:** Checks for broken internal and external links in markdown files.
    *   **Triggers:** On pull requests (checks changed files) and pushes to main branches (checks all files).
    *   **Outputs:** Fails if broken links are found. Uses Lychee Link Checker.
    *   **Notifications (Slack):** On link validation failure.
    *   **Setup:** Consider creating a `.lycheerc` file in the repository root for advanced Lychee configurations (e.g., excluding links). This workflow does not check Obsidian-style `[[wikilinks]]` without preprocessing.

3.  **`project-board-mgmt.yml`**:
    *   **Purpose:** Automatically moves issues on a specified GitHub Project (V2) board based on their labels or status (closed/reopened).
    *   **Outputs:** Updates issue status on the project board.
    *   **Notifications (Slack):** On failure to update the project board.
    *   **CRITICAL SETUP:** This workflow requires manual configuration of several Node IDs directly in the YAML file's `env` section:
        *   `PROJECT_NODE_ID`: The Node ID of your target GitHub Project.
        *   `STATUS_FIELD_NODE_ID`: The Node ID of the "Status" field within that project.
        *   `OPTION_ID_TRIAGE`, `OPTION_ID_BACKLOG`, etc.: The Option IDs for each value of your "Status" field.
        *   *Refer to GitHub's GraphQL API or UI inspection tools to obtain these IDs.*

4.  **`publish-docs.yml`**:
    *   **Purpose:** Publishes approved L0 documents to GitHub Pages and creates a Git tag.
    *   **Triggers:** When a Pull Request with the label `status:approved-for-publication` is merged into the `main` branch (or other configured L0 source branch).
    *   **Outputs:** Deploys content from a specified directory (default: `./content/L0_public/`) to the `gh-pages` branch and creates a tag like `pub/L0/pr<PR_NUMBER>-<TIMESTAMP>`.
    *   **Notifications (Slack):** On successful publication and on publication failure.
    *   **Setup:**
        *   Customize the L0 source branch, approval label, and content directory in the workflow file if defaults are not suitable.
        *   Ensure your repository settings are configured for GitHub Pages if using that feature (e.g., deploying from the `gh-pages` branch).

5.  **`security-validation.yml`**:
    *   **Purpose:** Validates that documents in Pull Requests do not have a security classification higher than allowed for the target branch. Uses the `.github/scripts/validate_classifications.py` script.
    *   **Triggers:** On pull requests to `main`, `L1-internal`, `L2-secure` (or other configured protected branches).
    *   **Outputs:** Fails if classification violations are found.
    *   **Notifications (Slack):** On validation failure.
    *   **Setup:**
        *   Ensure branch names in the workflow trigger match your repository's protected/tiered branches.
        *   Documents should use a `classification_level: LX` (e.g., `L0`, `L1`, `L2`) field in their YAML frontmatter. Files without this field or with unknown values default to L0.

## Common Setup for Notifications

Most workflows include Slack notifications. To enable these:
1.  Create a Slack Incoming Webhook URL for your workspace.
2.  Add this URL as a repository secret named `SLACK_WEBHOOK_URL`.

## Helper Scripts

*   **`.github/scripts/validate_classifications.py`**:
    *   Used by `security-validation.yml` to parse frontmatter and check document classification levels.
    *   Requires `PyYAML` (installed by its parent workflow).

Please review each workflow file for specific TODO comments regarding customization (e.g., branch names, paths, labels).
