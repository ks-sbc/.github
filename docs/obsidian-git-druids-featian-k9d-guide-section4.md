# Verifying Your Feitian K9D Hardware Key and GPG Integration

## 1. Introduction

### Purpose
This section provides methods to verify that your Feitian K9D security key is correctly set up with GnuPG (GPG) and that cryptographic operations, such as signing and decryption, are indeed utilizing the hardware key.

### Importance
Regular verification is crucial for:
*   **Detecting Issues Early:** Identifying potential problems with your setup, drivers, or the hardware key itself before they impact your workflow or security.
*   **Building Confidence:** Ensuring that your sensitive GPG private keys are being protected by the hardware security of the Feitian K9D as intended.
*   **Maintaining Security Posture:** Confirming that operations that should require the hardware key are not silently failing or falling back to software-based keys.

### Scope
The verification methods covered here include GPG command-line checks and observational verification during cryptographic operations. This section assumes you have already completed the initial setup described in Part 1 of this guide.

## 2. Physical Inspection (Basic Check)

While not a GPG-specific verification, maintaining awareness of your Feitian K9D's physical state is a foundational security practice.

### User Responsibility
*   Be aware of the normal appearance and feel of your specific Feitian K9D model.
*   Store your K9D securely when not in use to prevent unauthorized physical access or substitution.

### What to Look For
*   **Obvious Tampering:** Check for any signs of physical tampering with the device casing (e.g., cracks, unusual marks, attempts to open it).
*   **Correct Device:** Ensure the device you are using is indeed *your* Feitian K9D and has not been swapped with a look-alike. This is especially important if the device has been out of your direct control.

### Disclaimer
Physical inspection is a basic precaution and is **not foolproof against sophisticated hardware attacks** (e.g., supply chain attacks or highly skilled physical tampering). However, it can help detect obvious issues.

## 3. GPG Command-Line Verifications

GnuPG provides several commands to inspect the status of your smart card (the Feitian K9D) and the keys associated with it.

### A. `gpg --card-status`
This is your primary command for checking GPG's recognition of the K9D.

```bash
gpg --card-status
```

**Detailed Explanation of What to Check in the Output:**

*   **Reader Information:** `Reader ...........: Feitian K9D [CCID Interface] (xxxxxxxxxxxx) 00 00`
    *   Confirms the K9D is detected as a CCID-compliant reader. The specific name might vary slightly.
*   **Application ID:** `Application ID ...: D276000124010304...` (OpenPGP Card application ID)
    *   Indicates the card is initialized as an OpenPGP card.
*   **Serial Number:** `Serial number ....: XXXXXXXX`
    *   Should match the serial number of your K9D (if known or labeled).
*   **Key Attributes / URLs:**
    *   `Signature key ....: FINGERPRINT_HEX`
    *   `Encryption key ...: FINGERPRINT_HEX`
    *   `Authentication key: FINGERPRINT_HEX`
    *   If keys have been generated or moved to the card, these fields should display the fingerprints of those keys. For a newly initialized card before key generation, these might show `[none]`.
    *   `URL of public key : [URL if set]` - This is where you can store a URL pointing to your public key.
*   **PIN Retry Counters:** `PIN retry counter : 3 0 3` (Example: User PIN, Resetting Counter, Admin PIN)
    *   Indicates how many remaining attempts you have for each PIN. If this is low (e.g., 1), be extremely careful. If it's 0, the PIN is locked.
*   **Key Timestamps:** If keys are present, their creation/expiration dates might be indirectly visible or confirmed via `gpg -K`.
*   **Absence of Unexpected Information:** The output should generally align with what you expect from your card's configuration.

### B. `gpg -K` or `gpg --list-secret-keys`
This command lists secret keys known to GPG, indicating which ones are stubs pointing to a hardware key.

```bash
gpg -K --keyid-format LONG
# or
gpg --list-secret-keys --keyid-format LONG
```

