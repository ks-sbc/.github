# Troubleshooting Guide for Frequent DRUIDS (Obsidian) Issues

This guide is designed to help you identify and resolve common problems you might encounter while using DRUIDS, which is built upon Obsidian and various plugins. If you cannot resolve an issue using this guide, please escalate it to your mentor, a Cadre member, or the designated KSBC technical support.

## 1. Obsidian Startup Issues or Slow Performance

**Symptoms:**
*   Obsidian won't open.
*   Obsidian takes a very long time to load.
*   Obsidian is generally sluggish or unresponsive.

**Diagnostic Steps & Solutions:**

1.  **Restart Obsidian:** The simplest solution first! Close and reopen Obsidian.
2.  **Restart Your Computer:** This can resolve underlying system issues.
3.  **Check for Updates:**
    *   **Obsidian:** Go to `Settings` (gear icon) > `About`. Click "Check for updates."
        *   **Operator Variable:** If an update is available, **click** the update button.
    *   **Plugins:** Go to `Settings` > `Community plugins`. For each installed plugin, check if an update is available. It's generally good practice to keep plugins updated, but see "Plugin Conflicts" below.
4.  **Vault Size:** Very large vaults with numerous notes, images, or attachments can impact performance. While DRUIDS is designed for extensive information, extreme cases might cause slowdowns. Discuss with support if you suspect this.
5.  **Plugin Overload:** Too many active plugins, or a poorly optimized plugin, can slow Obsidian down.
    *   **Action:** Try disabling recently installed or updated plugins one by one to see if performance improves. Go to `Settings` > `Community plugins`, toggle off a plugin, and restart Obsidian.
6.  **Hardware Resources:** Ensure your computer meets Obsidian's minimum requirements and has sufficient free RAM and CPU resources. Close other resource-heavy applications.
7.  **Corrupted Vault Configuration (Rare):** If Obsidian fails to start for a specific vault, the vault's configuration files might be corrupted.
    *   **Action (Advanced - Seek help if unsure):** You might try opening a different vault or creating a new empty vault to see if Obsidian itself starts. If it does, the issue is likely specific to your DRUIDS vault configuration. Do *not* delete any files without guidance.

## 2. Plugin Conflicts or Plugin Not Behaving as Expected

**Symptoms:**
*   A feature that used to work suddenly stops.
*   Error messages appear related to a specific plugin.
*   Obsidian behaves erratically after installing/updating a plugin.

**Diagnostic Steps & Solutions:**

1.  **Check Plugin Settings:** Open the settings for the problematic plugin (`Settings` > `Community plugins` > find the plugin and click its gear icon or look for a dedicated settings tab). Ensure its configuration is correct.
2.  **Update Plugins:** Update the problematic plugin and any related plugins. Also, update Obsidian itself.
3.  **Disable Other Plugins:** Other plugins might conflict.
    *   **Action:** Temporarily disable all other community plugins except the one you're troubleshooting. Restart Obsidian. If the issue is resolved, re-enable other plugins one by one, restarting each time, until the conflict reappears. The last plugin enabled is likely the conflicting one.
        *   **Operator Variable:** The **act of toggling on/off** specific plugins.
4.  **Check Plugin Documentation/GitHub Issues:** Visit the plugin's official documentation or its GitHub repository. Look for known issues or troubleshooting tips.
5.  **Reinstall Plugin:**
    *   **Action:** Go to `Settings` > `Community plugins`. Uninstall the problematic plugin, then reinstall it. You might lose plugin-specific settings, so note them down first if complex.
6.  **Check Obsidian Console for Errors:**
    *   **Action:** Open the Developer Console (`Ctrl+Shift+I` on Windows/Linux, `Cmd+Option+I` on macOS, then go to the "Console" tab). Look for error messages in red. These can provide clues. Copy relevant error messages when asking for help.
        *   **Operator Variable:** The **specific error messages** you observe.

## 3. Git Synchronization Problems (e.g., Merge Conflicts, GitHub Authentication)

DRUIDS relies on Git for version control and synchronization.

**Symptoms:**
*   Changes not saving or syncing to the shared repository (GitHub).
*   Error messages related to "git," "pull," "push," or "merge."
*   "Merge conflict" notifications.
*   Authentication errors when Obsidian tries to connect to GitHub.

**Diagnostic Steps & Solutions:**

1.  **Check Internet Connection:** Ensure you are connected to the internet.
2.  **Obsidian Git Plugin Settings:**
    *   Open the settings for your Git plugin in Obsidian (e.g., "Obsidian Git").
    *   Verify the repository URL, branch name, and authentication details.
    *   **Authentication:** If using HTTPS, you might need to re-enter your GitHub Personal Access Token (PAT) or password. If using SSH, ensure your SSH key is correctly set up and added to your GitHub account.
        *   **Operator Variable:** Your **GitHub credentials (PAT or SSH key setup)**.
3.  **Pull Changes First:** Before pushing your changes, always try to pull changes from the remote repository to get the latest updates. Many Git plugins have a "Pull" button.
4.  **Resolve Merge Conflicts:**
    *   Merge conflicts happen when changes on the remote repository overlap with your local changes.
    *   Obsidian Git or other tools may offer a way to view and resolve these conflicts. This usually involves looking at the conflicting files (marked with `<<<<<<<`, `=======`, `>>>>>>>`) and choosing which version to keep or manually merging them.
    *   **Action:** If you are unsure how to resolve merge conflicts, **STOP** and ask for help from a Cadre member or someone experienced with Git. Incorrectly resolving conflicts can lead to data loss.
