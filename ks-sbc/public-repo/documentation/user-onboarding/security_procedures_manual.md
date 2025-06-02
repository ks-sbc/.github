# DRUIDS Security Procedures Manual for Different Classification Levels

This manual outlines the security procedures for handling information at different classification levels within DRUIDS (Democratic Repository and Universal Information Distribution System). Adherence to these procedures is mandatory for all KSBC members to maintain operational security and protect sensitive information.

## Core Principle: Need-to-Know and Least Privilege

Access to information within DRUIDS is governed by the principles of "need-to-know" and "least privilege." Members will only be granted access to information and system functionalities necessary for their roles and responsibilities.

## Security Tier Definitions

DRUIDS utilizes three primary security tiers:

*   **L0: Public / General Access**
*   **L1: Internal / Candidate Access**
*   **L2: Cadre / Sensitive Access**

---

## L0: Public / General Access

**1. Types of Information:**
    *   Publicly shareable information about KSBC.
    *   General announcements and news.
    *   Non-sensitive educational materials and resources.
    *   Approved public statements and publications.
    *   General member onboarding guides (like this one, excluding L1/L2 specific details not yet public).

**2. Access Controls and Permissions:**
    *   **Enforcement:** Typically managed by folder structure within the Obsidian vault. Files in designated L0 folders are considered public within KSBC.
    *   **DRUIDS Structure:** E.g., `Vault_Root/L0_Public_Documents/`, `Vault_Root/Announcements/`.
    *   No specific encryption is applied at this level by default. All DRUIDS users with vault access can view these files.

**3. Procedures for Creating, Storing, and Sharing:**
    *   **Creation:** Use L0 templates if available.
    *   **Storage:** Store L0 documents only in designated L0 folders.
        *   **Operator Action:** When saving a new public document, ensure its file path is within an L0 directory (e.g., `ks-sbc/public-repo/documentation/L0_Resources/MyPublicDocument.md`).
    *   **Sharing:** L0 documents can be freely shared among all KSBC members. If sharing outside KSBC, ensure the document has been approved for external release.

**4. Handling Sensitive Information:**
    *   **No sensitive information should be stored at the L0 level.**
    *   If a document draft initially considered for L0 is found to contain sensitive details, it must be reclassified and moved to L1 or L2 *before* widespread sharing.

**5. Communication and Collaboration:**
    *   Open communication is encouraged for L0 materials. Discussions can occur in general KSBC channels.

**6. Reporting Security Incidents:**
    *   If L1 or L2 information is mistakenly found in an L0 folder, immediately report it to a Cadre member or the DRUIDS administration team. Do not attempt to move or delete it yourself unless instructed.

---

## L1: Internal / Candidate Access

**1. Types of Information:**
    *   Internal KSBC operational procedures and guidelines not meant for public release.
    *   Candidate-specific training materials and curriculum.
    *   Internal discussion drafts and working documents for projects.
    *   Meeting minutes for internal committees (not dealing with L2 sensitive topics).
    *   Contact lists for internal members (handle with care).

**2. Access Controls and Permissions:**
    *   **Enforcement:**
        *   Folder structure: Designated L1 folders (e.g., `Vault_Root/L1_Internal/`, `Vault_Root/Candidates/L1_Materials/`). Access to these folders might be visually managed or, in future DRUIDS iterations, through vault-splitting or access control list (ACL) like mechanisms if Obsidian/Git allows.
        *   **Potential Future GPG:** Specific L1 sub-folders or particularly sensitive L1 documents *may* be encrypted using GPG for an additional layer of security, accessible only to L1 and L2 members. This will be clearly communicated if implemented.
    *   Access is granted to Candidates and Cadre members. General Members typically do not have access to L1 areas.

**3. Procedures for Creating, Storing, and Sharing:**
    *   **Creation:** Use L1 templates. Frontmatter should correctly label `classification: L1`.
    *   **Storage:** Store L1 documents exclusively in designated L1 folders.
        *   **Operator Action:** Ensure file path is within an L1 directory (e.g., `ks-sbc/internal-repo/L1_Candidate_Resources/MyInternalDocument.md`).
    *   **Sharing:** L1 documents can be shared with other Candidates and Cadre members. Do NOT share L1 documents with General Members or externally without explicit Cadre approval.
    *   **Encryption (if mandated for specific L1 files):**
        *   **Operator Action (Encryption):** `gpg --encrypt --recipient <L1_Group_Key_ID_or_individual_Key_IDs> --output <filename>.gpg <filename>` (Requires relevant public keys).
        *   **Operator Action (Decryption):** `gpg --decrypt <filename>.gpg > <decrypted_filename>` (Requires your private key and passphrase).

**4. Specific Guidelines for Handling Sensitive Information:**
    *   **Avoid Cross-Tier Contamination:** Do not copy/paste L1 information into L0 documents or L0 communication channels.
    *   **Digital Hygiene:** When working with L1 documents, ensure your screen is not visible to unauthorized individuals. Lock your computer when stepping away.
    *   **Printed Copies:** Avoid printing L1 documents if possible. If necessary, handle printed copies with care and shred them securely when no longer needed.

