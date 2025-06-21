# Guide: Air-Gapped Backup and Synchronization for Obsidian on Tails OS

## 1. Introduction

### Purpose of This Guide
This guide provides procedures for:
1.  Securely backing up critical data from your Tails OS Encrypted Persistent Storage.
2.  Performing basic air-gapped file and folder synchronization for your Obsidian vault between your Tails OS environment and another computer (e.g., your main machine).

### Importance
*   **Data Resilience:** Protect against loss of your Tails USB drive, corruption of Persistent Storage, or accidental deletion.
*   **Disaster Recovery:** Enable you to restore your Obsidian environment and other critical configurations if your primary Tails setup becomes unusable.

### Scope and Limitations
*   **Focus:** This guide focuses on file-based backup methods and basic file-level synchronization.
*   **Synchronization Limitations:** The synchronization methods described here are rudimentary (e.g., using `rsync`). They are prone to errors like unintentionally overwriting newer files with older ones if not handled with extreme care.
*   **Cross-Reference for Robust Vault Content Synchronization:** For proper, version-controlled, and conflict-managed synchronization of your Obsidian vault *content*, this guide **strongly recommends and cross-references** the future "Obsidian & Git: Manual Workflow for Offline Environments" guide. The methods here are more for simple transfers or backups of the vault as a whole.

### Security First: Discipline with Transfer Media
All air-gapped procedures rely on the disciplined use of transfer media (typically USB drives). Maintain strict hygiene and awareness when moving data between systems.

## 2. Prerequisites

*   **Tails OS:** With Encrypted Persistent Storage configured, unlocked, and in use.
*   **Secure USB Drive(s):**
    *   One or more USB drives dedicated for backup and transfer.
    *   **Recommendation (User-Encrypted USB):** For enhanced security, especially when using direct copy methods like `rsync` (Method A4), it's highly recommended to use USB drives that you have **fully encrypted yourself**. This is typically a one-time setup task performed on a trusted computer (Linux, Windows, or macOS) using tools like:
        *   **LUKS:** Standard disk encryption for Linux (Tails can unlock LUKS volumes if the necessary utilities are part of its base or added via "Additional Software").
        *   **VeraCrypt:** A cross-platform encryption tool. To *use* VeraCrypt volumes within Tails, the `veracrypt` package might need to be installed and potentially persisted using Tails' "Additional Software" feature if not included by default.
*   **(For Synchronization) Another Computer ("Main Machine"):** A trusted computer where you want to sync your Obsidian vault data to/from.
*   **Basic Linux Command-Line Familiarity:** Some procedures involve using the terminal for commands like `tar`, `gpg`, and `rsync`.

---

## 3. Section A: Backing Up Your Tails Persistent Storage Data

This section covers methods to back up the data stored in your Tails Encrypted Persistent Storage. Remember that any data not explicitly saved to `~/Persistent/` or configured for persistence (Dotfiles, Additional Software) will be lost on reboot.

### A1. Identifying Your Critical Data
Before backing up, identify what data is critical to you. This typically includes:

*   **Obsidian Vaults:** e.g., `~/Persistent/MyVaults/YourVaultName/`
*   **Obsidian Application (if stored locally):** e.g., `~/Persistent/Applications/Obsidian/`
*   **Obsidian Configuration (if Dotfiles persistence used):** `~/.config/obsidian/` (persisted via `~/Persistent/dotfiles/.config/obsidian/`)
*   **GPG Configuration (if Dotfiles persistence used):** `~/.gnupg/` (persisted via `~/Persistent/dotfiles/.gnupg/`)
*   **SSH Keys (if Dotfiles persistence used):** `~/.ssh/` (persisted via `~/Persistent/dotfiles/.ssh/`)
*   **Custom Scripts or Other Applications:** Any other tools or data you've stored in `~/Persistent/` that are important.

*   **Operator Action: User must list their specific critical data paths for backup.** Create a checklist for yourself.

