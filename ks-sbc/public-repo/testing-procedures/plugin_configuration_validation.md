# Manual Test Script: Key Plugin Configuration Validation for DRUIDS

**Purpose:** This document outlines the manual steps to validate critical configuration settings for key plugins used in the DRUIDS (Obsidian-based) environment. Regular validation ensures plugins are functioning as intended and supporting KSBC workflows and security protocols.

**Procedure:** This is a manual checklist. For each plugin and setting listed:
1.  Navigate to the plugin's settings page in Obsidian.
2.  Verify the actual setting against the "Expected Value/State."
3.  Mark "Pass" or "Fail" in the provided checkbox.
4.  Add any relevant notes, especially for failures.

**Reporting Discrepancies:** If any configuration setting fails validation or if you encounter issues performing these checks, report the discrepancy immediately to the DRUIDS administration team or your designated KSBC technical lead. Include the plugin name, setting name, expected value, actual value, and any error messages or unexpected behavior.

---

## Test Environment:
*   **DRUIDS Version (Obsidian Version):** ______________
*   **Plugin Versions (if specifically checking):** ______________
*   **Tester:** ______________
*   **Date:** ______________

---

## I. Obsidian Git (or chosen Git plugin)

**Navigation:** `Obsidian Settings (Gear Icon)` > `Community Plugins` > `Obsidian Git` (or specific Git plugin name) > `Options` (Gear Icon next to plugin).

| Setting / Feature                      | How to Check                                                                 | Expected Value / State                                                                                                                                                                                             | Result      | Notes                                                 |
|----------------------------------------|------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. Auto Save / Commit / Push**       | Check settings for automatic operations.                                     | Dependent on KSBC policy. E.g., "Auto Save" might be ON, "Auto Commit" might be OFF or timed, "Auto Push" might be OFF or timed. **Clarify KSBC's current Git discipline policy.**                                | `[ ] Pass` `[ ] Fail` |                                                       |
| **2. Commit Message Template**         | Inspect the commit message template setting, if used.                        | Should align with KSBC standards (e.g., may prompt for type, scope, description).                                                                                                                                  | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Authentication**                  | Attempt a manual `Pull` and `Push` using the plugin's controls.              | Successful connection to the remote repository (e.g., GitHub) without authentication errors. SSH keys or PATs should be functional.                                                                               | `[ ] Pass` `[ ] Fail` | *Requires network access & valid credentials.*        |
| **4. Conflict Handling Display**       | (If possible, simulate a merge conflict - Advanced) Check how conflicts are shown. | Plugin should visually indicate files with merge conflicts.                                                                                                                                                        | `[ ] Pass` `[ ] Fail` | *May require coordination to test.*                   |
| **5. Git Path (if applicable)**        | If the plugin requires a path to the Git executable.                         | Should be correctly configured if not automatically detected by the system.                                                                                                                                      | `[ ] Pass` `[ ] Fail` |                                                       |

---

## II. Dataview

**Navigation:** `Obsidian Settings` > `Community Plugins` > `Dataview` > `Options`.

| Setting / Feature                      | How to Check                                                              | Expected Value / State                                                                                                 | Result      | Notes                                                 |
|----------------------------------------|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. Enable JavaScript Queries**       | Verify checkbox state.                                                    | **ON** (Required for TPPS tracking and other advanced queries).                                                        | `[ ] Pass` `[ ] Fail` |                                                       |
| **2. Enable Inline JavaScript Queries**| Verify checkbox state.                                                    | **ON** (If used by KSBC for specific inline data display).                                                             | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Query Language Settings**         | Review settings like `Dataview Prefix` (default `dataview`).                | Default settings are usually fine unless KSBC has specific overrides. `Dataview Prefix` should be `dataview`.          | `[ ] Pass` `[ ] Fail` |                                                       |
| **4. Automatic View Refreshing**       | Check settings for automatic refresh of Dataview blocks.                  | Usually ON for live updates, but check KSBC preference for performance.                                                | `[ ] Pass` `[ ] Fail` |                                                       |

---

## III. Templater

**Navigation:** `Obsidian Settings` > `Community Plugins` > `Templater` > `Options`.

| Setting / Feature                      | How to Check                                                              | Expected Value / State                                                                                                   | Result      | Notes                                                 |
|----------------------------------------|---------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. Template Folder Location**        | Inspect the path set for "Template folder location".                      | Must point to the correct KSBC-defined templates folder (e.g., `ks-sbc/public-repo/documentation/_templates` or similar, or the training vault equivalent). | `[ ] Pass` `[ ] Fail` | *Verify exact path with DRUIDS admin.*               |
| **2. Enable Trigger Templater on New File Creation** | Verify checkbox state.                                      | **ON** (If KSBC workflow relies on templates auto-applying to new notes in certain folders).                               | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. User Script Functions Folder**    | If Templater user scripts are used, verify this path.                     | Should point to the correct folder containing custom JavaScript functions for Templater (e.g., `ks-sbc/system/.obsidian/scripts/templater/`). | `[ ] Pass` `[ ] Fail` | *Verify if KSBC uses this & path.*                    |
| **4. Syntax for Variables/Functions**  | Check if default syntax (`<% ... %>` and `<%* ... %>`) is used.           | Usually default, unless KSBC has specific reasons to change it.                                                          | `[ ] Pass` `[ ] Fail` |                                                       |

