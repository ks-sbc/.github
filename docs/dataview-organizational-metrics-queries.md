# Dataview Queries for Organizational Metrics

This document provides a set of Dataview queries designed to track various organizational metrics based on the metadata structure proposed previously.

**Important Considerations:**
*   **Metadata Consistency:** These queries will only work effectively if the specified metadata (YAML frontmatter, tags, inline fields) is used consistently across your Obsidian vault. The required metadata for each query set is recapped before the queries.
*   **Operator Variables:** Many queries contain placeholders or example values (e.g., for folder paths, specific tags, date ranges). These are marked as **Operator Variables** and **MUST be customized** by the user to fit their vault structure and specific needs.
*   **Dataview Plugin:** Ensure the Dataview plugin is installed and enabled in Obsidian.
*   **Placement:** These queries are designed to be placed within markdown notes, often in dedicated "Dashboard" or "Reporting" notes.
*   **DataviewJS:** Some queries use DataviewJS for more complex logic. These are marked and require DataviewJS execution to be enabled in plugin settings (which is usually default).

---

## A. Theory → Plan → Practice → Summation Cycles

### Metadata Recap (Assumed for Category A)

*   `type`: "cycle_theory", "cycle_plan", "cycle_practice", "cycle_summation"
*   `cycle_id`: A unique identifier linking all notes in a single cycle (e.g., "cycle-2023-q4-initiative-x")
*   `status`:
    *   For `cycle_theory`: "ideation", "proposed", "approved"
    *   For `cycle_plan`: "drafting", "pending-review", "approved", "active"
    *   For `cycle_practice`: "ongoing", "stalled", "completed"
    *   For `cycle_summation`: "pending", "drafting", "completed"
*   `created`: YYYY-MM-DD
*   `updated`: YYYY-MM-DD
*   `cycle_start_date`: YYYY-MM-DD (on `cycle_plan` or `cycle_practice`)
*   `cycle_end_date`: YYYY-MM-DD (on `cycle_practice` or `cycle_summation`)
*   `related_project`: (Optional Link to a project note)
*   `responsible`: (Link to member note, for overall cycle or specific stages)

---

### A1. View Full Cycle by ID

*   **Purpose:** To see all documents related to a specific Theory → Plan → Practice → Summation cycle, ordered by their typical progression.
*   **Operator Variable:**
    *   `TARGET_CYCLE_ID`: The specific `cycle_id` you want to view. (e.g., "cycle-2023-q4-initiative-x")

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Document",
        type AS "Stage",
        status AS "Status",
        created AS "Created",
        responsible AS "Responsible"
    FROM "" // **Operator Variable**: Or specify a folder like "cycles/" or tag like #cycle_document
    WHERE cycle_id = "<TARGET_CYCLE_ID>"
    SORT choice(type = "cycle_theory", 1, choice(type = "cycle_plan", 2, choice(type = "cycle_practice", 3, choice(type = "cycle_summation", 4, 5)))) ASC, file.ctime ASC
    ```
    **Note:** The `SORT` line uses nested `choice` functions to order by stage. Replace `<TARGET_CYCLE_ID>` with the actual ID.

---

### A2. Status of All Active Cycles

*   **Purpose:** To get an overview of all cycles that are currently in an active phase (e.g., plan approved, practice ongoing) and not yet fully summated.
*   **Operator Variables:**
    *   `ACTIVE_CYCLE_PLAN_STATUSES`: List of statuses indicating an active plan (e.g., `"approved"`, `"active"`)
    *   `ACTIVE_CYCLE_PRACTICE_STATUSES`: List of statuses indicating ongoing practice (e.g., `"ongoing"`)
    *   `COMPLETED_SUMMATION_STATUS`: Status indicating summation is done (e.g., `"completed"`)

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        cycle.id AS "Cycle ID",
        theory_link AS "Theory",
        plan_status AS "Plan Status",
        practice_status AS "Practice Status",
        summation_status AS "Summation Status"
    FROM "" // **Operator Variable**: Or specify a folder like "cycles/"
    WHERE cycle_id AND (type = "cycle_plan" OR type = "cycle_practice" OR type = "cycle_summation" OR type = "cycle_theory")
    GROUP BY cycle_id AS cycle
    // Get links to each stage for display
    LET theory_doc = filter(cycle.rows, (r) => r.type = "cycle_theory")
    LET theory_link = theory_doc[0].file.link
    // Get statuses of each stage
    LET plan_docs = filter(cycle.rows, (r) => r.type = "cycle_plan")
    LET plan_status = plan_docs[0].status ?? "N/A" // Handle missing plan
    LET practice_docs = filter(cycle.rows, (r) => r.type = "cycle_practice")
    LET practice_status = practice_docs[0].status ?? "N/A" // Handle missing practice
    LET summation_docs = filter(cycle.rows, (r) => r.type = "cycle_summation")
    LET summation_status = summation_docs[0].status ?? "N/A" // Handle missing summation
    // Filter for active cycles:
    // Plan is active OR Practice is active, AND Summation is NOT completed.
    WHERE (contains(list("approved", "active"), plan_status) OR contains(list("ongoing"), practice_status)) AND summation_status != "completed"
    SORT cycle.id ASC
    ```