### A2. Method 1: Tails' Built-in Persistent Storage Backup Utility
Tails includes a utility to clone your entire Persistent Storage to another USB drive.

*   **Procedure:**
    1.  Boot Tails and unlock your Persistent Storage.
    2.  Insert a **destination USB drive** that is at least as large as your current Tails USB drive. **> [!WARNING] The destination USB drive will be completely overwritten.**
    3.  Go to **Applications -> Tails -> Backup Persistent Storage**.
    4.  Follow the on-screen prompts.
*   **Output:** A complete, encrypted copy of your Persistent Storage on the destination USB.
*   **Pros:** Simple, guided, comprehensive, output is encrypted by default.
*   **Cons:** All-or-nothing backup, needs a dedicated (often large) USB.

### A3. Method 2: Selective Encrypted Archives (`tar` + `gpg`)
Backup specific folders into a GPG-encrypted archive on a USB drive.

*   **Procedure:**
    1.  **Operator Action:** Identify source directories (e.g., `~/Persistent/MyVaults`).
    2.  Insert backup USB. Note its mount point (e.g., `/media/amnesia/BackupUSB/` - **Operator Action:** verify this path in Files).
    3.  Open **Terminal**.
    4.  Command:
        *   **Operator Variables:**
            *   `<list_of_paths_to_backup_relative_to_home>`: e.g., `Persistent/MyVaults Persistent/dotfiles/.config/obsidian`. Paths are relative to `/home/amnesia/`.
            *   `<output_archive_name.tar.gz.gpg>`: e.g., `my_obsidian_backup_$(date +%Y%m%d).tar.gz.gpg`.
            *   `<full_path_to_backup_usb>`: e.g., `/media/amnesia/BackupUSB/`.
        ```bash
        # Example from /home/amnesia/
        tar -czvf - Persistent/MyVaults Persistent/dotfiles/.config/obsidian | gpg -c --cipher-algo AES256 -o <full_path_to_backup_usb>/<output_archive_name.tar.gz.gpg>
        ```
        You'll be prompted for a strong GPG passphrase.
    5.  **Store the GPG passphrase securely and separately.**
*   **Restoration Steps:**
    1.  Copy archive to `~/Persistent/` or a temporary location.
    2.  Open Terminal.
    3.  **Operator Action:** Restore to a *new, temporary location first* to inspect before overwriting live data.
        ```bash
        # Example: Restore to a new folder named "RestoreTest" in Persistent
        mkdir -p ~/Persistent/RestoreTest 
        gpg -d <path_to_archive_file.tar.gz.gpg> | tar -xzvf - -C ~/Persistent/RestoreTest
        ```
        This creates `~/Persistent/RestoreTest/Persistent/MyVaults/...`. Adjust `-C` or use `--strip-components` if your tarball paths are structured differently or if you want to restore directly into `~/Persistent/`.
*   **Pros:** Selective, encrypted.
*   **Cons:** Command-line, critical passphrase management, careful path management on restore.

### A4. Method 3: Selective Direct Copy (`rsync` to User-Encrypted USB)
Direct copy to a USB drive *you have already fully encrypted* (e.g., LUKS, VeraCrypt).

*   **Prerequisite:** Encrypted USB drive.
    *   **Configuration Note (VeraCrypt):** To use a VeraCrypt volume in Tails, the `veracrypt` package may need to be installed and persisted using Tails' "Additional Software" feature. This is an advanced setup.
*   **Procedure:**
    1.  Insert and mount your encrypted USB. Note its mount point (**Operator Action:** identify path, e.g., `/media/amnesia/MyEncryptedUSB/`).
    2.  Open **Terminal**.
    3.  Use `rsync`:
        *   **Operator Variables:**
            *   `<list_of_source_paths>`: e.g., `~/Persistent/MyVaults/ ~/Persistent/dotfiles/.config/obsidian/`. **Note trailing slashes on source paths.**
            *   `<destination_on_encrypted_usb>`: e.g., `/media/amnesia/MyEncryptedUSB/TailsBackup/`.
        ```bash
        # Example (ensure destination folder exists):
        mkdir -p /media/amnesia/MyEncryptedUSB/TailsBackup/
        rsync -avh --delete ~/Persistent/MyVaults/ ~/Persistent/dotfiles/.config/obsidian/ /media/amnesia/MyEncryptedUSB/TailsBackup/
        ```
        > **[!CAUTION] Use `rsync --delete` with extreme care.** It deletes files in the destination if they are not in the source, making the destination an exact mirror. Always double-check your source and destination paths.