---

## IV. GPG-Encrypt (or chosen GPG/encryption plugin)

**Navigation:** `Obsidian Settings` > `Community Plugins` > `GPG Encrypt` (or specific plugin name) > `Options`.

| Setting / Feature                      | How to Check                                                              | Expected Value / State                                                                                                                                  | Result      | Notes                                                 |
|----------------------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. GPG Executable Path**             | If the plugin requires a manual path to the GPG executable.               | Should be correct for the user's OS, or empty if detected automatically.                                                                                | `[ ] Pass` `[ ] Fail` | *Requires GPG installed on system.*                   |
| **2. Default Key ID / Recipient(s)**   | Check for default encryption key settings.                                | May be blank (user selects per file) or pre-configured with KSBC group keys for L1/L2 if policy dictates. **Verify KSBC GPG policy.**                  | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Test Encryption/Decryption**      | Create a dummy file, encrypt it for yourself, then decrypt it.            | Successful encryption and decryption without errors. Prompt for passphrase should occur.                                                                | `[ ] Pass` `[ ] Fail` | *Requires user's GPG key setup.*                      |
| **4. Armor (ASCII Output)**            | Check if encrypted files are saved in ASCII armor format (`.asc` or similar). | Usually **ON** for easier handling in Git/text systems.                                                                                                 | `[ ] Pass` `[ ] Fail` |                                                       |

---

## V. Kanban (or chosen Kanban plugin)

**Navigation:** `Obsidian Settings` > `Community Plugins` > `Kanban` (or specific plugin name) > `Options`.

| Setting / Feature                      | How to Check                                                              | Expected Value / State                                                                                                | Result      | Notes                                                 |
|----------------------------------------|---------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. New Note Creation from Card**     | Verify settings related to creating notes from Kanban cards.              | Should specify the folder where new notes linked from cards are created (e.g., a project's `Tasks/` or `Notes/` folder). | `[ ] Pass` `[ ] Fail` |                                                       |
| **2. Date Format**                     | Check any date format settings used on cards.                             | Should be consistent (e.g., `YYYY-MM-DD`).                                                                            | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Template for New Note from Card** | If a template is used when creating a note from a card.                   | Should point to a valid template file if this feature is used by KSBC.                                                | `[ ] Pass` `[ ] Fail` |                                                       |

---

## VI. QuickAdd

**Navigation:** `Obsidian Settings` > `Community Plugins` > `QuickAdd` > `Options`.

| Setting / Feature                      | How to Check                                                                | Expected Value / State                                                                                                                            | Result      | Notes                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. Configured Choices (Macros)**     | Review the list of configured QuickAdd choices (e.g., "New L1 Document").   | Should match KSBC-defined macros for quick content creation (e.g., pre-defined templates, folder locations, metadata prompts for different document types). | `[ ] Pass` `[ ] Fail` | *Requires knowledge of KSBC QuickAdd setup.*          |
| **2. Template Paths in Macros**        | For each "Template" type choice, verify the template file path.             | Must point to valid, existing template files.                                                                                                     | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Script Paths in Macros**          | For each "Macro" type choice using scripts, verify script file paths.       | Must point to valid, existing script files.                                                                                                       | `[ ] Pass` `[ ] Fail` |                                                       |
| **4. Folder Creation/Selection**       | For choices that create files, verify default/prompted folder locations.    | Should align with DRUIDS folder structure and security tiers.                                                                                     | `[ ] Pass` `[ ] Fail` |                                                       |

---

## VII. ShellCommands (If used)

**Navigation:** `Obsidian Settings` > `Community Plugins` > `ShellCommands` > `Options`.

| Setting / Feature                      | How to Check                                                                | Expected Value / State                                                                                                                            | Result      | Notes                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|-------------|-------------------------------------------------------|
| **1. Defined Shell Commands**          | Review the list of configured shell commands.                               | Should match KSBC-defined commands for specific automation tasks (e.g., custom Git operations, file manipulations, script executions).                | `[ ] Pass` `[ ] Fail` | *Requires knowledge of KSBC ShellCommands setup.*     |
| **2. Command Working Directories**     | For each command, verify the specified working directory.                   | Should be appropriate for the command's context (e.g., vault root, specific project folder).                                                      | `[ ] Pass` `[ ] Fail` |                                                       |
| **3. Output Handling**                 | Check how output from commands is handled (e.g., notification, clipboard).  | Should be configured to provide clear feedback to the user.                                                                                       | `[ ] Pass` `[ ] Fail` |                                                       |
| **4. Prompts and Variables**           | If commands use prompts or variables, ensure they are correctly defined.      | Prompts should be clear, and variables correctly interpolated into commands.                                                                        | `[ ] Pass` `[ ] Fail` |                                                       |

---

**End of Checklist**
