# Guide: Offline Installation of Obsidian Community Plugins (for Tails OS and Air-Gapped Environments)

## 1. Introduction

### Purpose of This Guide
This guide provides a step-by-step procedure for manually downloading and installing Obsidian community plugins in environments with limited or no internet connectivity, such as Tails OS (when direct online installation is problematic) or fully air-gapped systems.

### Benefits
*   **Enhanced Security:** Allows for plugin installation in isolated environments where direct internet access is undesirable or restricted.
*   **Controlled Updates:** Gives you full control over when and how plugins are updated.
*   **Verification (Optional):** Enables a workflow where plugins can be downloaded and potentially vetted on a trusted machine before being transferred.

### Core Principle: Secure File Transfer
The fundamental principle is to download the necessary plugin files from their official source on an internet-connected machine (Machine A) and then securely transfer them to the offline or air-gapped machine (Machine B) where Obsidian is running.

### Security Warning
*   **Download Only from Official Sources:** Always download plugin files directly from the plugin's official GitHub repository releases page. Avoid third-party download sites.
*   **Trust:** You are responsible for trusting the plugin developer and the plugin's code. Offline installation bypasses Obsidian's built-in community plugin browser's direct link to these sources but does not change the trust model for the plugin code itself.

## 2. Prerequisites

*   **Machine A:** An internet-connected computer (e.g., your regular OS) where you can download files.
*   **Machine B:** The offline or air-gapped system where Obsidian is installed (e.g., Tails OS, a dedicated offline computer).
*   **Secure Transfer Medium:** A USB flash drive or other removable media that you trust for transferring files between Machine A and Machine B.
*   **Obsidian Installed on Machine B:** Obsidian must already be installed and functional on the target offline system.
*   **Knowledge of Plugin ID:** You need to know the unique ID of the plugin you want to install. This is usually the repository name or a specific `id` field within the plugin's `manifest.json` file. For example, the `obsidian-git` plugin has the ID `obsidian-git`.

## 3. Step-by-Step Procedure

### Part I: On Machine A (Internet-Connected Computer)