---

### A3. Cycles Missing Summation

*   **Purpose:** To identify cycles where the "Practice" phase is marked as completed, but a "Summation" document either doesn't exist or is not yet marked as completed.
*   **Operator Variables:**
    *   `PRACTICE_COMPLETED_STATUS`: Status indicating practice is done (e.g., `"completed"`)
    *   `SUMMATION_COMPLETED_STATUS`: Status indicating summation is done (e.g., `"completed"`)

*   **Dataview Query (DQL - basic version, might need DataviewJS for more robustness):**
    ```dataview
    TABLE WITHOUT ID
        cycle.id AS "Cycle ID",
        practice_doc.file.link AS "Completed Practice Document",
        practice_doc.status AS "Practice Status",
        summation_doc.file.link AS "Summation Document (if any)",
        summation_doc.status AS "Summation Status"
    FROM "" // **Operator Variable**: Or specify a folder like "cycles/"
    WHERE cycle_id AND (type = "cycle_practice" OR type = "cycle_summation")
    GROUP BY cycle_id AS cycle
    LET practice_doc = filter(cycle.rows, (r) => r.type = "cycle_practice" AND r.status = "completed")[0]
    LET summation_doc = filter(cycle.rows, (r) => r.type = "cycle_summation")[0]
    WHERE practice_doc AND (summation_doc = null OR summation_doc.status != "completed")
    SORT cycle.id ASC
    ```
    **Note:** This DQL query attempts to find cycles where practice is completed but summation is not. For more complex scenarios (e.g., multiple practice notes per cycle), a DataviewJS query might be more robust to ensure all practice elements are considered before flagging a missing summation.

---

## B. Decision Implementation Tracking and Accountability Reports

### Metadata Recap (Assumed for Category B)

*   `type`: "decision_log", "action_item"
*   `decision_id`: Unique ID linking a decision to its action items.
*   `decision_date`: YYYY-MM-DD
*   `decision_outcome`: "approved", "rejected", "deferred" (on `decision_log`)
*   `action_summary`: Brief description of the action (on `action_item`)
*   `assigned_to`: (Link to member note, for `action_item`)
*   `due_date`: YYYY-MM-DD (for `action_item`)
*   `status`: "open", "in-progress", "completed", "blocked" (for `action_item`)
*   `completion_date`: YYYY-MM-DD (for `action_item`)
*   `related_decision`: (Link to `decision_log` note, on `action_item`)

---

### B1. All Approved Decisions and Current Status of Related Action Items

