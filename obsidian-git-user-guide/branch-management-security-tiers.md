## Branch Management Strategy for Security Tiers

When managing notes with varying levels of sensitivity within a single Obsidian vault, a robust branch management strategy is crucial. This strategy helps prevent accidental exposure of sensitive information and allows for controlled collaboration. This guide outlines a tier-based branching model using Obsidian-Git.

### 1. Core Principles

This strategy revolves around the following core principles:

1.  **Branch per Tier:** Each distinct security or sensitivity level will have its own dedicated Git branch.
2.  **Default to Lowest Tier:** The vault should typically default to the lowest sensitivity tier branch (e.g., `main` for public/unclassified information). This minimizes the risk of accidentally committing sensitive information to a less secure branch.
3.  **Conscious Switching:** Moving to a higher sensitivity tier branch requires a deliberate, conscious action by the user.
4.  **No Direct Merge Down of Sensitive Information:** Information from a higher sensitivity branch (e.g., `L2-secure`) should *never* be directly merged into a lower sensitivity branch (e.g., `L1-internal` or `main`). If information needs to be declassified, it must be done manually by copying and pasting, ensuring no sensitive remnants remain.
5.  **Optional Feature Branches:** For complex changes within a specific tier, users can create temporary feature branches off their current tier branch (e.g., `L1-internal-feature-x`). These should be merged back into their parent tier branch upon completion.

### 2. Tier Branch Details

Here's a breakdown of the recommended branches:

#### `main` (L0 - Public/Unclassified)

*   **Purpose:** This branch is for notes and information that are considered public, unclassified, or safe for general sharing. It's the default branch your vault should be on most of the time.
*   **Typical Obsidian-Git Workflow:**
    *   Automatic commits and pushes can be safely enabled for this branch.
    *   Regular synchronization with the remote `main` branch.
*   **Collaboration Notes:**
    *   Suitable for open collaboration.
    *   Changes made here can be freely shared.
    *   If collaborating, ensure all collaborators understand this is the public tier.

#### `L1-internal` (L1 - Internal Use Only)

*   **Purpose:** This branch is for notes containing information that is not for public release but is suitable for internal team members or personal private use. This might include internal project details, meeting notes not meant for external eyes, or drafts of documents before they are sanitized for public release.
*   **Explicit Switching Workflow with Obsidian-Git:**
    1.  **Before Switching:**
        *   Ensure all changes on your current branch (e.g., `main`) are committed or stashed. Use the Obsidian-Git "Commit all changes" or "Commit staged changes" command.
        *   Verify your current branch status using the Obsidian-Git status bar or `git status` command.
    2.  **Switch Branch:** Use the Obsidian-Git command palette (Ctrl/Cmd+P) to search for and select "Obsidian Git: Checkout branch" and choose `L1-internal`.
    3.  **After Switching:**
        *   Verify you are on the `L1-internal` branch.
        *   Pull the latest changes for `L1-internal` from the remote to ensure your local branch is up-to-date before making new commits: "Obsidian Git: Pull".
*   **Crucial Pre/Post Switching Commit Discipline:**
    *   **ALWAYS commit or stash pending changes on your current branch BEFORE switching to `L1-internal`**. Failure to do so can result in unclassified changes being accidentally brought into the `L1-internal` branch or vice-versa.
    *   **ALWAYS commit your `L1-internal` changes BEFORE switching back to `main` (or any other branch)**.
*   **Auto-Commit/Push Considerations:**
    *   **Auto-Commit:** Can be useful, but ensure the commit message for auto-backups is generic enough (e.g., `"chore: L1 internal sync"`).
    *   **Auto-Push:** Exercise caution. If you frequently switch branches, you might prefer to manually push changes on `L1-internal` to have more control and avoid accidentally pushing incomplete or sensitive work prematurely. If auto-push is enabled globally, consider temporarily disabling it when working on `L1-internal` if this is a concern (see "Plugin Limitations" below).
*   **Collaboration Notes:**
    *   Suitable for collaboration with trusted internal team members.
    *   Ensure collaborators are aware they are on the `L1-internal` branch and understand its sensitivity level.
    *   The remote repository for `L1-internal` should have access controls limiting it to authorized personnel.

#### `L2-secure` (L2 - Highly Sensitive)

