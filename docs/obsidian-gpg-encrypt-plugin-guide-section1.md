# User Guide: Encrypting Note Content with an Obsidian GPG Plugin

## 1. Introduction

### Purpose
This guide explains how to use a hypothetical GnuPG (GPG) plugin within Obsidian to encrypt and decrypt the content of your notes. This allows you to protect sensitive information directly within your Obsidian vault.

### Benefits
*   **Convenient Protection:** Encrypt and decrypt information directly within the Obsidian interface, streamlining your workflow.
*   **Integration with System GPG:** The plugin leverages your existing GPG installation, meaning it can work with GPG keys managed on hardware security keys like the Feitian K9D.
*   **Selective Encryption:** Choose to encrypt entire notes or just specific sections of text, allowing for granular control over what is protected.

### Assumed Plugin Functionality (Hypothetical)
This guide is based on a hypothetical GPG plugin for Obsidian with the following core capabilities:
*   Encrypting selected text within a note.
*   Decrypting GPG-encrypted blocks of text within a note.
*   Allowing the user to select GPG recipients for encryption.
*   Interacting with the system's GPG installation, `gpg-agent`, and any connected hardware keys (like a Feitian K9D).

### Prerequisites
Before using this plugin, ensure you have the following setup:
1.  **GnuPG Installed and Configured:** A working GnuPG (GPG) installation on your system (including `gpg`, `gpg-agent`, `scdaemon` if using smart cards, and a `pinentry` program). Refer to official GPG documentation for installation.
2.  **Your GPG Key Pair:** You must have your own GPG key pair (public and private keys).
    *   **Highly Recommended:** Your private key should be stored on a hardware security key like a Feitian K9D (see the "Feitian K9D: GPG Setup and Hardware-Backed Git Commit Signing Guide" for setup).
3.  **`gpg-agent` Running:** Ensure `gpg-agent` is running and configured correctly to handle PIN entry and smart card operations.
4.  **Recipient Public Keys Imported:** To encrypt content for others (or for yourself for later decryption), you must have the recipients' public GPG keys imported into your GPG keyring and ideally validated (fingerprint checked).

## 2. Plugin Installation and Setup (Hypothetical)

This section describes a typical installation and setup process for a community GPG plugin in Obsidian. The exact steps might vary based on the actual plugin's design.

### Installation
1.  Open Obsidian.
2.  Go to **Settings** -> **Community plugins**.
3.  Turn off "Safe mode" if it's enabled (at your own discretion, understanding the risks of community plugins).
4.  Click **Browse** to open the community plugin browser.
5.  Search for the GPG encryption plugin (e.g., "GPG Encrypt", "Obsidian GPG").
6.  Click **Install** on the desired plugin.
7.  Once installed, find the plugin in the "Installed plugins" list and **enable it** using the toggle switch.

### Typical Plugin Settings
After installation, the plugin will likely have settings that you can configure. Access these via **Settings** -> **Community plugins** -> (Plugin Name).

**Key User Configuration Options (Operator Variables):**
These settings allow you to customize the plugin's behavior. The exact names and options will depend on the specific plugin.

*   **`Default GPG Key ID for Signing` (if plugin supports signing plaintext):**
    *   **User Configuration:** Your GPG Key ID to be used by default if the plugin offers a separate plaintext signing feature (distinct from encryption).
    *   *Note: Encryption itself inherently uses your key for access if you are a recipient.*
*   **`Default Recipient(s) for Encryption`:**
    *   **User Configuration:** You might be able to specify one or more GPG Key IDs or email addresses to be automatically included as recipients every time you encrypt.
    *   **Crucial:** It's highly recommended to **always include your own GPG Key ID as a default recipient** if you intend to decrypt the content yourself later.
*   **`Output Format for Encrypted Blocks`:**
    *   **User Configuration:**
        *   `ASCII Armor` (Recommended): Produces a text-based GPG block (e.g., `-----BEGIN PGP MESSAGE-----...`), which is generally more robust for copying/pasting and storage within Markdown notes.
        *   `Binary`: Produces binary encrypted output, which might be less portable in text files.