*   **Purpose:** To list all approved decisions and provide a summary of the status of their associated action items.
*   **Operator Variables:**
    *   `DECISION_TYPE`: `type: "decision_log"`
    *   `ACTION_ITEM_TYPE`: `type: "action_item"`
    *   `APPROVED_OUTCOME`: `"approved"`

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        d.file.link AS "Decision",
        d.decision_date AS "Date Approved",
        length(actions) AS "Total Actions",
        length(filter(actions, (item) => item.status = "completed")) AS "Completed",
        length(filter(actions, (item) => item.status = "in-progress")) AS "In Progress",
        length(filter(actions, (item) => item.status = "open")) AS "Open",
        length(filter(actions, (item) => item.status = "blocked")) AS "Blocked"
    FROM "" // **Operator Variable**: Or specify a folder like "decisions/"
    WHERE type = "decision_log" AND decision_outcome = "approved" AS d
    LET actions = مربوط("related_decision", d.file.link) // Hypothetical: 'm مربوط' (related) function to link action items
                                                      // This assumes action_items link back to the decision.
                                                      // More robustly, use decision_id if action_items have it.
    // If action_items have a 'decision_id' field:
    // LET actions = dv.pages().where(p => p.type == "action_item" AND p.decision_id == d.decision_id)
    SORT d.decision_date DESC
    ```
    **Note:** The `مربوط` (related) part is conceptual. A more common Dataview approach if `action_item` notes link to `decision_log` notes via a field like `related_decision:: [[decision_log_filename]]` would be:
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Decision",
        decision_date AS "Date Approved",
        length(this.file.inlinks.where(p => p.type = "action_item")) AS "Total Actions",
        length(this.file.inlinks.where(p => p.type = "action_item" AND p.status = "completed")) AS "Completed",
        // ... and so on for other statuses
    FROM "" // **Operator Variable**: Or specify a folder like "decisions/"
    WHERE type = "decision_log" AND decision_outcome = "approved"
    SORT decision_date DESC
    ```
    If action items have a `decision_id` field that matches a `decision_id` in the decision log:
    ```dataview
    TABLE WITHOUT ID
        L.file.link AS "Decision",
        L.decision_date AS "Date Approved",
        count(A) AS "Total Actions",
        sum(map(A, (item) => item.status = "completed")) AS "Completed",
        sum(map(A, (item) => item.status = "in-progress")) AS "In Progress",
        sum(map(A, (item) => item.status = "open")) AS "Open"
    FROM "" AS L // **Operator Variable**: Or specify a folder like "decisions/"
    WHERE L.type = "decision_log" AND L.decision_outcome = "approved"
    JOIN dv.pages().where(p => p.type = "action_item" AND p.decision_id = L.decision_id) AS A ON true
    GROUP BY L.file.link, L.decision_date
    SORT L.decision_date DESC
    ```

---

### B2. Overdue Action Items

*   **Purpose:** To identify all action items that are past their `due_date` and not yet completed.
*   **Operator Variables:**
    *   `ACTION_ITEM_TYPE`: `type: "action_item"`
    *   `NON_COMPLETED_STATUSES`: List of statuses that are not "completed" (e.g., `"open"`, `"in-progress"`, `"blocked"`)

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Action Item",
        action_summary AS "Summary",
        assigned_to AS "Assigned To",
        due_date AS "Due Date",
        status AS "Status",
        related_decision AS "Related Decision"
    FROM "" // **Operator Variable**: Or specify a folder like "action_items/" or tag #action_item
    WHERE type = "action_item" AND due_date AND date(due_date) < date(today) AND !contains(list("completed", "cancelled"), status)
    SORT date(due_date) ASC
    ```

---

### B3. Action Items Assigned to a Specific Member

*   **Purpose:** To list all non-completed action items assigned to a particular member.
*   **Operator Variables:**
    *   `ACTION_ITEM_TYPE`: `type: "action_item"`
    *   `MEMBER_LINK`: The exact link to the member's note (e.g., `"[[Members/Member Name]]"` or specific member ID if used).
    *   `NON_COMPLETED_STATUSES`: As above.

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Action Item",
        action_summary AS "Summary",
        due_date AS "Due Date",
        status AS "Status",
        related_decision AS "Related Decision"
    FROM "" // **Operator Variable**: Or specify a folder like "action_items/" or tag #action_item
    WHERE type = "action_item" AND assigned_to = link("<MEMBER_LINK>") AND !contains(list("completed", "cancelled"), status)
    SORT date(due_date) ASC
    ```
    **Note:** Replace `<MEMBER_LINK>` with the actual link, e.g., `[[Members/JohnDoe]]`.

