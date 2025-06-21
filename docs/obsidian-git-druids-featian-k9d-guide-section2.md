# Configuring Git for Hardware-Backed Commit Signing with Feitian K9D

## Introduction

This section details how to configure Git to use your Feitian K9D-held GPG key for signing commits. This process ensures that your commits are cryptographically verified, providing strong guarantees of **authenticity** (who made the commit) and **integrity** (the commit hasn't been tampered with). By using a hardware key like the Feitian K9D, the private signing key remains securely on the device, protected from threats on your computer.

**Prerequisite:** This guide assumes you have successfully completed Section 1: "Setting Up Your Feitian K9D with GPG for Different Security Tiers," meaning your K9D is initialized, has GPG keys, and is recognized by your GPG environment.

## I. Identifying Your GPG Signing Key ID (Hardware-Backed)

Before configuring Git, you need the ID of the GPG signing key that is stored on your Feitian K9D.

1.  **List Secret Keys:** Open your terminal and run:
    ```bash
    gpg --list-secret-keys --keyid-format LONG
    ```
    This command displays your GPG secret keys. Look for the key associated with your Feitian K9D.
    *   **`ssb>` (Secret Subkey):** If you generated keys directly on the card or moved subkeys to it (Option A or B from Section 1), the signing key will likely be a subkey. The line will start with `ssb>` and often include `[S]` for signing capability. Crucially, it should also indicate that it's a card-key, for example:
        ```
        sec   rsa4096/0A1B2C3D4E5F6G7H 2023-01-01 [C] [expires: 2025-01-01]
              Primary_Key_Fingerprint
        uid                 [ultimate] Your Name <your.email@example.com>
        ssb>  rsa4096/S1A2B3C4D5E6F7G8 2023-01-01 [S] [expires: 2025-01-01]
              Card serial no. = XXXXXXXXXXXXXXXX 
        ```
        In this example, `S1A2B3C4D5E6F7G8` is the ID of the signing subkey stored on the card.
    *   **`sec>` (Secret Key):** In less common scenarios, if the primary key itself was generated on a card that allows it and is designated for signing, it might appear as `sec>`.

2.  **Cross-Reference with Card Status:** To be certain, you can cross-reference with the output of:
    ```bash
    gpg --card-status
    ```
    Look at the "Signature key" fingerprint listed in the card status. This fingerprint should match the fingerprint of one of the subkeys (or the primary key) listed by `gpg --list-secret-keys`. The Key ID you need is the shorter identifier associated with that fingerprint (the part after the `/`).

**Note:** You need the *signing* key ID. If your card has multiple keys (e.g., for signing, encryption, authentication), ensure you pick the one with the `[S]` capability intended for signing.

## II. Configuring Git to Use the Hardware-Backed GPG Key

Once you have your GPG signing key ID from the K9D, configure Git to use it:

1.  **Set the Signing Key in Git:**
    Replace `<YOUR_GPG_KEY_ID>` with the actual key ID you identified.
    ```bash
    git config --global user.signingkey <YOUR_GPG_KEY_ID>
    ```
    *   `--global`: This sets the signing key for all your Git repositories.
    *   Per-Repository: If you want to use this key only for a specific repository, navigate into that repository's directory and run the command without `--global`.

2.  **Enable Automatic Commit Signing (Recommended for L1/L2 Tiers):**
    To automatically sign every commit:
    ```bash
    git config --global commit.gpgsign true
    ```
    If you prefer to sign commits manually (e.g., for L0 classification), you can set this to `false` or leave it unset and use `git commit -S ...` for individual signed commits.

3.  **Enable Automatic Tag Signing (Optional):**
    If you create annotated tags and want them signed as well:
    ```bash
    git config --global tag.gpgsign true
    ```
    If you only want to sign specific tags, use `git tag -s ...` instead of enabling this globally.

4.  **Specify GPG Program (Usually Not Needed):**
    In most cases, Git can find the `gpg` executable. If you have multiple GPG versions or it's installed in a non-standard location, you might need to specify it:
    ```bash
    git config --global gpg.program gpg 
    # or git config --global gpg.program /path/to/your/gpg
    ```

## III. The Role of `gpg-agent`

`gpg-agent` is a background daemon that caches your GPG private key passphrases and, importantly here, handles communication with your Feitian K9D via `scdaemon` (smart card daemon).

*   **Handling Requests:** When Git needs to sign a commit, it calls GPG, which in turn communicates with `gpg-agent`. `gpg-agent` then directs the request to `scdaemon`, which interacts with the K9D.
*   **PIN Caching:** To avoid re-entering your K9D User PIN for every single commit within a short period, `gpg-agent` can cache it.
    *   Configuration is done in `~/.gnupg/gpg-agent.conf`.
    *   Common settings:
        ```
        # Cache PIN for 1 hour (3600 seconds)
        default-cache-ttl 3600
        # Max time PIN can be cached, even if re-used (e.g., 8 hours)
        max-cache-ttl 28800 
        ```
    *   Adjust these values based on your security needs and convenience.
*   **Restarting `gpg-agent`:** If you change `gpg-agent.conf`, you need to restart `gpg-agent`:
    ```bash
    gpg-connect-agent reloadagent /bye
    ```
    In some cases, you might need to kill the agent (`killall gpg-agent`) and let it restart automatically on the next GPG operation.

## IV. The Commit Signing Process with Feitian K9D (Step-by-Step Flow)

Understanding the flow helps in troubleshooting:

1.  **User executes `git commit ...`**.
2.  **Git prepares the commit data** and, if `commit.gpgsign` is `true` or `-S` is used, invokes the GPG program (as specified by `gpg.program` or default `gpg`).
3.  **GPG identifies the signing key** (from `user.signingkey`) and recognizes it's a hardware-backed key.
4.  **GPG (via `scdaemon`) communicates with `gpg-agent`** to request a signing operation from the smart card.
5.  **`gpg-agent` checks its cache** for the K9D's User PIN.
    *   If the PIN is cached and valid, `gpg-agent` may proceed without a prompt (depending on card capabilities and settings).
    *   If the PIN is not cached or has expired, `gpg-agent` invokes a **`pinentry` program** (e.g., `pinentry-curses`, `pinentry-mac`) to securely prompt the user for their K9D User PIN.
6.  **User enters the PIN** into the `pinentry` dialog.
7.  **`gpg-agent` passes the PIN to `scdaemon`**, which sends it to the Feitian K9D.
8.  **The Feitian K9D verifies the PIN.**
    *   If correct, it may require a **physical touch confirmation** (depending on the K9D model and its configuration) to authorize the signing operation.
    *   The K9D then performs the cryptographic signing operation internally using the private key stored on the card.
9.  **The digital signature is returned** from the K9D through `scdaemon` and `gpg-agent` back to GPG.
10. **GPG attaches the signature to the commit data.**
11. **Git completes the commit process**, now with a signed commit.

## V. "Scripts" - Procedures and Helper Snippets

In this context, "scripts" primarily refer to the configuration procedures already outlined. However, here are a few optional shell aliases or functions that some users find helpful. Add these to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`).

*   **Check Git and GPG Card Status (`gitsignstatus`):**
    ```bash
    alias gitsignstatus='echo "--- Git Config ---"; git config user.name; git config user.email; git config user.signingkey; git config commit.gpgsign; echo "--- GPG Card Status ---"; gpg --card-status; echo "--- GPG Secret Keys (Hardware) ---"; gpg -K | grep -A1 "Card serial no."'
    ```
    This alias provides a quick overview of relevant settings and card status.

*   **Enable GPG Signing Locally for Current Repo (`gitenablesignlocal`):**
    ```bash
    # Function to enable GPG signing for the current repository
    # Tries to guess the hardware key if only one is available, otherwise prompts.
    gitenablesignlocal() {
        local key_id
        # Attempt to find a single hardware-backed signing key
        key_id=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "ssb" && $12 ~ /S/ && $20 ~ /card-no=/ {print $5; count++} END {if (count != 1) exit 1}')
        
        if [ -z "$key_id" ]; then
            echo "Could not automatically determine a unique hardware signing key."
            echo "Please list your keys with 'gpg --list-secret-keys' and use:"
            echo "git config user.signingkey <KEY_ID>"
            echo "git config commit.gpgsign true"
            return 1
        fi
        
        echo "Found hardware signing key: $key_id"
        git config user.signingkey "$key_id"
        git config commit.gpgsign true
        echo "GPG signing enabled locally for this repository with key $key_id."
    }
    ```
    **Caveat:** Automatically detecting the "correct" key ID can be tricky if you have multiple GPG keys or multiple hardware keys. Use such helper functions with caution and understanding.

## VI. Verifying Signed Commits

1.  **Using `git log --show-signature`:**
    To view commits and their GPG signature verification status in the terminal:
    ```bash
    git log --show-signature
    ```
    *   For each signed commit, you'll see output similar to:
        ```
        commit a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2 (HEAD -> main)
        gpg: Signature made Mon 01 Jan 2024 10:00:00 AM PST
        gpg:                using RSA key YOUR_GPG_KEY_FINGERPRINT
        gpg: Good signature from "Your Name <your.email@example.com>" [ultimate]
        Author: Your Name <your.email@example.com>
        Date:   Mon Jan 1 10:00:00 2024 -0800

            Your commit message
        ```
    *   **"Good signature"**: Indicates the signature is valid and trusted by your GPG keyring.
    *   **"Bad signature"**: Indicates the commit data has been altered since signing, or there's an issue with the key.
    *   You might also see warnings about trust levels if the key isn't fully trusted in your local GPG setup (e.g., if you haven't set `trustlevel` for it).

2.  **Platforms like GitHub/GitLab:**
    *   When you push signed commits to platforms like GitHub or GitLab, they will often display a "Verified" or "Unverified" badge next to the commit.
    *   For your commits to show as "Verified," you typically need to:
        1.  **Export your public GPG key:**
            ```bash
            gpg --armor --export YOUR_GPG_KEY_ID > my_public_gpg_key.asc
            ```
        2.  **Upload this public GPG key** to your account settings on the respective platform (e.g., GitHub > Settings > SSH and GPG keys > New GPG key).
        3.  Ensure the email address associated with the GPG key is a verified email address on your GitHub/GitLab account.

## VII. Troubleshooting Common Issues

*   **"Secret key not available" / "No secret key" / "gpg failed to sign data":**
    *   **K9D Not Plugged In:** Ensure your Feitian K9D is properly connected.
    *   **`gpg-agent` or `scdaemon` Issues:** `gpg-agent` might not be running or `scdaemon` might not be communicating with the card. Try `gpg-connect-agent reloadagent /bye` or even `killall gpg-agent` (it should restart automatically).
    *   **Incorrect Key ID in Git Config:** Double-check `git config user.signingkey`.
    *   **PC/SC or Driver Problems (Linux):** Ensure `pcscd` is running (`systemctl status pcscd`). Check system logs for CCID or smart card related errors.
    *   **GPG cannot find the key:** Run `gpg --card-status`. If GPG can't see the card, Git won't be able to either.
*   **PIN Not Prompted / Repeatedly Prompted:**
    *   **`pinentry` Issues:** The `pinentry` program might not be configured correctly or accessible in your environment. Ensure `GPG_TTY=$(tty)` is set in your shell profile. Check `~/.gnupg/gpg-agent.conf` for `pinentry-program` settings.
    *   **`gpg-agent` Cache:** If you expect a PIN prompt but don't get one, the PIN might be cached. If prompted too often, your `default-cache-ttl` might be too short.
    *   **Background Process:** If Git is run from a script or GUI without proper terminal access, `pinentry` might fail.
*   **"Bad signature" in `git log`:**
    *   This is serious. It means the commit data does not match the signature. This could indicate tampering (unlikely if you just made the commit) or, more commonly, subtle issues like line ending changes if files were modified after signing but before the final commit object was written (very rare with standard Git usage).
    *   Ensure your GPG and Git setup is stable.
*   **K9D Not Recognized by GPG (`gpg --card-status` fails or shows no card):**
    *   **Physical Connection:** Check USB connection. Try a different port.
    *   **`pcscd` (Linux):** Ensure it's installed and running.
    *   **Drivers:** Refer to Feitian documentation for any necessary drivers for your OS, although often generic CCID drivers work.
    *   **Other Software:** Sometimes other software that tries to access smart cards can interfere.

For most issues, running `gpg --card-status` and `gpg -K` are good first diagnostic steps to ensure GPG itself can correctly interact with your Feitian K9D and its keys.
