# Obsidian Integration Guide for ks-sbc

## Quick Start for New Coders

Welcome to the ks-sbc project! This quick start will help you get up and running with our content management workflow.

**Core Tools:** You'll primarily be using **Obsidian** for content creation and organization, along with **Git** and **GitHub** for version control and collaboration.

**Essential Obsidian Setup:**

1.  **Download Obsidian:** Get it from [obsidian.md](https://obsidian.md).
2.  **Open the Project Vault:**
    *   In Obsidian, use the "Open folder as vault" option.
    *   Select the main project directory where the content is stored (e.g., `content-repo` or `ObsidianVault`). `[Confirm correct vault folder with your team]`.
3.  **Install Essential Plugins:**
    *   Go to `Settings` (gear icon) > `Community Plugins` > `Browse`.
    *   Search for and install:
        *   `Dataview`
        *   `Templater`
    *   After installation, ensure both plugins are enabled (toggle them on in the `Community Plugins` list).

**Creating Your First Document (Study Guide Example):**

Let's create a new study guide using a template:

1.  Open the command palette (Ctrl+P on Windows/Linux, Cmd+P on macOS).
2.  Type `Templater: Open insert template modal` and select it.
3.  Choose the `study_guide_template` from the list.
4.  You'll be prompted to enter:
    *   Study Guide Title
    *   Security Level (e.g., Public, Candidate, Cadre)
    *   Related GitHub Issue Number (if any)
    *   Tags (comma-separated, e.g., `marxism, study-guide, state`)
5.  Your new study guide will be created with pre-filled metadata. (See Section 4.2 for more on Templater).

**Understanding Security Levels & Storage:**

We classify content by security levels (e.g., Public, Candidate, Cadre) to ensure information is handled appropriately.

*   **Public:** General information accessible to anyone.
*   **Candidate:** Materials for those undergoing training or onboarding.
*   **Cadre:** Restricted information for core team members.

Save your files in the correct directory based on their security level. For example, cadre-level documents go into `content/cadre/`. (See Section 2.1 for details on the vault structure).

**Linking to GitHub Issues:**

When referencing a GitHub issue in your notes, use a standard Markdown link:

`[Brief description of issue](https://github.com/ks-sbc/content-repo/issues/YOUR-ISSUE-NUMBER)`

Replace `YOUR-ISSUE-NUMBER` with the actual issue number. (See Section 3.1 for more detailed linking guidance).

**Simple Dataview Query Example:**

Dataview helps you find and organize your notes. To list all notes that you've tagged as `#study-guide` (assuming you add this tag when prompted by the template):

```dataview
LIST
FROM #study-guide
SORT file.ctime DESC
```

Place this code block in any Obsidian note. It will display a list of notes tagged `#study-guide`, sorted by creation date. (See Section 4.1 for more on Dataview).

---

This guide outlines the strategy for enhancing Obsidian as the primary content management tool for the ks-sbc project, as detailed in [GitHub Issue #5](https://github.com/ks-sbc/.github/issues/5). The focus is on robust security, streamlined workflow, and effective content lifecycle management.

## 1. Explanation: Goals of the Obsidian Setup

The primary goals for this Obsidian integration are:

*   **Enhanced Security:** Implement security-aware plugins and vault structures to protect content according to its classification.
*   **Democratic Centralist Workflow:** Support the full content lifecycle (creation, review, publication, maintenance) in a manner that aligns with the project's operational principles.
*   **Efficient Content Management:** Utilize Obsidian's features and plugins to make content creation, organization, and retrieval seamless for users.
*   **Clear Cross-Referencing:** Establish unambiguous linking between content in Obsidian and related items in GitHub (issues, discussions, PRs).
*   **Metadata Integrity:** Ensure content is appropriately tagged and validated for effective management and auditing.

This setup aims to provide a powerful, secure, and user-friendly environment for all content-related activities.

## 2. Reference: Vault Structure

A well-defined vault structure is crucial for security and organization. The following structure is proposed:

### 2.1. Key Principles for Security Compartments

Organizing content by security level is fundamental. Here's how we approach it:

*   **Directory-Based Separation:**
    *   Group content into directories named by security levels (e.g., `content/public`, `content/candidate`, `content/cadre`).
    *   **Note on Multiple Vaults:** While using separate Obsidian vaults for different security levels offers stricter OS-level access control, it can complicate linking between content. For this project, we primarily focus on a single vault with disciplined directory structures.
*   **Visual Cues for Clarity:**
    *   Employ clear folder naming conventions (as listed above).
    *   Optionally, use Obsidian themes or custom CSS snippets to visually distinguish notes or folders based on their security path or associated tags (e.g., applying a different color to files within the `content/cadre` directory).
*   **Intuitive Navigation:** Design the directory structure to make finding content based on security clearance straightforward.
*   **External Access Management:** Remember that Obsidian itself does not manage user-based access to individual notes. Access control for the vault (or its parts) should be handled through the system where the vault is stored (e.g., Git repository permissions, file system permissions on a shared drive), aligning with organizational roles.

### 2.2. Example Directory Layout (Within a Single Vault)

```
ObsidianVault/
├── content/
│   ├── public/       # Publicly accessible information
│   │   ├── general-info/
│   │   └── articles/
│   ├── candidate/    # Information for candidates
│   │   ├── training-materials/
│   │   └── onboarding/
│   ├── cadre/        # Restricted information for cadre members
│   │   ├── theory/
│   │   ├── strategy/
│   │   └── issues/   # Notes related to specific GitHub issues
│   └── shared/       # Templates, common assets (less sensitive)
├── attachments/      # Images, PDFs, etc.
├── .obsidian/        # Obsidian configuration files (plugins, themes, etc.)
│   ├── plugins/
│   ├── snippets/
│   └── config
├── templates/        # Folder for Templater plugin templates
└── README.md         # Vault introduction and guidelines
```

*Note: The exact paths like `quartz/content/cadre/theory/state-theory.md` mentioned in the issue should be mapped to this structure, e.g., `ObsidianVault/content/cadre/theory/state-theory.md`.*

## 3. Reference: Standardized URI Linking

Clear and consistent linking between Obsidian notes and GitHub resources is essential.

### 3.1. Linking from Obsidian to GitHub

Use standard Markdown links by inserting the full URL to the GitHub resource.

**How to Link:**

1.  Identify the full URL of the GitHub resource (e.g., issue, pull request, file).
2.  In your Obsidian note, create a Markdown link: `[Descriptive Text](URL)`

**Example:**
```markdown
<!-- In an Obsidian note, linking to a GitHub issue -->
This task relates to the [State and Revolution Study Guide Issue](https://github.com/ksbc/content-repo/issues/123).

Further discussion can be found in [PR #45](https://github.com/ksbc/content-repo/pull/45).
```

### 3.2. Linking from GitHub to Obsidian

Linking from GitHub (e.g., in issue comments or Markdown files in the repo) to Obsidian notes requires a consistent scheme. This ensures that links are predictable and, ideally, directly usable. Obsidian URIs are one way to achieve this.

#### Option 1: Using Obsidian URIs (Recommended for Direct Opening in Obsidian)

Obsidian supports a special URL scheme `obsidian://` that allows you to create links that open directly in the Obsidian application.

**Key Requirements for Team Use:**

*   **Consistent Vault Name:** Every team member must use the exact same vault name for the project vault in their local Obsidian setup.
*   **Consistent File Paths:** The path to the file within the vault must be the same for everyone.

**Format:**

`obsidian://open?vault=<VAULT_NAME_URL_ENCODED>&file=<FILE_PATH_URL_ENCODED>`

*   `<VAULT_NAME_URL_ENCODED>`: The name of your Obsidian vault, with spaces and special characters URL-encoded.
*   `<FILE_PATH_URL_ENCODED>`: The path to the note from the root of the vault (e.g., `content/cadre/My Note.md`), also URL-encoded.

**(Important Note:** The `vault=` parameter in Obsidian URIs (e.g., `ksbc-shared-vault` or `ksbc-content` in the examples) must match the exact name of the Obsidian vault as it is set up on each user's machine. Please confirm your project's official vault name with your team to ensure these links work correctly for everyone.)**

**Example (assuming vault name is "ksbc-shared-vault"):**
```markdown
<!-- In a GitHub issue comment -->
See the [theoretical foundation](obsidian://open?vault=ksbc-shared-vault&file=content%2Fcadre%2Ftheory%2Fstate-theory.md) for more details.
```

**Pros & Cons:**

*   **Pros:**
    *   Opens the note directly in the user's Obsidian application, providing a seamless experience.
*   **Cons:**
    *   Relies heavily on every user having the vault set up with the identical name.
    *   May be less intuitive for users who do not have Obsidian installed or the specific vault synced.

#### Option 2: Using Relative Paths (If Vault is in a Git Repo)

If your Obsidian vault is also a Git repository (or a subdirectory within one), and you are linking from a Markdown file within that same repository (e.g., from a `README.md` on GitHub), you can use relative paths.

**How it Works:**

These links are standard Markdown relative paths that work when browsing files directly on GitHub.

**Example (from a file at `content-repo/README.md` to an Obsidian note located at `content-repo/quartz/content/cadre/theory/state-theory.md`):**
```markdown
<!-- In content-repo/README.md -->
See the [theoretical foundation](./quartz/content/cadre/theory/state-theory.md) for more details.
```
**Pros & Cons:**

*   **Pros:**
    *   Standard Markdown, making it easy to create and understand.
    *   Works perfectly when browsing files directly on the GitHub website.
*   **Cons:**
    *   Does not open the note directly in the Obsidian application.
    *   Assumes the path (e.g., `quartz/content/...`) is correct relative to the file containing the link. The example from the original issue, `See the [theoretical foundation](quartz/content/cadre/theory/state-theory.md) for more details.`, implies that the content is structured within a `quartz` directory. This directory is likely version-controlled and possibly used for publishing with a static site generator. The path must be relative to the root of that repository.

**Our Recommendation for ks-sbc:**

To ensure clarity and functionality for different scenarios:

1.  **For Direct Obsidian Access:** Prioritize using **Obsidian URIs** (`obsidian://`) when your primary goal is to direct a team member into their local Obsidian application to view or edit a note. (Remember the vault name consistency!)
2.  **For GitHub Browsing & General Links:** Use **relative paths** or **full GitHub URLs** to specific files if:
    *   The Obsidian vault is also a browsable Git repository.
    *   You are linking from GitHub issues, discussions, or other contexts where users might not all have the Obsidian vault readily available or configured.

## 4. How-to & Reference: Plugin Configurations

Effective content management and workflow automation in Obsidian heavily rely on plugins. This section details the setup and use of key plugins mentioned in [GitHub Issue #5](https://github.com/ks-sbc/.github/issues/5).

### 4.1. Dataview Plugin

The Dataview plugin is a powerful tool that allows you to query, list, and table data directly from the metadata and content of your notes within your Obsidian vault. It's essential for tracking content, statuses, relationships, and creating dynamic overviews.

**(How-to) Basic Dataview Setup and Usage:**

1.  **Install Dataview:**
    *   Open Obsidian's settings (click the gear icon).
    *   Navigate to `Community Plugins`.
    *   Click `Browse` to open the community plugins list.
    *   Search for "Dataview" and click `Install`.
2.  **Enable Dataview:**
    *   After installation, find Dataview in your list of community plugins (under `Settings` > `Community Plugins`).
    *   Toggle the switch to enable it.
3.  **Start Querying:**
    *   In any Obsidian note, create a code block by typing three backticks, followed by `dataview`, like this:
        \`\`\`dataview
        // Your query goes here
        \`\`\`
    *   Write your DQL (Dataview Query Language) queries within this block.

**(Reference) Example Dataview Query (from original Issue #5):**

This query tables issues from a specific folder, filtered by a tag, showing their status and a link.

```dataview
TABLE
  issueStatus AS "Status",
  issueUrl AS "Link"
FROM "content/cadre/issues"
WHERE contains(tags, "theory-marxism")
SORT createdAt DESC
```

**(How-to) Adapting the Query:**

*   Change `"content/cadre/issues"` to the actual path where your issue notes or relevant documents are stored.
*   Modify `contains(tags, "theory-marxism")` to filter by different tags relevant to your needs.
*   `issueStatus` and `issueUrl` are examples of metadata fields you should have in your notes (e.g., in the YAML frontmatter).

**(How-to) Suggested Dataview Queries for Content Management:**

*   **List all study guides without a review date:**
    ```dataview
    LIST
    FROM "content"
    WHERE type = "study-guide" AND reviewDate = null
    ```
*   **Table of contents for a specific security level:**
    ```dataview
    TABLE title, created
    FROM "content/cadre" // or "content/public", "content/candidate"
    SORT file.mtime DESC
    ```
*   **Tasks from notes with 'status: pending':**
    ```dataview
    TASK
    WHERE status = "pending"
    GROUP BY file.link
    ```

### 4.2. Templater Plugin

The Templater plugin is a utility that lets you insert pre-defined templates into your notes. This is incredibly useful for creating new notes with consistent structures, boilerplate text, and dynamic information like dates or prompted values.

**(How-to) Basic Templater Setup and Usage:**

1.  **Install Templater:**
    *   Go to `Settings` > `Community Plugins` > `Browse`.
    *   Search for "Templater" and click `Install`.
2.  **Enable Templater:**
    *   In `Settings` > `Community Plugins`, toggle Templater on.
3.  **Configure Template Folder:**
    *   Open Templater's settings (usually found under `Settings` > `Templater` in the left sidebar).
    *   Set the "Template folder location" to the directory in your vault where you store your templates (e.g., `templates/` as per our recommended vault structure).
4.  **Insert a Template into a Note:**
    *   Open or create the note where you want to insert a template.
    *   Open the Obsidian command palette (default: `Ctrl+P` or `Cmd+P`).
    *   Type "Templater: Open insert template modal" and select it.
    *   Choose your desired template from the list that appears.

**(Reference) Using the `study_guide_template.md`:**

A template for creating new study guides (`study_guide_template.md`) should be placed in your configured template folder. Its content is specified in GitHub Issue #5 and has been created as `study_guide_template.md` in this repository.

**(How-to) Using the `study_guide_template.md`:**

1.  Ensure `study_guide_template.md` is in your Templater plugin's template folder.
2.  When creating a new study guide, invoke Templater.
3.  Select the "study_guide_template".
4.  You will be prompted for:
    *   Study Guide Title
    *   Security Level (Public, Candidate, Cadre)
    *   Related GitHub Issue Number
    *   Tags (comma-separated)
5.  The template will generate the note structure with the provided metadata.

### 4.3. Security Plugins: Concepts and Approaches

**Note:** The 'security plugins' described below often represent conceptual goals for enhancing security. While some existing Obsidian plugins can be adapted for these purposes (e.g., Linter, Dataview with custom queries), specific off-the-shelf plugins for all these functions may not be available and might require custom development or creative configuration as your team evolves its setup.

GitHub Issue #5 emphasizes the need for "security-aware plugins." Since specific plugins are not named, this section provides conceptual guidance on what functionalities to look for or potentially develop to reinforce the project's security model and workflow.

**(Explanation & How-to Concepts for Enhancing Security)**

1.  **Security Level Enforcement Plugins:**
    *   **Importance:** Ensures content is correctly classified and access/visibility aligns with its sensitivity.
    *   **What to look for/How to implement:**
        *   Plugins that can read metadata (e.g., `security: cadre`) and visually flag or restrict actions on notes that don't match user roles (though Obsidian's core doesn't have user roles).
        *   Custom scripts (perhaps using Templater or QuickAdd) that enforce security field completion.
        *   Linters or validation tools that check for the presence and valid values of a `security` field in the frontmatter.

2.  **Metadata Validation Tools:**
    *   **Importance:** Ensures all necessary metadata (e.g., `security`, `created`, `issue`, `tags`) is present and correctly formatted. Crucial for Dataview queries, auditing, and workflow.
    *   **What to look for/How to implement:**
        *   Plugins that allow defining schema for frontmatter and validating notes against it (e.g., Linter plugin with custom rules).
        *   Templater scripts that ensure all required fields are prompted for during note creation.

3.  **Cross-Reference Security Checkers:**
    *   **Importance:** Prevents accidentally linking from lower-security documents to higher-security documents if those links could expose restricted content or titles.
    *   **What to look for/How to implement:**
        *   This is a complex area. It might involve custom scripts that parse links and check the `security` level of linked notes.
        *   Manual review processes might be needed initially.
        *   Consider if a plugin could visually flag links pointing to notes with a higher security level.

4.  **Classification Visualization Helpers:**
    *   **Importance:** Provides clear visual cues about the security level of content.
    *   **What to look for/How to implement:**
        *   Obsidian themes or CSS snippets that change note appearance (e.g., border color, header color) based on tags or parent folder (e.g., files in `content/cadre/` get a red highlight).
        *   Plugins that add icons or badges to notes based on metadata.

5.  **Security Audit Trail Generators:**
    *   **Importance:** For tracking changes to sensitive content, especially modifications to security classifications or critical information.
    *   **What to look for/How to implement:**
        *   While Obsidian is file-based, Git is the primary audit trail for content changes. Ensure the vault is under Git version control.
        *   No specific Obsidian plugin for "audit trails" in the traditional server sense. Focus on robust Git practices.
        *   Potentially, a plugin could log specific actions (like changing a `security:` field) to a dedicated log note, but this would be custom.

**Note on Implementation:**
*   Some of these "Security Plugins" might not exist as off-the-shelf solutions and may require creative use of existing plugins (like Linter, Dataview, Templater with custom scripts) or even new plugin development for the `ks-sbc` project if the requirements are highly specific.
*   Start with robust manual processes and gradually automate with plugins where feasible.

## 5. Tutorial Concepts & How-to: Workflow and Lifecycle

This section outlines how the configured Obsidian environment, in conjunction with Git/GitHub, supports the entire lifecycle of content from creation to maintenance. This aligns with the acceptance criteria from [GitHub Issue #5](https://github.com/ks-sbc/.github/issues/5).

### 5.1. Overview: Content Lifecycle Stages

The Obsidian setup is designed to support the full content lifecycle. Each stage is described below with relevant how-to information and Diataxis classification (which helps categorize the type of information being provided: How-to, Tutorial, Reference, or Explanation).

#### 1. Creation

*   **How-to:**
    1.  Utilize the **Templater plugin** (see Section 4.2) with pre-defined templates like `study_guide_template.md`.
    2.  These templates prompt for essential metadata such as title, security level, related GitHub issue numbers, and tags.
*   **Security:** The template system encourages assigning a security level (e.g., `public`, `candidate`, `cadre`) right from the start.
*   **Diataxis Classification:** This part of the process is a **How-to** (using the template) and generates **Reference** material (the note itself with its structured metadata).

#### 2. Development & Collaboration

*   **How-to:**
    1.  Authors develop content using Obsidian's Markdown editor.
    2.  **Git** is employed for version control (saving changes, branching).
    3.  **GitHub** is used for collaborative aspects like sharing branches and managing Pull Requests.
*   **Cross-References:** Follow the guidelines in Section 3 (Standardized URI Linking) to link to other notes within the vault or to external resources like GitHub issues.
*   **Dataview Usage:** Employ **Dataview queries** (see Section 4.1) to track personal tasks, view lists of related documents, or monitor content status.
*   **Diataxis Classification:** This stage is primarily **How-to** (writing, linking, versioning, collaborating).

#### 3. Review

*   **How-to:**
    1.  Content changes are typically reviewed via **GitHub Pull Requests (PRs)**. The Obsidian vault (or the relevant content portion) should be a Git repository.
    2.  Reviewers examine the PR for accuracy, completeness, clarity, and adherence to project guidelines.
*   **Key Review Checks:**
    *   **Metadata Validation:** Use "Security Plugins" concepts (Section 4.3) or manual checks (guided by this document) to ensure metadata (e.g., `security` field, `tags`) is appropriate and complete.
    *   **Cross-Reference Integrity:** Verify that links are valid and do not inadvertently expose restricted content (e.g., a `public` note should not link to internal details of a `cadre` note unless that specific detail is also intended to be public).
*   **Diataxis Classification:** This involves **How-to** (performing reviews) and checking against **Reference** material (this guide, security guidelines, metadata schema).

#### 4. Publication

*   **How-to:**
    1.  Once a PR is reviewed and approved, the changes are **merged** into the main branch of the content repository.
    2.  **Static Site Generation (If Applicable):** If the project uses a static site generator like Quartz (as implied by `quartz/content/...` paths in the original issue), this merge can automatically trigger a rebuild and deployment of the public-facing website.
*   **Diataxis Classification:** This is a **How-to** (merging, deploying).

#### 5. Maintenance

*   **How-to:**
    1.  Regularly use **Dataview queries** to identify content that may need attention (e.g., notes without a recent review date, pages not updated in a specified period, articles linked to closed issues).
    2.  Track related GitHub issues for necessary updates or corrections to content.
    3.  The content lifecycle then repeats for updates: development of changes, review, and re-publication.
*   **Diataxis Classification:** This involves **How-to** (finding and updating content) and using **Reference** material (Dataview queries, issue trackers).

### 5.2. Tutorial: Testing the Full Content Lifecycle

To fulfill the acceptance criterion "Test full content lifecycle within Obsidian," a new coder can perform the following steps:

1.  **Create:**
    *   Use the `study_guide_template` via the Templater plugin to create a new sample study guide.
    *   Fill in prompted metadata (e.g., Title: "My Test Guide", Security: "candidate", Tags: "test, quickstart").
2.  **Develop:**
    *   Add some sample content to the note.
    *   Create a link to a test GitHub issue (e.g., `[Test Issue](https://github.com/ks-sbc/.github/issues/5)` - replace with an actual test issue if possible).
    *   Commit your changes to a new Git branch (e.g., `git checkout -b test-guide-username` and `git commit -am "feat: create test study guide"`).
3.  **Collaborate & Review (Simulated):**
    *   Push your branch to GitHub (`git push origin test-guide-username`).
    *   Open a Pull Request on GitHub from your branch to the main project branch.
    *   Ask a teammate (or simulate yourself as another user) to review the PR. The review should check:
        *   Correct metadata (security level, tags).
        *   Valid links.
        *   Clarity of content.
4.  **Publish (Simulated):**
    *   Merge the Pull Request into the main branch on GitHub.
5.  **Verify:**
    *   Ensure the new guide appears as expected in your local vault after pulling changes from main.
    *   If a website is automatically published, check if the guide appears there (this might take a few minutes).
6.  **Maintain (Simulated):**
    *   Later, make a small edit to your "My Test Guide".
    *   Commit the change to a new branch, create another PR, merge it. This simulates the update process.
    *   Use a Dataview query (like the one in the Quick Start section, or one that lists files by the "test" tag) to find your guide.

This exercise provides a hands-on understanding of how content moves through the established workflow.

### 5.3. How-to: Cross-Repository Reference Handling

This addresses the acceptance criterion "Enhance cross-repository reference handling." The key is consistent URI/URL usage as defined in Section 3 (Standardized URI Linking).

**Context:** The `ks-sbc` project may involve multiple repositories (e.g., a main `content-repo` where the Obsidian vault resides, the `.github` repository for community health files, and potentially specialized tool or project repositories). Obsidian is primarily focused on the content within the `content-repo`.

**Best Practices for Linking:**

1.  **From Obsidian to GitHub (Any Repository):**
    *   **Action:** Always use full, absolute URLs for maximum clarity and to ensure links work for all collaborators, regardless of their local setup or whether they are browsing on GitHub or in Obsidian.
    *   **Example:** `[Discussion on new strategy](https://github.com/ks-sbc/strategy-repo/discussions/12)` (This links to a hypothetical `strategy-repo`).
    *   **Example:** `[Related configuration file](https://github.com/ks-sbc/.github/blob/main/some-config.yaml)`

2.  **From GitHub (Any Repository) to Obsidian (Main `content-repo` Vault):**
    *   **Scenario 1: Linking to open directly in Obsidian (Preferred for team members):**
        *   **Action:** Use the `obsidian://open?vault=VAULT_NAME&file=FILE_PATH` scheme.
        *   **Reminder:** This requires all users to have their Obsidian vault named consistently (see Section 3.2 and the important note about vault names).
        *   **Example:** `See details in [State Theory notes](obsidian://open?vault=ksbc-content&file=content%2Fcadre%2Ftheory%2Fstate-theory.md)` (assuming your project's vault is named `ksbc-content`).
    *   **Scenario 2: Linking to a file viewable on GitHub (Good for general reference or if users might not have Obsidian setup):**
        *   **Action:** Use relative paths if linking from within the *same* repository, or full GitHub file URLs if linking from a *different* repository or for maximum explicitness.
        *   **Example (relative, from an issue in `content-repo` to a file in `content-repo`):** `Refer to the [State Theory document](./content/cadre/theory/state-theory.md).`
        *   **Example (full URL, from `.github` repo to a file in `content-repo`):** `Refer to the [State Theory document](https://github.com/ks-sbc/content-repo/blob/main/content/cadre/theory/state-theory.md).`
    *   **Guidance:** The choice depends on the audience and the desired behavior (open directly in Obsidian vs. view the Markdown file on GitHub).

3.  **Linking Between Different Obsidian Vaults (If Ever Applicable):**
    *   **Consideration:** This is generally more complex and should be minimized if possible by centralizing heavily interlinked content into a single primary vault.
    *   **Action:** If necessary, using `obsidian://` URIs is the only direct way. This requires knowing the other vault's exact name and the file path within it.
    *   **Example:** `[External Reference](obsidian://open?vault=MyOtherVault&file=some%2Fother%2Fnote.md)`

4.  **Documentation and Consistency:**
    *   **Action:** Clearly document the chosen primary vault name(s) for the project (as done in this guide, which needs team confirmation for the placeholder names).
    *   **Action:** Encourage all team members to use these linking conventions consistently.

By adhering to these linking strategies, cross-repository (and intra-repository) references become more manageable, predictable, and user-friendly for everyone involved in the `ks-sbc` project.

## 6. Troubleshooting/FAQ

This section addresses common questions and issues that may arise while using Obsidian with the ks-sbc project setup.

**Q: My Templater template (e.g., Study Guide) isn't appearing or working.**
*   A: Check the following:
    *   Ensure the Templater plugin is installed and enabled (go to `Settings` > `Community Plugins`).
    *   Verify the "Template folder location" in Templater's settings (`Settings` > `Templater`) is correctly set to your templates folder (e.g., `templates/` as described in Section 2.2).
    *   Make sure the `study_guide_template.md` (or other template file) is actually present in that designated folder.
    *   When trying to insert a template, are you using the correct command? (Typically, open the command palette with `Ctrl+P` or `Cmd+P`, then type "Templater: Open insert template modal").
    *   For more details on Templater setup and usage, refer to Section 4.2.

**Q: My Dataview query isn't showing any results. What should I check?**
*   A: Common issues include:
    *   Ensure the Dataview plugin is installed and enabled (`Settings` > `Community Plugins`).
    *   Double-check the `FROM` clause in your query. Does it accurately point to the correct folders or tags (e.g., `FROM "content/cadre/issues"` or `FROM #my-tag`)? Remember that paths and tags are case-sensitive.
    *   Verify that the metadata fields used in your `WHERE` clause (e.g., `WHERE type = "study-guide"`) exist in your notes' YAML frontmatter and are spelled exactly as in the query.
    *   For tag-based queries (e.g., `FROM #study-guide`), ensure your notes actually contain that specific tag.
    *   Review Section 4.1 for more examples and guidance on Dataview queries.

**Q: I'm confused about where to save a new file based on its security level.**
*   A: Refer to the vault structure outlined in Section 2.1 (Key Principles for Security Compartments) and the example directory layout in Section 2.2. As a general guide:
    *   Public content: `content/public/`
    *   Candidate-level content: `content/candidate/`
    *   Cadre-level content: `content/cadre/`
    *   Always confirm with your team lead or a mentor if you are unsure, especially when handling sensitive or restricted information.

**Q: How do I know the correct `vault` name for `obsidian://` links?**
*   A: This is crucial for team collaboration and ensuring `obsidian://` links work for everyone. As highlighted in Section 3.2, the vault name in links like `obsidian://open?vault=YOUR_VAULT_NAME&file=...` must exactly match the name of the vault as it is set up in each team member's Obsidian application.
    *   Your project should have a standardized vault name. Please confirm this official name with your team lead or consult your project's primary setup documentation.
    *   The "Quick Start for New Coders" section (Section 0) also includes a placeholder reminder to confirm this with your team.

**Q: Where can I find more help or ask project-specific questions?**
*   A: This guide aims to cover many aspects of the Obsidian integration. However, for project-specific questions, workflow clarifications, or issues not addressed here:
    *   First, check your project's main `README.md` file or any internal team communication channels (e.g., dedicated chat spaces, forums, or wikis).
    *   Consult with your team lead, a designated mentor, or a more experienced team member.
    *   *(Placeholder: If your project has a specific Q&A forum or contact point, it can be linked here, e.g., [Link to ks-sbc Project Discussion Forum])*