*   **`Clipboard Handling for Decryption`:**
    *   **User Configuration:**
        *   `Replace selection/block with decrypted text`: Decrypted text appears directly in the note.
        *   `Copy decrypted text to clipboard`: Decrypted text is copied to the clipboard and not shown directly in the note. This can be more secure for very sensitive information, reducing on-screen exposure.
        *   `Show in a temporary modal/popup`: Displays decrypted content in a temporary window.
*   **`UI Customization Options`:**
    *   **User Configuration:** Options for context menu entries, command palette command names, or status bar indicators.

### Initial Check
*   After installation and configuration, open the Command Palette (usually `Ctrl+P` or `Cmd+P`) and search for commands related to "GPG", "Encrypt", or "Decrypt" to see if the plugin has registered its actions.
*   You might also find options in the right-click context menu when text is selected or when the cursor is within a GPG block.

## 3. Encryption Workflow within Obsidian

This describes how you would typically encrypt content within a note using the plugin.

### A. Encrypting Selected Text

1.  **Select Text:** Highlight the portion of text within your note that you want to encrypt.
2.  **Trigger Encryption:**
    *   Open the Command Palette and search for a command like "GPG: Encrypt selected text".
    *   Alternatively, right-click on the selected text; if the plugin supports it, choose an "Encrypt selection with GPG" option.
3.  **Recipient Selection Process:**
    *   The plugin should prompt you to specify the recipient(s) for this encrypted block. This might be a dialog box where you can enter:
        *   GPG Key IDs (long or short).
        *   Email addresses associated with GPG keys in your keyring.
    *   It might pre-fill with any default recipients you configured in settings.
    *   **Operator Variable:** The list of GPG Key IDs/emails for whom this specific piece of content should be encrypted.
    *   **Crucial Reminder:** **Always include your own GPG Key ID as a recipient if you need to decrypt this content later.** If you only encrypt to others, you will not be able to read it yourself.
4.  **GPG/Feitian K9D Interaction:**
    *   The plugin will call your system's `gpg` command in the background.
    *   `gpg-agent` will handle access to your private GPG key.
    *   If your private key is on a Feitian K9D (or another hardware key):
        *   You will likely be prompted to enter your **K9D User PIN** by a `pinentry` program.
        *   Your K9D may require a **physical touch confirmation** to authorize the use of the encryption key (though this is more common for signing/decryption, verify your K9D's behavior for encryption key access if it's also on the card).
5.  **Output:**
    *   The originally selected plaintext will be replaced in your note by an ASCII armored GPG block, for example:
        ```
        -----BEGIN PGP MESSAGE-----
        
        hQEMA7WXYZabcdefgHIJKLMNOPQRSTuvwxyzABCDEFGHIJKLMNopqrstuvwx123456
        ... many lines of encrypted text ...
        =ABCD
        -----END PGP MESSAGE-----
        ```

### B. Encrypting an Entire Note (If Supported)

Some plugins might offer a command to encrypt the entire content of the current note.
*   **Process:** Similar to encrypting selected text:
    1.  Trigger the "Encrypt entire note" command.
    2.  Select recipients (remember to include yourself).
    3.  Interact with GPG/K9D for PIN/touch if required.
*   **Output:** The entire body of the note would be replaced by a GPG block.
*   **Frontmatter Handling:** YAML Frontmatter at the beginning of a note is typically **not encrypted** by such content-focused plugins. Sensitive information should not be placed in the frontmatter if the note's content is to be GPG encrypted by this plugin. The plugin encrypts the Markdown body.

## 4. Decryption Workflow within Obsidian

This describes how to decrypt GPG-encrypted blocks within your notes.

### A. Triggering Decryption
1.  **Position Cursor or Select Block:**
    *   Place your cursor anywhere within a GPG-encrypted block (e.g., between `-----BEGIN PGP MESSAGE-----` and `-----END PGP MESSAGE-----`).
    *   Alternatively, some plugins might require you to select the entire GPG block.
2.  **Trigger Decryption Command:**
    *   Open the Command Palette and search for a command like "GPG: Decrypt selection/block".
    *   Or, right-click and choose a "Decrypt GPG block" option from the context menu if available.

