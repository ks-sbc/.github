# Tutorial: Working with Documents - Creating, Editing, and Formatting

This tutorial will teach you the essentials of working with documents (notes) in DRUIDS (Obsidian). We'll cover creating new notes and folders, basic text formatting with Markdown, linking, and using tags.

## 1. Creating New Notes

Notes are the fundamental building blocks of your DRUIDS vault.

*   **Method 1: Using the File Explorer**
    1.  Open the File Explorer sidebar (Click the folder icon on the far left ribbon, or `Ctrl+Shift+E`).
    2.  Right-click on the folder where you want to create the new note (e.g., right-click on `04 - Exercises`).
    3.  Select "New note" from the context menu.
    4.  `[SCREENSHOT: Context menu in File Explorer showing "New note" option highlighted.]`
    5.  A new untitled note will be created. Immediately type the name for your note (e.g., `My Test Note.md`) and press `Enter`.
        *   **Operator Input:** You will type the desired filename.

*   **Method 2: Using the Quick Switcher Command**
    1.  Open the Quick Switcher (`Ctrl+O` or `Cmd+O`).
    2.  Type the name of the note you want to create. If it doesn't exist, Obsidian will offer to create it.
    3.  Select the "[Create new note]" option or simply press `Enter` if it's the only option.
    4.  `[SCREENSHOT: Quick Switcher showing the option to create a new note if it doesn't exist.]`

*   **Practice:**
    *   Create a new note inside the `04 - Exercises` folder named `My Formatting Practice.md`.

## 2. Creating New Folders

Folders help you organize your notes.

1.  Open the File Explorer sidebar.
2.  Right-click on an existing folder (to create a subfolder) or right-click in the empty space at the bottom of the File Explorer (to create a top-level folder in your vault).
3.  Select "New folder."
4.  `[SCREENSHOT: Context menu in File Explorer showing "New folder" option highlighted.]`
5.  Type the name for your folder and press `Enter`.
    *   **Operator Input:** You will type the desired folder name.

*   **Practice:**
    *   Create a new folder inside `04 - Exercises` named `My Test Subfolder`.

## 3. Basic Markdown Formatting

Markdown is a simple way to add formatting to plain text. Obsidian uses Markdown for its notes. Here are some basics:

*   **Headings:** Used to create titles and subtitles, structuring your document.
    *   `# Heading 1` (Largest heading - usually for the main title of a note)
    *   `## Heading 2` (For major sections)
    *   `### Heading 3` (For subsections)
    *   ...and so on, up to `###### Heading 6`.
    *   **How it looks:** The text will become larger and bolder.
    *   `[SCREENSHOT: Example of different heading levels rendered in Obsidian's reading view.]`

*   **Bold Text:** To make text **bold**.
    *   Wrap the text with double asterisks: `**This text will be bold**`
    *   Or double underscores: `__This text will also be bold__`

*   **Italic Text:** To make text *italic*.
    *   Wrap the text with single asterisks: `*This text will be italic*`
    *   Or single underscores: `_This text will also be italic_`

*   **Bulleted Lists:** For unordered lists.
    *   Start each line with a hyphen (`-`) or an asterisk (`*`), followed by a space.
    *   Example:
        ```markdown
        - Item 1
        - Item 2
          - Sub-item 2a (indent with spaces)
        ```
    *   `[SCREENSHOT: A rendered bulleted list with a sub-item.]`

*   **Numbered Lists:** For ordered lists.
    *   Start each line with a number followed by a period (`.`) and a space.
    *   Example:
        ```markdown
        1. First item
        2. Second item
        3. Third item
        ```

*   **Practice:**
    1.  Open your `My Formatting Practice.md` note (that you created in `04 - Exercises`).
    2.  Add a `# Main Title for My Note`.
    3.  Add a `## Subsection Title`.
    4.  Write a sentence and make **some words bold** and *others italic*.
    5.  Create a bulleted list with at least three items.
    6.  Create a numbered list with at least two items.