---

### B4. Accountability: Action Item Summary by Assignee

*   **Purpose:** To provide a summary table showing the number of open, in-progress, and overdue action items for each assignee.
*   **Operator Variables:**
    *   `ACTION_ITEM_TYPE`: `type: "action_item"`
    *   `NON_COMPLETED_STATUSES`: As above.

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        assignee AS "Assignee",
        length(filter(rows, (r) => r.status = "open")) AS "Open",
        length(filter(rows, (r) => r.status = "in-progress")) AS "In Progress",
        length(filter(rows, (r) => r.due_date AND date(r.due_date) < date(today) AND !contains(list("completed", "cancelled"), r.status))) AS "Overdue"
    FROM "" // **Operator Variable**: Or specify a folder like "action_items/" or tag #action_item
    WHERE type = "action_item" AND !contains(list("completed", "cancelled"), status) AND assigned_to
    GROUP BY assigned_to AS assignee
    SORT assignee ASC
    ```

---

## C. Member Contribution and Development Tracking

### Metadata Recap (Assumed for Category C)

*   `type`: "contribution_log", "skill_assessment", "project_participation"
*   `member`: (Link to member note)
*   `contribution_date`: YYYY-MM-DD (for `contribution_log`)
*   `contribution_type`: "documentation", "research", "facilitation", "mentorship" (for `contribution_log`)
*   `skill_name`: Name of the skill (for `skill_assessment`)
*   `skill_level`: "beginner", "intermediate", "advanced", "expert" (for `skill_assessment`)
*   `assessment_date`: YYYY-MM-DD (for `skill_assessment`)
*   `project`: (Link to project note, for `project_participation`)
*   `role`: Role in the project (for `project_participation`)
*   `participation_start_date`: YYYY-MM-DD
*   `participation_end_date`: YYYY-MM-DD (optional)

---

### C1. Contributions by Member (Last 90 Days)

*   **Purpose:** To list contributions logged by each member in the last 90 days.
*   **Operator Variables:**
    *   `CONTRIBUTION_TYPE`: `type: "contribution_log"`
    *   `REPORTING_PERIOD_DAYS`: 90

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        member AS "Member",
        rows.contribution_type AS "Contribution Types",
        length(rows) AS "Total Contributions"
    FROM "" // **Operator Variable**: Or specify folder "contributions/" or tag #contribution
    WHERE type = "contribution_log" AND contribution_date >= date(today) - dur(90 days)
    GROUP BY member
    SORT length(rows) DESC
    ```

---

### C2. Skills Acquired or Updated by Each Member

