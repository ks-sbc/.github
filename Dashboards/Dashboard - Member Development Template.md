<!-- 
**THIS IS A TEMPLATE FILE.**
**Instructions for Use:**
1.  **Copy this file:** Duplicate it and rename it for a specific member (e.g., `Dashboard - Member - Jane Doe.md` or place it in a member-specific folder like `People/Jane Doe/Dashboard - Jane Doe.md`).
2.  **Update Title:** Change `{{memberName}}` in the H1 title below to the member's actual name.
3.  **Customize Queries:** In each Dataview query below:
    *   Replace the placeholder `link("<MEMBER_LINK_PLACEHOLDER>")` with the correct Obsidian link to that specific member's note (e.g., `link("[[Members/Jane Doe]]")`).
    *   For the DataviewJS query in Section V, replace `"<MEMBER_FILE_PATH_PLACEHOLDER>"` with the actual file path to the member's note (e.g., `"Members/Jane Doe.md"`).
4.  **Alternative for `dv.current()`:** If you place this dashboard's content *directly within that specific member's main note file*, you can often make the queries dynamic. Instead of hardcoding the member link/path, you might use `dv.current().file.link` (for DQL `assigned_to` or `member` fields if they are links) or `dv.current().file.path` (for the `memberFilePath` variable in DataviewJS). This requires your metadata to align (e.g., the `assigned_to` field uses direct links to member notes). Test thoroughly if attempting this.
-->

# Member Development Dashboard: {{memberName}}

This dashboard template provides an overview of contributions, skills, project involvement, and political education progress for a specific member.

**Navigation:**
*   [[Dashboard - Organizational Overview]]
*   ... (other relevant dashboards)

---

## I. Action Items Assigned to {{memberName}}

*Purpose: To list all non-completed action items assigned to this member.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially the member link and status values) below. -->
```dataview
TABLE WITHOUT ID
    file.link AS "Action Item",
    action_summary AS "Summary",
    due_date AS "Due Date",
    status AS "Status",
    related_decision AS "Related Decision"
FROM "" // **Operator Variable**: Or specify folder "action_items/" or tag #action_item
WHERE type = "action_item" 
    AND assigned_to = link("<MEMBER_LINK_PLACEHOLDER>") // **Modify This**: Replace with link to member note or use dv.current().file.link if applicable
    AND !contains(list("completed", "cancelled"), status) // **Operator Variable**: Adjust non-completed statuses
SORT date(due_date) ASC
```

---

## II. Contributions by {{memberName}} (Last 90 Days)

*Purpose: To list contributions logged by this member in the last 90 days.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially the member link and date duration) below. -->
```dataview
TABLE WITHOUT ID
    file.link AS "Contribution Log Entry",
    contribution_type AS "Type",
    contribution_summary AS "Summary (if available)",
    contribution_date AS "Date"
FROM "" // **Operator Variable**: Or specify folder "contributions/" or tag #contribution_log
WHERE type = "contribution_log" 
    AND member = link("<MEMBER_LINK_PLACEHOLDER>") // **Modify This**: Replace with link to member note or use dv.current().file.link if applicable
    AND contribution_date >= date(today) - dur(90 days) // **Operator Variable**: Reporting period (e.g., 90 days)
SORT contribution_date DESC
```

---

## III. Skills Acquired/Assessed for {{memberName}}

*Purpose: To list the skills and their current assessed levels for this member.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially the member link) below. -->
```dataview
TABLE WITHOUT ID
    skill_name AS "Skill",
    skill_level AS "Level",
    assessment_date AS "Assessment Date",
    notes AS "Notes (if any)"
FROM "" // **Operator Variable**: Or specify folder "skill_assessments/" or tag #skill_assessment
WHERE type = "skill_assessment" 
    AND member = link("<MEMBER_LINK_PLACEHOLDER>") // **Modify This**: Replace with link to member note or use dv.current().file.link if applicable
SORT assessment_date DESC
```

---

## IV. Project Involvement for {{memberName}}

