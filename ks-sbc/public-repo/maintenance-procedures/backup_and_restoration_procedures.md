# DRUIDS Backup and Restoration Procedures

**Document Version:** 1.0
**Date:** YYYY-MM-DD

## 0. Table of Contents
1.  Introduction
2.  What to Backup
3.  Backup Strategies
    *   3.1. Manual Backup
    *   3.2. Automated/Semi-Automated Backup (Recommendations)
    *   3.3. GitHub as a Backup Mechanism
4.  Backup Frequency
5.  Secure Storage of Backups
6.  Restoration Process
    *   6.1. Restoring the Entire Vault Content
    *   6.2. Restoring the `.obsidian` Configuration
    *   6.3. Order of Operations
7.  Testing Restores
8.  Roles and Responsibilities

## 1. Introduction

Regular backups of your DRUIDS (Obsidian) vault and its configuration are critical for data protection and disaster recovery. This document outlines procedures and recommendations for backing up and restoring your DRUIDS environment to prevent data loss due to hardware failure, software issues, accidental deletion, or other unforeseen circumstances.

While KSBC's use of GitHub provides a robust version history and remote copy of the main document content, individual user configurations and unpushed changes require local backup strategies.

## 2. What to Backup

The following components of your DRUIDS setup should be included in your backup routine:

1.  **Entire Obsidian Vault Folder:**
    *   This includes all your Markdown notes (`.md` files), folders, attachments (images, PDFs, etc.), and any other files stored within your main DRUIDS vault directory.
    *   **Location:** This is the primary folder you open with Obsidian for DRUIDS.
    *   `[SCREENSHOT: File explorer showing an example DRUIDS vault folder structure.]`

2.  **Critical Obsidian Configuration Folder (`.obsidian/`):**
    *   This hidden folder (its name starts with a dot) is located directly inside your DRUIDS vault folder.
    *   It contains:
        *   Obsidian's core settings.
        *   Installed community plugin configurations and their data.
        *   Active theme and appearance settings.
        *   Custom CSS snippets.
        *   Workspace layouts.
        *   Hotkeys configurations.
    *   **Importance:** Backing up this folder is crucial for restoring your personalized Obsidian environment and plugin setups.
    *   `[SCREENSHOT: File explorer showing the '.obsidian' folder inside the main vault directory, possibly with hidden files visible.]`

3.  **GPG Keys (Conditional with Extreme Caution):**
    *   **If you manage GPG keys locally** (i.e., your private GPG key is stored on your computer and not solely on a hardware token like a YubiKey) and these keys are used for encrypting/decrypting L1/L2 DRUIDS documents:
        *   Your GPG private key is **EXTREMELY SENSITIVE**.
        *   Backup of GPG keys should follow strict security protocols (e.g., encrypting the backup itself with a very strong passphrase, storing it on a physically secure and isolated offline medium).
        *   **Recommendation:** For most users, especially those using hardware tokens for GPG keys, backing up the key from the computer might not be necessary or advisable if the primary key storage is the hardware token itself (which should have its own secure backup/recovery method).
        *   **Consult KSBC Cadre/Security Guidelines:** Follow specific KSBC policy on GPG key management and backup. This document provides general advice; KSBC policy takes precedence.

## 3. Backup Strategies

A combination of strategies is recommended for robust backup coverage.

### 3.1. Manual Backup

This involves manually copying your vault data to a separate, secure location.

**Steps:**

1.  **Close Obsidian:** Ensure Obsidian is not running to prevent file locking issues or incomplete backups of configuration files.
2.  **Locate Your DRUIDS Vault Folder:** This is the main folder containing all your notes and the `.obsidian` subfolder.
3.  **Locate Your Backup Destination:** This should be a separate physical drive (e.g., encrypted USB drive, external HDD) or a secure cloud storage location (if permitted by KSBC policy and properly secured).
4.  **Copy the Entire Vault Folder:**
    *   Select your entire DRUIDS vault folder.
    *   Copy it to your chosen backup destination.
    *   It's good practice to date your backup folders (e.g., `DRUIDS_Backup_YYYY-MM-DD`).
5.  **Verify Backup (Optional but Recommended):**
    *   Briefly open a few files from the backup location to ensure they copied correctly.

### 3.2. Automated/Semi-Automated Backup (Recommendations)

While this document cannot mandate specific software, consider these approaches for more regular and less manual backups:

*   **File Synchronization Software:** Tools like FreeFileSync, SyncToy (Windows), or ChronoSync (macOS) can be configured to automatically or semi-automatically sync your vault folder to an external drive or another location on a schedule.
*   **System Backup Utilities:** Utilize your operating system's built-in backup tools:
    *   **Windows:** File History or Backup and Restore (Windows 7).
    *   **macOS:** Time Machine.
    *   Ensure these are configured to include your DRUIDS vault folder and the `.obsidian` directory.