*   **Purpose:** To list the skills and their current assessed levels for each member, ordered by assessment date.
*   **Operator Variables:**
    *   `SKILL_ASSESSMENT_TYPE`: `type: "skill_assessment"`

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        member AS "Member",
        collect(rows.skill_name + " (" + rows.skill_level + " - " + rows.assessment_date + ")") AS "Skills (Level - Assessed Date)"
    FROM "" // **Operator Variable**: Or specify folder "skills/" or tag #skill_assessment
    WHERE type = "skill_assessment" AND member
    GROUP BY member
    SORT member ASC
    ```
    **Note:** This groups skills under each member. For a chronological list of all skill assessments, the query would be simpler:
    ```dataview
    TABLE file.link, member, skill_name, skill_level, assessment_date
    FROM "" WHERE type = "skill_assessment" SORT assessment_date DESC
    ```

---

### C3. Project Involvement by Member

*   **Purpose:** To show which projects members are currently or have been involved in, and their roles.
*   **Operator Variables:**
    *   `PROJECT_PARTICIPATION_TYPE`: `type: "project_participation"`

*   **Dataview Query (DQL - Grouped by Member):**
    ```dataview
    TABLE WITHOUT ID
        member AS "Member",
        collect(rows.project.file.link + " (as " + rows.role + ")") AS "Projects and Roles"
    FROM "" // **Operator Variable**: Or specify folder "participation_logs/" or tag #project_participation
    WHERE type = "project_participation" AND member AND project
    GROUP BY member
    SORT member ASC
    ```

*   **Dataview Query (DQL - Grouped by Project):**
    ```dataview
    TABLE WITHOUT ID
        project.file.link AS "Project",
        collect(rows.member.file.link + " (as " + rows.role + ")") AS "Members and Roles"
    FROM "" // **Operator Variable**: Or specify folder "participation_logs/" or tag #project_participation
    WHERE type = "project_participation" AND member AND project
    GROUP BY project
    SORT project.file.name ASC
    ```

---

## D. Political Education Progress Monitoring

### Metadata Recap (Assumed for Category D)

*   `type`: "reading_material", "study_session", "member_progress"
*   `material_id`: Unique ID for a reading material.
*   `title`: Title of the reading material (on `reading_material`).
*   `required_for_level`: e.g., "L0", "L1", "L2" (on `reading_material`).
*   `member`: (Link to member note, on `member_progress`).
*   `material_completed`: (Link to `reading_material` note, on `member_progress`).
*   `completion_date`: YYYY-MM-DD (on `member_progress`).
*   `session_date`: YYYY-MM-DD (on `study_session`).
*   `attended_by`: List of links to member notes (on `study_session`).
*   `discussed_material`: (Link to `reading_material` note, on `study_session`).

---

### D1. Reading Status per Member for Key Materials (DataviewJS)

*   **Purpose:** To show which key reading materials each member has completed.
*   **Operator Variables:**
    *   `KEY_MATERIALS_FOLDER`: Folder containing notes about key reading materials (e.g., `"education/materials/"`). Each note should have a `material_id`.
    *   `MEMBER_PROGRESS_TYPE`: `type: "member_progress"`.
    *   `MEMBER_FOLDER`: Folder containing member notes (e.g., `"members/"`).

*   **Dataview Query (DataviewJS):**
    ```dataviewjs
    const keyMaterialsFolder = "education/materials"; // **Operator Variable**
    const memberProgressType = "member_progress";    // **Operator Variable**
    const memberFolder = "members";                  // **Operator Variable**

    const materials = dv.pages(`"${keyMaterialsFolder}"`).where(p => p.material_id);
    const members = dv.pages(`"${memberFolder}"`);
    const progressNotes = dv.pages(`type = "${memberProgressType}"`);

    const output = [];
    for (let member of members) {
        let memberData = { "Member": member.file.link, "Completed Materials": [] };
        let completedByMember = [];
        for (let progress of progressNotes) {
            if (progress.member && progress.member.path === member.file.path && progress.material_completed) {
                completedByMember.push(progress.material_completed.path);
            }
        }
        for (let material of materials) {
            if (completedByMember.includes(material.file.path)) {
                memberData["Completed Materials"].push(material.title || material.file.name);
            }
        }
        memberData["Completed Materials"] = memberData["Completed Materials"].join(", ");
        if (!memberData["Completed Materials"]) memberData["Completed Materials"] = "None recorded";
        output.push(memberData);
    }
    dv.table(["Member", "Completed Materials"], output.map(m => [m.Member, m["Completed Materials"]]));
    ```

---

### D2. Materials Completion Overview

*   **Purpose:** To show how many members have completed each key reading material.
*   **Operator Variables:**
    *   `KEY_MATERIALS_FOLDER`: As above.
    *   `MEMBER_PROGRESS_TYPE`: As above.

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        material.title AS "Material",
        length(rows) AS "Completions"
    FROM "" // **Operator Variable**: Source for member_progress notes, e.g., '"progress_tracking/"'
    WHERE type = "member_progress" AND material_completed
    FLATTEN material_completed AS material_link
    LET material = dv.page(material_link.path)
    WHERE material // ensure the material page exists
    GROUP BY material.title // or material.file.link
    SORT length(rows) DESC
    ```

