# Organizational Overview Dashboard

This dashboard provides a high-level snapshot of key organizational metrics, including active work cycles, decision statuses, project progress, and critical Key Performance Indicators (KPIs).

**Navigation:**
*   [[Dashboard - Member Development Template]]
*   [[Dashboard - Projects Overview]]
*   [[Dashboard - Decisions and Accountability]]
*   [[Dashboard - Political Education Overview]]
*   [[Dashboard - Security Monitoring]]

---

## I. Active Work Cycles

### A. Active Cycles Overview
*Purpose: To get an overview of all cycles that are currently in an active phase (e.g., plan approved, practice ongoing) and not yet fully summated.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially status values), and LET statements below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    cycle.id AS "Cycle ID",
    theory_link AS "Theory",
    plan_status AS "Plan Status",
    practice_status AS "Practice Status",
    summation_status AS "Summation Status"
FROM "" // **Operator Variable**: Or specify a folder like "cycles/" or tag #cycle_document
WHERE cycle_id AND (type = "cycle_plan" OR type = "cycle_practice" OR type = "cycle_summation" OR type = "cycle_theory")
GROUP BY cycle_id AS cycle
// Get links to each stage for display
LET theory_doc = filter(cycle.rows, (r) => r.type = "cycle_theory")
LET theory_link = theory_doc[0].file.link
// Get statuses of each stage
LET plan_docs = filter(cycle.rows, (r) => r.type = "cycle_plan")
LET plan_status = plan_docs[0].status ?? "N/A" 
LET practice_docs = filter(cycle.rows, (r) => r.type = "cycle_practice")
LET practice_status = practice_docs[0].status ?? "N/A" 
LET summation_docs = filter(cycle.rows, (r) => r.type = "cycle_summation")
LET summation_status = summation_docs[0].status ?? "N/A" 
// Filter for active cycles:
// **Operator Variables**: Adjust status values (e.g., "approved", "active", "ongoing", "completed") as needed.
WHERE (contains(list("approved", "active"), plan_status) OR contains(list("ongoing"), practice_status)) AND summation_status != "completed"
SORT cycle.id ASC
```

### B. Cycles Awaiting Summation
*Purpose: To identify cycles where "Practice" is completed, but "Summation" is pending or not yet completed.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially status values for 'completed'), and LET statements below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    cycle.id AS "Cycle ID",
    practice_doc.file.link AS "Completed Practice Document",
    summation_doc.file.link AS "Summation Document (if any)",
    summation_doc.status AS "Summation Status"
FROM "" // **Operator Variable**: Or specify a folder like "cycles/" or tag #cycle_document
WHERE cycle_id AND (type = "cycle_practice" OR type = "cycle_summation")
GROUP BY cycle_id AS cycle
// **Operator Variables**: Adjust status values (e.g., "completed") as needed.
LET practice_doc = filter(cycle.rows, (r) => r.type = "cycle_practice" AND r.status = "completed")[0]
LET summation_doc = filter(cycle.rows, (r) => r.type = "cycle_summation")[0]
WHERE practice_doc AND (summation_doc = null OR summation_doc.status != "completed")
SORT cycle.id ASC
```
**Note:** For more complex scenarios with multiple practice notes per cycle, a DataviewJS query might be more robust for "Cycles Awaiting Summation."

---

## II. Key Decisions & Actions

### A. Recent Approved Decisions
*Purpose: A quick look at recently approved decisions.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially type and decision_outcome values), and LIMIT below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    file.link AS "Decision",
    decision_date AS "Date Approved",
    summary AS "Summary (if available)"
FROM "" // **Operator Variable**: Or specify folder "decisions/" or tag #decision_log
WHERE type = "decision_log" AND decision_outcome = "approved" // **Operator Variable**: "approved" status
SORT decision_date DESC
LIMIT 5 // **Operator Variable**: Number of recent decisions to show
```

### B. Overdue Action Items Count
*Purpose: Total count of overdue action items across all projects/decisions.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type and status values) below to match your vault structure and specific data! -->
```dataview
LIST WITHOUT ID
    "**Total Overdue Action Items:** " + length(rows.file.link)
FROM "" // **Operator Variable**: Or specify folder "action_items/" or tag #action_item
WHERE type = "action_item" AND due_date AND date(due_date) < date(today) AND !contains(list("completed", "cancelled"), status) // **Operator Variables**: status values
```

---

## III. Project Health Snapshot

### A. Project Status Counts
*Purpose: To count projects by their current status (e.g., planning, active, completed, on-hold, failed).*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type field) below to match your vault structure and specific data! -->
```dataview
TABLE WITHOUT ID
    status AS "Project Status",
    count AS "Number of Projects"
FROM "" // **Operator Variable**: Or specify folder "projects/" or tag #project_log
WHERE type = "project_log" AND status // Ensure status field exists
GROUP BY status
SORT count DESC
```

---

## IV. Critical KPIs (Key Performance Indicators)

*Purpose: Display the latest values for a few critical KPIs. This section requires careful selection of what is most important for a quick overview.*

<!-- USER ACTION: Customize 'criticalMetrics' array, 'snapshotType', and ensure your metric notes have 'metric_name', 'metric_value', and 'date' fields. -->
```dataviewjs
// **Operator Variables**: Define which metrics are considered "critical"
const criticalMetrics = ["WeeklyActiveUsers", "L1DocumentsCreated", "SecurityIncidentsOpen"]; 
// **Operator Variable**: Source of metric snapshots (e.g., notes with type: "metric_snapshot" or tag: #metric_snapshot)
const snapshotType = "metric_snapshot"; 
// **Operator Variable**: Optional: specify a folder if your metric snapshots are centralized
const metricsFolder = ""; // e.g., "metrics/" - leave empty to search whole vault

const querySource = metricsFolder ? `"${metricsFolder}" AND type = "${snapshotType}"` : `type = "${snapshotType}"`;

const pages = dv.pages(querySource)
    .where(p => criticalMetrics.includes(p.metric_name) && p.metric_value !== undefined && p.date)
    .sort(p => p.date, 'desc');

const latestValues = {};
for (let page of pages) {
    if (!latestValues[page.metric_name]) {
        latestValues[page.metric_name] = {
            value: page.metric_value,
            date: page.date.toString(), // dv.date(page.date).toFormat("yyyy-MM-dd") for specific format
            unit: page.unit || "",
            link: page.file.link
        };
    }
}

const output = Object.entries(latestValues).map(([name, data]) => {
    return [dv.fileLink(data.link.path, false, name), data.value, data.date, data.unit];
});

if (output.length > 0) {
  dv.table(["Critical KPI (Link to Latest)", "Latest Value", "As of Date", "Unit"], output);
} else {
  dv.paragraph("No critical KPI snapshots found. Check 'criticalMetrics' array, 'snapshotType', 'metricsFolder' (if used), and your metric note metadata ('metric_name', 'metric_value', 'date').");
}
```
**Note:** Ensure your `metric_snapshot` notes have the fields `metric_name`, `metric_value`, and `date`. The `criticalMetrics` array in the script must be updated with the exact `metric_name` values you want to display.

---
*This dashboard provides a starting point. Customize the queries and sections to best reflect your organization's priorities and data structure.*
```
