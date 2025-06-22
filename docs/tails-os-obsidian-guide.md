# Guide: Setting Up and Using Obsidian on Tails OS for Enhanced Privacy and Security

## 1. Introduction

### Purpose of This Guide
This guide provides step-by-step instructions for downloading, installing, configuring, and using Obsidian on the Tails (The Amnesic Incognito Live System) operating system. The primary goal is to leverage Tails' privacy and security features while using Obsidian for note-taking and knowledge management.

### Benefits of Using Obsidian on Tails
*   **Enhanced Privacy:** Tails routes all internet traffic through the Tor network, anonymizing your online activity.
*   **Amnesia by Default:** Tails is designed to leave no trace on the computer it's run from unless explicitly configured with Encrypted Persistent Storage. Any data not saved to `~/Persistent/` will be lost on reboot.
*   **Security-Focused OS:** Tails is designed with security in mind, mitigating many common threats.
*   **Offline Use:** Obsidian can be used entirely offline within Tails, further enhancing privacy.
*   **Controlled Persistence:** You decide what data (vaults, Obsidian application, configurations) is saved between sessions using Encrypted Persistent Storage.

### Target Audience
This guide is intended for users who:
*   Require a high degree of privacy and security for their note-taking.
*   Are using or planning to use Tails OS.
*   Wish to integrate Obsidian into their Tails workflow, potentially with Git and hardware security keys like the Feitian K9D.