*   **Pros:** Direct file access on backup (when decrypted). `rsync` is efficient for subsequent backups.
*   **Cons:** Security relies entirely on USB's pre-existing encryption. `rsync --delete` risk. VeraCrypt setup can be complex.

### A5. Backup Schedule and Rotation
*   **Operator Action: Define a backup schedule (e.g., weekly) and use multiple USBs for rotation.** Store backups in secure, separate locations.

---

## 4. Section B: Air-Gapped Synchronization of Obsidian Vault Data (Basic File-Level)

This section describes basic methods for synchronizing Obsidian vault files between Tails OS and another computer ("Main Machine") using a USB drive. "Synchronization" here means making the content of two locations identical, not version merging.

> **[!WARNING]
> **For Robust Vault Content Synchronization, Use Git!**
> The `rsync` methods described below are for **basic file/folder mirroring only.** They directly copy files and can easily lead to:
> *   **Overwriting newer files with older ones** if not managed with extreme care and a clear understanding of the "source of truth" at any given time.
> *   **Data loss,** especially if using options like `--delete` without full awareness, or if changes were made on *both* systems independently since the last sync.
> *   **No conflict resolution:** `rsync` does not understand or merge changes within individual files like Git does.
>
> For proper, version-controlled, and conflict-managed synchronization of your Obsidian vault *content*, it is **STRONGLY ADVISED** to use the procedures outlined in the (future) guide: **"Obsidian & Git: Manual Workflow for Offline Environments."** The methods below are more suited for simple one-way transfers of an entire vault for backup purposes or when Git is absolutely not an option and the risks are understood. **Proceed with extreme caution.**

### B1. Unidirectional Synchronization (Example: Tails Vault → Main Machine Vault)
This syncs changes *from* Tails *to* your Main Machine. **Changes made only on the Main Machine vault in the destination path will be overwritten by this operation if they don't exist in the source.**

*   **Operator Variables:**
    *   `TAILS_VAULT_PATH`: e.g., `~/Persistent/MyVaults/YourVaultName/` (Source)
    *   `USB_SYNC_FOLDER_PATH`: e.g., `/media/amnesia/YOUR_USB_LABEL/VaultSync/` (Intermediate on USB)
    *   `MAIN_MACHINE_VAULT_PATH`: Path on your main computer. (Destination)
*   **Steps:**
    1.  **On Tails OS:**
        *   Insert USB, ensure mounted. Note its mount point (e.g., `/media/amnesia/TransferUSB/`).
        *   Open Terminal. **Operator Action:** Replace placeholders with your actual paths.
        *   ```bash
          # Create sync folder on USB if it doesn't exist
          mkdir -p /media/amnesia/TransferUSB/VaultSync/
          # Sync from Tails to USB. Note trailing slash on source.
          rsync -avh --delete ~/Persistent/MyVaults/YourVaultName/ /media/amnesia/TransferUSB/VaultSync/
          ```
          > **[!CAUTION] `rsync --delete` on this step will delete files in `/media/amnesia/TransferUSB/VaultSync/` if they are not in `~/Persistent/MyVaults/YourVaultName/`.**
        *   Safely eject USB.
    2.  **On Main Machine:**
        *   Insert USB. Note its mount point.
        *   Open Terminal. **Operator Action:** Replace placeholders with your actual paths.
        *   ```bash
          # Sync from USB to Main Machine. Note trailing slash on source.
          rsync -avh --delete /path/to/usb/mount/VaultSync/ /path/to/your/MainMachineVault/
          ```
          > **[!CAUTION] `rsync --delete` on this step will delete files in `/path/to/your/MainMachineVault/` if they are not in `/path/to/usb/mount/VaultSync/`.**