## 4. Creating Internal Links (Wikilinks)

Links connect your notes, creating a web of knowledge.

*   **How to Create:**
    1.  In your current note, type `[[`.
    2.  Start typing the name of the note you want to link to. Obsidian will show suggestions.
        *   Example: `[[What is DRUIDS]]`
    3.  Select the desired note from the suggestions or finish typing the name, then type `]]`.
*   You can also link to headings within notes: `[[What is DRUIDS#Core Functionality]]`
*   Or use custom display text: `[[What is DRUIDS|Learn about DRUIDS here]]`

*   **Practice:**
    1.  In your `My Formatting Practice.md` note, add a new line.
    2.  Create a link to the `[[../01 - Core Concepts/What is DRUIDS.md]]` note.
    3.  Create another link to the `[[../Examples/L0 - Public Examples/Example Public Document.md]]` note, but use custom display text like `[[../Examples/L0 - Public Examples/Example Public Document.md|View Public Example]]`.

## 5. Embedding Images (Conceptual)

You can embed images into your notes. While we can't add actual image files in this current tool, here's how the Markdown syntax works:

*   **Syntax:** `![Alt text for the image](path/to/your/image.png)`
    *   `![Alt text]` : The "alt text" describes the image for accessibility (e.g., if the image doesn't load or for screen readers).
    *   `(path/to/your/image.png)`: This is the relative path from your current note to the image file, or a web URL.
        *   **Example (local image):** If you have an image named `obsidian_logo.png` in a subfolder called `assets` relative to your current note: `![Obsidian Logo](assets/obsidian_logo.png)`
        *   **Example (web image):** `![External Image](https://obsidian.md/images/banner.png)`
    *   `[SCREENSHOT: Example of Markdown for an embedded image and how it might look rendered (placeholder image if needed).]`

*   **Note for DRUIDS:** In the actual DRUIDS vault, images would typically be stored within the vault structure (e.g., in an `assets` or `attachments` folder specific to a project or section).

## 6. Basic Use of Tags

Tags are another way to organize and find notes. They act like keywords or categories.

*   **How to Create:**
    *   Type a hashtag (`#`) followed by your tag word. No spaces are allowed in a tag, but you can use hyphens or underscores, or camelCase.
    *   Examples: `#important`, `#meeting-notes`, `#project-alpha`, `#CoreConcept`
    *   Tags can be placed anywhere in your note, but are often put at the top, in the frontmatter (metadata section), or at the end.

*   **Finding Notes with Tags:**
    *   You can click on a tag within a note to search for all other notes containing that tag.
    *   The "Tags Pane" in the sidebar (if enabled) lists all tags in your vault and lets you browse by tag.
    *   `[SCREENSHOT: The Tags Pane showing a list of example tags.]`

*   **Practice:**
    1.  Open your `My Formatting Practice.md` note.
    2.  Add at least two tags to it, for example: `#exercise` and `#formatting-practice`.
    3.  Click on one of the tags you added. What happens? (Obsidian's search should open, filtered by that tag).

## Comprehensive Exercise

1.  Go to the `04 - Exercises/My Test Subfolder/` folder you created earlier.
2.  Create a **new note** inside it named `Comprehensive Test Note.md`.
3.  In this new note:
    *   Add a `# Main Heading`.
    *   Write a short paragraph with some **bold** and *italic* text.
    *   Create a bulleted list of three things you've learned.
    *   Create a link to `[[../../01 - Core Concepts/Understanding Security Tiers.md]]`.
    *   Add the tags `#comprehensive-exercise` and `#test`.

## Conclusion

You've now learned the basics of creating, editing, and formatting documents in DRUIDS/Obsidian! These skills are essential for contributing to and organizing information within KSBC. The more you practice with Markdown and these features, the more intuitive they will become.

**Next Steps:**
*   Continue practicing by creating more notes.
*   Explore the official Obsidian documentation for more advanced Markdown and features.
*   Look for other tutorials in this training vault that might cover more specific plugins or workflows.