*   **Purpose:** This branch is for notes containing highly sensitive, confidential, or restricted information. Access should be strictly controlled. This could include personal identifiable information (PII), trade secrets, critical security information, etc.
*   **Explicit Switching Workflow:**
    *   Follow the same rigorous pre/post switching commit discipline as with `L1-internal`.
    *   The commands are the same: "Obsidian Git: Checkout branch" to `L2-secure`, and "Obsidian Git: Pull" after switching.
*   **Extreme Care Notes (Commit Discipline):**
    *   **Meticulous attention to detail is paramount.** Double-check the current branch before every commit.
    *   Ensure no uncommitted changes from lower tiers are accidentally carried over.
    *   Before pushing, review the changes staged for commit very carefully.
*   **Recommendations for Auto-Push:**
    *   **Strongly Recommended: Disable global auto-push** if you use this tier.
    *   **Always use manual push** for the `L2-secure` branch. This provides a final checkpoint to ensure only intended information is transmitted.
    *   Automatic commits can still be used locally, but the push to the remote should be a deliberate manual action.
*   **Collaboration Notes:**
    *   Collaboration on this tier should be minimal and only with individuals who absolutely require access.
    *   All collaborators must be thoroughly trained on the handling procedures for this level of data.
*   **Stricter Remote Repository Access Controls:**
    *   The remote repository hosting the `L2-secure` branch (if pushed at all) MUST have highly restrictive access controls. This might involve separate private repositories, branch protection rules, and multi-factor authentication for all users with access. Consider if this tier should even have a remote, or if it should remain local-only or pushed to a highly secured, air-gapped, or end-to-end encrypted storage.

### 3. Implementation Notes & Considerations

*   **Potential Plugin Limitations (Global Auto-Sync):**
    *   Obsidian-Git's auto-sync settings (backup interval, auto-pull, auto-push) are typically global. This means if auto-push is enabled, it will attempt to push *any* branch you are currently on after a commit.
    *   **Mitigation for L1/L2:**
        *   **Manual Push:** The simplest approach is to disable global auto-push in Obsidian-Git settings and manually push changes for `L1-internal` and `L2-secure` using the "Obsidian Git: Push" command.
        *   **Temporary Disable:** If you prefer to keep auto-push for `main`, you could temporarily disable the "Auto Push on interval" setting before switching to `L1-internal` or `L2-secure`, and re-enable it when switching back to `main`. This is more cumbersome and error-prone.
*   **Importance of User Training:**
    *   All users of the vault must be trained on this branching strategy.
    *   Key training points:
        *   Always commit (or stash) changes before switching branches.
        *   Always verify the current active branch before committing sensitive information (Obsidian's status bar usually shows the current Git branch if the plugin is active).
        *   Understand the sensitivity level of each branch.
*   **The Role of `.gitignore`:**
    *   Utilize a comprehensive `.gitignore` file to prevent common Obsidian files (cache, workspace settings if not shared, etc.) and any OS-specific files (e.g., `.DS_Store`, `thumbs.db`) from being committed to any branch.
    *   You might also consider `.gitignore` for specific large files or temporary files that don't need to be versioned within any security tier.
*   **Handling Accidental Commits:**
    *   Mistakes can happen. If sensitive information is accidentally committed to the wrong branch (e.g., L1 data to `main`):
        *   **Do NOT push the change if it hasn't been pushed yet!**
        *   A detailed procedure for remediating such incidents (e.g., using `git reset`, `git rebase -i`, or filtering branch history) should be documented and understood by users. This is a more advanced Git topic and will be covered in a separate "Incident Response" section (placeholder). For now, the immediate action is to avoid pushing and seek help if unsure.
*   **Future Security Enhancements (Forward Reference):**
    *   For `L1-internal` and especially `L2-secure` branches, consider implementing additional security measures:
        *   **Signed Commits:** Use GPG keys to sign commits, verifying the author's identity. Obsidian-Git may have settings to enable this if your Git environment is configured for it.
        *   **Hardware Keys:** For ultimate security on `L2-secure` pushes, consider requiring hardware security keys (like YubiKey) for signing commits or authenticating to the remote repository.

---

This branch management strategy provides a framework for handling notes of varying sensitivity. Its effectiveness relies on user diligence, proper configuration, and awareness of the potential risks and mitigation techniques. Always prioritize the security of sensitive information.
