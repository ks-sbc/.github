# Organizational GPG & Feitian K9D: Multi-User Key Management Strategies

## 1. Introduction

### Purpose
This section outlines strategies and considerations for managing GnuPG (GPG) keys, especially those held on Feitian K9D hardware security keys, within multi-user or organizational settings. The goal is to enable secure collaboration, data encryption, and commit signing while addressing the complexities introduced when multiple users are involved.

### Challenges
Managing GPG keys in an organization presents several challenges:
*   **Secure Public Key Distribution and Verification:** How do users reliably find and trust each other's public keys?
*   **Trust Management:** How is trust in public keys established and maintained?
*   **Group Encryption:** How can data be encrypted for teams or roles efficiently and securely?
*   **Key Lifecycle Management:** How are keys handled when users join or leave the organization, or when keys need to be rotated or revoked?
*   **Policy Enforcement:** How are organizational policies regarding key usage (e.g., mandatory hardware keys for certain data) enforced?

This section aims to provide a framework for addressing these challenges.

## 2. Establishing a Foundation of Trust: Public Key Management

Reliable public key management is the cornerstone of secure GPG usage in a team.

### A. Secure Public Key Distribution & Discovery

Team members need a trustworthy way to obtain each other's public GPG keys.

*   **Internal Keyserver (e.g., SKS, Hagrid):**
    *   **Pros:** Centralized, searchable repository for internal public keys. Can automate updates.
    *   **Cons:** Requires setup and maintenance of the keyserver software. Needs policies for key submission and removal.
    *   **Operator Variable: Decision to Deploy Internal Keyserver.** If yes, further decisions on specific software, maintenance R&R, and access control are needed.

*   **WKD (Web Key Directory):**
    *   **Pros:** Allows discovery of public keys via HTTPS based on email addresses (e.g., `gpg --auto-key-locate clear,wkd --locate-keys user@example.org`). Leverages existing web infrastructure.
    *   **Cons:** Requires specific setup on a web server (e.g., Nginx, Apache) and DNS configuration. Keys must be named and placed correctly according to the WKD specification.
    *   **Operator Variable: Decision and Resources for WKD Deployment.** If yes, requires web admin and potentially DNS admin effort.

*   **Internal Git Repository for Public Keys:**
    *   **Pros:** Uses familiar Git infrastructure. Changes are auditable via commit history. Access control via Git repository permissions.
    *   **Cons:** Less automated discovery than WKD or a keyserver (users might need to manually pull and import). Requires a defined process for submitting, validating, and organizing keys within the repository (e.g., directory structure by username or team, clear naming conventions for key files).
    *   **Operator Variable: Designation of a Git Repository and Definition of Key Management Process.** This includes how keys are submitted (e.g., via PRs), validated, and imported by users.

*   **Secure Email / Shared Encrypted Storage:**
    *   **Pros:** Simple for very small teams.
    *   **Cons:** Does not scale well. Prone to errors (e.g., sending wrong key, key not reaching everyone). Verification can be ad-hoc. Less suitable for automated processes.

*   **Discourage Public Keyserver Use for Purely Internal Keys:**
    *   While public keyservers (e.g., `keys.openpgp.org`) are useful for general public communication, relying on them exclusively for internal organizational keys can be problematic:
        *   No control over key removal or outdated information.
        *   Potential for spam or malicious key uploads.
        *   May not align with internal privacy or security policies.
    *   An internal, controlled mechanism is generally preferred for organizational key discovery.

### B. Initial Key Verification (Out-of-Band - OOB)
**This is a CRITICAL step, regardless of the distribution method chosen.**
*   **Importance:** Before trusting any public key, its fingerprint *must* be verified out-of-band with the purported owner. This prevents man-in-the-middle attacks where an attacker might substitute their own key.
*   **Methods:**
    *   In-person verification (e.g., reading fingerprints at a team meeting).
    *   Verification via a trusted secondary communication channel (e.g., video call where IDs are confirmed, secure authenticated chat).
    *   **Do NOT trust a key solely based on it being on a keyserver or in an email without OOB fingerprint verification.**
*   **Documenting Verified Fingerprints:**
    *   Maintain an internal, secure list or database of users and their verified GPG key fingerprints. This can be part of the internal Git repo for public keys or a separate secure document.

### C. Key Signing Policies & Web of Trust

Once a key's fingerprint is verified OOB, signing it with your own GPG key records your trust in it.