**5. Communication and Collaboration:**
    *   Discuss L1 matters in designated internal channels or meetings appropriate for Candidate/Cadre level.
    *   Be mindful when discussing L1 topics in mixed company; ensure everyone present is authorized for L1 information.

**6. Reporting Security Incidents:**
    *   If L1 information is found in an L0 area, or if unauthorized access to L1 is suspected, report immediately to a Cadre member.
    *   If L2 information is found in an L1 area, report immediately.

---

## L2: Cadre / Sensitive Access

**1. Types of Information:**
    *   Highly sensitive strategic plans and long-term KSBC goals.
    *   Internal security procedures and vulnerability assessments (including aspects of this manual if not made fully public).
    *   Detailed financial records or sensitive membership data requiring strict confidentiality.
    *   Deliberations and records of Cadre-level decision-making.
    *   Sensitive inter-organizational communications.
    *   GPG keys, passphrases, or other critical security parameters (though these are ideally managed outside DRUIDS general storage).

**2. Access Controls and Permissions:**
    *   **Enforcement:**
        *   Highly restricted folder structures (e.g., `Vault_Root/L2_Cadre_Secure/`). These folders might be in a separate, more tightly controlled Git repository or a specially configured section of the vault.
        *   **Mandatory GPG Encryption:** Most, if not all, L2 documents MUST be GPG encrypted at rest within DRUIDS.
        *   **Hardware Key Usage:** Access to L2 areas or decryption of L2 keys may require the use of a hardware security key (e.g., YubiKey) as a second factor or for storing GPG private keys.
    *   Access is strictly limited to Cadre members on a strict need-to-know basis.

**3. Procedures for Creating, Storing, and Sharing:**
    *   **Creation:** Use L2 templates. Frontmatter MUST correctly label `classification: L2` and potentially other sensitive metadata markers.
    *   **Storage:**
        *   Store L2 documents *only* in designated L2 secure, encrypted locations.
        *   **Operator Action (Path):** Ensure file path is within a designated L2 directory (e.g., `ks-sbc/cadre-secure-repo/L2_Strategic/Document.gpg`).
        *   **Operator Action (Encryption):** All L2 files must be encrypted before committing to DRUIDS.
            `gpg -e -r <Cadre_Recipient_KeyID_1> -r <Cadre_Recipient_KeyID_2> ... --output <filename>.md.gpg <filename>.md`
            (Encrypt with `-e` or `--encrypt`; `-r` for each recipient Cadre member).
    *   **Sharing:** L2 documents are shared *only* among authorized Cadre members. Distribution is tightly controlled. Avoid email for L2 document transfer; use DRUIDS secure sync.

**4. Specific Guidelines for Handling Sensitive Information:**
    *   **Highest Level of Care:** Treat all L2 information as extremely sensitive.
    *   **No Cross-Tier Contamination:** NEVER copy/paste L2 information or excerpts into L1 or L0 documents or communication channels. Be extremely vigilant about summaries or discussions that might inadvertently reveal L2 details.
    *   **Secure Environment:** Only access L2 documents on trusted devices in a secure, private physical environment.
    *   **Hardware Keys (Operator Action):**
        *   If required for GPG private key storage: Insert your hardware key when prompted by GPG for operations. **Input your hardware key PIN** if it is configured.
        *   If required for DRUIDS access: Use your hardware key as a second factor during login as per DRUIDS configuration.
    *   **Decryption (Operator Action):**
        `gpg -d --output <decrypted_filename>.md <filename>.md.gpg`
        (Or `gpg <filename>.md.gpg` which outputs to stdout, then redirect if needed). You will be prompted for **your GPG passphrase** (and potentially hardware key PIN).
    *   **Digital Footprint:** Be mindful of temporary files or decrypted versions. Securely delete them after use if not stored in an encrypted volume (e.g., using `shred` or secure delete utilities).

**5. Communication and Collaboration:**
    *   Discuss L2 matters *only* in secure, end-to-end encrypted Cadre channels or in person in secure locations.
    *   Assume all other channels are not secure for L2 information.
    *   Use codenames or indirect language when referring to highly sensitive L2 projects in less secure contexts if absolutely necessary and approved.

**6. Reporting Security Incidents:**
    *   Any suspected breach, unauthorized access, loss of an L2-related hardware key, or compromise of an L2 passphrase MUST be reported immediately to the KSBC security lead or the entire Cadre leadership. This is critical.
    *   If L2 data is found outside designated L2 secure areas, it's a serious incident.

## General Security Incident Reporting

For any security incident or potential breach at any level:

1.  **Immediately stop the suspected activity.**
2.  **Do not attempt to investigate further on your own** unless you are part of the designated security team, as this could alter evidence.
3.  **Preserve any relevant information:** Note down times, actions taken, error messages, individuals involved.
4.  **Report to your immediate superior, a Cadre member, or the designated KSBC security contact point.** Provide all collected information.
5.  Follow instructions from the security team.

Your vigilance in upholding these security procedures is paramount to the safety and success of KSBC. If you are ever unsure about a security procedure, **ask before acting.** It is always better to clarify than to risk a breach. This manual will be reviewed and updated periodically.
