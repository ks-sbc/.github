# Secure Document Workflows: Encrypting and Decrypting L1/L2 Files with Feitian K9D and GPG

## 1. Introduction

### Purpose
This section outlines the procedures for encrypting and decrypting sensitive files, particularly those classified as L1 (Internal) and L2 (Secure), using GPG keys managed by your Feitian K9D security key.

### Scope
The focus here is on file and directory-level encryption for documents intended to be stored in a Git repository. This is distinct from full-disk encryption or transport-layer encryption, although it complements them.

### Benefits
*   **Data-at-Rest Protection:** Encrypting files ensures that even if the repository or underlying storage is compromised, the sensitive content remains unreadable without the correct GPG private key.
*   **Hardware-Backed Security:** Decryption operations require the Feitian K9D to be present and the correct User PIN to be entered (and potentially a touch confirmation), providing strong protection for the decryption key.
*   **Authorized Access Control:** Only individuals possessing the necessary GPG private key (held on their K9D) and its PIN can decrypt and access the sensitive information.

### Security Reminder
Encrypting files is a critical component of a defense-in-depth strategy. However, it's essential to remember that overall security also depends on factors like strong PINs, secure handling of the K9D, protecting your computer from malware, and secure practices for managing decrypted files. This guide should be used within the broader security context of the DRUIDS project.

## 2. Prerequisites

Before proceeding with encryption and decryption workflows, ensure the following are met:

*   **Feitian K9D GPG Setup Completed:** You must have successfully completed Part 1 of this guide ("Setting Up Your Feitian K9D with GPG for Different Security Tiers"), meaning your K9D is initialized, has GPG keys (including an encryption subkey), and is recognized by your GPG environment.
*   **GnuPG Installed and Configured:** GnuPG (gpg, gpg-agent, scdaemon, pinentry) must be correctly installed and functioning on your system.
*   **Recipient Public GPG Keys Imported (for Encryption):** To encrypt a file for others (or for yourself for later decryption), you need their public GPG keys imported into your GPG keyring and ideally validated (e.g., through key signing or direct exchange).
*   **Understanding of L1/L2 Classification:** Familiarize yourself with your organization's data classification policy to correctly identify which files require encryption as L1 or L2 documents.

## 3. Encryption Workflow (Protecting L1/L2 Documents)

This workflow describes how to encrypt sensitive documents before committing them to the Git repository.

### A. Identifying Files for Encryption

*   **Manual Selection:** For individual sensitive files, you can manually select them for encryption.
*   **Directory-Based Policy (Recommended):** A more robust approach is to establish specific directories for different classification levels. For example:
    *   `vault/secure/L1/` for L1 internal documents.
    *   `vault/secure/L2/` for L2 highly sensitive documents.
    All files placed within these directories (that are not already encrypted) should be encrypted.

### B. GPG Encryption Commands (Manual)

GPG provides powerful command-line tools for encryption. The primary method for this workflow is asymmetric (public-key) encryption.

*   **Asymmetric Encryption (Recommended):**
    This method uses the recipient's public GPG key to encrypt the file. Only the corresponding private key (held by the recipient, ideally on their K9D) can decrypt it.

    ```bash
    gpg --armor --encrypt --recipient <recipient1_key_id_or_email> --recipient <recipient2_key_id_or_email> --output <encrypted_document_name.md.gpg> <original_document_name.md>
    ```
    **Explanation of Flags:**
    *   `--armor` or `-a`: Creates ASCII armored output (a text-based `.asc` or `.gpg` file that looks like a block of random characters), which is generally easier to handle in text-based systems like Git. If omitted, GPG produces binary output.
    *   `--encrypt` or `-e`: Instructs GPG to encrypt the data.
    *   `--recipient <key_id_or_email>` or `-r <key_id_or_email>`: Specifies the recipient of the encrypted file. You must have their public key in your keyring.
        *   **Operator Variable:** `<recipient_key_id_or_email>` is the GPG Key ID (long or short) or the email address associated with the recipient's public key.
        *   **Self-Encryption:** To encrypt a file for yourself (so you can decrypt it later with your K9D), use your own GPG key ID/email as a recipient.
        *   **Multiple Recipients:** You can include multiple `--recipient` flags to encrypt the file for several individuals simultaneously. Each will be able to decrypt it with their respective private key.
    *   `--output <encrypted_document_name.md.gpg>` or `-o <encrypted_document_name.md.gpg>`: Specifies the name for the output encrypted file. Using `.gpg` as the extension for GPG-encrypted files is a common convention.
        *   **Operator Variable:** `<encrypted_document_name.md.gpg>` is the desired filename for the encrypted output.
    *   `<original_document_name.md>`: The path to the original, unencrypted file.
        *   **Operator Variable:** `<original_document_name.md>` is the path to the file you want to encrypt.

    **Example:**
    ```bash
    gpg --armor --encrypt -r "user1@example.com" -r "user2-key-id" --output "MySecretDocument.md.gpg" "MySecretDocument.md"
    ```

