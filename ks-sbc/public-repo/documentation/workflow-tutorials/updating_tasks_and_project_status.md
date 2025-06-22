# Workflow Tutorial: How to Update Tasks or Project Status in DRUIDS (Obsidian)

This tutorial explains how to update tasks and project statuses within DRUIDS using Obsidian, focusing on interactions with Kanban boards (via the Kanban plugin) and task lists (via a tasks plugin like "Tasks" or "Dataview" queries). These updates are vital for tracking progress, especially within KSBC's Theory-Plan-Practice-Summation (TPPS) workflow.

## Prerequisites

*   Obsidian is configured with the necessary plugins for task and project management (e.g., Kanban, Tasks, Dataview).
*   You have access to the relevant project boards or task list documents.
*   You understand the basics of KSBC's TPPS workflow.

## Part 1: Interacting with Kanban Boards

Kanban boards provide a visual way to manage tasks as they move through different stages of a project. Each card on the board typically represents a task.

**1. Accessing the Kanban Board:**

*   Navigate to the Obsidian note that contains the Kanban board. This is usually a specific project management note.

**2. Moving Tasks/Cards Between Columns:**

*   **Purpose:** To reflect a change in the task's status (e.g., from "To Do" to "In Progress").
*   **Action:**
    1.  Click and hold the task card you want to move.
    2.  Drag the card to the desired column.
        *   **Operator Variable:** The **column you select** (e.g., "To Do," "In Progress," "Review," "Done") represents the new status of the task.
    3.  Release the mouse button to drop the card in the new column.

**3. Marking Tasks as Complete (on a Kanban board):**

*   Often, "Complete" or "Done" is the final column on a Kanban board. Moving a card to this column signifies completion.
*   Some Kanban setups might have an explicit "archive" or "mark complete" option on cards in the "Done" column. If so, right-click the card or look for a menu icon on the card for such options.

**4. Adding or Updating Task Details on a Card:**

*   **Action:**
    1.  Many Kanban card setups allow you to edit details directly on the card or by opening a more detailed view. Double-click the card or look for an "edit" icon.
    2.  You may be able to update:
        *   **Task Description:** **Input** or modify the main text of the task.
        *   **Due Date:** If the Kanban plugin supports it, **input** or select a due date. This might involve typing a date in `YYYY-MM-DD` format or using a date picker.
        *   **Assignees:** If applicable and supported, **select** or **input** the name(s) of KSBC members assigned to the task.
        *   **Tags/Labels:** Add or change tags for categorization (e.g., `#priority-high`, `#theory-phase`). **Input** the tag name.
*   Save any changes as prompted by the plugin.

**5. Creating New Tasks (Cards) on a Kanban Board:**

*   **Action:**
    1.  Look for a "+" button or "Add Card" / "Add Task" option, usually at the top or bottom of a column (typically the "To Do" or "Backlog" column).
    2.  Click it to create a new card.
    3.  **Input** the task description for the new card.
    4.  Add other details (due date, assignee) as described above, if needed.

## Part 2: Interacting with Task Lists (Tasks Plugin or Dataview)

Task lists are often managed within regular Markdown notes, using specific syntax that plugins like "Tasks" or "Dataview" can understand and process.

**1. Accessing Task Lists:**

*   Navigate to the Obsidian note containing the task list (e.g., a project note, meeting minutes, or a personal task list).

**2. Marking Tasks as Complete:**

*   **Standard Markdown Task Syntax:** Tasks usually look like this: `- [ ] Task description`
*   **Action:**
    1.  Locate the task you want to mark complete.
    2.  Click inside the square brackets `[ ]`.
    3.  Type an `x` (or sometimes a space, depending on the plugin/theme) to mark it complete: `- [x] Task description`.
        *   **Operator Variable:** The character you **input** (`x`) changes the task's status.
*   The "Tasks" plugin or Dataview queries will recognize this change and filter or display the task accordingly (e.g., strike through the text, move it to a "Completed" section).

**3. Adding or Updating Task Details (Tasks Plugin Syntax):**

*   The "Tasks" plugin allows you to add metadata like due dates, priorities, and recurrence.
*   **Example Syntax:**
    *   Due Date: `- [ ] Task description 📅 YYYY-MM-DD` (**Input** your date)
    *   Priority: `- [ ] Task description ⏫` (high) `🔼` (medium) `🔽` (low)
    *   Assignee (if using a convention, not always a plugin feature): `- [ ] Task description @MemberName` (**Input** member name)
*   **Action:**
    1.  Edit the line of the task.
    2.  Add or modify the relevant emoji/symbols and their corresponding values.
        *   **Operator Variables:** The **date string**, **priority symbol**, or **assignee text** you input.
*   Refer to the specific documentation for the "Tasks" plugin for the full list of supported metadata and syntax.

**4. Creating New Tasks in a List:**

*   **Action:**
    1.  Go to a new line in your task list note.
    2.  Type the task syntax: `- [ ]` followed by the task description.
        *   **Operator Variable:** The **task description text** you input.
    3.  Add any desired metadata (due date, priority) as described above.

## Contribution to Theory-Plan-Practice-Summation (TPPS) Workflow Tracking

Updating tasks in DRUIDS (Obsidian) is essential for monitoring progress through the TPPS cycle:

*   **Theory:** Tasks might involve research, discussion documentation, or formulating initial hypotheses. Creating these tasks under a "Theory" project or with a `#theory` tag helps track this phase.
*   **Plan:** As theoretical concepts solidify, tasks shift to planning. This involves creating actionable steps, assigning responsibilities, and setting deadlines. A Kanban board might have columns like "Backlog," "Ready for Planning," "Planning in Progress."
    *   **Example:** A card "Draft Project Proposal" moves from "Theory" (discussion notes) to a "Plan" Kanban board's "To Do" column.
*   **Practice:** This is the execution phase. Tasks are actively being worked on.
    *   **Kanban:** Cards move from "To Do" to "In Progress."
    *   **Task Lists:** Tasks are actively being checked off or updated with progress notes.
    *   **Example:** The "Draft Project Proposal" card moves to "In Progress." Sub-tasks like "- [ ] Research Section A" are marked complete.
*   **Summation:** Once a practice phase or project is complete, tasks related to review, analysis, and lesson-learning are created and tracked.
    *   **Kanban:** Cards might move to a "Review" or "Summation" column. New cards for "Conduct Post-Project Review" or "Document Lessons Learned" are created.
    *   **Example:** After the "Draft Project Proposal" is "Done," a new task "- [ ] Review proposal feedback and summarize" is created for the Summation phase.

**Visibility and Oversight:**

*   **Cadre and Leadership:** Can use these updated Kanban boards and task lists (often aggregated by Dataview queries) to get an overview of project statuses, identify bottlenecks, and ensure the TPPS cycle is progressing across different initiatives.
*   **General Members/Candidates:** Can see the status of tasks relevant to their involvement, promoting transparency and accountability.

By diligently updating your tasks and project statuses, you contribute to the overall efficiency, transparency, and effective execution of KSBC's work as guided by the TPPS model. Always follow any specific conventions KSBC has established for task management within DRUIDS.