---

### D3. Members Who Have Not Completed a Specific Material (DataviewJS)

*   **Purpose:** To list members who have not yet logged completion for a specific required reading material.
*   **Operator Variables:**
    *   `TARGET_MATERIAL_LINK`: The link to the specific reading material note (e.g., `"[[education/materials/KeyText1]]"`).
    *   `MEMBER_PROGRESS_TYPE`: As above.
    *   `MEMBER_FOLDER`: As above.

*   **Dataview Query (DataviewJS):**
    ```dataviewjs
    const targetMaterialLink = dv.fileLink("education/materials/KeyText1"); // **Operator Variable**
    const memberProgressType = "member_progress";                           // **Operator Variable**
    const memberFolder = "members";                                         // **Operator Variable**

    const members = dv.pages(`"${memberFolder}"`);
    const progressNotes = dv.pages(`type = "${memberProgressType}" AND material_completed.path = "${targetMaterialLink.path}"`);
    
    const membersWhoCompleted = progressNotes.map(p => p.member.path);
    const membersNotCompleted = members
        .where(m => !membersWhoCompleted.includes(m.file.path))
        .map(m => m.file.link);

    if (membersNotCompleted.length > 0) {
        dv.header(3, `Members Who Have Not Completed: ${targetMaterialLink.display}`);
        dv.list(membersNotCompleted);
    } else {
        dv.paragraph(`All members listed in "${memberFolder}" have completed ${targetMaterialLink.display}, or no progress notes found.`);
    }
    ```

---

## E. Project Success/Failure Analysis Queries

### Metadata Recap (Assumed for Category E)

*   `type`: "project_log"
*   `project_name`: Name of the project.
*   `status`: "planning", "active", "completed", "failed", "on-hold"
*   `start_date`: YYYY-MM-DD
*   `end_date`: YYYY-MM-DD (actual end date)
*   `outcome`: "success", "partial_success", "failure", "abandoned" (when status is 'completed' or 'failed')
*   `success_factors`: List of strings/tags (for successful projects)
*   `failure_factors`: List of strings/tags (for failed projects)
*   `lessons_learned`: Text

---

### E1. List Projects by Outcome

