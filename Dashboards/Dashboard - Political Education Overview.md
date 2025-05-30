# Political Education Overview Dashboard

This dashboard provides an overview of progress related to political education, including the completion status of reading materials and study session participation.

**Navigation:**
*   [[Dashboard - Organizational Overview]]
*   ... (other relevant dashboards)

---

## I. Reading Materials Completion Overview

*Purpose: To show how many members have completed each key reading material.*
*Query D.2 from `docs/dataview-organizational-metrics-queries.md`.*
*Note: Assumes `member_progress` notes link to `reading_material` notes via a `material_completed` field.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type field) below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    material.title AS "Material",
    length(rows) AS "Number of Completions"
FROM "" // **Operator Variable**: Source for member_progress notes, e.g., '"progress_tracking/"' or tag #member_progress
WHERE type = "member_progress" AND material_completed // **Operator Variable**: type field for progress notes
FLATTEN material_completed AS material_link
LET material = dv.page(material_link.path) // Assumes material_completed is a link
WHERE material // Ensure the linked material page exists
GROUP BY material.title // or material.file.link if titles are not unique or always present
SORT length(rows) DESC
```

---

## II. Members Who Have Not Completed a Specific Material

*Purpose: To list members who have not yet logged completion for a specific required reading material. This query requires manual input of the target material link.*
*Query D.3 (DataviewJS) from `docs/dataview-organizational-metrics-queries.md`.*

**Instructions:**
1.  To use the query below, uncomment it.
2.  Modify the **`targetMaterialPath` Operator Variable** in the DataviewJS block to the exact file path of the reading material you want to check (e.g., `"education/materials/KeyText1.md"`).

<!-- USER ACTION: Customize 'targetMaterialPath', 'memberProgressType', and 'memberFolder' variables in the DataviewJS block below. -->
```dataviewjs
/* // Uncomment this block to use the query

// **Operator Variables**: Customize these paths and types for your vault structure.
const targetMaterialPath = "education/materials/PathToYourSpecificMaterial.md"; // MODIFY THIS: Exact path to the material note
const memberProgressType = "member_progress"; // Type for member progress notes
const memberFolder = "members"; // Folder containing notes for each member

// --- Query Logic ---
const targetMaterialLink = dv.fileLink(targetMaterialPath);
const members = dv.pages(`"${memberFolder}"`); // Get all member pages
const progressNotes = dv.pages(`type = "${memberProgressType}"`)
    .where(p => p.material_completed && p.material_completed.path === targetMaterialPath);

const membersWhoCompleted = progressNotes.map(p => {
    if (p.member && p.member.path) return p.member.path;
    return null; 
}).filter(p => p !== null);

const membersNotCompleted = members
    .where(m => !membersWhoCompleted.includes(m.file.path))
    .map(m => m.file.link);

if (!dv.page(targetMaterialPath)) {
    dv.paragraph(`**Error:** The target material note at path "${targetMaterialPath}" was not found. Please check the path in the query.`);
} else if (membersNotCompleted.length > 0) {
    dv.header(3, `Members Who Have Not Completed: ${targetMaterialLink.display}`);
    dv.list(membersNotCompleted);
} else {
    dv.paragraph(`All members listed in "${memberFolder}" appear to have completed ${targetMaterialLink.display}, no progress notes indicate otherwise, or the member/progress data is not structured as expected.`);
}

*/
```
**Note:** You can duplicate the DataviewJS block above multiple times in this note, each configured for a different `targetMaterialPath`, to track several specific materials.

---

## III. List of All Reading Materials

*Purpose: To provide a simple list of all documents designated as reading materials, optionally with their required level.*
*Note: Assumes `reading_material` notes have a `title` and optionally a `required_for_level` field.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type field) below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    file.link AS "Material Title",
    required_for_level AS "Required For Level",
    source_document AS "Source (if applicable)"
FROM "" // **Operator Variable**: Or specify folder "education/materials/" or tag #reading_material
WHERE type = "reading_material" // **Operator Variable**: type field for reading materials
SORT file.name ASC
```

---
*Ensure `reading_material` and `member_progress` notes are consistently created with the necessary metadata for these queries to function correctly.*
```
