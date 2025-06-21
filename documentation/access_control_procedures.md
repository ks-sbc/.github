# DRUIDS Access Control Procedures & Best Practices

This document outlines the access control model for the Distributed, Reproducible, Unifying, Ideological Documentation System (DRUIDS), based on its three-tier security classification. It also provides best practices for users to ensure the integrity of this security model.

## 1. Security Tier Definitions & Intended Access

The DRUIDS system classifies information into three tiers. Access to and handling of information must strictly adhere to these classifications:

*   **L0 (Public)**
    *   **Definition:** General membership materials, publicly accessible information, organizational documents intended for wide distribution.
    *   **Intended Access (Read):** Everyone (public, general members, candidates, cadre).
    *   **Intended Access (Write/Modify):** Designated members after appropriate review (e.g., via PRs from any member, reviewed by editors/maintainers).
    *   **Storage:** Primarily within the `content/L0_public/` directory.

*   **L1 (Candidate)**
    *   **Definition:** Administrative functions, internal discussions not suitable for L0, membership records (handled with extreme care and possibly outside the main vault or encrypted), training materials for candidates.
    *   **Intended Access (Read):** Candidates, Cadre members, and specific administrative roles as authorized. Not for general members or the public.
    *   **Intended Access (Write/Modify):** Cadre members, and Candidates in their designated areas or specific project roles, under supervision/review by Cadre.
    *   **Storage:** Primarily within the `content/L1_candidate/` directory.

*   **L2 (Cadre)**
    *   **Definition:** High-security operations, sensitive strategic discussions, internal policy development, advanced theoretical work prior to broader discussion, information that could compromise organizational security or members if leaked. (Note: Cryptographic keys themselves should *never* be stored directly in this repository).
    *   **Intended Access (Read):** Strictly Cadre members only.
    *   **Intended Access (Write/Modify):** Strictly Cadre members only.
    *   **Storage:** Primarily within the `content/L2_cadre/` directory.

## 2. Mapping to Repository & System Permissions (Guidance)

While Obsidian itself does not manage multi-user permissions for vault access, the DRUIDS security model relies on a combination of disciplined vault structure, user responsibility, and external permission systems (primarily Git/GitHub).

*   **Git Repository Access (GitHub):**
    *   **Public Repository (`ks-sbc/public-repo` - for Quartz site):** This repository, which builds the public-facing website, should only contain L0 content. Content should be pushed here via a secure, reviewed pipeline from the main DRUIDS vault.
    *   **Main DRUIDS Vault Repository (This Repository):**
        *   **Default Branch (`main`):** Should be protected. Direct pushes should be disallowed. Changes should be made via Pull Requests (PRs).
        *   **Write Access to `main` (Merge Rights):** Restricted to a small group of trusted Cadre members responsible for maintaining the integrity of the repository.
        *   **Branch Creation:** All members (or candidates and above) may be allowed to create branches to propose changes.
        *   **Folder-Specific Permissions (Conceptual):** While Git itself doesn't offer per-folder write permissions easily, the PR review process is the primary gatekeeper.
            *   PRs modifying content in `content/L1_candidate/` must be reviewed by Cadre or designated L1 content approvers.
            *   PRs modifying content in `content/L2_cadre/` must be reviewed *exclusively* by Cadre members with need-to-know.
        *   **GitHub Teams:** Utilize GitHub Teams (e.g., "DRUIDS-Cadre", "DRUIDS-Candidates") to manage group access and review assignments if the GitHub plan supports it.

*   **Obsidian Vault Sharing:**
    *   The entire DRUIDS Obsidian vault (this repository) is intended for use by members who have been onboarded to the system.
    *   It is **not** intended to be a publicly cloned vault if it contains L1/L2 material. Access to the Git repository implies access to all unencrypted content within it.

## 3. User Best Practices for Security

Adherence to these best practices by all users is critical:

*   **Classify Correctly:** When creating new content, use the provided templates and QuickAdd commands to ensure accurate security classification from the start. If unsure, default to a higher security level and seek guidance.
*   **Verify Before Linking/Sharing:**
    *   Before linking from a lower-classification document to a higher-classification one, consider if this exposes sensitive titles or information.
    *   When sharing `obsidian://` links, be mindful of the recipient's security clearance. A link to an L2 note is only useful and appropriate for another Cadre member.
*   **Respect Folder Structure:** Do not move or copy documents from higher-security folders (e.g., `content/L2_cadre/`) to lower-security folders unless explicitly declassifying the content through an approved process.
*   **Secure Communication:** Discuss sensitive L1/L2 content only through approved secure communication channels. Avoid discussing details in public forums, general chat channels, or unprotected GitHub issues/PR comments.
*   **Pull Request Discipline:**
    *   Clearly state the security level of content being changed in your PR descriptions.
    *   Reviewers: Pay close attention to the security implications of changes, especially modifications to L1/L2 content or security configurations.