*   **Symmetric Encryption (`gpg -c`):**
    GPG also supports symmetric encryption (`gpg --symmetric` or `gpg -c`), which encrypts the file using a passphrase only.
    ```bash
    gpg -c --output <encrypted_document_name.md.gpg> <original_document_name.md> 
    ```
    You will be prompted to create a passphrase.
    **Recommendation:** For the DRUIDS workflow, which emphasizes GPG key pairs (especially hardware-backed keys), **asymmetric encryption is strongly preferred over symmetric encryption.** Symmetric encryption relies on securely sharing and managing passphrases, which can be problematic for team collaboration and doesn't leverage the hardware security of the K9D for key management during encryption (though the K9D is used for decryption if you encrypt to yourself).

### C. "Automated" Encryption with Helper Scripts (Example)

Manually encrypting many files can be tedious. A helper script can automate this for files within designated directories. Below is a conceptual Bash script outline.

**Conceptual Bash Script for Directory Encryption:**
```bash
#!/bin/bash

# === CONFIGURATION (Operator Variables) ===
# Directory containing original unencrypted L1/L2 files
SOURCE_DIRECTORY="vault/secure/L1/"
# Directory where encrypted .gpg files will be placed
ENCRYPTED_OUTPUT_DIRECTORY="vault/secure/L1_encrypted/" # Or encrypt in-place and modify .gitignore
# GPG Key IDs or emails of ALL recipients (including yourself if you need to decrypt)
# Ensure these public keys are in your GPG keyring.
RECIPIENT_GPG_KEY_IDS=("your_key_id@example.com" "teammate1@example.com" "teammate2_key_id")
# Whether to delete original files after successful encryption (use with extreme caution!)
DELETE_ORIGINALS_AFTER_ENCRYPTION=false # Set to true ONLY if you are certain and have backups.
# File pattern to encrypt (e.g., *.md, *.txt, * for all files)
FILE_PATTERN_TO_ENCRYPT="*.md" 
# === END CONFIGURATION ===

# Ensure output directory exists
mkdir -p "$ENCRYPTED_OUTPUT_DIRECTORY"

# Build recipient arguments for GPG
recipient_args=()
for recipient_id in "${RECIPIENT_GPG_KEY_IDS[@]}"; do
  recipient_args+=("--recipient" "$recipient_id")
done

echo "Starting encryption for files in '$SOURCE_DIRECTORY'..."

find "$SOURCE_DIRECTORY" -type f -name "$FILE_PATTERN_TO_ENCRYPT" | while read -r filepath; do
  filename=$(basename "$filepath")
  encrypted_filepath="${ENCRYPTED_OUTPUT_DIRECTORY}${filename}.gpg"
  
  echo "Encrypting '$filepath' to '$encrypted_filepath' for recipients: ${RECIPIENT_GPG_KEY_IDS[*]}..."
  
  # Perform encryption
  gpg --armor --encrypt "${recipient_args[@]}" --output "$encrypted_filepath" "$filepath"
  
  if [ $? -eq 0 ]; then
    echo "  Successfully encrypted '$filename'."
    if [ "$DELETE_ORIGINALS_AFTER_ENCRYPTION" = true ]; then
      echo "  Securely deleting original '$filepath'..."
      # Use 'shred' or 'srm' for more secure deletion if available and necessary. 'rm' is standard.
      # shred -u "$filepath" # Example with shred
      rm "$filepath" # Standard deletion
      echo "  Original '$filename' deleted."
    fi
  else
    echo "  ERROR: Failed to encrypt '$filename'. Original file NOT deleted." >&2
  fi
done

echo "Encryption process completed."
```
**Key Operator Variables to Highlight in Script:**
*   `SOURCE_DIRECTORY`: Path to original files.
*   `ENCRYPTED_OUTPUT_DIRECTORY`: Where to save encrypted files.
*   `RECIPIENT_GPG_KEY_IDS`: An array of GPG Key IDs or emails for all intended recipients. **Crucially, include your own key ID if you need to decrypt these files later.**
*   `DELETE_ORIGINALS_AFTER_ENCRYPTION`: Boolean (`true`/`false`). **Use with extreme caution.**
*   `FILE_PATTERN_TO_ENCRYPT`: Glob pattern for files to encrypt (e.g., `*.md`).

