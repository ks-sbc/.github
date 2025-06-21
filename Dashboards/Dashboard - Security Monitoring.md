# Security Monitoring Dashboard

This dashboard is a **starting framework** for an overview of key security-related metrics, including incident management, access control, and document compliance. 

**Important Setup Note:**
Unlike other dashboards that rely on a pre-defined metadata structure, the effective use of this Security Monitoring Dashboard requires **you to first define and implement a consistent metadata structure within your Obsidian notes for tracking security incidents, access requests, and document review cycles.** 

Once you have your metadata system in place for these items, you will then need to **adapt or create the Dataview queries** for the sections below. Example query structures and references to relevant queries (originally planned as Categories D, E, and F for these specific topics) in the `docs/dataview-organizational-metrics-queries.md` document are provided as a starting point.

**Navigation:**
*   [[Dashboard - Organizational Overview]]
*   ... (other relevant dashboards)

---

## I. Security Incident Management

*Purpose: To track and manage security incidents based on your defined metadata.*

### A. Open Security Incidents by Severity
*This query lists currently open security incidents, categorized by severity. Adapt it from **Query D1** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for incidents (e.g., `type: "security_incident"`, `status`, `incident_severity`). Then, customize FROM clause and WHERE conditions below. -->
```dataview
TABLE WITHOUT ID
    severity AS "Severity",
    count AS "Open Incidents"
FROM "" // **Operator Variable**: Specify source, e.g., '"security/incidents/"' OR #security/incident
WHERE type = "security_incident" AND contains(list("open", "in-progress", "under-investigation"), status) // **Operator Variables**: Match your incident type and open statuses
GROUP BY incident_severity AS severity // **Operator Variable**: Match your severity field
SORT length(rows) DESC
```
**Action:**
1.  Define how you will note security incidents (e.g., a `type: "security_incident"` field, specific tags).
2.  Define fields for `status` (e.g., "open", "under-investigation", "resolved") and `incident_severity` (e.g., "critical", "high", "medium", "low").
3.  Customize the `FROM` clause and all `WHERE` and `GROUP BY` conditions in the query above to match your metadata.

### B. Average Time to Resolution for Security Incidents (Last Quarter)
*This query calculates the average time taken to resolve incidents. Adapt it from **Query D2 (DataviewJS)** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for incident creation (`created`) and resolution (`resolved_on`) dates. Then, implement and customize the DataviewJS query (D2) from the metrics document. -->
```dataviewjs
// ** Placeholder for DataviewJS Query D2 from docs/dataview-organizational-metrics-queries.md **
// 1. Define your metadata: Ensure your incident notes have date fields for 'created' and 'resolved_on'.
// 2. Adapt Query D2: Copy the full D2 query from the metrics document.
// 3. Customize Operator Variables in the D2 script:
//    - Source of incident notes (e.g., based on `type: "security_incident"` or a specific folder/tag).
//    - `resolvedStatus` (e.g., "resolved", matching your metadata).
//    - `reportingPeriodDays` (e.g., 90 for a quarter).

dv.paragraph("To implement 'Average Time to Resolution':");
dv.paragraph("1. Ensure your incident notes have `created` (YYYY-MM-DD) and `resolved_on` (YYYY-MM-DD) date fields, and a `status` field.");
dv.paragraph("2. Copy the full DataviewJS query D2 from `docs/dataview-organizational-metrics-queries.md` into this code block.");
dv.paragraph("3. Customize the Operator Variables within that script (source, status values, period).");
```

---

## II. Access Control Metrics

*Purpose: To monitor access requests and identify sensitive resources based on your defined metadata.*

