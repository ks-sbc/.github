# DRUIDS Plugin Update and Compatibility Testing Procedures

**Document Version:** 1.0
**Date:** YYYY-MM-DD

## 0. Table of Contents
1.  Introduction
2.  Pre-Update Checklist
3.  Update Process (General)
4.  Compatibility Testing Steps (Post-Update)
5.  Rollback Procedure
6.  Documenting Updates
7.  Frequency of Updates
8.  Roles and Responsibilities

## 1. Introduction

Plugins extend the functionality of DRUIDS (Obsidian) significantly. Keeping them updated is important for accessing new features, performance improvements, and crucial security patches. However, updates can sometimes introduce compatibility issues with other plugins, themes, or custom configurations.

This document outlines procedures for updating plugins and performing compatibility testing to minimize disruption and ensure the continued stability and functionality of DRUIDS for KSBC.

## 2. Pre-Update Checklist

Before updating any plugin(s):

1.  **[ ] Backup Obsidian Vault Configuration:**
    *   **Action:** Create a complete backup of your local DRUIDS vault, **especially the `.obsidian` folder**. This folder contains your Obsidian configuration, including plugin settings, themes, snippets, and workspace layouts.
    *   **Method:** Copy the entire vault folder to a safe external location or use your system's backup tools. For the `.obsidian` folder, ensure hidden files are included in the copy.
    *   **Importance:** This is critical for rollback if an update causes major issues.

2.  **[ ] Check Plugin Changelogs:**
    *   **Action:** For each plugin you intend to update, review its changelog. This can usually be found on the plugin's page in the Obsidian Community Plugins browser or on its GitHub repository.
    *   **Look For:** Breaking changes, major feature additions, known issues, or dependencies on other plugins/Obsidian versions.

3.  **[ ] Identify Critical Plugins:**
    *   **Action:** Be aware of plugins that are essential for core DRUIDS functionality (e.g., Obsidian Git, Dataview, Templater, GPG-Encrypt, security-related plugins). These require more careful testing post-update.

4.  **[ ] Inform Users (If a Major Update Cycle):**
    *   If planning a large batch of updates or updating a critical plugin, consider informing DRUIDS users of a potential brief maintenance/testing window.

5.  **[ ] Ensure Stable Internet Connection:**
    *   Required for downloading plugin updates.

## 3. Update Process (General)

1.  **Check for Updates within Obsidian:**
    *   Navigate to `Obsidian Settings` (gear icon) > `Appearance`. Ensure "Community plugins" is enabled.
    *   Go to `Community plugins`. Obsidian will automatically check for updates for installed plugins.
    *   A list of plugins with available updates will be shown with an "Update" button next to each.
    *   `[SCREENSHOT: Obsidian Community Plugins settings page showing plugins with available updates.]`

2.  **Update Plugins:**
    *   **Recommended Approach:** Update plugins **one by one, or in small, related batches** (e.g., a theme and theme-related plugins). Avoid updating all plugins simultaneously, as this makes it harder to identify the source of any potential issues.
    *   Click the "Update" button next to the plugin you wish to update.
    *   Obsidian will download and install the update. It may require a restart of Obsidian to take full effect (Obsidian usually prompts if so).

## 4. Compatibility Testing Steps (Post-Update)

After updating a plugin (or a small batch), perform targeted testing to ensure compatibility and correct functionality.

1.  **Restart Obsidian:** Even if not prompted, it's good practice to restart Obsidian after an update.

2.  **Basic Functionality Check:**
    *   Ensure Obsidian loads without errors.
    *   Check that the updated plugin appears in the "Community plugins" list and is enabled.
    *   Briefly navigate DRUIDS, open a few notes, and check for any obvious visual glitches or errors in the console (`Ctrl+Shift+I` or `Cmd+Option+I`).

