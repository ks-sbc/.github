# Feitian K9D: GPG Key Backup and Recovery Procedures

## 1. Introduction

### Importance of Proactive Measures
While the Feitian K9D significantly enhances the security of your GPG private keys by keeping them on a hardware device, it's crucial to have robust backup and recovery procedures in place. Hardware can be lost, stolen, damaged, or PINs can be forgotten. Proactive preparation is key to mitigating the impact of such events.

### Definitions of Key Compromise / Loss Events
This section addresses recovery from various incidents:
*   **Lost K9D:** The physical device is no longer in your possession and cannot be found.
*   **Stolen K9D:** The device is known to have been taken by an unauthorized party.
*   **Damaged K9D:** The device is physically damaged and no longer functional, making on-card keys inaccessible.
*   **Forgotten PINs:** User or Admin PIN is forgotten, potentially locking the GPG applet on the K9D.
*   **Suspected Key Exposure (Highly Unlikely for K9D Private Keys):** While the K9D is designed to prevent private key extraction, this might refer to a scenario where the key's integrity is doubted due to a broader system compromise or user error (e.g., PIN compromise).

### Goals of Recovery
The primary goals of these recovery procedures are to:
1.  **Prevent Misuse:** Ensure that a lost, stolen, or compromised key cannot be used by unauthorized individuals to impersonate you or decrypt sensitive data.
2.  **Regain Capability:** Restore your ability to sign commits and encrypt/decrypt documents with GPG.
3.  **Regain Data Access (If Possible):** Recover access to data previously encrypted with keys from the affected K9D, where feasible based on your setup and backup strategy.

## 2. Core Backup Components (Essential Preparations - Recap & Emphasis)

Effective recovery relies on preparations made *before* an incident occurs. These components should have been addressed during the initial setup (as detailed in Part 1 of this guide) but are re-emphasized here due to their critical importance.

### A. Revocation Certificate
*   **Absolute Necessity:** This is your most crucial tool if your private key (or the K9D holding it) is lost, stolen, or compromised.
*   **Generation Recap:** Generated using `gpg --output revoke-key.asc --gen-revoke <YOUR_KEY_ID>` (refer to Part 1, Section G for details). **This should be done immediately after key generation/setup.**
*   **Secure, Multi-Location, Offline Storage:**
    *   Print multiple copies and store them in physically separate, secure locations (e.g., home safe, bank deposit box, trusted friend/family member).
    *   Store digital copies on encrypted USB drives, also kept offline and in different secure locations.
    *   **Crucially, do NOT store the revocation certificate alongside your Feitian K9D or in any easily accessible digital form that could be compromised along with your computer.**
*   **Purpose:** Allows you to publicly declare that your GPG key is no longer valid, warning others not to trust it for new signatures or encryptions.

### B. Offline Master Key (Conditional - if "Option B" from Part 1 used)
*   **If you generated your GPG key with an offline master key and transferred subkeys to the K9D (Part 1, Section D, Option 2):**
    *   **Secure Storage:** The offline master private key (and its own revocation certificate) must be stored with extreme security (e.g., encrypted offline media in multiple secure locations).
    *   **Purpose:** Allows you to generate new signing, encryption, and authentication subkeys if the ones on the K9D are compromised or the K9D is lost. Your GPG identity (tied to the master key) remains the same.

### C. Backup of Your Public Key
*   **Good Practice:** While your public key can often be re-exported from a new K9D (if keys are regenerated) or from keyservers, having a readily available copy is convenient.
    ```bash
    gpg --armor --export <YOUR_KEY_ID> > my_public_key.asc
    ```
    Store this with your non-sensitive backups.

### D. Backup of Trusted Public Keys (Contacts)
*   **Regular Keyring Backup:** Your GPG keyring (`~/.gnupg/pubring.kbx` or similar, and `~/.gnupg/trustdb.gpg`) contains the public keys of people you communicate with and your trust settings for them.
    ```bash
    # Example: Backup the entire .gnupg directory (contains public keys, trust settings, and configuration)
    # WARNING: This directory can also contain stubs of private keys if not managed carefully.
    # For purely public key + trust backup, specific file backup is better but more complex.
    # A simpler approach for many is to backup .gnupg and restore it to a new clean GPG environment.
    tar -czvf gnupg_backup_YYYYMMDD.tar.gz ~/.gnupg
    ```
    Store this backup securely. If you need to set up GPG on a new system, restoring this can save time re-importing and re-validating public keys.