### A. Access Requests Granted vs. Revoked (Last Month)
*This query tracks granted/revoked access. Adapt it from **Query E1 (DataviewJS)** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for access requests (e.g., `type: "access_request"`, `status`, decision date field). Then, implement and customize the DataviewJS query (E1) from the metrics document. -->
```dataviewjs
// ** Placeholder for DataviewJS Query E1 from docs/dataview-organizational-metrics-queries.md **
// 1. Define your metadata: Notes for access requests should have a `type` (e.g., "access_request"), a `status` (e.g., "approved", "revoked"), and a decision date field.
// 2. Adapt Query E1: Copy the full E1 query from the metrics document.
// 3. Customize Operator Variables in the E1 script:
//    - Source of access request notes.
//    - `grantedStatus`, `revokedStatus` values.
//    - `decisionDateField` (e.g., "resolved_on", "decision_date").
//    - `reportingPeriodDays` (e.g., 30).

dv.paragraph("To implement 'Access Requests Granted vs. Revoked':");
dv.paragraph("1. Ensure your access request notes have a `type`, `status`, and a decision date field (e.g., `resolved_on`).");
dv.paragraph("2. Copy the full DataviewJS query E1 from `docs/dataview-organizational-metrics-queries.md` here.");
dv.paragraph("3. Customize the Operator Variables within that script.");
```

### B. L2 Classified Resources Requiring Approval
*This query lists resources defined with L2 classification. Adapt it from **Query E2** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for resources (e.g., `type: "resource"`, `classification`). Then, customize FROM clause and WHERE conditions below. -->
```dataview
TABLE WITHOUT ID
    file.link AS "Resource",
    classification AS "Classification",
    owner AS "Owner/Custodian (if available)"
FROM "" // **Operator Variable**: Specify source, e.g., '"resources/"' OR #resource_definition
WHERE type = "resource" AND classification = "L2" // **Operator Variables**: Match your resource type and L2 classification value
    // AND requires_access_approval = true // Optional: if you have this explicit field
SORT file.name ASC
```
**Action:**
1.  Define how you note resources (e.g., `type: "resource"`) and their `classification`.
2.  Customize the `FROM` clause and `WHERE` conditions.

---

## III. Document Review and Compliance

*Purpose: To track document review cycles and identify overdue reviews based on your defined metadata.*

### A. Documents Overdue for Review
*This query lists documents past their `next_review_date`. Adapt it from **Query F1** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for reviewable documents (e.g., `type: "policy"`, `next_review_date`). Then, customize FROM clause and WHERE conditions below. -->
```dataview
TABLE WITHOUT ID
    file.link AS "Document",
    next_review_date AS "Next Review Date",
    classification AS "Classification",
    owner AS "Owner (if available)"
FROM "" // **Operator Variable**: Specify source, e.g., '"policies/"' OR #document/reviewable
WHERE (type = "policy" OR type = "procedure" OR contains(file.tags, "#document/reviewable")) // **Operator Variables**: Match your document types/tags
    AND next_review_date AND date(next_review_date) < date(today)
SORT date(next_review_date) ASC
```
**Action:**
1.  Define how you note reviewable documents and their `next_review_date`.
2.  Customize the `FROM` clause and `WHERE` conditions.

### B. Documents Not Reviewed in Last Year (by Classification)
*This query counts documents by classification not reviewed recently. Adapt it from **Query F2 (DataviewJS)** in `docs/dataview-organizational-metrics-queries.md`.*

<!-- USER ACTION: Define your metadata for document review dates (`review_date`). Then, implement and customize the DataviewJS query (F2) from the metrics document. -->
```dataviewjs
// ** Placeholder for DataviewJS Query F2 from docs/dataview-organizational-metrics-queries.md **
// 1. Define your metadata: Ensure your documents have a `review_date` field (date of last review) and optionally a `classification`.
// 2. Adapt Query F2: Copy the full F2 query from the metrics document.
// 3. Customize Operator Variables in the F2 script:
//    - Source of document notes.
//    - `reportingPeriodDays` (e.g., 365).

dv.paragraph("To implement 'Documents Not Reviewed in Last Year':");
dv.paragraph("1. Ensure your documents have a `review_date` field and optionally a `classification` field.");
dv.paragraph("2. Copy the full DataviewJS query F2 from `docs/dataview-organizational-metrics-queries.md` here.");
dv.paragraph("3. Customize the Operator Variables within that script.");
```

---
*This dashboard requires users to first establish their own metadata conventions for tracking security incidents, access requests, and document reviews. Once that system is in place, the example queries referenced from `docs/dataview-organizational-metrics-queries.md` (Categories D, E, F) can be adapted and embedded here.*
```
