# Using and Customizing the Obsidian Dashboard System

## 0. Important Prerequisites & Core Concepts

> **Critical for Success: Consistent Metadata & Dataview Plugin**
>
> This dashboard system relies **entirely** on two key elements:
>
> 1.  **The Dataview Plugin:** You must have the Dataview plugin installed and enabled in your Obsidian settings. Most queries also require JavaScript execution to be enabled for Dataview (this is usually on by default).
> 2.  **Consistent Metadata:** The queries embedded in these dashboards are designed to work with a specific set of metadata fields (YAML frontmatter, tags, inline fields) in your notes. **You MUST ensure your notes use this metadata structure consistently for the dashboards to produce accurate results.**
>
> **Please refer to the `docs/dataview-organizational-metrics-queries.md` document, specifically its "Metadata Recap (Assumed for Category X)" sections, for the detailed metadata structure expected by these dashboards.** Without adhering to this structure, the dashboards will likely show no results or incorrect information.

This guide explains how to use and customize the provided dashboard system within Obsidian to gain actionable insights from your organizational data.

## 1. Introduction

### Purpose of the Dashboard System
This dashboard system is designed to provide actionable insights and a clear overview of organizational data, processes, and metrics managed within your Obsidian vault. By leveraging the Dataview plugin, these dashboards dynamically pull and present information from your notes, helping you track progress, identify bottlenecks, and monitor key areas of activity.

### Overview of Available Dashboards
The system includes several pre-designed dashboards, each focusing on a different aspect of organizational activity:
*   **Organizational Overview:** A high-level summary of active cycles, key decisions, project health, and critical KPIs.
*   **Member Development Template:** A template to be customized for individual members, tracking their contributions, skills, project involvement, and educational progress.
*   **Projects Overview:** Summaries of all projects, analysis of outcomes, and common success/failure factors.
*   **Decisions and Accountability:** Tracks approved decisions and the status of their associated action items.
*   **Political Education Overview:** Monitors the completion of reading materials and participation in study sessions.
*   **Security Monitoring:** A framework for security-related metrics (requires user implementation of specific queries).

### Dataview Plugin: The Backbone
The entire dashboard system is powered by the **Dataview plugin** for Obsidian. This plugin allows you to query metadata and information directly from your Markdown notes.

### Importance of Consistent Metadata (Reiteration)
As highlighted in the "Important Prerequisites" above, consistent use of metadata is paramount. The queries are based on structures in `docs/dataview-organizational-metrics-queries.md`.

## 2. General Setup

### Ensuring Dataview Plugin is Installed and Enabled
1.  Open Obsidian.
2.  Go to **Settings** -> **Community plugins**.
3.  If Dataview is not installed: Turn off "Safe mode" (if enabled), click **Browse**, search for "Dataview", and click **Install**.
4.  Once installed, ensure the Dataview plugin is **enabled** using the toggle switch in the "Installed plugins" list.
5.  Review Dataview plugin settings, particularly ensuring "Enable JavaScript Queries" and "Enable Inline JavaScript Queries" are active.

### How Dataview Queries Source Data
Dataview queries (both DQL and DataviewJS) embedded in the dashboard files will scan your Obsidian vault (or specified folders/tags) for notes that match their criteria. They then extract and display information from the YAML frontmatter and inline Dataview fields within those notes.

### Location of Dashboard Files
The pre-designed dashboard files are typically located in a root-level `Dashboards/` directory within your Obsidian vault (e.g., `YourVault/Dashboards/Dashboard - Organizational Overview.md`).

## 3. Using the Dashboards

Each dashboard is an editable Markdown file. When you open a dashboard note in Obsidian's reading view (or live preview), the Dataview queries execute and render their results dynamically.

*   **`Dashboard - Organizational Overview.md`**: Provides a high-level summary.
*   **`Dashboard - Projects Overview.md`**: Focuses on project status and learnings.
*   **`Dashboard - Decisions and Accountability.md`**: Tracks decisions and actions.
*   **`Dashboard - Political Education Overview.md`**: Monitors educational engagement.
*   **`Dashboard - Member Development Template.md`**: A **template** file. Copy and rename it for each member (e.g., `Dashboard - Member - Ada Lovelace.md`), then customize the queries within. See Section 4.
*   **`Dashboard - Security Monitoring.md`**: A structural outline. Requires user implementation of queries. See Section 4.

