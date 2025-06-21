# Setting Up Your Feitian K9D with GPG for Different Security Tiers

## Introduction

This guide provides detailed instructions for setting up your Feitian K9D security key with GnuPG (GPG) for use with Git commit signing, particularly within the context of the DRUIDS (Democratic Repository for Unclassified and Internal DocumentS) project's security tier model. Using a hardware key like the Feitian K9D significantly enhances the security of your GPG private keys, as they are generated and stored on the device and never leave it. This protects your keys from malware and unauthorized access on your computer.

**Crucial Disclaimer:**
This guide provides general steps and examples. **Always refer to the official Feitian documentation for your specific K9D model regarding drivers, default PINs/PUKs, and any model-specific utilities or behavior.** Hardware and its associated software can change, and the manufacturer's documentation is the authoritative source. The default PINs mentioned here (e.g., User PIN `123456`, Admin PIN `12345678`) are common defaults but **must be verified** with your device's documentation.

## I. Prerequisites

Before you begin, ensure you have the following:

### Hardware
*   **Feitian K9D Security Key:** Your physical hardware key.

### Software
*   **GnuPG (GPG):**
    *   Ensure you have a modern version of GnuPG installed. This typically includes:
        *   `gpg`: The main GnuPG executable.
        *   `gpg-agent`: The GPG agent that manages private keys and passphrases.
        *   `scdaemon`: The smart card daemon used by GPG to interact with hardware keys.
        *   `pinentry`: A program for secure PIN entry. GPG will try to find a suitable `pinentry` program (e.g., `pinentry-curses`, `pinentry-gtk`, `pinentry-mac`).
    *   **Check version:** Open a terminal and type `gpg --version`. Version 2.1 or higher is recommended.
*   **PC/SC Subsystem:** This allows your operating system to communicate with smart card readers.
    *   **Linux:** `pcscd` (PC/SC Smart Card Daemon). You may need to install it via your package manager (e.g., `sudo apt-get install pcscd` on Debian/Ubuntu, `sudo yum install pcsc-lite` on Fedora). Ensure the `pcscd` service is running.
    *   **macOS:** Native support. Usually works out of the box.
    *   **Windows:** Native support. Usually works out of the box.
*   **CCID Drivers (If Necessary):**
    *   Most modern operating systems have generic CCID (Chip Card Interface Device) drivers. The Feitian K9D should generally be recognized as a standard CCID-compliant smart card reader.
    *   **Check Feitian's official website/documentation** if your K9D is not recognized by your system or GPG. They may provide specific drivers or troubleshooting steps.
*   **Feitian Middleware (Potential, but usually not needed for GPG):**
    *   Feitian provides various tools and middleware for their keys. For standard GPG usage as a smart card, this middleware is often not strictly necessary, as GPG uses the PC/SC interface. However, it might be useful for firmware updates or other administrative tasks on the key itself. Refer to Feitian's documentation.

## II. Initial Card Setup with GPG (`gpg --card-edit`)

Once GPG and necessary drivers are installed, you can proceed with initializing the K9D for GPG use.

### User & Admin PINs
The Feitian K9D, like most smart cards, has at least two Personal Identification Numbers (PINs):
*   **User PIN:** Required for day-to-day operations like signing or decrypting.
    *   *Example Default (VERIFY WITH YOUR DOCS):* `123456`
*   **Admin PIN:** Required for administrative tasks on the card, such as changing PINs, generating keys directly on the card, or resetting the User PIN.
    *   *Example Default (VERIFY WITH YOUR DOCS):* `12345678`

**It is CRITICAL to change these default PINs immediately.**

### Initial Setup Steps

1.  **Connect your Feitian K9D:** Plug the K9D into a USB port on your computer.
2.  **Launch `gpg --card-edit`:** Open a terminal and type:
    ```bash
    gpg --card-edit
    ```
    You should see GPG attempt to connect to the card. If it fails, ensure `pcscd` is running (on Linux) and the card is properly inserted.

