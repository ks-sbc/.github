# Workflow Tutorial: How to Create a New Document Using a Template in DRUIDS (Obsidian)

This tutorial provides step-by-step instructions on how to create a new document in DRUIDS using pre-defined templates within Obsidian. Templates help ensure consistency and include necessary metadata for proper document management.

## Prerequisites

*   You have Obsidian installed and configured for use with DRUIDS.
*   You have the necessary permissions to create documents in the desired location/classification.
*   You are familiar with basic Obsidian navigation.

## Accessing Document Templates

DRUIDS (via Obsidian) utilizes a "Templates" plugin or a designated templates folder.

1.  **Locate the Templates Plugin/Folder:**
    *   **Templates Plugin:** If DRUIDS uses the official "Templates" or "Templater" plugin, you'll typically access templates via a hotkey or a command.
        *   Check KSBC's Obsidian configuration notes for the specific hotkey (e.g., `Ctrl+T`, `Alt+T`) or command (open the command palette with `Ctrl+P` or `Cmd+P` and type "Template" or "Templater").
    *   **Designated Templates Folder:** There might be a specific folder in your Obsidian vault named `Templates`, `_templates`, or similar, where all document templates are stored. You would navigate to this folder in the file explorer.

2.  **Identify the Correct Template:**
    *   Templates are usually named descriptively, e.g., `L0_General_Document_Template.md`, `L1_Meeting_Minutes_Template.md`, `L2_Policy_Proposal_Template.md`.
    *   **Security Classification Matters:**
        *   **L0 (Public/General):** Templates for general documents are usually in a main templates folder.
        *   **L1 (Internal/Candidate):** Templates for L1 documents might be in a subfolder like `Templates/L1_Templates/` or may have specific prefixes/suffixes. Access to these might be visually apparent or implicitly based on your ability to navigate to certain vault areas.
        *   **L2 (Cadre/Sensitive):** L2 templates will be in highly restricted folders, potentially within encrypted sections of the vault if DRUIDS is structured that way. They might also have distinct naming conventions (e.g., `SECURE_L2_Strategic_Analysis_Template.md`). You might need to ensure you are in the correct "profile" or have the necessary decryption active to see these templates. Some L2 templates might only be accessible via specific macros or commands that enforce stricter creation protocols.

## Steps to Create a New Document from a Template

Here's the general workflow. Specifics might vary slightly based on the plugin used (Templates vs. Templater).

**Method 1: Using the "Templates" or "Templater" Plugin (Recommended)**

1.  **Navigate to the Target Folder:** In the Obsidian file explorer, navigate to the folder where you want to create the new document. This is important for organization.
    *   **Input/Choice:** You need to **select** the correct destination folder based on the document's purpose and security classification.

2.  **Create a New Note:**
    *   Right-click in the target folder and select "New note," or use the Obsidian command palette (`Ctrl+P` or `Cmd+P`) and type "New note."
    *   Alternatively, some template plugins allow you to create a new note *from* a template directly, skipping the initial blank note.

3.  **Name Your Document:**
    *   Immediately after creating the note, Obsidian will prompt you to name it, or the first line will be the filename.
    *   **Input/Choice:** **Enter** a clear, descriptive filename for your new document. Follow any KSBC naming conventions (e.g., `YYYY-MM-DD_Topic_Or_Title.md`, `ProjectX_Status_Report_Week10.md`).

4.  **Insert the Template:**
    *   With the new, empty (or nearly empty) note open and active:
        *   Use the designated hotkey for inserting a template (e.g., `Ctrl+T`).
        *   Or, open the command palette (`Ctrl+P` or `Cmd+P`), type "Template" or "Templater," and select the option like "Templates: Insert template" or "Templater: Insert template from file."
    *   A list of available templates will appear.
    *   **Input/Choice:** **Select** the appropriate template from the list. Ensure it matches the document's intended purpose and security level. For example, choose `L1_Meeting_Minutes_Template.md` if you are creating minutes for an L1 committee.

5.  **Template Content is Inserted:** The content of the selected template, including any pre-defined frontmatter and structure, will be inserted into your new note.

**Method 2: Manually Copying from a Templates Folder (Less Common for active templating plugins)**

1.  **Navigate to the Templates Folder:** Find the `Templates` folder in your Obsidian file explorer.
2.  **Find and Open the Template:** Click on the template file you wish to use.
3.  **Copy Content:** Select all the content (`Ctrl+A` or `Cmd+A`) and copy it (`Ctrl+C` or `Cmd+C`).
4.  **Create Your New Document:**
    *   Navigate to your target folder.
    *   Create a new note and name it appropriately (see step 3 above).
5.  **Paste Content:** Paste the copied template content into your new note (`Ctrl+V` or `Cmd+V`).

## Filling Out Initial Frontmatter/Metadata

Most KSBC templates will start with a "frontmatter" block at the very top of the document. This is typically YAML syntax (between `---` lines).

```yaml
---
title: ""
date: {{date}}
author: ""
tags: []
classification: "" # E.g., L0, L1, L2
status: "draft" # E.g., draft, review, final
related_docs: []
---
```

1.  **Review the Frontmatter:** The template will provide placeholders or default values.
2.  **Fill in the Details:**
    *   `title:` **Input** the full, formal title of your document. This might be the same as your filename or more descriptive.
    *   `date:` Often, templates (especially with Templater) will automatically insert the current date (e.g., `{{date}}` or `{{tp.date.now("YYYY-MM-DD")}}`). If not, **input** the correct date.
    *   `author:` **Input** your name or the responsible entity.
    *   `tags:` **Input** relevant keywords or tags, separated by commas or on new lines with a hyphen (e.g., `[meeting, project-alpha, planning]`). This helps in searching and organization.
    *   `classification:` **Input** the correct security classification (e.g., `L0`, `L1`, `L2`). This MUST match the document's actual sensitivity and storage location.
    *   `status:` **Input** the current status of the document (e.g., `draft`, `in-review`, `approved`, `final`).
    *   `related_docs:` If applicable, **input** links or references to other relevant documents within DRUIDS (e.g., `[[YYYY-MM-DD_Project_Proposal.md]]`).

**Important Considerations for L1/L2 Templates:**

*   **Specific Macros:** L1 or L2 templates might trigger specific macros or scripts upon creation (if using Templater or similar advanced tools). These could:
    *   Prompt you for additional mandatory metadata (e.g., "Review Date," "Owning Committee"). **Input** this information as prompted.
    *   Automatically apply certain tags or move the file to a subfolder based on your input.
    *   For L2, a macro might even initiate an encryption prompt or require a digital signature confirmation.
*   **Location and Permissions:** Always ensure you are creating L1/L2 documents in their designated, access-controlled locations. Using an L2 template outside an L2-secure area defeats its purpose.

## After Filling Frontmatter

Once the frontmatter is complete, you can proceed to fill in the main content of the document according to the structure provided by the template.

## Getting Help

If you are unsure which template to use, how to fill out specific metadata, or if you encounter issues with template functionalities, consult:

*   Your mentor or a Cadre member.
*   KSBC's specific documentation on DRUIDS and Obsidian usage.
*   The DRUIDS/Obsidian support channel or administrator.

Using templates correctly is crucial for maintaining order, consistency, and proper information management within KSBC.