### B. GPG/Feitian K9D Interaction
*   The plugin calls your system's `gpg` command.
*   `gpg-agent` handles access to your private decryption key.
*   If your private key is on a Feitian K9D:
    *   You will be prompted for your **K9D User PIN** via `pinentry`.
    *   Your K9D **may require a physical touch confirmation** to authorize the decryption. (Verify your K9D model's behavior).

### C. Output/Display of Decrypted Content
The way decrypted content is displayed depends on the plugin's design and your settings:
*   **Inline Temporary Replacement:** The GPG block in the note might be temporarily replaced with the decrypted plaintext. Clicking away or another action might re-hide it or revert to the encrypted block.
*   **Modal/Popup Window:** A temporary window or modal might appear displaying the decrypted content. Closing this window would typically not alter the note itself.
*   **Copy to Clipboard:** The decrypted plaintext is copied to your system clipboard without altering the note. You can then paste it where needed.
*   **Operator Variable (if plugin setting):** Your preferred method for displaying decrypted content, if configurable in the plugin settings.

### D. Handling Decryption Failures
If decryption fails (e.g., wrong key, incorrect PIN, corrupted data, K9D not connected), the plugin should provide some form of feedback:
*   A notification within Obsidian.
*   An error message in a modal or the developer console.
*   The GPG block remaining unchanged.

## 5. Managing Recipients for Plugin Use

The GPG plugin relies on your system's GPG keyring for recipient public keys (for encryption) and your own private keys (for decryption).

*   **Importing Public Keys:** Before you can encrypt content for someone, you need their public GPG key in your local GPG keyring.
    ```bash
    # Example: Importing a key from a file
    gpg --import <path_to_teammates_public_key.asc>
    # Example: Fetching a key from a keyserver
    gpg --keyserver hkps://keys.openpgp.org --search-keys "teammate_email@example.com" 
    # (Then select and import from the search results)
    ```
*   **Validating Public Keys (Fingerprint Check):**
    *   After importing, always verify the fingerprint of the public key out-of-band (e.g., in person, video call, trusted channel) with the owner to ensure it's legitimate.
    ```bash
    gpg --fingerprint <key_id_or_email>
    ```
    *   Optionally, sign trusted keys locally (`gpg --sign-key <key_id>`) or `gpg --lsign-key <key_id>`.

## 6. Common Use Cases

*   **Storing Secrets:** Encrypt API keys, passwords, or other sensitive credentials directly within your notes.
*   **Drafting Confidential Sections:** Work on sensitive parts of a document in encrypted form until ready for wider (plaintext) sharing or processing.
*   **Sharing Encrypted Snippets:** Securely share specific pieces of information with colleagues by encrypting for their GPG keys and pasting the GPG block into emails or messages.
*   **Sensitive Personal Logs:** Keep personal journal entries or sensitive personal information encrypted within your Obsidian vault.
*   **Team-Specific Information:** Encrypt meeting notes or project details intended only for specific team members who have shared their GPG public keys.

## 7. Security Considerations with an Obsidian GPG Plugin

*   **Plugin Trust:** As with any community plugin, you are trusting its developers and code. Review the plugin's source code if possible, check its reputation, and understand the permissions it requires.
*   **Underlying GPG Security:** The plugin's security is fundamentally reliant on the security of your system's GPG installation, your GPG key management practices, and the security of your Feitian K9D (including strong PINs and physical protection of the device).
*   **Decrypted Content Handling:**
    *   **Obsidian Memory:** When content is decrypted and displayed (even temporarily inline or in a modal), it exists in plaintext in Obsidian's memory.
    *   **Clipboard:** If decrypted content is copied to the clipboard, it's vulnerable to clipboard snooping tools. Clear your clipboard after pasting sensitive data.
    *   **Plaintext Nature of Notes:** Remember that Obsidian notes are fundamentally plaintext Markdown files. Only the GPG blocks are encrypted. Any information typed *outside* these blocks remains unencrypted.
*   **Plugin Encrypts *Content Within* Notes:** This type of plugin typically encrypts selected text or the body of a note. It does not usually encrypt the entire note file itself on the filesystem in a way that would make the filename or metadata opaque, nor does it automatically encrypt linked files or attachments unless they are also explicitly encrypted.
*   **Ensure `gpg-agent` and `pinentry` are Secure:** The security of PIN entry depends on a trusted `pinentry` program and a secure `gpg-agent` setup.

By understanding these considerations and using the plugin responsibly, you can effectively add a strong layer of GPG encryption to your notes within Obsidian.