5.  **Commit Regularly:** Make small, frequent commits with clear messages. This makes it easier to pinpoint issues and manage conflicts.
6.  **Check GitHub Status:** Occasionally, GitHub itself might have issues. Check the [GitHub Status Page](https://www.githubstatus.com/).
7.  **Command Line Git (Advanced):** If comfortable with the command line, you can open a terminal or Git Bash in your local vault directory and use Git commands (`git pull`, `git push`, `git status`) to diagnose issues.
    *   **Operator Variable:** Specific **Git commands** and their output.

## 4. Issues with Applying or Creating Templates

**Symptoms:**
*   Templates are not appearing in the selection list.
*   Template content is not inserted correctly.
*   Errors when trying to use a template.

**Diagnostic Steps & Solutions:**

1.  **Check Template Plugin Settings:**
    *   Ensure the "Templates" or "Templater" plugin is enabled.
    *   Verify the configured "Template folder location." Make sure it points to the correct folder where your `.md` template files are stored (e.g., `Templates/`, `ks-sbc/public-repo/documentation/_templates/`).
        *   **Operator Variable:** The **folder path** set in the plugin settings.
2.  **Template File Existence and Name:** Double-check that the template file exists in the specified folder and that its name matches what you expect.
3.  **Template Syntax (Templater):** If using "Templater" with dynamic commands, ensure the syntax within the template file is correct. A small error can break it.
4.  **Permissions (if applicable):** If templates are in restricted L1/L2 areas, ensure you have the necessary vault/file system permissions.

## 5. Problems with Encryption/Decryption (gpg-encrypt Plugin or similar)

**Symptoms:**
*   Unable to encrypt files.
*   Unable to decrypt files (e.g., prompted for a password that doesn't work).
*   Error messages from the encryption plugin.

**Diagnostic Steps & Solutions:**

1.  **GPG Installation:** Ensure GPG (GNU Privacy Guard) is correctly installed on your system and accessible in your system's PATH. The encryption plugin relies on this.
2.  **Plugin Settings:** Check the settings of your encryption plugin (e.g., "gpg-encrypt").
    *   Verify the path to the GPG executable if it needs to be set manually.
    *   Ensure your GPG Key ID for encryption/decryption is correctly configured if the plugin requires it.
        *   **Operator Variable:** Your **GPG Key ID** or **recipient Key IDs**.
3.  **Correct Passphrase:** You MUST enter the correct passphrase for your GPG private key to decrypt files. There is no recovery for a lost GPG passphrase.
4.  **Recipient Public Keys:** To encrypt a file for others, you need their GPG public keys imported into your GPG keyring. Ensure you have the correct public keys for your intended recipients.
5.  **File Corruption:** If a file was not encrypted or decrypted properly, it might have become corrupted. Always keep backups of important unencrypted data until you are sure the workflow is solid.
6.  **Key Expiry/Revocation:** Check if your GPG key (or the recipient's key) has expired or been revoked.

## 6. Difficulties Finding Documents or Links Not Working

**Symptoms:**
*   Search doesn't return expected documents.
*   Wikilinks appear broken (e.g., different color, clicking doesn't navigate).

**Diagnostic Steps & Solutions:**

1.  **Search Scope:** Ensure your search query is correct and not too narrow or too broad. Check for typos. Try different keywords. (See `finding_and_linking_documents.md` tutorial).
2.  **File Indexing:** Obsidian needs to index your vault files to search them. This usually happens automatically. If search is consistently failing, try restarting Obsidian. In very rare cases, the index might need rebuilding (more advanced, seek help).
3.  **Link Syntax:** For wikilinks `[[My Document]]`:
    *   Ensure the filename inside the brackets exactly matches the target document's name (case sensitivity can matter depending on your OS).
    *   Avoid special characters in filenames that might interfere with linking.
4.  **File Moved or Renamed:** If a linked document was moved or renamed, links to it will break unless Obsidian automatically updated them. If you manually renamed a file outside of Obsidian, links will break. It's best to rename files within Obsidian to allow it to update links.
5.  **Restricted Access:** If a link points to a document in a higher security tier (e.g., an L0 document linking to L2), you won't be able to follow it unless you have L2 access. The link itself might appear, but navigation will fail.

## 7. Visual Glitches or Theme Issues

**Symptoms:**
*   Text is unreadable, colors are off.
*   Interface elements are misplaced.
*   Problems after changing a theme or installing a theme-related plugin.

**Diagnostic Steps & Solutions:**

1.  **Switch to Default Theme:** Go to `Settings` > `Appearance`. Under "Themes," select "Default." If this fixes the issue, the problem is with your custom theme.
2.  **Update Theme:** If using a custom theme, check if it has updates.
3.  **Disable Custom CSS Snippets:** If you've added custom CSS (`Settings` > `Appearance` > `CSS snippets`), try disabling them.
4.  **Check Theme/Plugin Compatibility:** A theme might conflict with a plugin that also tries to modify appearance. Try disabling appearance-related plugins.

## When to Ask for Help

If you've gone through these steps and are still experiencing issues:

*   **Collect Information:** Note down the exact symptoms, error messages (copy them if possible), what you were doing when the issue occurred, and the troubleshooting steps you've already tried.
*   **Reproduce the Issue:** If possible, try to reliably reproduce the problem. This helps in diagnosing it.
*   **Contact Support:** Reach out to your KSBC mentor, a Cadre member responsible for DRUIDS, or the designated technical support channel. Provide them with all the information you've collected.

Remember, keeping your Obsidian, plugins, and computer system updated is a good first step in preventing many common issues.