*   **Organizational CA / Designated Signers (More Formal):**
    *   **Concept:** The organization designates one or more trusted individuals (or a specific GPG key, an "Organizational CA") to sign the GPG keys of verified employees. This creates a local, hierarchical trust model.
    *   **Benefits:** Users only need to trust the Organizational CA key(s). If they trust the CA, they can transitively trust keys signed by it. Simplifies trust for new users.
    *   **Command:** `gpg --lsign-key <verified_user_key_id>` (local signature, not typically exported). Or `gpg --sign-key <verified_user_key_id>` for an exportable signature.
    *   **Operator Variable: Policy on Designated Signers and Certification Levels.** Define who can sign, the verification process they must follow, and the certification level (e.g., `gpg --edit-key <key_id>` then `tsign` and choose level 1, 2, or 3) they apply.
    *   The public key of the Organizational CA must be securely distributed and trusted by all employees.

*   **Peer-to-Peer Key Signing (Less Formal / Complementary):**
    *   Encourage employees to sign each other's keys after they have performed their own OOB fingerprint verification.
    *   This builds a more decentralized "web of trust" within the organization.
    *   Command: `gpg --sign-key <verified_user_key_id>`.

## 3. Encrypting for Teams and Roles

When encrypting documents for multiple users, consider these approaches:

### A. Encrypting to Multiple Individual Recipients
*   **Standard Practice:** Use multiple `--recipient` (or `-r`) flags with the `gpg --encrypt` command, listing the GPG key ID or email of each authorized individual.
    ```bash
    gpg --armor --encrypt \
        -r <user1_key_id> \
        -r <user2_key_id> \
        -r <user3_key_id> \
        --output sensitive_document.gpg original_document.txt
    ```
*   **Auditability:** This method clearly shows who has been granted access (assuming key IDs are known).
*   **Hardware Key Benefit:** Each recipient uses their own Feitian K9D (or other GPG key store) to decrypt, maintaining individual key security.

### B. Managing Groups for Encryption (Helper Scripts/Aliases)
For frequently used groups, aliases or simple scripts can simplify encryption.

*   **Example Bash Alias/Function:**
    ```bash
    # Add to ~/.bashrc or ~/.zshrc
    # Operator Variable: Define group members for 'project_alpha_team'
    GPG_GROUP_PROJECT_ALPHA=("user1@example.com" "user2_keyid" "manager_keyid")

    encrypt_for_project_alpha() {
        if [ -z "$1" ] || [ -z "$2" ]; then
            echo "Usage: encrypt_for_project_alpha <original_file> <encrypted_output_file.gpg>"
            return 1
        fi
        local recipient_args=()
        for recipient in "${GPG_GROUP_PROJECT_ALPHA[@]}"; do
            recipient_args+=("-r" "$recipient")
        done
        gpg --armor --encrypt "${recipient_args[@]}" -o "$2" "$1"
        echo "Encrypted '$1' for Project Alpha team to '$2'"
    }
    ```
*   **Operator Variable: Standardized Group Definitions.** The organization needs to define and maintain these group lists (e.g., in a shared script, configuration file, or even a dynamically generated list from an identity system if advanced). Changes to group membership require updating these definitions.