## 4. Customizing the Dashboards (Key Section)

The power of this dashboard system comes from its adaptability. You customize by **editing the Dataview query blocks directly within the dashboard `.md` files.**

### Understanding Embedded Queries
Each section of a dashboard typically contains one or more Dataview query blocks:
```dataview
TABLE ...
FROM ...
WHERE ...
```
or for JavaScript versions:
```dataviewjs
const pages = dv.pages(...);
// ... more JavaScript logic ...
dv.table(...);
```

### Identifying and Modifying Operator Variables
Queries include placeholders or example values called **Operator Variables** (often noted in comments within the query block or surrounding text). **You MUST modify these to match your vault's structure and data.**

**Common Types of Operator Variables to Customize:**

*   **Folder Paths in `FROM` Clauses:** (e.g., `FROM "projects/"`). Change to your actual folder paths.
*   **Tags in `FROM` Clauses:** (e.g., `FROM #project_log`). Adjust to your tags.
*   **Date Ranges and Durations:** (e.g., `contribution_date >= date(today) - dur(90 days)`). Modify for your reporting periods.
*   **Specific Names/Links in Filters:** (e.g., `assigned_to = link("[[Members/Jane Doe]]")`). Replace with your exact links/names.
*   **Lists in DataviewJS/DQL:** (e.g., `const criticalMetrics = ["Metric1"];`, `!contains(list("val1"), status)`). Update these lists.
*   **Field Names:** (e.g., `WHERE type = "project_log"`). If your metadata field names differ, update them in the queries.

**How to Edit:**
1.  Open the dashboard `.md` file in Obsidian's source mode or live preview with an editor pane.
2.  Locate the Dataview query block.
3.  Directly edit the **Operator Variables** within the query code to your specific values.
4.  Obsidian will re-render the Dataview results.

### Specific Guidance for `Dashboard - Member Development Template.md`
1.  **Copy and Rename:** Duplicate the template (e.g., to `People/Jane Doe/Dashboard - Jane Doe.md` or `Dashboards/Members/Dashboard - Jane Doe.md`).
2.  **Update Title:** Change the H1 title in the new file.
3.  **Customize Queries:**
    *   In each query, replace placeholders like `link("<MEMBER_LINK_PLACEHOLDER>")` or `"YOUR_MEMBER_FILE_PATH_PLACEHOLDER"` with the actual link/path to the member's note.
    *   **Alternative for `dv.current()`:** If the dashboard content is placed *directly within that member's main note file*, you can often make queries dynamic using `dv.current().file.link` or `dv.current().file.name` instead of hardcoding the member link. For example, `assigned_to = dv.current().file.link`. This is highly dependent on your note organization and metadata consistency.

### Specific Guidance for `Dashboard - Security Monitoring.md`
This dashboard is a framework. You need to:
1.  **Design Your Metadata:** First, decide how you will track security incidents, access requests, and document reviews using metadata in your notes.
2.  **Implement Queries:** Copy relevant query structures from **Categories D, E, and F** of the `docs/dataview-organizational-metrics-queries.md` document (which cover security incidents, access control, and document review/compliance respectively).
3.  Paste these into the appropriate sections of `Dashboard - Security Monitoring.md`.
4.  **Crucially, customize all Operator Variables** within those queries to match the metadata structure you've designed.

## 5. Conceptual Guidance on Custom CSS Styling
(Content from original guide's Section 5 remains here, unchanged for this step)
[...]

## 6. Troubleshooting Common Dataview Issues on Dashboards
(Content from original guide's Section 6 remains here, unchanged for this step)
[...]

## 7. Maintenance and Updates
(Content from original guide's Section 7 remains here, unchanged for this step)
[...]

By understanding how to use and customize these dashboards, you can create a powerful, dynamic reporting system tailored to your organization's needs within Obsidian.
```