*   **Purpose:** To categorize and list projects based on their final outcome.
*   **Operator Variables:**
    *   `PROJECT_LOG_TYPE`: `type: "project_log"`
    *   `COMPLETED_STATUSES`: e.g., list("completed", "failed", "abandoned")

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        outcome AS "Outcome",
        rows.file.link AS "Project",
        rows.start_date AS "Start Date",
        rows.end_date AS "End Date"
    FROM "" // **Operator Variable**: Or specify folder "projects/" or tag #project_log
    WHERE type = "project_log" AND outcome AND contains(list("completed", "failed", "abandoned"), status)
    GROUP BY outcome
    SORT outcome ASC
    ```

---

### E2. Common Factors in Successful/Failed Projects (DataviewJS)

*   **Purpose:** To identify and count common success or failure factors listed in project logs.
*   **Operator Variables:**
    *   `PROJECT_LOG_TYPE`: `type: "project_log"`
    *   `TARGET_OUTCOME`: Either `"success"` or `"failure"`.
    *   `FACTOR_FIELD`: Either `success_factors` or `failure_factors`.

*   **Dataview Query (DataviewJS):**
    ```dataviewjs
    const projectLogType = "project_log";       // **Operator Variable**
    const targetOutcome = "success";            // **Operator Variable**: "success" or "failure"
    const factorField = (targetOutcome === "success") ? "success_factors" : "failure_factors"; // **Operator Variable** (indirectly)

    const projects = dv.pages(`type = "${projectLogType}"`)
        .where(p => p.outcome === targetOutcome && p[factorField]);

    const factorCounts = {};
    for (let project of projects) {
        let factors = dv.array(project[factorField]); // Ensure it's an array
        for (let factor of factors) {
            factorCounts[factor] = (factorCounts[factor] || 0) + 1;
        }
    }

    const sortedFactors = Object.entries(factorCounts).sort((a, b) => b[1] - a[1]);

    dv.header(3, `Common ${targetOutcome === "success" ? "Success" : "Failure"} Factors`);
    if (sortedFactors.length > 0) {
        dv.table(["Factor", "Count"], sortedFactors);
    } else {
        dv.paragraph(`No projects found with outcome "${targetOutcome}" and associated factors.`);
    }
    ```

---

### E3. Projects Completed Within a Timeframe

*   **Purpose:** To list projects completed within a specific start and end date range.
*   **Operator Variables:**
    *   `PROJECT_LOG_TYPE`: `type: "project_log"`
    *   `COMPLETED_STATUS`: `"completed"`
    *   `START_DATE_RANGE`: YYYY-MM-DD (e.g., "2023-01-01")
    *   `END_DATE_RANGE`: YYYY-MM-DD (e.g., "2023-12-31")

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Project",
        project_name AS "Name",
        start_date AS "Started",
        end_date AS "Completed",
        outcome AS "Outcome"
    FROM "" // **Operator Variable**: Or specify folder "projects/" or tag #project_log
    WHERE type = "project_log" AND status = "completed" AND outcome = "success" // Or other relevant outcomes
        AND date(end_date) >= date("<START_DATE_RANGE>")
        AND date(end_date) <= date("<END_DATE_RANGE>")
    SORT date(end_date) DESC
    ```
    **Note:** Replace `<START_DATE_RANGE>` and `<END_DATE_RANGE>` with actual dates.

---

## F. Quantitative Change Measurement Tracking

### Metadata Recap (Assumed for Category F)

*   `type`: "metric_snapshot"
*   `metric_name`: Name of the specific metric (e.g., "WeeklyActiveUsers", "L1DocumentsCreated", "PublicCommits")
*   `metric_value`: The numerical value of the metric.
*   `date`: YYYY-MM-DD (Date the snapshot was taken)
*   `unit`: (Optional) Unit of measurement (e.g., "users", "documents", "count")

---

### F1. Trend of a Specific Metric Over Time (Table View)

