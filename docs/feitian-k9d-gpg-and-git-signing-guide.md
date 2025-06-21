# Feitian K9D: GPG Setup and Hardware-Backed Git Commit Signing Guide

This guide provides comprehensive instructions for setting up your Feitian K9D security key with GnuPG (GPG), configuring Git to use this hardware-backed key for signing commits, using the key for encrypting and decrypting sensitive documents, verifying the overall integration, and managing keys in both individual and organizational contexts. Following these steps will enhance the security and integrity of your Git workflow, particularly when managing sensitive information across different security tiers.

**Important Note:** This guide aims to be a helpful resource. However, for any model-specific details, driver information, default PINs/PUKs, or firmware utilities related to your Feitian K9D, **always consult the official Feitian documentation that came with your device or is available on their official website.** Hardware and associated software can evolve, and the manufacturer's documentation remains the primary authoritative source.

## Table of Contents

*   [I. Setting Up Your Feitian K9D with GPG for Different Security Tiers](#i-setting-up-your-feitian-k9d-with-gpg-for-different-security-tiers)
    *   [A. Introduction to GPG Setup](#a-introduction-to-gpg-setup)
    *   [B. Prerequisites for GPG Setup](#b-prerequisites-for-gpg-setup)
    *   [C. Initial Card Setup with GPG (`gpg --card-edit`)](#c-initial-card-setup-with-gpg---gpg---card-edit--)
    *   [D. GPG Key Generation/Transfer Strategy](#d-gpg-key-generationtransfer-strategy)
    *   [E. Configuring GPG for Different Security Tiers (GPG Side)](#e-configuring-gpg-for-different-security-tiers-gpg-side)
    *   [F. Verifying GPG Key and Card Association](#f-verifying-gpg-key-and-card-association)
    *   [G. Basic Backup and Revocation (Essential First Steps)](#g-basic-backup-and-revocation-essential-first-steps)
*   [II. Configuring Git for Hardware-Backed Commit Signing with Feitian K9D](#ii-configuring-git-for-hardware-backed-commit-signing-with-feitian-k9d)
    *   [A. Introduction to Git Configuration](#a-introduction-to-git-configuration)
    *   [B. Identifying Your GPG Signing Key ID (Hardware-Backed)](#b-identifying-your-gpg-signing-key-id-hardware-backed)
    *   [C. Configuring Git to Use the Hardware-Backed GPG Key](#c-configuring-git-to-use-the-hardware-backed-gpg-key)
    *   [D. The Role of `gpg-agent` in Git Signing](#d-the-role-of-gpg-agent-in-git-signing)
    *   [E. The Commit Signing Process with Feitian K9D (Step-by-Step Flow)](#e-the-commit-signing-process-with-feitian-k9d-step-by-step-flow)
    *   [F. "Scripts" - Configuration Procedures and Optional Helper Snippets](#f--scripts----configuration-procedures-and-optional-helper-snippets)
    *   [G. Verifying Signed Commits](#g-verifying-signed-commits)
    *   [H. Troubleshooting Common Git Signing Issues](#h-troubleshooting-common-git-signing-issues)
*   [III. Secure Document Workflows: Encrypting and Decrypting L1/L2 Files with Feitian K9D and GPG](#iii-secure-document-workflows-encrypting-and-decrypting-l1l2-files-with-feitian-k9d-and-gpg)
    *   [A. Introduction to Secure Document Workflows](#a-introduction-to-secure-document-workflows)
    *   [B. Prerequisites for Encryption/Decryption](#b-prerequisites-for-encryptiondecryption)
    *   [C. Encryption Workflow (Protecting L1/L2 Documents)](#c-encryption-workflow-protecting-l1l2-documents)
    *   [D. Decryption Workflow (Accessing L1/L2 Documents)](#d-decryption-workflow-accessing-l1l2-documents)
    *   [E. Key Management for Team Access (Brief Overview)](#e-key-management-for-team-access-brief-overview)
*   [IV. Verifying Your Feitian K9D Hardware Key and GPG Integration](#iv-verifying-your-feitian-k9d-hardware-key-and-gpg-integration)
    *   [A. Introduction to Verification](#a-introduction-to-verification)
    *   [B. Physical Inspection (Basic Check)](#b-physical-inspection-basic-check)
    *   [C. GPG Command-Line Verifications](#c-gpg-command-line-verifications)
    *   [D. Operational Verification (Ensuring K9D is Used)](#d-operational-verification-ensuring-k9d-is-used)
    *   [E. (Advanced) Key Attestation](#e-advanced-key-attestation)
    *   [F. Recommendations for Regular Checks](#f-recommendations-for-regular-checks)
    *   [G. What to Do If Verification Fails](#g-what-to-do-if-verification-fails)
*   [V. Feitian K9D: GPG Key Backup and Recovery Procedures](#v-feitian-k9d-gpg-key-backup-and-recovery-procedures)
    *   [A. Introduction to Backup and Recovery](#a-introduction-to-backup-and-recovery)
    *   [B. Core Backup Components (Essential Preparations - Recap & Emphasis)](#b-core-backup-components-essential-preparations---recap--emphasis)
    *   [C. Scenario-Based Recovery Procedures](#c-scenario-based-recovery-procedures)
    *   [D. Post-Recovery Steps](#d-post-recovery-steps)
    *   [E. Best Practices for Prevention and Mitigation (Backup/Recovery)](#e-best-practices-for-prevention-and-mitigation-backuprecovery)
*   [VI. Organizational GPG & Feitian K9D: Multi-User Key Management Strategies](#vi-organizational-gpg--feitian-k9d-multi-user-key-management-strategies)
    *   [A. Introduction to Multi-User Key Management](#a-introduction-to-multi-user-key-management)
    *   [B. Establishing a Foundation of Trust: Public Key Management](#b-establishing-a-foundation-of-trust-public-key-management)
    *   [C. Encrypting for Teams and Roles](#c-encrypting-for-teams-and-roles)
    *   [D. Key Lifecycle Management in the Organization](#d-key-lifecycle-management-in-the-organization)
    *   [E. Policy for Hardware Key Usage (L1/L2 Data)](#e-policy-for-hardware-key-usage-l1l2-data)

## I. Setting Up Your Feitian K9D with GPG for Different Security Tiers

### A. Introduction to GPG Setup
This first major part of the guide provides detailed instructions for setting up your Feitian K9D security key with GnuPG (GPG). This setup is essential before you can use the key for Git commit signing or document encryption/decryption. Using a hardware key like the Feitian K9D significantly enhances the security of your GPG private keys, as they are generated and stored on the device and should never leave it. This protects your keys from malware and unauthorized access on your computer.

> **WARNING: Crucial Disclaimer & PIN Information**
> This guide provides general steps and examples. **Always refer to the official Feitian documentation for your specific K9D model regarding drivers, default PINs/PUKs, and any model-specific utilities or behavior.** Hardware and its associated software can change, and the manufacturer's documentation is the authoritative source. 
>
> **Example Default PINs (MUST BE VERIFIED with your device's official documentation):**
> *   User PIN: Often `123456`
> *   Admin PIN: Often `12345678`
>
> **It is CRITICAL to change these default PINs immediately upon first use.** Failure to do so severely undermines the security of your hardware key.

### B. Prerequisites for GPG Setup
(Content from original Section 1.B remains here)
[...]

### C. Initial Card Setup with GPG (`gpg --card-edit`)
(Content from original Section 1.C remains here, ensuring PIN warnings are prominent)
[...]

### D. GPG Key Generation/Transfer Strategy
(Content from original Section 1.D remains here)
[...]

### E. Configuring GPG for Different Security Tiers (GPG Side)
(Content from original Section 1.E remains here, ensuring `gpg-agent.conf` path details are clear)
[...]

### F. Verifying GPG Key and Card Association
(Content from original Section 1.F remains here)
[...]

### G. Basic Backup and Revocation (Essential First Steps)
(Content from original Section 1.G remains here, ensuring emphasis on revocation certificate is strong)
[...]

## II. Configuring Git for Hardware-Backed Commit Signing with Feitian K9D
(Content from original Section 2 remains here, ensuring clarity on "scripts" as procedures and reinforcing security tier linkage)
[...]

## III. Secure Document Workflows: Encrypting and Decrypting L1/L2 Files with Feitian K9D and GPG

### A. Introduction to Secure Document Workflows
This part of the guide outlines the procedures for encrypting and decrypting sensitive files, particularly those classified as L1 (Internal) and L2 (Secure), using GPG keys managed by your Feitian K9D security key.

*   **Scope:** The focus here is on file and directory-level encryption for documents intended to be stored in a Git repository. This is distinct from full-disk encryption or transport-layer encryption, although it complements them.
*   **Benefits:**
    *   **Data-at-Rest Protection:** Encrypting files ensures that even if the repository or underlying storage is compromised, the sensitive content remains unreadable without the correct GPG private key.
    *   **Hardware-Backed Security:** Decryption operations require the Feitian K9D to be present and the correct User PIN to be entered (and potentially a touch confirmation), providing strong protection for the decryption key.
    *   **Authorized Access Control:** Only individuals possessing the necessary GPG private key (held on their K9D) and its PIN can decrypt and access the sensitive information.
*   **Security Reminder:** Encrypting files is a critical component of a defense-in-depth strategy. Overall security also depends on strong PINs, secure handling of the K9D, protecting your computer from malware, and secure practices for managing decrypted files.

### B. Prerequisites for Encryption/Decryption
*   **Feitian K9D GPG Setup Completed:** You must have successfully completed Part I of this guide.
*   **GnuPG Installed and Configured:** GPG suite (gpg, gpg-agent, scdaemon, pinentry) must be functional on your system.
*   **Recipient Public GPG Keys Imported:** To encrypt a file for others, or for yourself for later decryption, you need their public GPG keys imported into your GPG keyring. These keys should ideally be validated (e.g., through key signing or direct fingerprint verification). **To decrypt files encrypted for you, your own public key (corresponding to the private encryption key on your K9D) must have been used by the sender.**
*   **Understanding of L1/L2 Classification:** Familiarize yourself with your organization's data classification policy to correctly identify which files require L1 or L2 encryption.

### C. Encryption Workflow (Protecting L1/L2 Documents)

#### 1. Identifying Files for Encryption
*   **Manual Selection:** For individual files.
*   **Directory-Based Policy (Recommended):** Establish specific directories for L1/L2 files (e.g., `vault/secure/L1/`, `vault/secure/L2/`). All non-encrypted files in these directories should be encrypted.

#### 2. GPG Encryption Commands (Manual)
Asymmetric (public-key) encryption is recommended.

*   **Command:**
    ```bash
    gpg --armor --encrypt --recipient <recipient1_key_id_or_email> --output <encrypted_file.gpg> <original_file>
    ```
*   **Explanation:**
    *   `--armor` (`-a`): Creates ASCII armored output (easier for Git).
    *   `--encrypt` (`-e`): Encrypts data.
    *   `--recipient <key_id_or_email>` (`-r <key_id_or_email>`): **Operator Variable.** Specifies the recipient. You must have their public key.
        *   **Self-Encryption (Crucial for your own access):** To encrypt a file so that you can decrypt it later with your K9D, **you MUST include your own GPG key ID/email as a recipient.** This is a common oversight that can lead to being unable to access your own encrypted files.
        *   **Multiple Recipients:** Use multiple `-r` flags to encrypt for several people.
    *   `--output <encrypted_file.gpg>` (`-o <encrypted_file.gpg>`): **Operator Variable.** Output encrypted filename.
    *   `<original_file>`: **Operator Variable.** Path to the unencrypted file.
*   **Symmetric Encryption (`gpg -c`):** Encrypts with a passphrase. Generally **not recommended** for this GPG key-based workflow as it bypasses hardware key benefits for key management during encryption and relies on passphrase sharing.

#### 3. "Automated" Encryption with Helper Scripts (Example)
A helper script can ease encrypting multiple files. **Note:** The following is a conceptual script. Users must understand it, customize the **Operator Variables** at the beginning, and test it thoroughly in a safe environment before use on critical data.

**Conceptual Bash Script for Directory Encryption:**
```bash
#!/bin/bash

# === USER CONFIGURATION (Operator Variables) ===
# **IMPORTANT**: Review and set these variables carefully. Test in a safe environment first.

# Directory containing original unencrypted L1/L2 files
# Example: SOURCE_DIRECTORY="vault/secure/L1_plaintext/"
SOURCE_DIRECTORY="YOUR_PLAINTEXT_SOURCE_DIRECTORY_HERE"

# Directory where encrypted .gpg files will be placed.
# Can be the same as SOURCE_DIRECTORY if you manage originals and .gitignore carefully.
# Example: ENCRYPTED_OUTPUT_DIRECTORY="vault/secure/L1_encrypted/"
ENCRYPTED_OUTPUT_DIRECTORY="YOUR_ENCRYPTED_OUTPUT_DIRECTORY_HERE"

# GPG Key IDs or emails of ALL recipients.
# **CRITICAL: Include your own GPG key ID here if you need to decrypt these files later!**
# Example: RECIPIENT_GPG_KEY_IDS=("your_email@example.com" "teammate1_keyid" "teammate2_email@example.com")
RECIPIENT_GPG_KEY_IDS=("YOUR_OWN_GPG_KEY_ID" "ANOTHER_RECIPIENT_KEY_ID")

# Securely delete original files after successful encryption? (true/false)
# **EXTREME CAUTION**: Set to true only if you are absolutely certain and have reliable backups.
# Consider manual deletion after verification as a safer alternative.
DELETE_ORIGINALS_AFTER_ENCRYPTION=false

# File pattern to encrypt (e.g., *.md, *.txt, * for all files in SOURCE_DIRECTORY)
# Be specific to avoid encrypting unintended files.
FILE_PATTERN_TO_ENCRYPT="*.md" 
# === END USER CONFIGURATION ===

# Script execution starts here
if [ "$SOURCE_DIRECTORY" == "YOUR_PLAINTEXT_SOURCE_DIRECTORY_HERE" ] || \
   [ "$ENCRYPTED_OUTPUT_DIRECTORY" == "YOUR_ENCRYPTED_OUTPUT_DIRECTORY_HERE" ] || \
   [ "${RECIPIENT_GPG_KEY_IDS[0]}" == "YOUR_OWN_GPG_KEY_ID" ]; then
  echo "ERROR: Please configure Operator Variables in the script before running." >&2
  exit 1
fi

mkdir -p "$ENCRYPTED_OUTPUT_DIRECTORY" 

recipient_args=()
for recipient_id in "${RECIPIENT_GPG_KEY_IDS[@]}"; do
  recipient_args+=("--recipient" "$recipient_id")
done

echo "Starting encryption for files in '$SOURCE_DIRECTORY' matching pattern '$FILE_PATTERN_TO_ENCRYPT'..."
echo "Recipients: ${RECIPIENT_GPG_KEY_IDS[*]}"

find "$SOURCE_DIRECTORY" -type f -name "$FILE_PATTERN_TO_ENCRYPT" | while read -r filepath; do
  if [[ "$filepath" == *.gpg ]]; then
    echo "  Skipping already encrypted file: '$filepath'"
    continue
  fi
  filename=$(basename "$filepath")
  encrypted_filepath="${ENCRYPTED_OUTPUT_DIRECTORY%/}/${filename}.gpg" 
  echo "Encrypting '$filepath' to '$encrypted_filepath'..."
  gpg --batch --yes --trust-model always --armor --encrypt "${recipient_args[@]}" --output "$encrypted_filepath" "$filepath"
  if [ $? -eq 0 ]; then
    echo "  Successfully encrypted '$filename'."
    if [ "$DELETE_ORIGINALS_AFTER_ENCRYPTION" = true ]; then
      echo "  Securely deleting original '$filepath'..."
      # For more secure deletion for highly sensitive data, consider 'shred -u "$filepath"' (Linux)
      # or other secure deletion tools specific to your OS. 'rm' may not erase data from disk.
      rm "$filepath" 
      echo "  Original '$filename' deleted."
    fi
  else
    echo "  ERROR: Failed to encrypt '$filename'. Original file NOT deleted." >&2
  fi
done
echo "Encryption process completed."
echo "Review encrypted files in '$ENCRYPTED_OUTPUT_DIRECTORY'."
if [ "$DELETE_ORIGINALS_AFTER_ENCRYPTION" = false ]; then
  echo "Remember to manually manage/delete original plaintext files from '$SOURCE_DIRECTORY' as per your security policy."
fi
```
**Security Note on Deleting Originals:** Standard `rm` often only unlinks files, potentially leaving data recoverable. For sensitive files, use tools like `shred -u <filepath>` (Linux) or other secure deletion utilities for your OS to overwrite the data before removal. **Always verify successful encryption and backups before deleting originals.**

#### 4. Git Integration
*   **Add Encrypted Files:** `git add vault/secure/L1_encrypted/MyDocument.md.gpg`
*   **Commit:** `git commit -m "Add encrypted L1 document: MyDocument"` (This commit itself should be signed as per Part II).
*   **`.gitignore` for Unencrypted Files (CRITICAL):** Prevent accidental commits of plaintext L1/L2 data.
    ```gitignore
    # Example .gitignore entries:
    # Prevent committing any Markdown files if originals are kept in same dir as encrypted versions
    # vault/secure/L1/*.md 
    # !vault/secure/L1/*.md.gpg # Un-ignore the encrypted versions

    # More robustly, if plaintext files are in a specific subdirectory:
    vault/secure/L1_plaintext/*
    vault/secure/L2_plaintext/*

    # DO NOT ignore the GPG encrypted files if they are in a specific output directory
    # (or ensure the plaintext version is ignored if encrypting in-place)
    !vault/secure/L1_encrypted/**/*.md.gpg 
    !vault/secure/L2_encrypted/**/*.md.gpg

    # Ignore common local decrypted file patterns/directories
    *_decrypted.md
    vault/secure/**/decrypted/* 
    ```
    Adapt these patterns to your chosen directory structure. The goal is that only `.gpg` (encrypted) versions of sensitive files are committed.

### D. Decryption Workflow (Accessing L1/L2 Documents)
This workflow requires your Feitian K9D and User PIN.

#### 1. Identifying Files for Decryption
Encrypted files (e.g., `MyDocument.md.gpg`) will be in your working directory after `git checkout` or `git pull`.

#### 2. GPG Decryption Commands (Manual)
```bash
gpg --output <original_document_name.md> --decrypt <encrypted_document_name.md.gpg>
```
*   `--output <original_document_name.md>` (`-o`): **Operator Variable.** Output decrypted filename.
*   `--decrypt` (`-d`): Decrypts data.
*   `<encrypted_document_name.md.gpg>`: **Operator Variable.** Path to encrypted file.

**Process:** GPG prompts for K9D User PIN (via `pinentry`), K9D may require touch.

#### 3. "Automated" Decryption with Helper Scripts (Example)
Conceptual script for decrypting files. **Handle decrypted files with extreme care.** Users must adapt and use cautiously.

**Conceptual Bash Script for Directory Decryption:**
```bash
#!/bin/bash

# === USER CONFIGURATION (Operator Variables) ===
# **IMPORTANT**: Review and set these variables carefully. Test in a safe environment first.

# Directory containing encrypted .gpg files from Git
# Example: ENCRYPTED_SOURCE_DIRECTORY="vault/secure/L1_encrypted/"
ENCRYPTED_SOURCE_DIRECTORY="YOUR_ENCRYPTED_SOURCE_DIRECTORY_HERE"

# Directory where decrypted original files will be placed.
# **CRITICAL**: This location MUST be secure (e.g., an encrypted volume, RAM disk, or a
# directory that is definitely in your .gitignore and cleaned regularly).
# Example: DECRYPTED_OUTPUT_DIRECTORY="vault/secure/L1_decrypted_temp/"
DECRYPTED_OUTPUT_DIRECTORY="YOUR_DECRYPTED_OUTPUT_DIRECTORY_HERE"

# File pattern to decrypt (e.g., *.md.gpg, *.gpg)
FILE_PATTERN_TO_DECRYPT="*.md.gpg"
# === END USER CONFIGURATION ===

if [ "$ENCRYPTED_SOURCE_DIRECTORY" == "YOUR_ENCRYPTED_SOURCE_DIRECTORY_HERE" ] || \
   [ "$DECRYPTED_OUTPUT_DIRECTORY" == "YOUR_DECRYPTED_OUTPUT_DIRECTORY_HERE" ]; then
  echo "ERROR: Please configure Operator Variables in the script before running." >&2
  exit 1
fi

mkdir -p "$DECRYPTED_OUTPUT_DIRECTORY"

echo "Starting decryption for files in '$ENCRYPTED_SOURCE_DIRECTORY' matching pattern '$FILE_PATTERN_TO_DECRYPT'..."
echo "Decrypted files will be placed in '$DECRYPTED_OUTPUT_DIRECTORY'."
echo "**WARNING**: Ensure '$DECRYPTED_OUTPUT_DIRECTORY' is secure and managed appropriately."

find "$ENCRYPTED_SOURCE_DIRECTORY" -type f -name "$FILE_PATTERN_TO_DECRYPT" | while read -r filepath; do
  filename=$(basename "$filepath" .gpg) 
  decrypted_filepath="${DECRYPTED_OUTPUT_DIRECTORY%/}/${filename}"
  
  echo "Decrypting '$filepath' to '$decrypted_filepath'..."
  
  gpg --batch --yes --trust-model always --output "$decrypted_filepath" --decrypt "$filepath"
  
  if [ $? -eq 0 ]; then
    echo "  Successfully decrypted '$filename'."
    # chmod 600 "$decrypted_filepath" # Consider setting restrictive permissions
  else
    echo "  ERROR: Failed to decrypt '$filename'. PIN incorrect, key missing, or other GPG error." >&2
    rm -f "$decrypted_filepath" 
  fi
done

echo "Decryption process completed."
echo "**CRITICAL REMINDER**: Securely manage all decrypted files in '$DECRYPTED_OUTPUT_DIRECTORY'. Delete or re-encrypt them when no longer needed."
```

#### 4. Secure Handling of Decrypted Files (CRITICAL)
*   **Minimize Exposure:** Decrypt files only when actively needed.
*   **Secure Storage:** Use encrypted volumes (VeraCrypt, LUKS, BitLocker) or RAM disks for decrypted plaintext.
*   **Avoid Committing Decrypted Files:** Ensure `.gitignore` is effective.
*   **Re-encrypt or Securely Delete:** After use, re-encrypt changes or securely delete plaintext (e.g., using `shred -u` or equivalent).
*   **Beware Temporary Files:** Applications might create temporary/backup files; ensure these are handled securely.

### E. Key Management for Team Access (Brief Overview)
*   **Exchange Public Keys:** Securely share public GPG keys.
*   **Validate Public Keys:** Verify authenticity (fingerprint checking OOB).
*   **Encrypting for Groups:** Use multiple `-r <recipient_key>` flags.
*   **Shared "Team Key" (Advanced, Use with Caution):** Sharing a private key (even on multiple K9Ds) centralizes risk. Generally less recommended.
*   *(Detailed multi-user GPG key management is a separate, advanced topic.)*

## IV. Verifying Your Feitian K9D Hardware Key and GPG Integration

### A. Introduction to Verification
This part provides methods to verify that your Feitian K9D is correctly set up with GnuPG and that cryptographic operations utilize the hardware key. Regular verification is crucial. This assumes Part I (GPG Setup) is complete.

### B. Physical Inspection (Basic Check)
*   **User Responsibility:** Awareness of K9D's physical state.
*   **What to Look For:** Obvious tampering, correct device.
*   **Disclaimer:** Not foolproof against sophisticated attacks.

### C. GPG Command-Line Verifications

#### 1. `gpg --card-status`
Primary command for checking GPG's recognition of the K9D.
```bash
gpg --card-status
```
**Check Output For:** Reader info, Application ID, Serial Number, Key fingerprints, PIN retry counters.

#### 2. `gpg -K` or `gpg --list-secret-keys`
Lists secret keys, indicating hardware-backed stubs.
```bash
gpg -K --keyid-format LONG
```
**Check Output For:** `ssb>` entries showing `Card serial no. = ...` (matching `gpg --card-status`), not a local file path.

#### 3. Checking GPG Agent Status
Query `gpg-agent` for awareness of card keys.
```bash
gpg-connect-agent 'keyinfo --list' /bye
```
Output should list keygrips associated with your card's serial number.

### D. Operational Verification (Ensuring K9D is Used)
Perform test operations and observe behavior. **Note:** Specific LED/touch behavior varies by K9D model; **users MUST consult their Feitian K9D's official documentation to confirm expected physical interactions (LED blinking, touch requirements) for their device.**

#### 1. Test Signing Operation
1.  Create dummy file: `echo "Test sign" > test_sign.txt`
2.  Sign it: `gpg --clearsign --default-key <YOUR_K9D_SIGNING_KEY_ID> test_sign.txt`
3.  **Crucial Observations:**
    *   **Expect PIN Prompt:** `pinentry` should request your K9D User PIN (unless cached).
    *   **Expect K9D Interaction:** Observe K9D for LED activity. **Your specific K9D model may require a physical touch to authorize signing.** This is a key indicator of hardware use.
4.  Verify signature: `gpg --verify test_sign.txt.asc` (should show "Good signature").

#### 2. Test Decryption Operation
1.  Create dummy file: `echo "Test decrypt" > test_decrypt.txt`
2.  Encrypt to K9D's encryption key: `gpg --encrypt --armor -r <YOUR_K9D_ENCRYPTION_KEY_ID> -o test_decrypt.txt.asc test_decrypt.txt`
3.  Decrypt: `gpg -o test_decrypt_recovered.txt -d test_decrypt.txt.asc`
4.  **Crucial Observations:**
    *   **Expect PIN Prompt:** `pinentry` should request K9D User PIN.
    *   **Expect K9D Interaction:** Observe K9D for LED/touch (verify model behavior).
5.  Verify content: `cat test_decrypt_recovered.txt`.

#### 3. Interpreting Observations
*   **PIN Prompt & K9D Physical Interaction:** Strong indicators the K9D is being used correctly.
*   **No PIN Prompt (Unexpectedly):** Investigate immediately.

### E. (Advanced) Key Attestation
*   **Concept:** Hardware key cryptographically proves a key was generated on-device.
*   **K9D & GPG Support:** Standardized OpenPGP key attestation via GPG is not a universally mature feature. **Consult Feitian's documentation for any specific attestation capabilities of your K9D model concerning OpenPGP keys.**
*   **Current Reliance:** Verification primarily relies on operational checks (PIN prompts, K9D interaction) and GPG commands showing hardware-bound keys (`gpg -K`).

### F. Recommendations for Regular Checks
*   Periodically run `gpg --card-status`.
*   Test operations after GPG/OS updates.
*   Be vigilant for expected PIN prompts and K9D physical interactions.

### G. What to Do If Verification Fails
*   **Stop Sensitive Use:** Do not use for L1/L2 operations or critical signing.
*   **Troubleshoot:** Review previous troubleshooting sections, check connections, restart `pcscd`/`gpg-agent`.
*   **Consult Feitian Support.**
*   **Re-initialize GPG Applet (Caution - Last Resort):** This erases on-card keys. Have a recovery plan.
*   **Report:** To organizational security if applicable.

## V. Feitian K9D: GPG Key Backup and Recovery Procedures

### A. Introduction to Backup and Recovery
This part covers essential backup and recovery procedures for GPG keys used with your Feitian K9D. Proactive preparation is vital for mitigating incidents like lost, stolen, or damaged hardware, or forgotten PINs.

*   **Definitions of Loss Events:** Lost/stolen/damaged K9D, forgotten PINs, suspected key exposure.
*   **Goals of Recovery:** Prevent misuse, regain signing/encryption capabilities, and recover data access where possible.

### B. Core Backup Components (Essential Preparations - Recap & Emphasis)

#### 1. Revocation Certificate (Absolute Necessity)
*   **Recap:** Generated via `gpg --output revoke.asc --gen-revoke <KEY_ID>` (Part I.G). **Do this immediately after key setup.**
*   **Secure Storage:** Multiple printed copies offline (safe, bank box), encrypted USBs offline. **NOT with the K9D or unencrypted digitally.**
*   **Purpose:** To publicly declare a key invalid. Publish by importing and sending to keyservers (`gpg --import revoke.asc; gpg --keyserver hkps://keys.openpgp.org --send-keys <KEY_ID>`) and notifying contacts.

#### 2. Offline Master Key (Conditional - If "Option B" from Part 1 Used)
*   **Secure Storage:** The offline master private key must be extremely secure.
*   **Purpose:** Generate new subkeys if K9D-held subkeys are lost/compromised.

#### 3. Backup of Your Public Key
*   Convenient: `gpg --armor --export <KEY_ID> > my_public_key.asc`.

#### 4. Backup of Trusted Public Keys (Contacts)
*   Backup `~/.gnupg` directory (or `pubring.kbx`, `trustdb.gpg`) securely.

#### 5. Backup of Encrypted Data
*   Git repo for committed encrypted files. Local strategy for other data.

### C. Scenario-Based Recovery Procedures

#### 1. Scenario: Feitian K9D is Lost or Stolen
1.  **IMMEDIATE ACTION: Revoke GPG Key:** Use your revocation certificate (see V.B.1).
2.  **Key Replacement:**
    *   **Case 1 (Keys generated on K9D - Part 1, Option A):** Private keys are lost. Generate a new GPG key pair on a new K9D. Distribute new public key. Update `git config --global user.signingkey <NEW_KEY_ID>`. Create new revocation certificate.
    *   **Case 2 (Offline Master Key exists - Part 1, Option B):** Use master key to generate new subkeys, provision to new K9D. Publish updated public key. Update Git config if subkey ID changed.
3.  **Accessing Previously Encrypted Data:**
    *   > **WARNING: Data Inaccessibility Risk**
    > If keys were generated directly on the lost/stolen K9D (Option A), and that K9D held the *only* private key capable of decrypting certain data, then that data is **PERMANENTLY INACCESSIBLE.** This is a critical trade-off of on-card key generation.
    *   **Mitigation:** Use multi-recipient encryption for shared/critical data (encrypt to yourself AND trusted colleagues).
    *   If an offline backup of the *private subkey* existed (highly non-standard for hardware keys), it could be used.

#### 2. Scenario: Feitian K9D is Damaged (Keys Inaccessible)
*   Treat as "Lost or Stolen K9D." Revoke keys, replace K9D/keys, address data access.

#### 3. Scenario: User PIN Forgotten / Card GPG Applet Locked
1.  **User PIN Forgotten (Admin PIN Known):** The Admin PIN often acts as a PUK (PIN Unblocking Key) for the User PIN.
    *   **Operator Variable:** Your knowledge of the Admin PIN.
    *   Use `gpg --card-edit`, then `admin`, then `passwd` (select option to change User PIN or unblock). Consult Feitian docs for exact commands (e.g., `unblock`).
2.  **Admin PIN Forgotten or Both Locked:**
    *   This may lead to permanent GPG applet inaccessibility.
    *   Refer to Feitian documentation for possible factory reset options. **A factory reset WIPES ALL KEYS from the GPG applet.**
    *   If keys become inaccessible, treat as lost/damaged K9D: Revoke (using pre-generated certificate) and replace keys.

#### 4. Scenario: Suspected Private Key Compromise
*   Highly unlikely for K9D on-card keys if PINs are strong and device is physically secure.
*   If suspected: Immediate revocation, stop K9D use, new keys on a new K9D, clean system, investigate.

### D. Post-Recovery Steps
*   Distribute new public key.
*   Update `git config --global user.signingkey <NEW_KEY_ID>`.
*   Re-encrypt shared data if necessary and possible.
*   Update internal documentation.

### E. Best Practices for Prevention and Mitigation (Backup/Recovery)
*   **Generate & Secure Revocation Certificate Immediately.**
*   Understand key generation trade-offs (on-card vs. offline master).
*   Memorize User PIN; securely store Admin PIN (e.g., password manager, physical safe).
*   Encrypt critical shared data to multiple trusted recipients.
*   Regularly verify K9D function (Part IV).
*   Maintain physical security of the K9D.

## VI. Organizational GPG & Feitian K9D: Multi-User Key Management Strategies

### A. Introduction to Multi-User Key Management
This final part outlines strategies for managing GPG keys (especially on Feitian K9Ds) in organizational settings to enable secure collaboration.

*   **Challenges:** Secure key distribution/verification, trust management, group encryption, key lifecycle, policy enforcement.

### B. Establishing a Foundation of Trust: Public Key Management

#### 1. Secure Public Key Distribution & Discovery
*   **Internal Keyserver (e.g., SKS, Hagrid):** Centralized. **Policy Decision:** Deploy and maintain?
*   **WKD (Web Key Directory):** Discovery via HTTPS/email. **Policy Decision:** Setup and resource allocation?
*   **Internal Git Repository for Public Keys:** Auditable, uses Git. **Policy Decision:** Designate repo and define key submission/validation process.
*   **Secure Email/Shared Storage:** Limited scalability.
*   **Discourage Public Keyservers for purely internal keys.**

#### 2. Initial Key Verification (Out-of-Band - OOB)
*   **CRITICAL:** Verify fingerprints OOB (in-person, trusted channel) before trusting any key.
*   Document verified fingerprints internally.

#### 3. Key Signing Policies & Web of Trust
*   **Organizational CA / Designated Signers:** **Policy Decision:** Define who signs employee keys and certification levels. Trusted individuals sign verified keys (`gpg --lsign-key` or `gpg --sign-key`). Simplifies trust.
*   **Peer-to-Peer Key Signing:** Encourage after OOB verification to build a decentralized trust web.

### C. Encrypting for Teams and Roles

#### 1. Encrypting to Multiple Individual Recipients
*   Standard: Multiple `-r <key_id>` flags with `gpg --encrypt`. Good auditability.

#### 2. Managing Groups for Encryption (Helper Scripts/Aliases)
*   Example alias for encrypting to a defined group. **Operator Variable / Policy Decision:** How are groups defined and maintained?
    ```bash
    # Example: GPG_GROUP_PROJECT_X_MEMBERS=("id1" "id2" "id3")
    # encrypt_for_project_x() { ... }
    ```

#### 3. (Advanced) Role-Based Encryption Keys
*   **Concept:** GPG key for a role (e.g., `project-alpha-l2@org.example`).
*   **Private Key Management:** CRITICAL challenge. Shared K9D (high risk, needs access policy - **Operator Variable**), or import to multiple K9Ds (if supported/allowed, dilutes some hardware key benefits).
*   **Pros:** Simpler for encryptor.
*   **Cons:** Reduced auditability, high impact if role key compromised, complex lifecycle.
*   **Recommendation: Use with EXTREME CAUTION.** Prefer multiple individual recipients.

### D. Key Lifecycle Management in the Organization

#### 1. Onboarding New Users
*   Provision K9D (if policy). Guide GPG setup. User generates keys & revocation cert. Public key submitted to internal system. OOB verification. Optional CA signing.

#### 2. Offboarding Users
*   Key Revocation (user or org process). Public key removal from internal systems.
*   **Data Access Transition:** CRITICAL. Re-encrypt files if departing user had unique access. Emphasizes need for prior multi-recipient encryption.

#### 3. Periodic Key Review and Rotation
*   **Policy Decision: Key Rotation Period.** Define if/when keys expire and are rotated (e.g., 1-3 years). Balance security vs. overhead. Subkey rotation is easier.

#### 4. Handling Revoked/Expired Keys
*   Regularly `gpg --refresh-keys`. Train users not to encrypt to bad keys.

### E. Policy for Hardware Key Usage (L1/L2 Data)
*   **Formalize Requirements:**
    *   L2 data: *MUST* use K9D for GPG operations.
    *   L1 data: *SHOULD* use K9D.
    *   **Policy Decision: Exception Process for L1.** If software GPG keys allowed for L1, define strict conditions and approval.
*   **User Training:** GPG, K9D usage, data classification, security policies.
*   **Compliance Checks (Optional):** Audits for signed commits, encrypted files.
