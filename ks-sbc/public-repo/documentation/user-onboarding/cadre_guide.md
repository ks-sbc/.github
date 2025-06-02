# Cadre Guide to DRUIDS

This guide is specifically for Cadre members of KSBC. It assumes familiarity with general DRUIDS usage (as outlined in previous guides) and focuses on the advanced functionalities, responsibilities, and security protocols pertinent to your role.

## Recap: DRUIDS in KSBC

DRUIDS (Democratic Repository and Universal Information Distribution System) is our core platform for secure information management, collaborative work, and upholding KSBC's democratic centralist principles at an operational level.

## Your Role as Cadre

Cadre members hold significant responsibility within KSBC. Your interaction with DRUIDS involves not only accessing and contributing to high-level information but also overseeing organizational workflows and ensuring the security and integrity of sensitive data.

## Accessing, Managing, and Contributing to L2 Security Tier Materials

L2 materials represent a higher security tier, containing sensitive strategic, planning, or internal review information critical to KSBC's operations.

*   **What are L2 Materials?** These documents might include long-term strategic plans, detailed operational procedures, sensitive internal reviews, advanced training materials for leadership, or records of significant decisions. Access is strictly controlled.
*   **Accessing L2 Materials:**
    1.  **Permissions:** Access to L2 is highly restricted and granted based on your Cadre role. This often involves multi-factor authentication or specific access protocols.
    2.  **Location:** L2 materials will be in designated secure areas of DRUIDS, possibly encrypted, and accessible only via specific paths or interfaces.
        *   **Example Path (Illustrative):** `DRUIDS_Secure_Zone/L2_Cadre_Strategic/` or similar. You will be provided with the exact paths.
*   **Managing and Contributing to L2 Materials:**
    *   **Responsibility:** Cadre members may be responsible for creating, editing, classifying, and archiving L2 documents.
    *   **Version Control:** Strict version control is crucial. DRUIDS may have built-in versioning, or external protocols might be used.
    *   **Input/Choice:** When creating or updating L2 documents, you will **input** content, filenames (following strict naming conventions, e.g., `L2_StrategicPlan_2024-2026_v1.0_draft.gpg`), and metadata. You will also choose appropriate encryption methods if manual encryption is part of the workflow.

## Overseeing Organizational Workflows

Cadre members play a key role in ensuring KSBC's core processes are effectively managed and documented within DRUIDS.

*   **Theory -> Plan -> Practice -> Summation (TPPS) Cycle Tracking:**
    *   **Responsibility:** Overseeing that each stage of the TPPS cycle is properly documented, tracked, and accessible to relevant members.
    *   **DRUIDS Functionality:** This might involve dedicated sections for each stage, task management systems, or specific document templates.
    *   **Workflow:**
        1.  Ensure theoretical discussions (Theory) are captured.
        2.  Track the development of actionable items (Plan).
        3.  Monitor the implementation and documentation of actions (Practice).
        4.  Facilitate and record the review and lessons learned (Summation).
    *   **Input/Choice:** You may need to **input** status updates, link related documents, or assign tasks within DRUIDS to facilitate this cycle. For example, updating a "Plan" document's status to "Practice phase initiated."

*   **Decision Registers:**
    *   **Responsibility:** Maintaining or overseeing a central register of all significant decisions made within KSBC.
    *   **DRUIDS Functionality:** This could be a specialized database, a structured list, or a series of documents within DRUIDS.
    *   **Workflow:** Ensure that decisions are recorded with date, context, rationale, outcome, and any follow-up actions.
    *   **Input/Choice:** You will **input** details of new decisions or verify entries made by others. For example, **inputting** `Decision_ID: 2024-03-Decision_005, Summary: Adopt new communication protocol, Status: Approved`.

## Advanced Functionalities for Cadre Members