**What to Check:**
*   **Secret Key Stubs (`ssb>`):** For keys stored on your Feitian K9D (typically subkeys for signing, encryption, authentication if you followed Part 1, Option A or B for subkeys):
    *   The line for the secret subkey will start with `ssb>`.
    *   Crucially, it will **not** show a file path to the private key material on your computer.
    *   Instead, it should indicate that the key is on a card, often by listing the **`Card serial no. = XXXXXXXX`** that matches the one from `gpg --card-status`.
    *   Example:
      ```
      sec   rsa4096/PRIMARY_KEY_ID 2023-01-01 [C] [expires: 2025-01-01]
            PRIMARY_KEY_FINGERPRINT
      uid                 [ultimate] Your Name <your.email@example.com>
      ssb>  rsa4096/SIGNING_SUBKEY_ID 2023-01-01 [S] [expires: 2025-01-01]
            Card serial no. = XXXXXXXX
      ssb>  rsa4096/ENCRYPTION_SUBKEY_ID 2023-01-01 [E] [expires: 2025-01-01]
            Card serial no. = XXXXXXXX
      ```
*   **Key IDs Match:** The Key IDs (e.g., `SIGNING_SUBKEY_ID`) and fingerprints shown here for the card-bound keys should correspond to the fingerprints shown in `gpg --card-status` for the respective key slots (Signature, Encryption, Authentication).

### C. Checking GPG Agent Status
You can query `gpg-agent` to see if it's aware of the keys on the smart card.

```bash
gpg-connect-agent 'keyinfo --list' /bye
```
**What to Check:**
*   The output will list keygrips known to the agent.
*   For keys on the smart card, you should see lines that include the card's serial number and indicate they are from a smart card. For example:
    ```
    S KEYINFO <keygrip1> D - - - P S <card_serial_number> /<app_id_path> -
    S KEYINFO <keygrip2> D - - - P S <card_serial_number> /<app_id_path> -
    ```
This confirms that `gpg-agent` has processed information about the keys available on the connected K9D.

## 4. Operational Verification (Ensuring K9D is Used)

The most direct way to verify that the Feitian K9D is being used for cryptographic operations is to perform a test operation and observe the system's behavior, particularly PIN prompts and any physical interaction required by the K9D.

**Note on K9D Behavior:** The specific LED behavior or physical touch requirements of your Feitian K9D model during cryptographic operations (signing, decryption) should be confirmed by consulting its official documentation. Many security keys require a physical touch for operations like signing to confirm user presence.

### A. Test Signing Operation

1.  **Create a Dummy File:**
    ```bash
    echo "This is a test file for GPG signing." > test_sign.txt
    ```
2.  **Sign the File:** Use the GPG key ID that you expect to be on your K9D.
    ```bash
    gpg --clearsign --default-key <YOUR_K9D_SIGNING_KEY_ID> test_sign.txt
    # Or, if you have a default key set to the K9D key:
    # gpg --clearsign test_sign.txt
    ```
    This will create `test_sign.txt.asc`.
3.  **Crucial Observations During Signing:**
    *   **PIN Prompt:** You should be prompted to enter your **User PIN** for the Feitian K9D. This prompt should come from `pinentry` (it might be a terminal-based prompt or a graphical one). If your PIN is cached by `gpg-agent` and the cache is still valid, you might not be prompted (this is expected if configured).
    *   **K9D LED Activity / Physical Touch:**
        *   Observe your Feitian K9D. Many models have an LED that will blink during cryptographic operations.
        *   **User Presence Verification (Touch):** Your K9D model may require a physical touch on a sensor/button to authorize the signing operation after PIN entry. **Please verify this behavior with your specific K9D model's documentation.** If it requires a touch and you don't provide it, the operation will typically time out or fail.
4.  **Verify the Signature:**
    ```bash
    gpg --verify test_sign.txt.asc
    ```
    The output should indicate a "Good signature" from your GPG key. Example:
    ```
    gpg: Signature made Mon Jan  1 12:34:56 2024 PST
    gpg:                using RSA key YOUR_KEY_FINGERPRINT
    gpg: Good signature from "Your Name <your.email@example.com>" [ultimate]
    ```

### B. Test Decryption Operation

1.  **Create a Dummy File:**
    ```bash
    echo "This is a secret message for GPG decryption." > test_decrypt.txt
    ```
2.  **Encrypt the File to Your K9D's Encryption Key:** Ensure you use the Key ID of the encryption subkey on your K9D.
    ```bash
    gpg --encrypt --armor --recipient <YOUR_K9D_ENCRYPTION_KEY_ID> --output test_decrypt.txt.asc test_decrypt.txt
    ```
3.  **Attempt to Decrypt the File:**
    ```bash
    gpg --output test_decrypt_recovered.txt --decrypt test_decrypt.txt.asc
    ```