### C. (Advanced) Role-Based Encryption Keys
*   **Concept:** A dedicated GPG key pair is created for a specific role or project (e.g., `project-alpha-l2-access@org.example.com`, `security-incident-response-team@org.example.com`). Documents are encrypted to this role key's public key.
*   **Private Key Management for Role Key:** This is the critical challenge.
    *   The private key for the role *must* be securely managed.
    *   **Option 1 (Shared K9D - High Risk):** Store the role's private key on a Feitian K9D that is physically secured but accessible to authorized members of that role. Requires strict access procedures.
        *   **Operator Variable: Policy for Role K9D Access and Security.** Who holds it? How is access logged? What if it's lost?
    *   **Option 2 (Key Splitting/Shamir's Secret Sharing - Very Advanced):** Not directly supported by GPG for private keys in a simple way.
    *   **Option 3 (Private Key Imported to Multiple User K9Ds - If supported by K9D model and policy):** Some security keys allow importing private keys. If the role key's private part is imported onto the individual K9Ds of *all* members fulfilling that role. This dilutes the core benefit of non-exportable keys if the source key was software-generated.
*   **Usage:** Users encrypt documents using `-r project-alpha-l2-access@org.example.com`. Authorized individuals access the role's private key (e.g., via the shared K9D with its PIN) to decrypt.
*   **Pros:** Simplifies encryption for the sender (only one recipient ID to specify for the group).
*   **Cons:**
    *   **Reduced Auditability:** Harder to tell exactly *who* decrypted a file, only that someone with access to the role key did.
    *   **Higher Impact if Role Key Compromised:** All data encrypted to the role key is vulnerable.
    *   **Complex Lifecycle:** Managing the role key's revocation, rotation, and access for a changing team is difficult.
    *   **PIN Management for Shared K9D:** Securely managing and distributing the PIN for a shared K9D is problematic.
*   **Recommendation:** **Use with EXTREME CAUTION.** Generally, encrypting to multiple individual recipients (Option A) is preferred for better security and auditability, especially when individual hardware keys (K9Ds) are in use. Role-based keys should only be considered if the operational benefits clearly outweigh the significant security and management overhead.

## 4. Key Lifecycle Management in the Organization

A defined policy for the entire lifecycle of GPG keys is essential.

### A. Onboarding New Users
1.  **Hardware Provisioning (Optional):** Provide new user with an organizational Feitian K9D if policy dictates.
2.  **Guidance:** Direct user to organizational GPG setup guides (like this one).
3.  **Key Generation:** User generates GPG keys on their K9D (as per Part 1).
4.  **Revocation Certificate:** User generates and securely stores their revocation certificate. This must be confirmed.
5.  **Public Key Submission:** User submits their public GPG key to the designated internal distribution mechanism (e.g., internal keyserver, Git repo for keys).
6.  **Out-of-Band Verification:** The submitted public key fingerprint is verified OOB by a manager, IT security, or designated team members.
7.  **Organizational Signing (Optional):** If applicable, the verified public key is signed by the Organizational CA or designated signers.

### B. Offboarding Users
1.  **Key Revocation:**
    *   **User Self-Revokes:** Ideally, the departing user revokes their GPG key using their revocation certificate and publishes this revocation.
    *   **Organizational Revocation Process:** If the user cannot or does not revoke their key, the organization needs a process to declare the key untrusted (e.g., internal notices, removing from trusted lists). Publishing a third-party revocation (if possible and ethical) is complex.
2.  **Public Key Removal:** Remove the user's public key from internal keyservers, WKD, or Git repositories for public keys.
3.  **Data Access Transition:**
    *   **Critical:** If data was encrypted *only* to the departing user's public key, access to that data will be lost unless they decrypt it before leaving or other measures were taken.
    *   This highlights the importance of **encrypting shared organizational data to multiple trusted individual recipients** or, very cautiously, to a well-managed role key to which current team members retain access.
    *   Files may need to be re-encrypted for the remaining team members if the departing user had unique access.

### C. Periodic Key Review and Rotation (Policy Decision)
*   **Operator Variable: Key Rotation Policy Period.** Decide if and when GPG keys (or specific subkeys) should expire and be rotated (e.g., every 1, 2, or 3 years).
*   **Policy Considerations:**
    *   Balance security benefits of rotation against the operational overhead of generating new keys, distributing public keys, and potentially re-encrypting long-term data.
    *   Subkey rotation is generally easier than master key rotation.
*   **Process:** If rotation is implemented, define a clear process for users to generate new keys (or subkeys), distribute them, and transition away from old keys before they expire.

### D. Handling Revoked/Expired Keys
*   **Refresh Keys:** Users should regularly refresh their local GPG keyrings from the chosen distribution mechanism to get new keys, revocations, and updated signatures:
    ```bash
    gpg --refresh-keys # If using keyservers
    # Or pull from Git repo and re-import if using that method
    ```
*   **Policy on Encrypting to Bad Keys:** Train users to check key status (`gpg --list-keys <key_id>`) before encrypting and **not to encrypt new data to keys that are revoked or expired.**

## 5. Policy for Hardware Key Usage (L1/L2 Data)

Formalize organizational requirements for using Feitian K9Ds (or similar hardware keys).

*   **Requirement Definition:**
    *   **L2 Data (Secure):** *MUST* be protected by GPG operations (signing, encryption/decryption) performed using a hardware key like the Feitian K9D.
    *   **L1 Data (Internal):** *SHOULD* (strongly recommended to) be protected by GPG operations performed using a hardware key.
    *   **Operator Variable: Exception Process for L1.** If exceptions are allowed for L1 data (e.g., software GPG keys in specific controlled environments), this process must be clearly defined, risk-assessed, and approved.
*   **User Training:**
    *   Provide regular training on GPG principles, secure K9D usage (PIN management, physical security), data classification, and organizational encryption/signing policies.
*   **Compliance Checks (Optional):**
    *   Implement methods to periodically audit or check compliance (e.g., verifying commit signatures, spot-checking encryption of sensitive files). This is organization-dependent.

By establishing clear policies, providing robust key management infrastructure, and training users, organizations can effectively leverage Feitian K9Ds and GPG for enhanced security and collaboration.