### Note on Tails OS Familiarity
This guide assumes a basic understanding of Tails OS, including how to boot it, configure Encrypted Persistent Storage, and navigate its desktop environment. For foundational knowledge about Tails, please refer to the [official Tails documentation](https://tails.net/docs/index.en.html).

---

## 2. Prerequisites

Before you begin, ensure you have the following:

*   **Tails OS:** A USB stick with a recent version of Tails OS installed.
*   **Encrypted Persistent Storage:** Configured and **unlocked** when starting Tails. This is essential for saving your Obsidian application, vaults, and configurations across reboots.
    *   **"Personal Data" enabled:** To store application files and vaults in `~/Persistent/`.
    *   **"Dotfiles" enabled:** Crucial for persisting configurations stored in hidden home directory folders (e.g., `~/.gnupg`, `~/.config/obsidian`, `~/.ssh`). **Configuration Note:** It's best to enable and configure Dotfiles persistence for specific paths *early* in your Tails setup.
*   **Optional: Feitian K9D or similar GPG Hardware Key:** If you plan to use hardware-backed GPG.
*   **Optional: Pre-downloaded and Verified Obsidian AppImage:** (See Section A).
*   **Administrator Password:** You **must** set an Administrator Password in the Tails Welcome Screen for the current session if you need to install additional software like `pcsc-daemon` or modify system configurations.

---

## 3. Section A: Downloading and Verifying Obsidian AppImage

Obsidian is often distributed as an AppImage for Linux, which is convenient for Tails.

### Option 1 (Recommended): Download on Trusted OS, Verify, Transfer
This method is generally recommended for reliability.

1.  **On a trusted, non-Tails OS:**
    *   Go to the [official Obsidian releases page](https://obsidian.md/download).
    *   Download the latest Linux AppImage (`.AppImage` file) and its corresponding checksum file (e.g., `.sha256sum`).
2.  **Verify the Download:**
    *   In a terminal on that OS, navigate to the download directory.
    *   Run: (**Operator Variable:** Adjust `Obsidian-X.Y.Z.AppImage` to the exact downloaded filename)
        ```bash
        sha256sum -c Obsidian-X.Y.Z.AppImage.sha256sum 
        # Or, if only the checksum string is provided on the website:
        # sha256sum Obsidian-X.Y.Z.AppImage 
        # Then manually compare the output with the website's checksum.
        ```
    *   Ensure it indicates `OK` or the checksums match. If not, re-download.
3.  **Transfer to Tails:**
    *   Securely transfer the verified AppImage to a separate USB drive.
    *   Boot Tails, unlock Persistent Storage, and copy the AppImage to `~/Persistent/Downloads/` (or directly to `~/Persistent/Applications/Obsidian/`).

### Option 2 (Inside Tails): Download via Tor Browser
Downloads over Tor can be slow or occasionally interrupted.

1.  Boot Tails with Persistent Storage unlocked and Tor connected.
2.  Open Tor Browser, navigate to [official Obsidian releases page](https://obsidian.md/download).
3.  Download the AppImage to `~/Persistent/Downloads/`.
4.  Download/note the checksum and verify using Terminal in Tails as described above.

---

## 4. Section B: Installing/Storing Obsidian for Persistent Use

The AppImage must be in Encrypted Persistent Storage to be available across sessions.

1.  **Create an Applications Directory:**
    In **Files**, navigate to `Persistent`. Create `Applications`, then `Obsidian` inside it: `~/Persistent/Applications/Obsidian/`.
2.  **Move and Rename AppImage (User Choice):**
    Move the `Obsidian-X.Y.Z.AppImage` to `~/Persistent/Applications/Obsidian/`. You might rename it to something simpler like `Obsidian.AppImage`.
    (**Operator Variable:** Your chosen AppImage name, e.g., `Obsidian.AppImage`)
3.  **Make it Executable:**
    In **Terminal**:
    ```bash
    cd ~/Persistent/Applications/Obsidian/
    chmod +x YourChosenAppImageName.AppImage 
    ```
    (Replace `YourChosenAppImageName.AppImage` with the actual name).

4.  **Optional: Creating a Desktop Entry for Easier Launching**
    *   **User Choice:** Decide if you want an application menu shortcut.
    *   **Configuration Note:** "Dotfiles" persistence for `~/.local/share/applications` should be active for this to persist. (Tails usually includes `~/.local` which covers this, but verify).
    *   Create the directory if needed: `mkdir -p ~/Persistent/.local/share/applications/`
    *   Create the file: `gedit ~/Persistent/.local/share/applications/obsidian.desktop`
    *   Paste and **edit**: (**Operator Variable:** Adjust `Exec=` path to match your AppImage location and name)
        ```ini
        [Desktop Entry]
        Name=Obsidian
        Comment=A knowledge base that works on local Markdown files.
        Exec=/home/amnesia/Persistent/Applications/Obsidian/YourChosenAppImageName.AppImage %U
        Type=Application
        Categories=Office;Utility;TextEditor;
        StartupNotify=true
        Terminal=false
        # Optional Icon Tip: For a custom icon, place an obsidian.png (e.g., 64x64) in a persistent path like
        # ~/Persistent/Pictures/icons/obsidian.png and set:
        # Icon=/home/amnesia/Persistent/Pictures/icons/obsidian.png
        # However, icon display for custom .desktop files in Tails can be inconsistent.
        ```
    *   Save and close. A restart of Tails may be needed for it to appear.

---

## 5. Section C: Creating and Storing Your Obsidian Vault

Your notes **must** be in Persistent Storage.

1.  **Choose Vault Location:** e.g., `~/Persistent/MyVaults/`.
2.  **Create Your Vault Directory:**
    Using **Files**, in `Persistent`, create `MyVaults`. Inside it, create your vault folder.
    (**Operator Variable:** `YourVaultName`, e.g., `MySecureNotes`)
    Example path: `~/Persistent/MyVaults/MySecureNotes/`
3.  **Importance of Location:** Storing in `~/Persistent/` ensures LUKS encryption by Tails. **Data outside `Persistent` is lost on reboot.**
4.  **Optional: Securely Transferring an Existing Vault:**
    Copy existing vault to a USB. In Tails, copy from USB to your persistent vault location. Be mindful of USB security if transferring unencrypted sensitive data.

---

## 6. Section D: First Launch and Essential Configuration

1.  **Running Obsidian:** Double-click the AppImage in `~/Persistent/Applications/Obsidian/`.
2.  **Opening Your Vault:** Select "Open folder as vault" and navigate to `Persistent/MyVaults/YourVaultName`.
3.  **Crucial: Configure "Dotfiles" Persistence for Obsidian Settings:**
    Obsidian settings (plugins, themes) are in `~/.config/obsidian/`. To save these:
    *   **Configuration Note:** Do this *before* extensive Obsidian customization.
    1.  Start Tails with an Administrator Password set.
    2.  Go to **Applications -> Tails -> Persistent Storage**.
    3.  Ensure "Dotfiles" is ON. Click "Configure".
    4.  Click "+" and add the path `~/.config/obsidian` (or browse to `amnesia/.config/obsidian`).
    5.  Click "Save".
    *   **Without this, Obsidian settings will reset after each reboot.** Vault data in `~/Persistent/MyVaults/` remains if "Personal Data" is on.

4.  **Tails-Specific Obsidian Settings:**
    *   **Disable Auto-Updates:** In Obsidian: **Settings -> About -> Automatic updates (toggle OFF)**. Manually update the AppImage (Section H).
    *   **Obsidian Sync via Tor:** If using Obsidian Sync, it will use Tor (slower, potential blocks, but connection is anonymized). Data on Obsidian servers is E2E encrypted by Sync.

---

## 7. Section E: Plugin Management in Tails

*   **Online Installation:** Via Community Plugins browser in Obsidian. Traffic goes via Tor (slower, potential blocks).
    *   Plugin files are in `YourVaultName/.obsidian/plugins/` (persists with vault).
    *   Plugin settings are in `~/.config/obsidian/` (needs Dotfiles persistence, see D.3).
*   **Offline Plugin Installation:**
    *   **Cross-Reference:** See future guide "Obsidian: Offline Plugin and Theme Installation Procedures."

---

## 8. Section F: Git Integration (using `obsidian-git`)

Requires careful setup for persistence.

1.  **Confirm System Git:** `git --version` in Terminal.
2.  **Install `obsidian-git` Plugin** from Community Plugins.
3.  **Configure for System Git:** In plugin settings, "Git executable path" should be `git`.
4.  **Commit Author Details (Operator Variable / User Choice):**
    *   Set in `obsidian-git` settings or globally. **Privacy Note:** This info is in commit history.
    *   For global persistent settings, ensure Dotfiles persistence for `~/.gitconfig`.
        ```bash
        # Example (run in Terminal, only persists if ~/.gitconfig is in Dotfiles)
        # git config --global user.name "Your Chosen Name"
        # git config --global user.email "chosen_email@example.com"
        ```
5.  **Persistent SSH Key Storage (Recommended):**
    1.  Generate keys: `ssh-keygen -t ed25519 -C "your_email"`
    2.  Store in `~/Persistent/.ssh/`.
    3.  **Configuration Note:** Ensure Dotfiles persistence for `~/.ssh/` is active.
6.  **HTTPS PATs:** More complex for persistence; SSH keys preferred.
7.  **Syncing via Tor:** All Git operations via Tor (slower, potential blocks).
8.  **Offline Git Workflow:**
    *   **Cross-Reference:** See future guide "Obsidian & Git: Manual Workflow for Offline Environments."

---

## 9. Section G: Using Hardware Keys (Feitian K9D) with GPG in Tails

Using a Feitian K9D for GPG (e.g., commit signing) requires `pcscd` (PC/SC Smart Card Daemon). GPG needs this daemon to communicate with any smart card or USB token, including your K9D.

1.  **`pcscd` Necessity and Verification:**
    *   `pcscd` allows GPG to see and use your K9D. It might not be installed/running by default.
    *   Verify in Terminal: `systemctl status pcscd`. If "could not be found" or "inactive", it's not ready.

2.  **Installing and Starting `pcscd` (Requires Admin Password):**
    *   **Crucial:** Set an **Administrator Password** in the Tails Welcome Screen when starting Tails for this session.
    *   Install `pcsc-daemon`:
        ```bash
        sudo apt update && sudo apt install -y pcsc-daemon
        ```
    *   Start `pcscd` for the current session:
        ```bash
        sudo systemctl start pcscd
        ```

3.  **Persistence of `pcscd` (Recommended Method - Additional Software):**
    *   To have `pcsc-daemon` available automatically across reboots without manual reinstallation:
        1.  After installing `pcsc-daemon` as above, **reboot Tails**.
        2.  When the "Install Additional Software?" prompt appears for `pcsc-daemon`, click **Install**.
        3.  Tails will then automatically install it each time you unlock Persistent Storage.
    *   **Disclaimer:** This "Additional Software" feature is powerful but adds to what Tails loads. **Consult the official Tails documentation on "Additional Software"** for full details, implications (like increased boot time), and troubleshooting. This is the most user-friendly way to persist `pcscd`.
    *   *Alternative (manual session start):* If not persisted, you must set an Admin Password and run `sudo apt install pcsc-daemon && sudo systemctl start pcscd` each session.

4.  **GPG Configuration Persistence (`~/.gnupg/`):**
    *   **Configuration Note:** Ensure "Dotfiles" persistence for `~/.gnupg/` is active to save GPG keys (stubs for hardware keys), trust, and config.

5.  **AppArmor Considerations:**
    *   Tails uses AppArmor. Rarely, it might interfere with GPG/PC/SC. Advanced troubleshooting may involve checking `journalctl` for AppArmor denials.

6.  **Using Your Feitian K9D:**
    *   With `pcscd` running and `~/.gnupg/` persisted, your K9D should function with GPG as on other Linux systems.
    *   **Cross-Reference:** See "Feitian K9D: GPG Setup and Hardware-Backed Git Commit Signing Guide" for GPG/Git setup.
    *   PIN entry will use a terminal-based `pinentry`.

---

## 10. Section H: Security Best Practices for Obsidian on Tails

*   **Backup Persistent Storage Regularly:** Crucial for `Applications`, vaults, and Dotfiles (`.config/obsidian`, `.gnupg`, `.ssh`). Use Tails' backup tools or manually copy to another encrypted drive.
*   **Plugin Scrutiny:** Minimize community plugins if dealing with extreme sensitivities.
*   **Data Exfiltration Awareness:** Syncing (Obsidian Sync, Git) sends data out via Tor. Be mindful of what you sync.
*   **Strong Persistent Storage Passphrase.**
*   **Lock Screen / Shut Down:** Lock Tails when away. Shut down to clear session memory.
*   **Manual AppImage Updates:** Download new AppImage versions securely (Section A), verify, and replace the old one in `~/Persistent/Applications/Obsidian/`.

By following this guide, you can establish a secure and private Obsidian environment on Tails OS. Always prioritize strong passphrases and careful handling of your Persistent Storage and any hardware keys.