### E. Backup of Encrypted Data
*   **Git Repository:** For L1/L2 documents committed to Git as `.gpg` files, the Git repository itself (especially its remote copies) serves as a backup of the *encrypted* files.
*   **Local Unencrypted Files:** If you maintain local unencrypted versions of sensitive files (even temporarily), ensure they are part of your regular system backup strategy and that these backups are themselves encrypted and physically secured. This is outside the scope of GPG key recovery but vital for data recovery.

## 3. Scenario-Based Recovery Procedures

### A. Scenario: Feitian K9D is Lost or Stolen

#### 1. IMMEDIATE ACTION: Revoke GPG Key
This is the first and most critical step to prevent misuse.
*   **Retrieve Your Revocation Certificate:** Access one of your securely stored copies.
*   **Import and Publish (if applicable):**
    ```bash
    gpg --import revoke-key.asc 
    # If you use keyservers and your public key is on them:
    gpg --keyserver <your_preferred_keyserver> --send-keys <YOUR_KEY_ID> 
    ```
    This uploads the revocation information to the keyserver.
*   **Notify Contacts:** Inform your regular correspondents that your key has been revoked and they should not trust new signatures or encrypt new messages to it. Provide them with your new public key once available.

#### 2. Key Replacement

*   **Case 1: Keys Were Generated Directly On K9D (Part 1, Option A)**
    *   **Private Keys Irreversibly Lost:** The private keys that were on the lost/stolen K9D are gone forever.
    *   **Action:**
        1.  Obtain a new Feitian K9D (or other GPG-compatible hardware key).
        2.  Generate a **brand new GPG key pair** on the new K9D (follow Part 1, Sections C & D).
        3.  Distribute your new public key to your contacts and upload it to keyservers if you use them.
        4.  Update your Git configuration: `git config --global user.signingkey <NEW_KEY_ID>`.
        5.  Generate and securely store a new revocation certificate for this new key pair.

*   **Case 2: Offline Master Key Exists (Part 1, Option B)**
    *   **Master Key is Safe:** Your core GPG identity (master key) is secure. Only the subkeys on the K9D were potentially compromised.
    *   **Action:**
        1.  On your secure offline system, use your master key to generate new signing, encryption, and authentication subkeys.
        2.  Obtain a new Feitian K9D.
        3.  Provision these new subkeys to the new K9D (refer to Part 1, Section D, Option 2, for moving subkeys to card).
        4.  Publish your updated public key (which now includes the new subkeys and potentially revoked old ones).
        5.  Update your Git configuration if the signing subkey ID has changed: `git config --global user.signingkey <NEW_SIGNING_SUBKEY_ID>`.
        6.  Generate and securely store a new revocation certificate for the new subkeys if your GPG version/setup handles subkey-specific revocations effectively, or ensure the master key's revocation is paramount.

#### 3. Accessing Previously Encrypted Data

*   **CRITICAL POINT: If keys were generated directly on the lost/stolen K9D (Option A), and that K9D was the *only* device holding the private decryption key, any data encrypted *solely* to that key's encryption subkey is PERMANENTLY INACCESSIBLE.**
    *   This underscores the importance of the chosen key generation strategy and data encryption practices.
*   **If an Offline Master Key + Subkey Backup Existed (Rare for typical hardware key use, implies private subkey material was also backed up, which is against the main security model of on-card generation):** If you had an export of the private subkey material (not just the master key), you might be able to import it into a new GPG setup. This is generally not the standard practice when relying on hardware keys for private key protection.
*   **Multi-Recipient Encryption:**
    *   If the data was encrypted to multiple recipients (e.g., yourself and trusted team members), those other recipients can still decrypt the data using their private keys. This is a key strategy for shared sensitive data.
    *   **Strategy:** For important shared data, always encrypt it to the public keys of all authorized individuals. For personal data that only you need to access, understand the risk if the K9D is your only means of decryption.

### B. Scenario: Feitian K9D is Damaged (Keys Inaccessible)
*   **Treat as "Lost or Stolen K9D":** The recovery steps are essentially the same.
    1.  **Revoke the GPG key** using your revocation certificate (as a precaution, in case the damage is not absolute or the card could be repaired by malicious actors, however unlikely).
    2.  **Replace the key** (either generate a new key pair or use an offline master key to create new subkeys for a new K9D).
    3.  Address access to previously encrypted data as described above.

### C. Scenario: User PIN Forgotten / Card GPG Applet Locked

