# Using QuickAdd for DRUIDS Workflows

QuickAdd is a powerful plugin that has been configured to streamline the creation of common document types within the DRUIDS system. This guide provides a brief overview of how to use these pre-configured QuickAdd commands.

## Accessing QuickAdd Commands

The easiest way to access the configured QuickAdd commands is through Obsidian's command palette:

1.  Press `Ctrl+P` (or `Cmd+P` on macOS) to open the command palette.
2.  Start typing "QuickAdd:" or the name of the command you wish to run (e.g., "New: Meeting Note", "New: Study Guide").
3.  Select the desired command from the list that appears.

You can also assign hotkeys to your most frequently used QuickAdd commands via Obsidian's "Hotkeys" settings for even faster access.

## Available QuickAdd Commands (Initial Setup)

The following QuickAdd commands have been pre-configured to help you create new documents using the DRUIDS templates:

*   **New: Meeting Note:** Creates a new meeting note.
*   **New: Project Proposal:** Creates a new project proposal.
*   **New: Study Guide:** Prompts for a security level (Public, Candidate, Cadre) and then creates a new study guide in the appropriate `content/L0_public`, `content/L1_candidate`, or `content/L2_cadre` folder.
*   **New: Theoretical Position Paper:** Prompts for a security level and creates a new position paper in the appropriate security-tiered folder.
*   **New: Criticism Session Note:** Creates a new note for criticism/self-criticism sessions.
*   **New: Campaign Summation:** Creates a new campaign summation document.
*   **New: Decision Implementation Plan:** Creates a new plan for implementing a decision.
*   **New: Security Protocol:** Prompts for a security level and creates a new security protocol document in the appropriate security-tiered folder.
*   **New: Mass Line Investigation:** Creates a new note for mass line investigations.
*   **New: Member Development Plan:** Creates a new member development plan.

## Using the Commands

When you run a QuickAdd command:

1.  **Security Level Prompt (for relevant commands):** If the command is for a document type that requires a security level decision upfront (like Study Guides, Position Papers, Security Protocols), you will first be prompted to select "Public," "Candidate," or "Cadre." The new note will then be created in the corresponding folder.
2.  **Templater Prompts:** After the initial QuickAdd steps, the Templater script within the selected template will run. This will prompt you for further information (e.g., title, date, attendees, tags) specific to that document type.
3.  **File Renaming:** The Templater script will also automatically suggest a filename and rename the new note accordingly.

---

*This guide will be updated as more QuickAdd commands and workflows are developed for DRUIDS.*