3.  **Targeted Plugin Testing:**
    *   Focus on the functionality of the *updated plugin(s)* and any workflows that heavily rely on it.
    *   **Refer to Specific Test Plans:**
        *   For core functionality and settings of critical plugins: `[[../testing-procedures/plugin_configuration_validation.md]]`. Execute relevant sections for the updated plugin(s).
        *   If the plugin impacts document creation or content (e.g., Templater, QuickAdd): `[[../testing-procedures/document_template_validation.md]]`. Test key templates.
    *   **Examples:**
        *   **If Templater is updated:**
            *   Test creating new documents from several key KSBC templates (e.g., Meeting Minutes, Project Proposal).
            *   Verify that frontmatter is correctly populated (dates, user prompts if any).
            *   Check if boilerplate content is inserted as expected.
        *   **If Obsidian-Git is updated:**
            *   Perform a test commit.
            *   Perform a test push to the remote repository.
            *   Perform a test pull from the remote repository.
            *   Ensure no authentication errors occur.
        *   **If Dataview is updated:**
            *   Open notes containing important Dataview queries (e.g., TPPS tracking dashboards, task lists).
            *   Verify that queries execute correctly and display expected results.
        *   **If GPG-Encrypt is updated:**
            *   Test encrypting a sample file.
            *   Test decrypting a sample file.
            *   Verify that passphrase prompts work correctly.
        *   **If a Theme is updated:**
            *   Check overall UI appearance.
            *   Verify that custom CSS snippets (if any) still work as expected.
            *   Check visual cues for security classifications.

4.  **Test Key Workflows:**
    *   Perform a quick run-through of 1-2 critical end-to-end workflows relevant to the updated plugin(s). For example, if a task management plugin is updated, try creating, updating, and completing a task.

## 5. Rollback Procedure

If a plugin update introduces critical issues (e.g., data loss, inability to use core features, widespread errors):

1.  **Identify the Problematic Plugin:** If multiple plugins were updated, try to isolate which one caused the issue by disabling them one by one (starting with the most recently updated).
2.  **Disable the Plugin:** Go to `Settings` > `Community plugins` and toggle off the problematic plugin. Restart Obsidian.
3.  **Restore Vault Configuration (Primary Method):**
    *   Close Obsidian.
    *   Delete or rename the current `.obsidian` folder within your local DRUIDS vault.
    *   Restore the `.obsidian` folder from the backup you created in the "Pre-Update Checklist."
    *   Re-open Obsidian. This should revert plugin versions and their settings to the pre-update state.
4.  **Manually Reinstalling an Older Version (Difficult):**
    *   Obsidian's plugin browser does not easily allow downgrading. This typically involves manually finding an older release of the plugin (e.g., from its GitHub releases page), downloading its files (`main.js`, `manifest.json`, `styles.css`), and replacing the files in your vault's `.obsidian/plugins/<plugin-name>/` directory. This is an advanced procedure and should be done with caution.
    *   **Priority should be given to restoring the `.obsidian` folder from backup.**
5.  **Report the Issue:** Inform the DRUIDS administration and KSBC technical lead about the problematic plugin and the steps taken.

## 6. Documenting Updates

Maintain a log of plugin updates for the DRUIDS system. This can be a simple Markdown file within a protected (e.g., L2) section of DRUIDS.

*   **Log Entry Should Include:**
    *   Date of update.
    *   Plugin Name(s) and Version(s) (Old -> New).
    *   Updater's Name.
    *   Summary of testing performed (e.g., "Tested Templater with Meeting Minutes and Project Proposal templates - Pass").
    *   Any issues encountered and their resolution.
    *   Link to relevant GitHub issue if one was created for the plugin developer.

## 7. Frequency of Updates

*   **Minor/Patch Updates (Non-Critical Plugins):** Can be checked and applied periodically (e.g., monthly or bi-monthly) by designated personnel, followed by basic compatibility checks.
*   **Major Updates or Critical Plugin Updates:** Should be planned, potentially with a dedicated maintenance window. These require more thorough testing as outlined above.
*   **Security Updates:** Any plugin update that addresses a known security vulnerability should be prioritized and applied as soon as possible, followed by rigorous testing.

Consult with the DRUIDS administration team for KSBC's specific update schedule.

## 8. Roles and Responsibilities

*   **DRUIDS Administrator / Technical Lead:**
    *   Oversees the plugin update strategy and schedule.
    *   Performs or delegates the update and testing process for critical plugins.
    *   Maintains the plugin update log.
    *   Investigates and resolves compatibility issues.
    *   Communicates significant changes or issues to KSBC members.
*   **Designated Testers (Optional):**
    *   May include Cadre members or technically proficient Candidates who can assist in testing specific plugin functionalities after updates.
*   **All Users:**
    *   Report any unexpected behavior or issues encountered after becoming aware of recent plugin updates.

---

By following these procedures, KSBC can maintain a stable, secure, and functional DRUIDS environment while benefiting from the improvements and features offered by plugin updates.