### B2. Basic Bidirectional "Synchronization" (Manual, Very High Caution)
Attempting bidirectional sync with `rsync` is **highly prone to data loss** if changes are made on both systems independently. This is effectively choosing one side as the "master" at the time of sync.

*   **STRONG DISCOURAGEMENT:** **Not recommended for active vaults with changes on both sides.** Use the Git-based offline workflow.
*   If you must proceed and understand you might lose some changes:
    1.  **Decide Source of Truth:** Which system's changes for this session are more important?
    2.  Sync from "Source of Truth" to USB (with `--delete` if making USB an exact mirror).
    3.  Sync from USB to the other machine (with `--delete` if making the other machine an exact mirror of USB).
    4.  **Any changes made on the "non-source-of-truth" machine since its last sync will be overwritten.**

### B3. Using File Comparison Tools
Before any `rsync` operation that might overwrite data, especially in a pseudo-bidirectional attempt:
*   Use `diff -qr <dir1> <dir2>` in Terminal to list differing files.
    ```bash
    # Example: On Tails, compare vault with USB content brought from Main Machine
    diff -qr ~/Persistent/MyVaults/YourVaultName/ /media/amnesia/TransferUSB/VaultSyncFromMain/
    ```
    Review differences to manually merge or decide which version to keep before syncing.

---

## 5. Section C: Security Considerations for Air-Gapped Transfers & Backups

### C1. USB Drive Hygiene
*   **Dedicated USBs:** Use USB drives only for these trusted transfers. Avoid using them on potentially compromised or untrusted computers.
*   **Known Clean Source (Machine A):** If downloading files to an internet-connected machine first, ensure it's well-maintained and malware-free.

### C2. Physical Security of USB Media
*   Treat backup USB drives as sensitive. Store them securely to prevent physical loss, theft, or unauthorized access, especially if unencrypted or if the encryption passphrase is weak or stored with the drive.

### C3. Encryption of Backup Medium
*   **Tails Backup Utility:** Output is already encrypted.
*   **`tar` + `gpg`:** The archive itself is encrypted. Protect the GPG passphrase vigilantly.
*   **`rsync` to User-Encrypted USB:** The security of the backup data at rest depends entirely on the strength of the USB's full-disk encryption (VeraCrypt/LUKS) and its passphrase. If `rsync`ing files to an *unencrypted* USB, the backup data is unencrypted and vulnerable if the USB is lost/stolen.

### C4. Data Remanence (Brief Mention)
*   Standard file deletion (`rm`) or even quick formatting a drive may not make data unrecoverable by forensic techniques.
*   For extreme security when decommissioning backup media that held highly sensitive data, physical destruction or cryptographic erasure (if supported by the drive hardware) are the most reliable methods.

### C5. Verifying Data Integrity (Checksums)
*   After transferring large backup files (e.g., `.tar.gz.gpg` archives), verify their integrity using checksums if you created them beforehand.
    ```bash
    # On the system where you created the archive (e.g., Tails, before transfer to backup USB)
    sha256sum my_backup_archive.tar.gz.gpg > my_backup_archive.sha256
    
    # Copy BOTH my_backup_archive.tar.gz.gpg AND my_backup_archive.sha256 to the backup USB.
    
    # When verifying (e.g., on restore, or on another machine after transfer):
    # Copy both files from USB to the checking system. Navigate to that directory.
    sha256sum -c my_backup_archive.sha256 
    # Look for "OK".
    ```
    This helps detect accidental data corruption during file transfer or storage. It verifies the archive file itself, not the individual files within an unencrypted archive.

---
*This guide provides methods for data resilience in an air-gapped Tails OS environment. Always prioritize understanding the commands and risks before execution, especially with operations that can delete or overwrite data.*