3.  **Key Commands within `gpg --card-edit`:**
    *   **Enter Admin Mode:** Most administrative commands require you to enable admin mode first. Type:
        ```
        admin
        ```
        You will be prompted to enter the **Admin PIN**.
    *   **Change PINs (`passwd`):** This is the most important first step.
        *   While in `admin` mode:
            *   To change the **Admin PIN**:
                ```
                passwd
                ```
                Select option `3` (Change Admin PIN). You'll be prompted for the current Admin PIN and then the new one twice.
            *   To change the **User PIN**:
                ```
                passwd
                ```
                Select option `1` (Change User PIN). You'll be prompted for the current User PIN (if set, or default) and then the new one twice. The Admin PIN is usually required to change the User PIN if you don't know the current User PIN, or for the first change.
            *   **PIN Policy:** Choose strong, unique PINs. Refer to your Feitian documentation for PIN length and complexity requirements.
    *   **Optional Cardholder Information:** You can set optional information like name, language, etc. These are generally not critical for Git signing but can be configured if desired (e.g., `name`, `lang` commands).
    *   **Quit Admin Mode (if applicable):** Some commands might automatically exit admin mode, or you can type `admin` again to toggle it.
    *   **Save and Exit:** When done, type:
        ```
        quit
        ```

4.  **Verify Card Recognition:** After exiting `gpg --card-edit`, verify GPG can read the card status:
    ```bash
    gpg --card-status
    ```
    This command should output information about your Feitian K9D, including its serial number, PIN retry counters, and whether keys are present (they won't be yet if it's a new card). If you see "Card not present" or errors, troubleshoot your PC/SC setup or drivers.

    Expected output for a new/reset card might look something like this (details vary):
    ```
    Reader ...........: Feitian K9D [CCID Interface] (xxxxxxxxxxxx) 00 00
    Application ID ...: D2760001240103040006123456780000
    Version ..........: 3.4
    Manufacturer .....: Feitian
    Serial number ....: 12345678 (example)
    Name of cardholder: [not set]
    Language prefs ...: [not set]
    Sex ..............: unspecified
    URL of public key : [not set]
    Login data .......: [not set]
    Signature PIN ....: not forced
    Key attributes ...: rsa2048 rsa2048 rsa2048
    Max. PIN lengths .: 32 32 32
    PIN retry counter : 3 0 3  (User, Resetting, Admin)
    Signature counter : 0
    KDF setting ......: off
    Signature key ....: [none]
    Encryption key ...: [none]
    Authentication key: [none]
    General key info..: [none]
    ```
    The "PIN retry counter" is important. If you enter the wrong PIN too many times, the card might get locked.

## III. GPG Key Generation/Transfer Strategy

You have two main options for getting GPG keys onto your Feitian K9D:

### Option A (Recommended): Generating Keys Directly On-Card

This is the most secure method for most users, as the private keys are generated on the K9D and never exist on your computer's hard drive.

1.  **Start `gpg --card-edit`:**
    ```bash
    gpg --card-edit
    ```
2.  **Enter Admin Mode:**
    ```
    admin
    ```
    Enter your new Admin PIN.
3.  **Generate Keys:** Type the `generate` command.
    ```
    generate
    ```
    *   You might be asked if you want to make an off-card backup of the encryption key. For the highest security with hardware keys, the typical answer is **no** (private keys should not leave the card). This means if the card is lost or damaged, the ability to decrypt *old* data with that specific encryption subkey is lost unless you had other backup mechanisms for the data itself. The primary "backup" for a hardware key setup is often the revocation certificate.
    *   GPG will then guide you through the key generation process:
        *   **Key Type and Size:** You'll be prompted to choose the type and size for the signature, encryption, and authentication keys.
            *   **RSA** is common. Key sizes of **3072 or 4096 bits** are recommended for RSA.
            *   **ECC (Elliptic Curve Cryptography)** (e.g., `cv25519`) is also an option if supported by your GPG version and card, offering strong security with smaller key sizes.
            *   The K9D's capabilities will determine the available options.
        *   **Validity Period:** Specify how long the key should be valid (e.g., `2y` for two years, `0` for never expires). You can extend the expiration date later.
        *   **User Information:** You'll be prompted for your Real Name, Email Address, and an optional Comment. This information forms your User ID.
        *   Confirm the details.
    *   GPG will generate the keys on the card. This may take a few moments. You'll be prompted for your User PIN and possibly Admin PIN during this process.
