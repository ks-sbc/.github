# DRUIDS Security Policies and Procedures

This document outlines key security policies, proposed branch protection rules, and best practices for maintaining the integrity and security of the DRUIDS repository and its content.

## 1. Content Classification and Handling

As detailed in the `OBSIDIAN_INTEGRATION_GUIDE.md` and reflected in the repository's `/content` structure, all information within DRUIDS is classified into one of three security tiers:

-   **L0 (Public):** General membership materials, publicly accessible information.
    -   *Handling:* Suitable for public distribution. Ensure no L1 or L2 information is inadvertently placed here.
-   **L1 (Candidate):** Administrative functions, membership records, internal discussions not suitable for L0.
    -   *Handling:* Requires access control. Avoid inclusion in public communications. Exercise caution when referencing L1 materials.
-   **L2 (Cadre):** High-security operations, sensitive strategic discussions, cryptographic key information (though keys themselves should NOT be stored in this repo).
    -   *Handling:* Strict access control is paramount. Information should not be discussed or shared outside secure, authorized channels. Encryption for specific L2 documents within Obsidian is recommended (see GPG encryption workflows in DRUIDS plan).

**Key Security Reminders:**

*   **Verify Classification:** Always double-check the correct security classification for any new content you create or modify.
*   **Need-to-Know:** Adhere to the principle of need-to-know, especially for L1 and L2 information.
*   **Secure Communication:** Discuss sensitive (L1/L2) content only through approved secure channels. Do not use unsecured platforms (e.g., public GitHub comments on non-security-related issues) to discuss sensitive details.
*   **No Secrets in Git (Generally):** Do not commit actual secrets (passwords, API keys, private cryptographic keys) directly into the Git repository. Use appropriate secret management tools or methods as defined by KSBC operational security. For L2 documents requiring encryption, the *encrypted files* may be versioned, but not the keys.

## 2. Proposed GitHub Branch Protection Rules

To protect the integrity of the main codebase and ensure changes are reviewed, the following branch protection rules are proposed for the `main` branch (and any other long-lived protected branches, e.g., `develop` if used):

*   **Require a pull request before merging:**
    *   All changes must be made via a pull request (PR). Direct pushes to `main` should be disabled.
*   **Require status checks to pass before merging:**
    *   If/when automated tests or linting (e.g., via GitHub Actions) are implemented, these must pass.
    *   `[Placeholder: List specific status checks once implemented]`
*   **Require review from Code Owners / Designated Reviewers:**
    *   PRs should require at least one (preferably two for significant changes) approvals from designated reviewers or code owners before merging.
    *   `[Placeholder: Define Code Owner/Reviewer roles and responsibilities, possibly linking to a CODEOWNERS file if used]`
*   **Dismiss stale pull request approvals when new commits are pushed:**
    *   If new changes are pushed to a PR, previous approvals should be dismissed to ensure the latest changes are reviewed.
*   **Require signed commits:**
    *   (Consideration for enhanced security) All commits merged into `main` should be signed with a GPG key tied to a verified contributor identity. This is part of the DRUIDS hardware key integration plan.
*   **Include administrators:**
    *   Enforce these rules for repository administrators as well.

*(Note: These rules need to be manually configured in the GitHub repository settings under "Branches".)*

## 3. Pull Request (PR) Security Review Best Practices

When reviewing PRs, especially those modifying L1/L2 content, security configurations, or workflows:

*   **Verify Content Classification:** Ensure new or modified content is appropriately classified and stored in the correct security tier folder.
*   **Check for Data Leakage:** Scrutinize changes for any accidental inclusion of higher-tier information into lower-tier documents or public-facing files (like documentation).
*   **Assess Dependency Changes:** If PRs update dependencies (e.g., for GitHub Actions workflows), consider the security implications of these new dependencies.
*   **Validate Workflow Changes:** For changes to GitHub Actions or other automation, ensure they do not introduce security vulnerabilities (e.g., overly permissive execution rights, exposure of secrets).

## 4. Incident Response (High-Level)

**[Placeholder: Incident Response Plan]**

*(This section will be developed to outline basic steps to take in case of a suspected security breach, data leakage, or vulnerability discovery. It should include who to contact and initial containment steps.)*

---

This document is subject to updates as DRUIDS and KSBC operational security practices evolve. All members are expected to be familiar with and adhere to these policies.