*   **Purpose:** To display the values of a specific metric over time, allowing for trend observation.
*   **Operator Variables:**
    *   `METRIC_SNAPSHOT_TYPE`: `type: "metric_snapshot"`
    *   `TARGET_METRIC_NAME`: The exact `metric_name` to track (e.g., "WeeklyActiveUsers").

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        date AS "Date",
        metric_value AS "Value",
        unit AS "Unit (if any)"
    FROM "" // **Operator Variable**: Or specify folder "metrics/" or tag #metric_snapshot
    WHERE type = "metric_snapshot" AND metric_name = "<TARGET_METRIC_NAME>"
    SORT date ASC
    ```
    **Note:** For a chart, you would typically export this data or use a charting plugin that can consume Dataview results.

---

### F2. Latest Value for All Tracked Metrics (DataviewJS for robustness)

*   **Purpose:** To show the most recent recorded value for each distinct metric.
*   **Operator Variables:**
    *   `METRIC_SNAPSHOT_TYPE`: `type: "metric_snapshot"`

*   **Dataview Query (DQL - simpler, shows all, not just latest per metric):**
    ```dataview
    TABLE metric_name AS "Metric", metric_value AS "Latest Value", date AS "As of Date", unit AS "Unit"
    FROM "" // **Operator Variable**: Or "metrics/"
    WHERE type = "metric_snapshot"
    SORT date DESC
    ```
*   **Dataview Query (DataviewJS - to get only the latest for each):**
    ```dataviewjs
    const snapshotType = "metric_snapshot"; // **Operator Variable**
    const pages = dv.pages(`type = "${snapshotType}"`)
        .where(p => p.metric_name && p.metric_value !== undefined && p.date)
        .sort(p => p.date, 'desc');

    const latestValues = {};
    for (let page of pages) {
        if (!latestValues[page.metric_name]) {
            latestValues[page.metric_name] = {
                value: page.metric_value,
                date: page.date.toString(), // Format date as string for display
                unit: page.unit || "N/A",
                link: page.file.link
            };
        }
    }

    const output = Object.entries(latestValues).map(([name, data]) => {
        return [dv.fileLink(data.link.path, false, name), data.value, data.date, data.unit];
    });
    
    if (output.length > 0) {
      dv.table(["Metric Name (Link to Latest)", "Latest Value", "As of Date", "Unit"], output);
    } else {
      dv.paragraph("No metric snapshots found.");
    }
    ```

---

### F3. Comparison of a Metric Period Over Period (DataviewJS)

*   **Purpose:** To compare the value of a specific metric in the current period against a previous period (e.g., this month vs. last month).
*   **Operator Variables:**
    *   `METRIC_SNAPSHOT_TYPE`: `type: "metric_snapshot"`
    *   `TARGET_METRIC_NAME`: The `metric_name` to compare.
    *   `PERIOD_DAYS`: Length of each comparison period in days (e.g., 30 for monthly).

*   **Dataview Query (DataviewJS):**
    ```dataviewjs
    const snapshotType = "metric_snapshot";         // **Operator Variable**
    const targetMetric = "WeeklyActiveUsers";       // **Operator Variable**
    const periodDays = 30;                          // **Operator Variable**

    const today = dv.date('today');
    const endCurrentPeriod = today;
    const startCurrentPeriod = today.minus(dv.duration(periodDays -1 + " days")); // -1 because period includes today

    const endPreviousPeriod = startCurrentPeriod.minus(dv.duration("1 day"));
    const startPreviousPeriod = endPreviousPeriod.minus(dv.duration(periodDays -1 + " days"));

    const snapshots = dv.pages(`type = "${snapshotType}" AND metric_name = "${targetMetric}"`)
        .where(p => p.date);

    let currentValue = null; // Could be an average, sum, or latest within period
    let previousValue = null;

    // For simplicity, let's find the latest snapshot in each period
    // More complex logic could average or sum values within the period.
    let currentPeriodSnapshots = snapshots
        .where(p => p.date >= startCurrentPeriod && p.date <= endCurrentPeriod)
        .sort(p => p.date, 'desc');
    if (currentPeriodSnapshots.length > 0) currentValue = currentPeriodSnapshots[0].metric_value;

    let previousPeriodSnapshots = snapshots
        .where(p => p.date >= startPreviousPeriod && p.date <= endPreviousPeriod)
        .sort(p => p.date, 'desc');
    if (previousPeriodSnapshots.length > 0) previousValue = previousPeriodSnapshots[0].metric_value;
    
    dv.header(3, `Metric Comparison for: ${targetMetric}`);
    dv.paragraph(`**Current Period (${startCurrentPeriod.toFormat("yyyy-MM-dd")} to ${endCurrentPeriod.toFormat("yyyy-MM-dd")}):** ${currentValue !== null ? currentValue : "N/A"}`);
    dv.paragraph(`**Previous Period (${startPreviousPeriod.toFormat("yyyy-MM-dd")} to ${endPreviousPeriod.toFormat("yyyy-MM-dd")}):** ${previousValue !== null ? previousValue : "N/A"}`);

    if (currentValue !== null && previousValue !== null) {
        const change = currentValue - previousValue;
        const percentageChange = (change / previousValue * 100).toFixed(2);
        dv.paragraph(`**Change:** ${change} (${percentageChange}%)`);
    } else {
        dv.paragraph("Could not calculate change due to missing data in one or both periods.");
    }
    ```

---
This concludes the set of Dataview queries for organizational metrics A-F. Remember to adapt the **Operator Variables** and source paths (`FROM` clauses) to your specific vault structure.