*   **Local System Security:** Ensure your local computer system where you clone the DRUIDS vault is reasonably secure (e.g., disk encryption, strong passwords, up-to-date OS).
*   **GPG Usage (for L2 content):** For Cadre members working with L2 content that requires note-level encryption, familiarize yourself with the GPG Crypt plugin usage and organizational GPG key management procedures (to be documented separately).
*   **Report Concerns:** If you identify a potential security misclassification, data leakage, or have concerns about access controls, report it immediately to the designated security personnel or committee within KSBC.

## 4. Declassification / Reclassification Process

**[Placeholder]**
*(This section will outline the formal process for changing a document's security classification, including required approvals and steps.)*

## 5. Guidance on External Encrypted Container Management (Optional L2 Protection)

For an additional layer of security for highly sensitive L2 (Cadre) information, or for managing sensitive files that are not directly part of the Obsidian vault's note structure (e.g., raw data, certain operational files), the use of external, client-side encrypted containers is recommended.

This practice complements the in-vault note-level encryption provided by the GPG Crypt plugin.

### Recommended Tools:

*   **VeraCrypt:** A free, open-source, and widely audited disk encryption tool. It can create encrypted file containers (volumes) that are mounted as virtual drives.
    *   *Website:* [https://www.veracrypt.fr/](https://www.veracrypt.fr/)
*   **Cryptomator:** A free, open-source, client-side encryption tool that creates encrypted "vaults" (folders) which can be stored on any drive or cloud service. It encrypts files individually.
    *   *Website:* [https://cryptomator.org/](https://cryptomator.org/)

### Use Cases for DRUIDS:

1.  **Storing Highly Sensitive Ancillary Files:** If L2 operations involve files that are not Markdown notes (e.g., spreadsheets with sensitive calculations, unencrypted raw source documents before processing into Obsidian, specific operational plans), these can be stored within a VeraCrypt container or Cryptomator vault.
2.  **Enhanced Obsidian Vault Security (Extreme Cases):** For maximum protection, an entire DRUIDS Obsidian vault (or a specific L2-only partial vault) could be located *inside* a VeraCrypt container or Cryptomator vault. This means the Obsidian vault files themselves are encrypted at rest on the user's machine, and the container must be mounted and decrypted before Obsidian can access it. This adds a significant security layer against unauthorized physical access to the device.
3.  **Secure Backups:** Encrypted containers are an excellent way to create secure, offline backups of critical L2 material or even the entire DRUIDS vault.

### Key Considerations:

*   **Strong Passphrases/Keyfiles:** The security of an encrypted container relies entirely on the strength of its passphrase and/or keyfiles. Follow best practices for creating and managing these.
*   **Performance:** Accessing files within an encrypted container might be slightly slower than direct disk access, though usually negligible for typical document work.
*   **Portability:** Encrypted containers can be stored on USB drives or other portable media for secure transport of L2 data if necessary.
*   **Not a Replacement for In-Vault GPG:** For encrypting specific *notes or sections of notes within Obsidian*, the GPG Crypt plugin remains the primary tool. External containers are for broader file-level or vault-level encryption at rest.

It is the responsibility of Cadre members handling L2 information to assess if this additional layer of protection is necessary for the specific data they are managing and to implement it correctly if so.

## 6. Future Considerations: Advanced Validation & Warnings

To further enhance the integrity of the DRUIDS security model, the following advanced features are desirable for future development. Implementing these robustly would likely require dedicated custom plugins or significant scripting efforts.

*   **Cross-Tier Reference Validation:**
    *   **Concept:** An automated system that could scan links within documents (e.g., upon saving or as part of a pre-commit check) to identify and flag potentially problematic links. For example, a link in an L0 (Public) document pointing directly to an L2 (Cadre) document.
    *   **Benefit:** Would help prevent accidental exposure of sensitive information through hyperlinks.
    *   **Current Practice:** Until such automation exists, members must be extremely diligent in manually reviewing links, especially in lower-classification documents, to ensure they do not point to inappropriately classified higher-tier content.

*   **Security Violation Warnings (Real-time or Proactive):**
    *   **Concept:** A system that could provide warnings to users if they are about to perform an action that might violate security policies. Examples:
        *   Attempting to move a document from an `L2_cadre` folder to an `L0_public` folder without a declassification flag.
        *   Copying content from a high-security note and pasting it into a lower-security note.
        *   Using a restricted tag in an inappropriate context.
    *   **Benefit:** Would provide proactive guidance and help prevent unintentional security breaches.
    *   **Current Practice:** Vigilance, adherence to the procedures in this document, and thorough peer review during Pull Requests are the current primary methods to prevent such violations.

The development of these advanced features will be considered as the DRUIDS system matures and technical capacity allows. In the interim, all users share the responsibility for upholding the security model through careful practice and mutual accountability.

---

By following these procedures and best practices, we can collectively maintain the security and integrity of the DRUIDS system and KSBC's information assets.
```
