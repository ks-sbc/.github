# Projects Overview Dashboard

This dashboard provides a summary of all projects, their outcomes, and an analysis of common factors contributing to success or failure.

**Navigation:**
*   [[Dashboard - Organizational Overview]]
*   ... (other relevant dashboards)

---

## I. All Projects Summary Table

*Purpose: To provide a comprehensive list of all projects with key information at a glance.*
*Note: This query assumes project information is stored in notes with `type: "project_log"`.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type field) below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    file.link AS "Project",
    project_name AS "Name",
    status AS "Status",
    start_date AS "Started",
    end_date AS "Ended",
    outcome AS "Outcome",
    project_lead AS "Lead (if any)",
    team_members AS "Team (if any)"
FROM "" // **Operator Variable**: Or specify folder "projects/" or tag #project_log
WHERE type = "project_log" // **Operator Variable**: Adjust if your project note type is different
SORT status, start_date DESC
```

---

## II. Projects by Outcome

*Purpose: To categorize and list projects based on their final outcome (e.g., success, failure, abandoned).*
*Query E.1 from `docs/dataview-organizational-metrics-queries.md`*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type, outcome, and status values) below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    outcome AS "Outcome",
    rows.file.link AS "Project",
    rows.start_date AS "Start Date",
    rows.end_date AS "End Date"
FROM "" // **Operator Variable**: Or specify folder "projects/" or tag #project_log
WHERE type = "project_log" // **Operator Variable**: Adjust if your project note type is different
    AND outcome 
    AND contains(list("completed", "failed", "abandoned"), status) // **Operator Variables**: Adjust status values for what you consider a "finalized" project with an outcome
GROUP BY outcome
SORT outcome ASC
```

---

## III. Project Success Factor Analysis

*Purpose: To identify and count common success factors listed in completed successful project logs.*
*Query E.2 (for success) from `docs/dataview-organizational-metrics-queries.md`*
*Note: This requires `success_factors` (as a list) in the YAML frontmatter of successful project notes.*

<!-- USER ACTION: Customize 'projectLogType', 'targetOutcome', 'factorField', and the dv.pages() source below to match your vault structure and specific data! -->
```dataviewjs
// **Operator Variables**: Adjust these to match your metadata fields
const projectLogType = "project_log";
const targetOutcome = "success"; // For this section, we want success factors
const factorField = "success_factors"; 

const projects = dv.pages(`type = "${projectLogType}"`) // **Operator Variable**: Source of project notes e.g., '"projects/"' or '#project_log'
    .where(p => p.outcome === targetOutcome && p[factorField]);

const factorCounts = {};
for (let project of projects) {
    let factors = dv.array(project[factorField]); // Ensures it's an array
    for (let factor of factors) {
        if(factor && typeof factor === 'string') { // Ensure factor is not null/undefined and is a string
            factorCounts[factor.trim()] = (factorCounts[factor.trim()] || 0) + 1;
        }
    }
}

const sortedFactors = Object.entries(factorCounts).sort((a, b) => b[1] - a[1]);

dv.header(3, `Common ${targetOutcome === "success" ? "Success" : "Failure"} Factors`);
if (sortedFactors.length > 0) {
    dv.table(["Factor", "Count"], sortedFactors);
} else {
    dv.paragraph(`No projects found with outcome "${targetOutcome}" and associated field "${factorField}". Check your project notes' metadata.`);
}
```

---

## IV. Project Failure Factor Analysis

*Purpose: To identify and count common failure factors listed in completed failed project logs.*
*Adapted from Query E.2 (for failure) from `docs/dataview-organizational-metrics-queries.md`*
*Note: This requires `failure_factors` (as a list) in the YAML frontmatter of failed project notes.*

<!-- USER ACTION: Customize 'projectLogType_fail', 'targetOutcome_fail', 'factorField_fail', and the dv.pages() source below to match your vault structure and specific data! -->
```dataviewjs
// **Operator Variables**: Adjust these to match your metadata fields
const projectLogType_fail = "project_log"; // Renamed to avoid conflict if copy-pasting blocks
const targetOutcome_fail = "failure"; // For this section, we want failure factors
const factorField_fail = "failure_factors"; 

const projects_fail = dv.pages(`type = "${projectLogType_fail}"`) // **Operator Variable**: Source of project notes e.g., '"projects/"' or '#project_log'
    .where(p => p.outcome === targetOutcome_fail && p[factorField_fail]);

const factorCounts_fail = {};
for (let project of projects_fail) {
    let factors = dv.array(project[factorField_fail]); // Ensures it's an array
    for (let factor of factors) {
       if(factor && typeof factor === 'string') { // Ensure factor is not null/undefined and is a string
            factorCounts_fail[factor.trim()] = (factorCounts_fail[factor.trim()] || 0) + 1;
        }
    }
}

const sortedFactors_fail = Object.entries(factorCounts_fail).sort((a, b) => b[1] - a[1]);

dv.header(3, `Common ${targetOutcome_fail === "success" ? "Success" : "Failure"} Factors`);
if (sortedFactors_fail.length > 0) {
    dv.table(["Factor", "Count"], sortedFactors_fail);
} else {
    dv.paragraph(`No projects found with outcome "${targetOutcome_fail}" and associated field "${factorField_fail}". Check your project notes' metadata.`);
}
```

---
*This dashboard helps in understanding project landscapes and learning from past experiences. Ensure project notes are consistently updated with `outcome` and relevant `success_factors` or `failure_factors`.*
```
