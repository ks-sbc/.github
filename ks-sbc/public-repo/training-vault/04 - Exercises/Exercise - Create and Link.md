# Exercise: Create a New Note and Link It

This exercise will help you practice creating a new note and linking it to an existing document in this training vault.

## Your Task

1.  **Create a New Note:**
    *   Decide where you want to create this new note. For this exercise, let's create it in the `04 - Exercises` folder.
    *   Right-click on the `04 - Exercises` folder in the file explorer (left sidebar).
    *   Select "New note."
    *   Name your new note: `My First Linked Note.md` (or any name you like, just remember it!).
        *   **Operator Input:** You will type this filename.

2.  **Add Some Content to Your New Note:**
    *   Open your newly created note.
    *   Write a sentence or two. For example: "This is my first note created as part of the DRUIDS training exercise."
        *   **Operator Input:** You will type this content.

3.  **Link Your New Note to an Existing Document:**
    *   In your new note (`My First Linked Note.md`), on a new line, type the following to create a link to the "Example Public Document":
        `I am linking to the [[../Examples/L0 - Public Examples/Example Public Document.md]]`
    *   Observe how Obsidian might suggest the link as you type `[[...]]`.
        *   **Operator Input:** You will type this link syntax.

4.  **Link an Existing Document Back to Your New Note:**
    *   Open the `Examples/L0 - Public Examples/Example Public Document.md` file.
    *   At the bottom of that file, add a new line and create a link back to the note you just made:
        `This document is now linked from [[../04 - Exercises/My First Linked Note.md]]` (Adjust the path if you named your note differently or placed it elsewhere).
        *   **Operator Input:** You will type this link syntax.

## Verification

*   Click on the link in `My First Linked Note.md`. Does it take you to the `Example Public Document.md`?
*   Click on the link you added in `Example Public Document.md`. Does it take you back to `My First Linked Note.md`?
*   Check the "Graph View" (icon in the left sidebar, looks like connected dots). Can you see your new note and the links you created?

## Congratulations!

You've practiced some fundamental DRUIDS/Obsidian skills: creating notes and establishing bi-directional links! This is crucial for building a connected knowledge base.

---
**Further Practice:** Try creating more notes and linking them to different documents in the `Examples` or `01 - Core Concepts` folders. Experiment with different link texts using the `[[Filename|Display Text]]` format.