4.  **Crucial Note on Backup (Revocation Certificate):**
    *   Since the private keys do not leave the card with this method, traditional private key backups are not possible.
    *   **The most critical backup is your GPG Revocation Certificate.** Generate this immediately after key generation (see Section VI). If your card is lost/stolen or the key is compromised, you use this certificate to inform others that the key should no longer be trusted.
5.  **Quit:**
    ```
    quit
    ```

### Option B (Advanced): Generating Keys Offline and Moving Subkeys to Card

This method involves creating a master GPG key offline (on an air-gapped machine or secure environment) and then transferring specific *subkeys* (for signing, encryption, authentication) to the Feitian K9D. The master key (primarily used for certification and creating new subkeys) remains offline.

*   **Brief Explanation:**
    1.  Generate an "offline master key" using `gpg --expert --full-generate-key` on a secure, air-gapped system. This allows you to choose specific capabilities for the master key (e.g., Certify only).
    2.  Create subkeys for Signing (S), Encryption (E), and Authentication (A) under this master key.
    3.  Export the master key and subkeys for backup.
    4.  Transfer the subkeys to the Feitian K9D using the `keytocard` command within `gpg --edit-key <master_key_id>`.
*   **Considerations:**
    *   This is a more complex setup, suitable for users with a deep understanding of GPG key management.
    *   It provides the benefit of a highly secure offline master key. If the K9D is lost or compromised, the master key is safe, allowing you to revoke the compromised subkeys and issue new ones.
*   **Recommendation:** For most users, especially those new to GPG or hardware keys, **Option A (generating keys directly on-card) is simpler and provides excellent security.**

## IV. Configuring GPG for Different Security Tiers

Once your K9D has GPG keys, you need to configure Git and `gpg-agent` to use them.

### General `gpg-agent` Setup
`gpg-agent` handles PIN caching and communication with the smart card.
1.  **Ensure it's Running:** `gpg-agent` usually starts automatically when needed. You can check its status or start it:
    ```bash
    gpg-connect-agent /bye
    ```
    If it's not running, it might start, or you might need to configure your shell (e.g., in `.bashrc` or `.zshrc`):
    ```bash
    # Start gpg-agent if not running
    gpg-connect-agent /bye >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        gpg-agent --daemon --enable-ssh-support >/dev/null 2>&1
    fi
    export GPG_TTY=$(tty) # Important for pinentry
    ```
2.  **`enable-ssh-support` (Optional):** If you want to use your GPG authentication key for SSH access, add `enable-ssh-support` to `~/.gnupg/gpg-agent.conf`.
3.  **`pinentry-program` Configuration (If needed):**
    *   GPG uses `pinentry` to ask for your PIN. If you have issues with PIN prompts, you might need to specify the `pinentry-program` path in `~/.gnupg/gpg-agent.conf`. For example:
        ```
        pinentry-program /usr/bin/pinentry-curses
        ```
    *   Restart `gpg-agent` after changes: `gpg-connect-agent reloadagent /bye`.

### Tier-Specific Git Configuration

You'll need to tell Git which GPG key to use. Find your GPG key ID (the one associated with your K9D, usually the signing subkey):
```bash
gpg --list-secret-keys --keyid-format=long
```
Look for an entry with `ssb>` (secret subkey) that also indicates it's on the card. The key ID is the long string after `rsa4096/` or `ed25519/` etc. For example, `rsa4096/YOUR_KEY_ID`.

*   **L0 (Public/Unclassified - Optional Signing):**
    *   Git Configuration:
        ```bash
        git config --global user.signingkey YOUR_KEY_ID_FROM_K9D
        # To disable automatic signing for all commits (sign manually when needed):
        git config --global commit.gpgsign false 
        # Or, leave commit.gpgsign unset and sign manually
        ```
    *   Usage: For commits you want to sign:
        ```bash
        git commit -S -m "Your commit message"
        ```
        You will be prompted for your K9D User PIN.
*   **L1 (Internal - Recommended Signing):**
    *   Git Configuration:
        ```bash
        git config --global user.signingkey YOUR_KEY_ID_FROM_K9D
        git config --global commit.gpgsign true # Sign all commits by default
        ```
    *   Usage: `git commit -m "Your commit message"` will automatically attempt to sign. You'll be prompted for your User PIN.