**Security Note on Deleting Originals:**
If `DELETE_ORIGINALS_AFTER_ENCRYPTION` is set to `true`:
*   Standard `rm` may not securely erase data from disk; it often just unlinks the file.
*   For higher security, consider using tools like `shred` (common on Linux) or `srm` (secure remove) if available and your threat model requires it. `shred -u <filepath>` overwrites the file before deleting.
*   **Always ensure successful encryption and backup before deleting originals.**

### D. Git Integration

1.  **Add Encrypted Files:** Once files are encrypted (e.g., `MyDocument.md.gpg`), add them to Git staging:
    ```bash
    git add vault/secure/L1_encrypted/MyDocument.md.gpg
    ```
2.  **Commit:** Commit the encrypted files. If you have hardware-backed signing configured (Part 2 of this guide), the commit itself will also be signed.
    ```bash
    git commit -m "Add encrypted L1 document: MyDocument"
    ```
3.  **`.gitignore` for Unencrypted L1/L2 Files:**
    It is **CRITICAL** to prevent accidental commits of unencrypted L1/L2 documents. Configure your `.gitignore` file accordingly.
    **Example `.gitignore` entries:**
    ```gitignore
    # Ignore all markdown files within L1 and L2 secure directories
    vault/secure/L1/**/*.md
    vault/secure/L2/**/*.md

    # But DO NOT ignore the GPG encrypted files in those directories
    !vault/secure/L1/**/*.md.gpg
    !vault/secure/L2/**/*.md.gpg

    # Also, generally ignore specific local decrypted files (if a pattern is used)
    # For example, if decrypted files are temporarily placed in a 'decrypted' subfolder:
    vault/secure/L1/decrypted/*
    vault/secure/L2/decrypted/*
    # Or if they are named with a specific pattern during decryption:
    *_decrypted.md 
    ```
    This ensures that only the `.gpg` (encrypted) versions are tracked by Git.

## 4. Decryption Workflow (Accessing L1/L2 Documents)

This workflow describes how to decrypt sensitive documents after checking them out from the Git repository. Decryption requires your Feitian K9D (containing the private GPG encryption subkey) to be connected and your User PIN.

### A. Identifying Files for Decryption
After pulling changes or checking out a branch, you will have `.gpg` files (e.g., `MyDocument.md.gpg`) in your working directory.

### B. GPG Decryption Commands (Manual)

```bash
gpg --output <original_document_name.md> --decrypt <encrypted_document_name.md.gpg>
```
**Explanation:**
*   `--output <original_document_name.md>` or `-o <original_document_name.md>`: Specifies the name for the output decrypted (original) file.
    *   **Operator Variable:** `<original_document_name.md>` is the desired filename for the decrypted plaintext.
*   `--decrypt` or `-d`: Instructs GPG to decrypt the data.
*   `<encrypted_document_name.md.gpg>`: The path to the encrypted file you want to decrypt.
    *   **Operator Variable:** `<encrypted_document_name.md.gpg>` is the path to the encrypted file.

**Process:**
1.  Run the command.
2.  GPG will communicate with `gpg-agent`.
3.  `gpg-agent` will prompt for your **Feitian K9D User PIN** via a `pinentry` program.
4.  Your K9D might require a **physical touch confirmation** to authorize the use of the decryption key.
5.  If the PIN is correct and touch (if required) is provided, the K9D decrypts the data, which GPG then writes to the specified output file.

**Example:**
```bash
gpg --output "MySecretDocument_decrypted.md" --decrypt "MySecretDocument.md.gpg"
```

### C. "Automated" Decryption with Helper Scripts (Example)

Similar to encryption, a helper script can decrypt multiple files from a directory.

**Conceptual Bash Script for Directory Decryption:**
```bash
#!/bin/bash

# === CONFIGURATION (Operator Variables) ===
# Directory containing encrypted .gpg files from Git
ENCRYPTED_SOURCE_DIRECTORY="vault/secure/L1_encrypted/"
# Directory where decrypted original files will be placed
# CRITICAL: Ensure this is a secure, temporary location, ideally an encrypted volume or RAM disk.
# For simplicity, this example decrypts to a 'decrypted' subfolder.
# Consider adding this output path to your .gitignore
DECRYPTED_OUTPUT_DIRECTORY="${ENCRYPTED_SOURCE_DIRECTORY}decrypted/"
# File pattern to decrypt (e.g., *.md.gpg, *.gpg)
FILE_PATTERN_TO_DECRYPT="*.md.gpg"
# === END CONFIGURATION ===

# Ensure output directory exists
mkdir -p "$DECRYPTED_OUTPUT_DIRECTORY"

echo "Starting decryption for files in '$ENCRYPTED_SOURCE_DIRECTORY'..."

find "$ENCRYPTED_SOURCE_DIRECTORY" -type f -name "$FILE_PATTERN_TO_DECRYPT" | while read -r filepath; do
  filename=$(basename "$filepath" .gpg) # Remove .gpg extension for output
  decrypted_filepath="${DECRYPTED_OUTPUT_DIRECTORY}${filename}"
  
  echo "Decrypting '$filepath' to '$decrypted_filepath'..."
  
  # Perform decryption (assumes your K9D and GPG are set up)
  gpg --output "$decrypted_filepath" --decrypt "$filepath"
  
  if [ $? -eq 0 ]; then
    echo "  Successfully decrypted '$filename'."
    # Consider setting permissions on decrypted_filepath if sensitive: chmod 600 "$decrypted_filepath"
  else
    echo "  ERROR: Failed to decrypt '$filename'. PIN incorrect, key missing, or other GPG error." >&2
    # Remove potentially empty output file on failure
    rm -f "$decrypted_filepath" 
  fi
done

echo "Decryption process completed. Remember to handle decrypted files securely!"
```
**Key Operator Variables to Highlight in Script:**
*   `ENCRYPTED_SOURCE_DIRECTORY`: Path to encrypted `.gpg` files.
*   `DECRYPTED_OUTPUT_DIRECTORY`: Where to save decrypted files. **This location must be handled with extreme care.**
*   `FILE_PATTERN_TO_DECRYPT`: Glob pattern for files to decrypt (e.g., `*.md.gpg`).

