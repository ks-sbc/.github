# Decisions and Accountability Dashboard

This dashboard tracks approved decisions, the status of their implementation via action items, and overall accountability for these actions.

**Navigation:**
*   [[Dashboard - Organizational Overview]]
*   ... (other relevant dashboards)

---

## I. Approved Decisions & Current Action Item Status

*Purpose: To list all approved decisions and provide a summary of the status of their associated action items.*
*Query B.1 from `docs/dataview-organizational-metrics-queries.md`.*
*Note: This query assumes action items have a `decision_id` field that matches a `decision_id` in the decision log notes.*

<!-- USER ACTION: Customize FROM clause, WHERE conditions (especially type and decision_outcome values), and JOIN condition if your linking method differs. -->
```dataview
TABLE WITHOUT ID
    L.file.link AS "Decision",
    L.decision_date AS "Date Approved",
    L.summary AS "Decision Summary",
    count(A) AS "Total Actions",
    sum(map(A, (item) => item.status = "completed")) AS "Completed",
    sum(map(A, (item) => item.status = "in-progress")) AS "In Progress",
    sum(map(A, (item) => item.status = "open")) AS "Open"
FROM "" AS L // **Operator Variable**: Or specify folder "decisions/" or tag #decision_log
WHERE L.type = "decision_log" AND L.decision_outcome = "approved" // **Operator Variable**: "approved" status
// Assumes action_item notes have a 'decision_id' field matching L.decision_id
// **Operator Variable**: Adjust p.type and p.decision_id if your action item metadata differs.
JOIN dv.pages().where(p => p.type = "action_item" AND p.decision_id = L.decision_id) AS A ON true
GROUP BY L.file.link, L.decision_date, L.summary
SORT L.decision_date DESC
```
**Alternative for simpler linking (if action items link via `related_decision:: [[Decision File]]`):**
<!-- USER ACTION: If using this alternative, customize FROM clause and WHERE conditions. -->
```dataview
/*
TABLE WITHOUT ID
    file.link AS "Decision",
    decision_date AS "Date Approved",
    summary AS "Decision Summary",
    length(filter(file.inlinks, (p) => p.type = "action_item")) AS "Total Actions",
    length(filter(file.inlinks, (p) => p.type = "action_item" AND p.status = "completed")) AS "Completed",
    length(filter(file.inlinks, (p) => p.type = "action_item" AND p.status = "in-progress")) AS "In Progress",
    length(filter(file.inlinks, (p) => p.type = "action_item" AND p.status = "open")) AS "Open"
FROM "" // **Operator Variable**: Or specify folder "decisions/" or tag #decision_log
WHERE type = "decision_log" AND decision_outcome = "approved" // **Operator Variable**: "approved" status
SORT decision_date DESC
*/
```

---

## II. All Overdue Action Items

*Purpose: To identify all action items across all decisions/projects that are past their `due_date` and not yet completed.*
*Query B.2 from `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type and status values) below. -->
```dataview
TABLE WITHOUT ID
    file.link AS "Action Item",
    action_summary AS "Summary",
    assigned_to AS "Assigned To",
    due_date AS "Due Date",
    status AS "Status",
    related_decision AS "Related Decision"
FROM "" // **Operator Variable**: Or specify folder "action_items/" or tag #action_item
WHERE type = "action_item" AND due_date AND date(due_date) < date(today) 
    AND !contains(list("completed", "cancelled"), status) // **Operator Variables**: Adjust non-completed statuses
SORT date(due_date) ASC
```

---

## III. Action Item Summary by Assignee

*Purpose: To provide a summary table showing the number of open, in-progress, and overdue action items for each assignee, promoting accountability.*
*Query B.4 from `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Customize FROM clause and WHERE conditions (especially type and status values) below. -->
```dataview
TABLE WITHOUT ID
    assignee AS "Assignee",
    length(filter(rows, (r) => r.status = "open")) AS "Open",
    length(filter(rows, (r) => r.status = "in-progress")) AS "In Progress",
    length(filter(rows, (r) => r.due_date AND date(r.due_date) < date(today) AND !contains(list("completed", "cancelled"), r.status))) AS "Overdue"
FROM "" // **Operator Variable**: Or specify folder "action_items/" or tag #action_item
WHERE type = "action_item" 
    AND !contains(list("completed", "cancelled"), status) // **Operator Variables**: Adjust non-completed statuses
    AND assigned_to
GROUP BY assigned_to AS assignee
SORT assignee ASC
```

---
*Ensure `decision_log` and `action_item` notes are consistently created with the required metadata for these queries to be effective.*
```