*   **GPG Encryption/Decryption Workflows:**
    *   **Purpose:** To protect highly sensitive L2 (and potentially L1) materials, ensuring only authorized individuals can access them.
    *   **Workflow:**
        1.  **Encryption:** Before uploading a sensitive document to DRUIDS, or for secure local storage:
            *   You will need the public keys of all intended recipients.
            *   Command (example using GPG CLI): `gpg --encrypt --recipient <Recipient_Key_ID_1> --recipient <Recipient_Key_ID_2> --output <filename>.gpg <filename>`
            *   **Input/Choice:** You will need to **input** the correct recipient GPG Key IDs (e.g., `0xABCDEF1234567890`) and choose appropriate input/output filenames. You will also need your **own private key passphrase** to sign the encryption if signing is part of the protocol.
        2.  **Decryption:** When accessing an encrypted document from DRUIDS:
            *   Download the `.gpg` file.
            *   Command (example using GPG CLI): `gpg --decrypt <filename>.gpg > <decrypted_filename>`
            *   **Input/Choice:** You will need to **input** the filename and will be prompted for **your private key passphrase** to decrypt the file.
    *   **Key Management:** Securely manage your own GPG private key and passphrase. Keep your public key updated with the KSBC key server/directory. Your **passphrase** is critical input.

*   **Specific Dataview Queries (if DRUIDS supports this, e.g., in Obsidian or similar):**
    *   **Purpose:** For oversight and extracting specific information from structured data within DRUIDS (e.g., tracking task completion, resource allocation).
    *   **Example Query (Conceptual Dataview syntax):**
        ```dataview
        TASK
        FROM "Projects/Active"
        WHERE status = "pending" AND priority = "high"
        ```
    *   **Input/Choice:** You would need to learn the specific query language (e.g., Dataview Query Language) and **input** queries tailored to your oversight needs. This might involve specifying file paths (`FROM "Projects/Active"`), tags, or specific field values.

*   **Hardware Key Usage (e.g., YubiKey):**
    *   **Purpose:** For enhanced security, such as Multi-Factor Authentication (MFA) for DRUIDS login or for storing GPG keys.
    *   **Workflow:**
        1.  **Setup:** Register your hardware key with DRUIDS or your GPG configuration. This process will involve **inputting** information from the key or codes generated by it.
        2.  **Usage:** When logging in or performing cryptographic operations, you will be prompted to insert your hardware key and potentially **input** a PIN for the key or touch the key.
    *   **Input/Choice:** You'll **input** your hardware key PIN or interact physically with the key.

## Security Best Practices and Protocols

*   **Strong Passphrases:** Use unique, complex passphrases for DRUIDS access and for your GPG key. Store them securely (e.g., in a password manager).
*   **Multi-Factor Authentication (MFA):** Always enable and use MFA if available for DRUIDS.
*   **Handling Sensitive Information:**
    *   Access L2 materials only on trusted devices and secure networks.
    *   Do not share sensitive information outside of approved channels.
    *   Ensure proper encryption of sensitive files before uploading or transmitting them.
    *   Be mindful of physical security if you print sensitive documents.
*   **Reporting Incidents:** Report any suspected security breaches or vulnerabilities immediately to the designated KSBC security contact.
*   **Regular Review:** Periodically review access lists and permissions for sensitive areas of DRUIDS if this is part of your responsibilities.
*   **File Paths for Sensitive Operations:** When performing cryptographic operations or accessing highly sensitive configuration files, always double-check you are using the correct **file paths**. An error here could lead to data exposure or corruption. For example, ensure you are encrypting `L2_Documents/MySecretFile.txt` and not accidentally a system file.

## Configuration Settings

*   You may need to configure specific software on your local machine (e.g., GPG suite, specific DRUIDS client applications). This will involve **inputting** settings like server addresses, user credentials, or paths to keyrings. Follow official KSBC setup guides carefully.

This guide provides a framework. Specific tools, procedures, and DRUIDS features will be detailed in KSBC's internal operational documents and training. Your diligence and adherence to these protocols are vital for KSBC's security and effectiveness.