#### 1. User PIN Forgotten (Admin PIN Known)
*   **Retry Limits:** You have a limited number of attempts (usually 3, check `gpg --card-status`) for the User PIN.
*   **Unblocking with Admin PIN:** If you know your **Admin PIN**, you can reset the User PIN or unblock it.
    *   **Operator Variable:** Knowledge of your current Admin PIN.
    ```bash
    gpg --card-edit
    admin # Enter Admin PIN
    passwd # Select option 1 to change User PIN, or option 4 to unblock User PIN if available
    # Alternatively, some cards offer an 'unblock' command directly in admin mode.
    # Or 'gpg --change-pin' might also work if card is in a suitable state.
    quit
    ```
    Consult your Feitian K9D documentation for the exact commands and options supported by your card model for PIN unblocking/reset.

#### 2. Admin PIN Forgotten or Both User/Admin PINs Locked
*   **Potential Permanent Lockout:** If the Admin PIN is forgotten, or if both User and Admin PIN retry counters are exhausted, the GPG applet on the K9D may become permanently inaccessible for GPG operations.
*   **Factory Reset (Refer to Feitian Documentation):** Some hardware keys offer a factory reset mechanism. This **WILL WIPE ALL KEYS and data from the GPG applet** (and possibly other applets on the device). It effectively turns it into a new, uninitialized card. You would then need to start the setup from scratch (Part 1).
*   **If Keys Inaccessible:** If the GPG applet is locked and cannot be reset, or if a factory reset is performed, treat the GPG keys that were on it as lost.
    1.  **Revoke the GPG key** using your revocation certificate.
    2.  **Replace the key** (generate a new key pair on the (reset) K9D or a new K9D, or use an offline master key).

### D. Scenario: Suspected Private Key Compromise
This scenario is highly unlikely for private keys generated and kept on a Feitian K9D, as they are designed not to be exportable. However, a "compromise" could be theorized in extreme cases (e.g., sophisticated hardware attack, severe PIN compromise combined with physical access by an attacker with advanced capabilities).

1.  **IMMEDIATE ACTION: Revoke GPG Key:** Use your revocation certificate immediately.
2.  **Stop Using the K9D:** Do not perform any further cryptographic operations with the suspect K9D.
3.  **New Keys on a New K9D:** Generate or provision keys on a new, trusted Feitian K9D.
4.  **Clean System:** Ensure the computer systems you use with the new K9D are secure and free from malware.
5.  **Investigation:** If applicable, conduct an investigation to understand how a compromise might have occurred.

## 4. Post-Recovery Steps

After successfully revoking an old key and establishing a new one:

*   **Distribute New Public Key:** If a new key pair was generated, ensure your contacts receive and validate your new public key. Update keyservers if you use them.
*   **Update Git `user.signingkey`:** Configure Git globally and/or in relevant repositories to use the new signing key ID:
    ```bash
    git config --global user.signingkey <NEW_KEY_ID_OR_SUBKEY_ID>
    ```
*   **Re-encrypt Shared Data (If Necessary):**
    *   If shared data was encrypted to the old, revoked key, it may need to be decrypted by someone who still has access (if multi-recipient encryption was used) and then re-encrypted to the new set of public keys (including your new public key). This is a complex task and depends on your team's data management strategy.
*   **Update Internal Documentation:** Update any personal or team documentation that references the old GPG key.

## 5. Best Practices for Prevention and Mitigation

*   **Revocation Certificate First:** Generate and securely store your revocation certificate *immediately* after key setup. This is your primary safety net.
*   **Choose Key Generation Strategy Wisely:** Understand the implications of on-card key generation (private keys never leave the card, but data inaccessible if K9D lost and it was the sole decryption key) versus using an offline master key (more complex, but master identity preserved).
*   **PIN Management:**
    *   Memorize your User PIN.
    *   Securely store your Admin PIN (e.g., in a trusted password manager, physically written down and stored separately from the K9D in a very secure location).
*   **Multi-Recipient Encryption:** For critical shared documents, always encrypt to multiple trusted recipients (including yourself). This provides redundancy for decryption access.
*   **Regular Verification:** Periodically verify your K9D's function as outlined in Part 4 of this guide.
*   **Physical Security of K9D:** Treat your Feitian K9D like any other important key. Secure it against loss and unauthorized physical access.
*   **Regular GPG Keyring Backups:** Backup your `~/.gnupg` directory (or at least `pubring.kbx` and `trustdb.gpg`) to preserve your trusted public keys and trust settings. Store this backup securely.