*Purpose: To show which projects this member is currently or has been involved in, and their roles.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially the member link) below. -->
```dataview
TABLE WITHOUT ID
    project.file.link AS "Project",
    role AS "Role",
    participation_start_date AS "Start Date",
    participation_end_date AS "End Date (if any)"
FROM "" // **Operator Variable**: Or specify folder "project_participation_logs/" or tag #project_participation
WHERE type = "project_participation" 
    AND member = link("<MEMBER_LINK_PLACEHOLDER>") // **Modify This**: Replace with link to member note or use dv.current().file.link if applicable
    AND project
SORT project.file.name ASC
```

---

## V. Political Education Progress for {{memberName}}

*Purpose: To show which key reading materials this member has completed.*
*Note: This query requires `material_id` in reading material notes and `material_completed` (as a link) in member progress notes.*

<!-- USER ACTION: Customize 'memberFilePath', 'keyMaterialsFolder', and 'memberProgressType' variables below. -->
```dataviewjs
// **Modify THIS**: Replace "<MEMBER_FILE_PATH_PLACEHOLDER>" with the actual file path of the member's note
// e.g., "Members/Jane Doe.md". Or, if this dashboard is IN the member's note, use `dv.current().file.path`.
const memberFilePath = "<MEMBER_FILE_PATH_PLACEHOLDER>"; 

// **Operator Variables**: Adjust these to match your vault structure.
const keyMaterialsFolder = "education/materials"; 
const memberProgressType = "member_progress";

const materials = dv.pages(`"${keyMaterialsFolder}"`).where(p => p.material_id);
const progressNotes = dv.pages(`type = "${memberProgressType}"`);

let completedMaterials = [];
for (let progress of progressNotes) {
    // Ensure progress.member and progress.material_completed are valid links before accessing .path
    if (progress.member && progress.member.path && progress.material_completed && progress.material_completed.path) {
        if (progress.member.path === memberFilePath) {
            const materialNote = dv.page(progress.material_completed.path);
            if (materialNote) {
                completedMaterials.push({
                    title: materialNote.title || materialNote.file.name,
                    date: progress.completion_date ? progress.completion_date.toString() : "N/A",
                    link: materialNote.file.link
                });
            }
        }
    }
}

if (memberFilePath === "<MEMBER_FILE_PATH_PLACEHOLDER>" || !memberFilePath) {
    dv.paragraph("Error: `memberFilePath` variable in the DataviewJS query is not set. Please edit the query and provide the correct file path to this member's note.");
} else if (completedMaterials.length > 0) {
    dv.header(3, "Completed Reading Materials");
    dv.table(
        ["Material Title", "Completion Date"],
        completedMaterials.sort((a,b) => (a.date < b.date) ? 1 : -1).map(m => [m.link, m.date])
    );
} else {
    dv.paragraph(`No completed reading materials recorded for member (path: ${memberFilePath}), or member file path not correctly set.`);
}

// Conceptual query for pending materials (requires 'required_for_level' or similar in material notes)
/*
const memberNote = dv.page(memberFilePath);
if (memberNote && memberNote.target_education_level) { // Assuming member note has a target education level
    const requiredLevel = memberNote.target_education_level;
    const allRequiredMaterials = materials.where(m => 
        m.required_for_level === requiredLevel // **Operator Variable**: Adjust field and logic as needed
    ); 
    let notCompleted = [];
    const completedPaths = completedMaterials.map(cm => cm.link.path);

    for (let reqMat of allRequiredMaterials) {
        if (!completedPaths.includes(reqMat.file.path)) {
            notCompleted.push(reqMat.file.link);
        }
    }
    if (notCompleted.length > 0) {
        dv.header(3, `Pending Key Materials for Level: ${requiredLevel}`);
        dv.list(notCompleted);
    } else if (allRequiredMaterials.length > 0) {
        dv.paragraph(`All required materials for level ${requiredLevel} appear to be completed.`);
    }
}
*/
```

---
*Remember to customize placeholders in the queries for this template to be effective.*
```