### D. Secure Handling of Decrypted Files

This is a **CRITICAL** aspect of the workflow:

*   **Minimize Exposure:** Decrypt files only when you need to work with them.
*   **Secure Storage for Decrypted Data:**
    *   Ideally, decrypt files to an **encrypted volume** (e.g., VeraCrypt, LUKS, BitLocker) or a **RAM disk** if your OS supports it and the files are small enough. This helps protect the plaintext data if your main system is compromised.
    *   If decrypted to a standard filesystem, ensure the directory has restrictive permissions.
*   **Avoid Committing Decrypted Files:** Your `.gitignore` (Section 3.D) should prevent this, but always be vigilant. Committing unencrypted L1/L2 data defeats the purpose of this workflow.
*   **Re-encrypt or Securely Delete After Use:**
    *   Once you are finished working with a decrypted file, either:
        1.  Re-encrypt it if you made changes that need to be saved in the encrypted store.
        2.  **Securely delete** the plaintext version. Again, `rm` might not be enough for highly sensitive data; consider `shred -u` or equivalent tools.
*   **Temporary Files:** Be aware that some applications create temporary or backup files. Ensure these are also handled securely or that applications are configured to save temporary files to encrypted locations.

## 5. Key Management for Team Access (Brief Overview)

For team members to encrypt files for each other and decrypt files encrypted by others, proper GPG key management is essential.

*   **Exchanging Public Keys:** Team members need to exchange their public GPG keys. This can be done via:
    *   Emailing the exported public key (`gpg --armor --export <your_key_id>`).
    *   Using public key servers (e.g., `keys.openpgp.org`, `keyserver.ubuntu.com`), though be mindful of privacy implications of publishing keys.
*   **Validating Public Keys (Web of Trust / Key Signing):**
    *   Before trusting a public key, verify its authenticity to prevent encrypting data for an attacker. This can be done by:
        *   Directly verifying the key's fingerprint with the owner (e.g., in person, via a trusted communication channel).
        *   Participating in key-signing parties to build a web of trust.
*   **Encrypting for Groups (Multiple `-r` Flags):**
    *   As shown in Section 3.B, use multiple `--recipient` (or `-r`) flags in the `gpg --encrypt` command to encrypt a single file for several individuals. Each listed recipient will be able to decrypt it using their own private key (on their K9D).
    ```bash
    gpg --encrypt -r alice@example.com -r bob_key_id -r carol@example.com --output secret.gpg original.txt
    ```
*   **Shared "Team Key" (Advanced and Use with Caution):**
    *   For some scenarios, a team might consider creating a dedicated GPG key pair where the private key is shared among trusted team members (e.g., by securely distributing copies of the private key for import onto their individual K9Ds, if the K9D model supports private key import, or by having multiple K9Ds initialized with the same key material via a careful, secure process).
    *   **Caution:** This approach centralizes risk. If this shared private key is compromised, all documents encrypted to it are vulnerable. It also dilutes individual accountability. This is generally less recommended than encrypting to individual recipients, especially when hardware keys are involved, as the primary benefit of a hardware key is individual, non-exportable private key storage.
*   **Further Details:** Detailed multi-user GPG key management, revocation, and update strategies are complex topics and will be covered in separate, dedicated documentation if required by the DRUIDS project. This section provides only a brief operational overview.

By following these encryption and decryption workflows, and by diligently managing GPG keys and the handling of decrypted data, you can significantly enhance the security of sensitive L1 and L2 documents within your Git repository.