1.  **Identify Plugin & Its Official GitHub Repository:**
    *   Find the plugin you want in the Obsidian Community Plugins list (either in Obsidian on an online machine or via the [Obsidian Plugins website](https://obsidian.md/plugins)).
    *   Locate its official GitHub repository link (usually provided by the plugin author).
2.  **Download Plugin Release Files:**
    *   Navigate to the GitHub repository for the plugin.
    *   Go to the "Releases" section (usually on the right-hand sidebar).
    *   Download the latest compatible release files. Typically, these are:
        *   `main.js` (the main plugin code)
        *   `manifest.json` (contains plugin metadata like ID, version, author)
        *   `styles.css` (if the plugin has custom styling)
    *   Some plugins might package these into a `.zip` file. If so, download the `.zip` file.
3.  **(Optional but Recommended) Verify Checksums:**
    *   Some plugin developers provide checksums (e.g., SHA256) for their release files. If available, verify the downloaded files against these checksums on Machine A to ensure integrity.
4.  **Prepare Plugin Folder on Transfer Medium:**
    *   On your USB drive (or other transfer medium), create a new folder.
    *   **Crucial:** This folder **must be named *exactly* the plugin's official ID.**
        *   To find the exact ID, if you downloaded a `.zip` file, extract it. Open the `manifest.json` file in a text editor. Look for the `"id": "plugin-id-here",` line. The value here is the correct folder name.
        *   For example, if `manifest.json` contains `"id": "obsidian-sample-plugin"`, then name your folder `obsidian-sample-plugin`.
    *   If you downloaded individual files (`main.js`, `manifest.json`, `styles.css`): Copy these directly into the correctly named `plugin-id` folder on the USB drive.
    *   If you downloaded a `.zip` file: Extract its contents. Ensure the `main.js`, `manifest.json`, etc., are directly inside the `plugin-id` folder (not in an additional subfolder that might have been created during extraction, e.g., `plugin-name-1.0.0/plugin-id/`).

### Part II: Securely Transfer Files

1.  **Safely Eject Transfer Medium:** Once all files are copied, safely eject the USB drive from Machine A.
2.  **Move to Machine B:** Physically move the USB drive to your offline/air-gapped system (Machine B, e.g., your Tails OS environment).
3.  **Security Note on USB Hygiene:**
    *   Use a USB drive that you trust and ideally dedicate for such transfers to minimize the risk of malware cross-contamination, especially if Machine A is not as hardened as Machine B.
    *   Consider wiping or reformatting the USB drive after use if transferring between systems of different trust levels. **Ensure any data you need from it is backed up elsewhere first.**

### Part III: On Machine B (Tails OS / Air-Gapped System)

1.  **Access Your Vault's Plugins Directory:**
    *   Navigate to your Obsidian vault's configuration directory. This is a hidden folder named `.obsidian` located in the root of your vault.
    *   Inside `.obsidian`, there should be a folder named `plugins`.
    *   **Example Path in Tails OS (if vault is in Persistent Storage):**
        `~/Persistent/MyVaults/YourVaultName/.obsidian/plugins/`
        (**Operator Variable:** Replace `MyVaults/YourVaultName` with the actual path to your vault).
2.  **Create `plugins` Directory (If It Doesn't Exist):**
    *   **Operator Action:** If the `plugins` folder is not present inside `.obsidian`, create it now.
        ```bash
        # In Terminal, navigate to your vault root first
        # cd ~/Persistent/MyVaults/YourVaultName/
        mkdir -p .obsidian/plugins/
        ```
3.  **Close Obsidian (Strongly Recommended):** Ensure Obsidian is fully closed on Machine B before adding or modifying plugin files. This helps Obsidian recognize new plugins correctly on next launch.
4.  **Copy Plugin Folder from USB:**
    *   Mount/access your USB drive on Machine B.
    *   Copy the entire `plugin-id` folder (e.g., the `obsidian-sample-plugin` folder you prepared) from the USB drive into the `plugins` directory within your vault's `.obsidian` folder.
    *   The final structure should look like: `YourVaultName/.obsidian/plugins/plugin-id-here/main.js` (and other files).
5.  **Safely Eject Transfer Medium:** Once copied, safely eject/remove the USB drive.
6.  **Start Obsidian.**
7.  **Enable the Plugin:**
    *   Go to **Settings** (gear icon).
    *   Navigate to **Community plugins**.
    *   You should see your newly copied plugin in the list. It will likely be disabled by default.
    *   Toggle the switch next to the plugin name to **enable it**.

## 4. Verifying Successful Installation

*   **Check Plugin Settings:** Once enabled, the plugin might have its own settings pane under "Community plugins" or in a dedicated section in Obsidian's settings. Check if these are accessible.
*   **Test Functionality:** Try using the core features of the plugin as described in its documentation.
*   **Consult Plugin's README:** The plugin's `README.md` file (often included in the downloaded files or visible on its GitHub page) usually contains specific instructions or troubleshooting tips.
*   **Obsidian Developer Console:** If issues arise, you can check the Obsidian Developer Console (usually `Ctrl+Shift+I` or `Cmd+Option+I`, then go to the "Console" tab) for error messages.

### Troubleshooting Common Issues
*   **Plugin not appearing in Obsidian's Community Plugins list after copying files:**
    *   Ensure Obsidian was fully **restarted** after copying the plugin files and before checking the list.
    *   Double-check that the plugin folder name under `.obsidian/plugins/` **exactly matches the plugin's `id`** from its `manifest.json` (this is case-sensitive).
    *   Verify that `main.js` and `manifest.json` are directly inside the `plugin-id` folder, not in an additional subfolder (e.g., if you extracted `plugin-archive.zip` and it created `plugin-archive/plugin-id/...`, you need to copy the `plugin-id` folder itself).
*   **Plugin enabled but not working:**
    *   Check if the plugin has unmet dependencies (see Section 6).
    *   Consult the plugin's official documentation (README on GitHub) for specific issues, required settings, or commands.
    *   Look for errors in the Obsidian Developer Console.

## 5. Updating Offline Plugins

Updating a manually installed plugin follows a similar process:

1.  **On Machine A:** Download the new release files (`main.js`, `manifest.json`, `styles.css`, or `.zip`) for the updated version from the plugin's official GitHub repository. Verify the plugin ID from the new `manifest.json`.
2.  **Prepare Plugin Folder:** On your USB drive, it's often cleanest to delete the old `plugin-id` folder and create a new one with the new files. Alternatively, carefully replace all files within the existing `plugin-id` folder with the updated versions. Ensure the new `manifest.json` (with the updated version number) is present.
3.  **Securely Transfer Files** to Machine B.
4.  **On Machine B:**
    *   **Close Obsidian (Strongly Recommended).**
    *   Navigate to `YourVaultName/.obsidian/plugins/`.
    *   **Replace the existing `plugin-id` folder** with the updated `plugin-id` folder from your USB drive.
    *   **Start Obsidian.** The updated plugin should now be active. You might need to re-enable it if it became disabled or if Obsidian prompts you.

## 6. Handling Plugin Dependencies

*   Some Obsidian plugins may depend on other community plugins to function correctly.
*   **Check Plugin Documentation:** The plugin's `README.md` or GitHub page should list any dependencies.
*   If dependencies exist, you must **install those dependency plugins offline first** using the same procedure described in this guide before installing or updating the main plugin that requires them.

## 7. Important Security Considerations for Offline Installation

*   **Source Trust:**
    *   **Only download plugins from their official GitHub repositories.** Verify the URL carefully. Do not download from unofficial sources or forums directly.
*   **Transfer Medium Integrity:**
    *   Use a USB drive that you trust and that is known to be clean of malware.
    *   Consider dedicating a USB drive solely for transfers to air-gapped or highly secure systems.
*   **No Automatic Updates or Vetting by Obsidian:**
    *   When you install plugins manually, you bypass Obsidian's mechanisms for checking for updates or potential issues flagged by the community (though such vetting is also limited for community plugins).
    *   **User Responsibility:** You are responsible for periodically checking the plugin's GitHub repository for updates, bug fixes, and any reported security issues.
*   **Review Plugin Code (Advanced):**
    *   For maximum security in highly sensitive environments, those with the capability can review the plugin's source code (downloaded from GitHub) before transferring and installing it. This is an advanced step and requires JavaScript/TypeScript knowledge.

By following these procedures carefully, you can manage Obsidian plugins effectively in offline and security-conscious environments like Tails OS. Always prioritize the integrity of your download sources and transfer media.