*   **`rsync` Scripts (Linux/macOS/Windows via WSL):** For technical users, `rsync` can create powerful, incremental backup scripts.
    *   Example basic `rsync` command:
        `rsync -avh --delete /path/to/your/DRUIDS_Vault/ /path/to/your/Backup_Location/DRUIDS_Vault_Backup/`
        *   **Operator Input:** You would need to replace `/path/to/your/...` with your actual paths.
        *   `--delete` option keeps the backup location a mirror; remove if you want to keep deleted files in the backup.

### 3.3. GitHub as a Backup Mechanism

Regularly committing and pushing your changes to the KSBC GitHub repositories (`ks-sbc/public-repo`, and any private L1/L2 repos) serves as an excellent versioned backup for the *content* of your DRUIDS vault (Markdown files, attachments).

*   **Advantages:** Version history, offsite storage, collaborative recovery.
*   **Limitations for Full Backup:**
    *   **`.obsidian` Folder:** By default, the `.obsidian` folder is often included in `.gitignore` to avoid committing user-specific workspace layouts or temporary plugin states that might conflict with other users. This means your local Obsidian settings, theme, snippets, and plugin configurations might *not* be backed up to GitHub unless explicitly configured to do so (which requires careful consideration to avoid conflicts).
    *   **Recommendation:** Maintain separate backups of your `.obsidian` folder (as per section 3.1 or 3.2) if you have a highly customized local setup you wish to preserve.
    *   **Unpushed Commits:** Only changes that are committed AND pushed to GitHub are backed up there.

## 4. Backup Frequency

*   **Active Users / Critical Data:** Daily manual or automated backups are highly recommended, especially if you are actively creating or modifying L1/L2 documents or significant L0 content.
*   **Less Active Users:** Weekly backups might suffice, but adjust based on your activity level and the importance of recent changes.
*   **Before Major Changes:** Always perform a backup before significant DRUIDS updates (Obsidian version, critical plugins) or major restructuring of your vault.

## 5. Secure Storage of Backups

*   **Encryption:** If your backup medium (e.g., USB drive, cloud storage) is not inherently encrypted, consider encrypting the backup files themselves, especially if they contain L1/L2 material (even if the L1/L2 files within the vault are already GPG-encrypted, an extra layer for the backup container is good practice). Tools like VeraCrypt or BitLocker (Windows) / FileVault (macOS) can encrypt entire drives.
*   **Physical Security:** Store external backup drives in a physically secure location, separate from your primary computer if possible (to protect against theft, fire, etc.).
*   **Cloud Storage Security:** If using cloud storage (and KSBC policy allows), ensure it has strong access controls, multi-factor authentication, and a good privacy policy. Be extremely cautious if backing up unencrypted sensitive data to the cloud.

## 6. Restoration Process

### 6.1. Restoring the Entire Vault Content (Notes, Attachments)

1.  **Locate Your Backup:** Identify the backup version you wish to restore from.
2.  **Close Obsidian.**
3.  **(Optional but Recommended) Backup Current State:** If your current vault has changes you might want to save, back it up first before overwriting.
4.  **Restore Files:**
    *   Delete the contents of your current DRUIDS vault folder (or rename it, e.g., `DRUIDS_Vault_corrupted`).
    *   Copy the entire vault folder from your backup location to where your DRUIDS vault should reside.

### 6.2. Restoring the `.obsidian` Configuration

This is useful if your notes are fine, but Obsidian settings, plugins, or themes are misbehaving.

1.  **Close Obsidian.**
2.  **Navigate to your DRUIDS vault folder.**
3.  **Delete or Rename the existing `.obsidian` folder** (e.g., to `.obsidian_old`).
4.  **Copy the backed-up `.obsidian` folder** into your DRUIDS vault folder.
5.  **Restart Obsidian.** Your settings, plugins, and appearance should be restored.

### 6.3. Order of Operations (If Restoring Both)

If restoring both content and configuration from a full vault backup:
1.  Restore the entire vault folder (which includes the `.obsidian` folder from that backup point) as described in 6.1. This single step usually suffices.

## 7. Testing Restores

Backups are only useful if they can be successfully restored.

*   **Schedule Periodic Tests:** At least once every few months (or more frequently for critical systems), perform a test restoration to a temporary location or a test machine.
*   **Verification:**
    *   Ensure Obsidian opens the restored vault.
    *   Check if key files are present and readable.
    *   Verify if critical plugin settings are intact.
    *   Confirm if themes and snippets are applied.
*   This helps identify issues with your backup process or the integrity of backup media.

## 8. Roles and Responsibilities

*   **Individual KSBC Members:**
    *   Each member is primarily responsible for backing up their local DRUIDS vault content that has not yet been pushed to the shared GitHub repository.
    *   Each member is responsible for backing up their local `.obsidian` configuration folder if they have customized settings they wish to preserve.
    *   Adherence to KSBC guidelines for secure storage of backups, especially those containing sensitive information.
*   **DRUIDS Administration / Cadre:**
    *   Provide clear guidance and recommendations on backup best practices (this document).
    *   Ensure the GitHub repositories (serving as the central content backup) are properly maintained and secured.
    *   May provide support or advice on backup/restoration issues.
    *   Define policy on the use of cloud storage for backups, especially for sensitive data tiers.

Regular and verified backups are your best defense against data loss. Make it a habit!