4.  **Crucial Observations During Decryption:**
    *   **PIN Prompt:** Similar to signing, you should be prompted for your K9D **User PIN** (unless validly cached).
    *   **K9D LED Activity / Physical Touch:** Observe the K9D for LED activity. Some cards/keys might also require a touch for decryption, though this is less common than for signing. **Verify with your K9D model's documentation.**
5.  **Verify Content:**
    Check the content of `test_decrypt_recovered.txt`:
    ```bash
    cat test_decrypt_recovered.txt
    ```
    It should match the original "This is a secret message for GPG decryption."

### Interpreting Observations
*   **PIN Prompt from `pinentry`:** This is a strong indicator that GPG is attempting to access a protected private key, which in this setup should be on the K9D.
*   **Physical Interaction with K9D (LED/Touch):** If your K9D blinks or requires a touch, and the operation only succeeds after this interaction, it's a very strong confirmation that the hardware key was directly involved.
*   **No PIN Prompt when Expected:** If you are *not* prompted for a PIN (and you haven't recently entered it for caching) for an operation that should require private key access, investigate immediately. It could mean GPG is using a different, software-based key, or `gpg-agent` is misconfigured.

## 5. (Advanced) Key Attestation (If Supported by Feitian K9D for GPG Keys)

*   **Research-Dependent Feature:** Key attestation is an advanced feature where the hardware key can cryptographically prove that a key was generated on the device and is managed by it. Support for this varies greatly between hardware key models and the software interacting with them (like GPG).
*   **If Supported (Hypothetical for K9D with GPG):**
    *   If your specific Feitian K9D model and GPG version explicitly support an attestation feature for OpenPGP keys, it would typically involve specific `gpg --card-edit` commands or other utilities provided by Feitian to generate an attestation certificate or statement for a key on the card. This attestation could then be verified by a third party.
*   **If Not Clearly Supported for GPG Keys on K9D:**
    *   As of many common GPG setups, direct key attestation in a standardized way for OpenPGP keys generated on smart cards (like those used by GPG) is not a universally available or straightforward feature.
    *   In such cases, verification relies on the **operational checks** described above (Section 4.A and 4.B), where PIN prompts and physical interaction with the K9D confirm its involvement. The fact that `gpg -K` shows the key as a hardware-backed stub is also a key piece of evidence.

**Recommendation:** For most users, the operational verification (test signing/decryption with observation of PIN prompts and K9D interaction) combined with `gpg --card-status` and `gpg -K` provides a high degree of confidence.

## 6. Recommendations for Regular Checks

*   **Periodic `gpg --card-status`:** Run this command occasionally to ensure your system still recognizes the K9D and its status (e.g., PIN retry counters).
*   **Test Operations After Updates:** Perform a quick test sign or decrypt operation after significant GPG updates, operating system updates, or if you move your K9D to a new computer, to ensure everything still functions as expected.
*   **Vigilance for PIN Prompts:** Be aware of when you *should* be prompted for your K9D PIN. If you are prompted unexpectedly, or not prompted when you believe you should be, investigate.

## 7. What to Do If Verification Fails

If any of the verification steps fail or produce unexpected results:

*   **Do Not Use for Sensitive Operations:** Immediately cease using the K9D for signing or decrypting sensitive L1/L2 documents or for any critical Git commits until the issue is resolved.
*   **Consult Troubleshooting Sections:** Refer to the troubleshooting sections in this guide (Part 2, Section H for Git signing issues) and official GPG/Feitian documentation.
*   **Check Feitian Support:** Visit Feitian's official support channels or documentation for model-specific troubleshooting.
*   **Consider Re-initializing (Caution):** For persistent issues, and as a last resort, you might consider re-initializing the OpenPGP applet on the K9D (e.g., via `gpg --card-edit` and potentially factory reset commands if your card supports them). **WARNING: This will erase any GPG keys stored on the K9D. Only do this if you have a clear recovery plan (e.g., generating new keys is acceptable, or you used Offline Master Key strategy and can re-provision subkeys).**
*   **Use Backup Keys/Procedures:** If you have backup keys or alternative approved procedures for handling sensitive data, use them.
*   **Report to Organizational Security:** If the K9D is used in an organizational context, report the verification failure and any potential security concerns to your IT security team or designated authority.