*   **L2 (Secure - Mandatory Hardware-Backed Signing):**
    *   Git Configuration: Same as L1.
        ```bash
        git config --global user.signingkey YOUR_KEY_ID_FROM_K9D
        git config --global commit.gpgsign true
        ```
    *   **Crucial Verification:**
        *   Ensure the key specified by `user.signingkey` is indeed hardware-backed.
        *   Run `gpg -K YOUR_KEY_ID_FROM_K9D` (or `gpg --list-secret-keys YOUR_KEY_ID_FROM_K9D`). The output for the secret subkey (`ssb>`) should indicate it's a card-key. It should NOT show a path to a file on your local system for the secret key part.
        *   Run `gpg --card-status`. The "Signature key" field should show the fingerprint of the key you configured in Git.
        *   This tier relies on the assurance that signing operations *require* the hardware key and its PIN.

## V. Verifying GPG Key and Card Association

1.  **Check Card Status:**
    ```bash
    gpg --card-status
    ```
    Ensure the "Signature key", "Encryption key", and "Authentication key" fields show fingerprints. These fingerprints should correspond to the keys listed by `gpg -K`.
2.  **List Secret Keys:**
    ```bash
    gpg -K --keyid-format=long
    # or gpg --list-secret-keys --keyid-format=long
    ```
    *   You should see your GPG key(s).
    *   For keys on the Feitian K9D, the secret key part will be indicated by `ssb>` (secret subkey) and a note like `Card serial no. = XXXXXXXXXXXXXXXX`. There won't be a direct file path to the secret key material itself for on-card keys.
    *   The public part (`pub`) will be listed as usual.
3.  **Perform a Test Operation:**
    *   **Test Signing:**
        ```bash
        echo "test content" | gpg --clearsign -u YOUR_KEY_ID_FROM_K9D
        ```
        You should be prompted for your K9D User PIN. If successful, it will output a signed message.
    *   **Test Decryption (if you have an encryption subkey):**
        Encrypt a file to your GPG key ID, then try to decrypt it. This will also prompt for the User PIN.
        ```bash
        echo "secret message" > test.txt
        gpg -e -r YOUR_KEY_ID_FROM_K9D test.txt 
        gpg -d test.txt.gpg 
        ```

## VI. Basic Backup and Revocation (Essential First Steps)

### Generate a Revocation Certificate
This is the **MOST IMPORTANT** backup step for any GPG key, especially when the private key is on a hardware device and cannot be backed up directly.
A revocation certificate is used to publicly declare that your GPG key should no longer be trusted (e.g., if your K9D is lost, stolen, or you suspect the key is compromised).

1.  **Generate the Certificate:**
    ```bash
    gpg --output ~/revoke-${YOUR_KEY_ID_FROM_K9D}.asc --gen-revoke YOUR_KEY_ID_FROM_K9D
    ```
    (Replace `YOUR_KEY_ID_FROM_K9D` with your actual GPG key ID, specifically the primary key ID if you have subkeys).
    *   You will be asked to choose a reason for revocation (e.g., key compromised, key superseded, etc.). Choose an appropriate reason, or `0` (No reason specified) if unsure.
    *   You'll be asked for a comment (optional) and to confirm.
    *   You will need to enter your GPG key's passphrase (if the primary key material is local, which is the case even if subkeys are on card) or User PIN (if the primary key itself was somehow generated on card, less common for full master keys).
2.  **Secure Storage:**
    *   **Print it:** Print multiple copies of the `revoke-*.asc` file.
    *   **Store Offline:** Store these printed copies in very safe, physically separate locations (e.g., a safe at home, a bank deposit box, with a trusted person).
    *   **Digital Offline Storage:** You can also store the digital file on encrypted USB drives, kept offline and secure.
    *   **Do NOT store it unencrypted on your computer or any internet-connected device.**

### Backup Offline Master Key (If Option B was used)
If you chose to generate your master key offline and move subkeys to the card (Option B):
*   The primary backup is the secure, offline storage of your master GPG key pair and its revocation certificate.
*   Ensure these are stored according to the best practices for offline GPG master keys (e.g., encrypted USB drives, paperkey, etc., stored in multiple secure locations).

*(Note: Detailed procedures for handling a compromised key, using the revocation certificate, and full disaster recovery are advanced topics and will be covered in separate documentation. This section focuses on the essential initial backup step: the revocation certificate.)*
