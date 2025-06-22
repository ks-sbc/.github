# Workflow Tutorial: How to Find and Link to Existing Documents in DRUIDS (Obsidian)

This tutorial explains how to search for existing documents and create internal links (wikilinks) to them within DRUIDS, using Obsidian. Effective linking is crucial for building a connected knowledge base.

## Prerequisites

*   You have Obsidian installed and configured for use with DRUIDS.
*   You are familiar with basic Obsidian navigation.

## Part 1: Finding Existing Documents

Obsidian offers powerful search capabilities to help you locate documents within your DRUIDS vault.

**Method 1: Quick Switcher (Recommended for known filenames)**

1.  **Open Quick Switcher:** Press `Ctrl+O` (Windows/Linux) or `Cmd+O` (macOS).
2.  **Start Typing:** Begin typing the name of the document you are looking for.
    *   **Operator Variable:** The text you **input** here is your search query. Obsidian will show a list of matching filenames in real-time.
    *   Example: If you type `Meeting`, it will show `Meeting Minutes 2023-10-26.md`, `Project Alpha Meeting Notes.md`, etc.
3.  **Navigate and Select:** Use the arrow keys to highlight the desired document in the list.
4.  **Open Document:** Press `Enter` to open the selected document.

**Method 2: Global Search (More comprehensive)**

1.  **Open Search Pane:**
    *   Click the search icon (magnifying glass) in the left sidebar.
    *   Or, press `Ctrl+Shift+F` (Windows/Linux) or `Cmd+Shift+F` (macOS).
2.  **Enter Search Query:**
    *   In the search bar at the top of the search pane, **input** your search terms. This can be:
        *   Keywords from the document title or content (e.g., `budget proposal`).
        *   Tags (e.g., `tag:#project-gamma`).
        *   Paths (e.g., `path:L1_Documents/Strategy/`).
        *   Specific phrases in quotes (e.g., `"democratic centralist principles"`).
    *   **Operator Variable:** Your search query can be simple or use advanced operators. Refer to Obsidian's search documentation for more advanced syntax (e.g., `OR`, `-` for exclude).
3.  **Review Search Results:** The search pane will display a list of documents matching your query, often with snippets of the relevant text.
4.  **Navigate and Open:** Click on any document in the results list to open it.

**Tips for Effective Searching:**

*   **Use Specific Keywords:** The more specific your keywords, the narrower and more relevant your results will be.
*   **Leverage Tags:** If KSBC uses a consistent tagging system, searching by tags can be very efficient.
*   **Filter by Path:** If you know roughly where a document should be, using the `path:` operator can help.

## Part 2: Creating Internal Links (Wikilinks)

Internal links create connections between your documents, making navigation and information discovery seamless. Obsidian uses the "wikilink" format.

**Method 1: Typing Double Brackets (Standard Wikilink)**

1.  **Open the Document:** Open the document where you want to add a link (the "source" document).
2.  **Place Cursor:** Click to place your cursor where you want the link to appear.
3.  **Type Double Brackets:** Type `[[`.
4.  **Start Typing Document Name:** As you type, Obsidian will suggest matching document names from your vault.
    *   **Operator Variable:** The text you **input** here is the name of the document you want to link to (the "target" document).
    *   Example: If you type `[[Policy`, Obsidian might suggest `Policy on Document Classification.md`, `L2_Policy_Proposal_Template.md`, etc.
5.  **Select from Suggestions:**
    *   Use the arrow keys to highlight the correct document from the suggestions.
    *   Press `Enter` or `Tab` to autocomplete the link.
    *   Alternatively, you can type out the full filename.
6.  **Close Brackets:** Type `]]` to complete the link.
    *   The final link will look like: `[[YYYY-MM-DD_Target_Document_Name.md]]` or simply `[[Target Document Name]]` if you have "Use Wikilinks" without file extensions enabled in settings.

**Method 2: Using Custom Link Text (Aliasing)**

Sometimes, you want the link text to be different from the target document's filename.

1.  **Follow Steps 1-4 from Method 1.**
2.  **Add a Pipe Symbol:** After the filename (or while selecting it), type a pipe symbol `|`.
3.  **Type Custom Link Text:** After the pipe symbol, **input** the text you want to display for the link.
    *   **Operator Variable:** This is the custom display text for your link.
4.  **Close Brackets:** Type `]]`.
    *   Example: `[[YYYY-MM-DD_Target_Document_Name.md|Read our policy here]]` will display as "Read our policy here" but link to the specified document.

**Method 3: Drag and Drop (Visual Linking)**

1.  **Arrange Panes:** Have both the source document and the file explorer (or another pane showing the target document) visible.
2.  **Drag:** Click and drag the filename of the target document from the file explorer.
3.  **Drop:** Drop it into the desired location in your source document. Obsidian will automatically create a wikilink.

## Part 3: Linking to Specific Headings within Documents

You can create links that take you directly to a specific section (heading) in another document.

1.  **Create the Basic Link:** First, create a link to the target document as described above (e.g., `[[Target Document Name`).
2.  **Add a Hash Symbol:** After the document name, type a `#` symbol.
3.  **Type Heading Text:** Start typing the text of the heading you want to link to. Obsidian will suggest matching headings from the target document.
    *   **Operator Variable:** The text you **input** here is the heading text.
    *   Example: `[[Target Document Name#Specific Section Title]]`.
4.  **Select and Close:** Select the correct heading and then type `]]`.

*   **Note:** If the heading text is long or complex, you might need to ensure it matches exactly, or that the target document has unique enough headings.

## Considerations for Linking Between Security Classifications

*   **Awareness is Key:** Be mindful when linking between documents of different security classifications.
*   **L0 to L1/L2 (Generally Discouraged without Clear Purpose):**
    *   Linking from a public (L0) document to a restricted (L1 or L2) document might expose the existence or title of the restricted document to users who cannot access it. This is generally not a good practice unless explicitly intended (e.g., an L0 index that lists L1 documents for authorized users).
    *   Obsidian will still create the link, but users without permission will not be able to follow it to the content.
*   **L1/L2 to L0 (Generally Acceptable):**
    *   Linking from a restricted document (L1/L2) to a public document (L0) is usually fine, as the L0 document is accessible to everyone who can see the link.
*   **L2 to L1 (Use with Caution):**
    *   Similar to L0 to L1/L2, ensure that linking from a highly sensitive L2 document to an L1 document doesn't inadvertently reveal sensitive context to L1-only users who might see the link text or backlinks.
*   **Best Practice:**
    *   **Avoid unnecessary cross-classification linking if it can cause confusion or imply access that doesn't exist.**
    *   If linking to higher-classification documents, use non-descriptive aliases if the title itself is sensitive: `[[L2_Secret_Project_Plan.md|Further Details (Cadre Only)]]`.
    *   Always adhere to KSBC's specific data handling and security policies. DRUIDS itself won't prevent you from *making* these links, but policy might dictate when it's appropriate.

## Verifying Links

After creating a link, you can:

*   **Hover:** Hover your mouse over the link to see a preview of the target document (if enabled).
*   **Click:** Click the link to navigate to the target document. This is the best way to ensure it works as expected.

By mastering searching and linking, you contribute to a well-organized and interconnected DRUIDS knowledge base, making information more accessible and useful for all KSBC members.
