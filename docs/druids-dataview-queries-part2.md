```markdown
# DRUIDS Project: Dataview Queries for Organizational Metrics (Part 2)

This document continues the drafting of Dataview queries for tracking organizational metrics, focusing on metrics D, E, and F.

## Recap of Assumed Metadata Structure

For these queries to function correctly, it's assumed that notes in your Obsidian vault will contain relevant YAML frontmatter. Key fields include:

*   `type`: Type of note (e.g., "meeting", "decision", "task", "security_incident", "access_request").
*   `status`: Current status of the item (e.g., "open", "in-progress", "completed", "resolved", "pending-review", "under-investigation").
*   `created`: Date the item was created (YYYY-MM-DD).
*   `resolved_on`: Date an incident/request was resolved (YYYY-MM-DD).
*   `due_date`: Due date for tasks or follow-ups (YYYY-MM-DD).
*   `classification`: Security classification (e.g., "L0", "L1", "L2").
*   `incident_severity`: Severity of a security incident (e.g., "low", "medium", "high", "critical").
*   `access_resource`: Link to the resource for an access request.
*   `approved_by`: Link(s) to user(s) who approved a request.
*   `decision_outcome`: Outcome of a decision note (e.g., "approved", "rejected").
*   `review_date`: Date of last review for a document.
*   `next_review_date`: Date for next scheduled review.

---

## D. Security Incident Management Metrics

### D1. Count of Open Security Incidents by Severity

*   **Purpose:** To provide an overview of all currently open security incidents, categorized by their severity level. This helps prioritize response efforts.
*   **Operator Variables:**
    *   `INCIDENT_TYPE_TAG`: The tag or `type` field value that identifies a note as a security incident (e.g., `type: "security_incident"` or could be a tag like `#security/incident`). For this query, we'll assume `type: "security_incident"`.
    *   `OPEN_STATUS_VALUES`: A list of status values that signify an incident is still open (e.g., `"open"`, `"in-progress"`, `"under-investigation"`).
    *   `SEVERITY_FIELD`: The metadata field name for incident severity (e.g., `incident_severity`).

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        severity AS "Severity",
        count AS "Open Incidents"
    FROM "" // Or specify a folder like "security/incidents/"
    WHERE type = "security_incident" AND contains(list("open", "in-progress", "under-investigation"), status)
    GROUP BY incident_severity AS severity
    SORT length(rows) DESC
    ```
    **Alternative using a tag `#security/incident` and `file.folder`:**
    ```dataview
    TABLE WITHOUT ID
        severity AS "Severity",
        count AS "Open Incidents"
    FROM #security/incident AND "security/incidents" // Assumes incidents are tagged and in a specific folder
    WHERE contains(list("open", "in-progress", "under-investigation"), status)
    GROUP BY incident_severity AS severity
    SORT length(rows) DESC
    ```

### D2. Average Time to Resolution for Security Incidents (Last Quarter)

*   **Purpose:** To measure the efficiency of the incident response process by calculating the average time taken to resolve incidents that were closed in the last quarter.
*   **Operator Variables:**
    *   `INCIDENT_TYPE_TAG`: `type: "security_incident"`.
    *   `RESOLVED_STATUS_VALUE`: The status value for resolved incidents (e.g., `"resolved"`).
    *   `CREATED_FIELD`: Metadata field for creation date (`created`).
    *   `RESOLVED_ON_FIELD`: Metadata field for resolution date (`resolved_on`).
    *   `DATE_FORMAT`: Assumed YYYY-MM-DD.
    *   `REPORTING_PERIOD_DAYS`: Number of days in the reporting period (e.g., 90 for a quarter).

*   **Dataview Query (DQL with DataviewJS for date calculations):**
    ```dataviewjs
    const incidents = dv.pages('type = "security_incident" OR #security/incident'); // Adjust source as needed
    const resolvedStatus = "resolved"; // Operator Variable
    const reportingPeriodDays = 90; // Operator Variable: Last 90 days for a quarter
    const today = dv.date('today');
    const startDate = today.minus(dv.duration(reportingPeriodDays + " days")); // Start of the period to look for resolved incidents

    let totalResolutionTimeDays = 0;
    let resolvedIncidentsCount = 0;

    for (let incident of incidents) {
        if (incident.status === resolvedStatus && incident.created && incident.resolved_on) {
            let createdDate = dv.date(incident.created);
            let resolvedDate = dv.date(incident.resolved_on);

            // Only include incidents resolved within the reporting period
            if (resolvedDate >= startDate && resolvedDate <= today) {
                if (createdDate && resolvedDate && resolvedDate >= createdDate) {
                    let resolutionDuration = resolvedDate.diff(createdDate, 'days');
                    totalResolutionTimeDays += resolutionDuration.days;
                    resolvedIncidentsCount++;
                }
            }
        }
    }

    if (resolvedIncidentsCount > 0) {
        const averageResolutionTime = totalResolutionTimeDays / resolvedIncidentsCount;
        dv.paragraph(`Average Time to Resolution (Last ${reportingPeriodDays} Days): **${averageResolutionTime.toFixed(2)} days** (based on ${resolvedIncidentsCount} incidents).`);
    } else {
        dv.paragraph("No security incidents resolved in the last " + reportingPeriodDays + " days to calculate average resolution time.");
    }
    ```
    **Note:** This DQL query uses DataviewJS due to the need for date calculations (time difference). Simpler DQL might only list resolution times per incident.

---

## E. Access Control Metrics

### E1. Number of Access Requests Granted vs. Revoked (Last Month)

*   **Purpose:** To track the volume of access requests and revocations, providing insight into access management activity.
*   **Operator Variables:**
    *   `ACCESS_REQUEST_TYPE_TAG`: `type: "access_request"`.
    *   `GRANTED_STATUS_VALUE`: Status for granted requests (e.g., `"approved"` or could be a dedicated field like `request_outcome: "granted"`). For this example, let's assume `status: "approved"` for granted and `status: "revoked"` for revoked.
    *   `DECISION_DATE_FIELD`: Field indicating when the decision was made (e.g., `resolved_on` or a custom `decision_date`). Using `resolved_on` for this example.
    *   `REPORTING_PERIOD_DAYS`: 30 for last month.

*   **Dataview Query (DQL with DataviewJS for flexibility):**
    ```dataviewjs
    const requests = dv.pages('type = "access_request"'); // Adjust source as needed
    const grantedStatus = "approved"; // Operator Variable
    const revokedStatus = "revoked";  // Operator Variable (assuming a status for revocation)
    const decisionDateField = "resolved_on"; // Operator Variable
    const reportingPeriodDays = 30; // Operator Variable
    const today = dv.date('today');
    const startDate = today.minus(dv.duration(reportingPeriodDays + " days"));

    let grantedCount = 0;
    let revokedCount = 0;

    for (let req of requests) {
        let decisionDate = req[decisionDateField] ? dv.date(req[decisionDateField]) : null;
        if (decisionDate && decisionDate >= startDate && decisionDate <= today) {
            if (req.status === grantedStatus) {
                grantedCount++;
            } else if (req.status === revokedStatus) { // This assumes 'revoked' is a status.
                                                     // Alternatively, you might track revocations differently.
                revokedCount++;
            }
        }
    }

    dv.paragraph(`Access Requests (Last ${reportingPeriodDays} Days):`);
    dv.list([
        `Granted: **${grantedCount}**`,
        `Revoked: **${revokedCount}**`
    ]);
    ```
    **Note:** Tracking "revoked" access might be more complex. A request might be granted and then later a *separate* action revokes it. This query assumes a simplified model where a request itself can end up in a "revoked" status or a similar terminal state indicating revocation within the period. A more robust system might involve linking revocation actions to original grant requests.

### E2. List of Resources with L2 Classification Requiring Access Approval

*   **Purpose:** To identify highly sensitive resources (classified L2) that typically require an approval process for access, helping in audits and reviews of access controls.
*   **Operator Variables:**
    *   `RESOURCE_DEFINITION_TYPE`: The `type` field for notes defining resources (e.g., `type: "resource_definition"` or `type: "system_asset"`). Assuming `type: "resource"` for this example.
    *   `CLASSIFICATION_FIELD`: `classification`.
    *   `L2_CLASSIFICATION_VALUE`: `"L2"`.
    *   `REQUIRES_APPROVAL_FIELD` (Optional): A boolean field like `requires_access_approval: true`. If not present, the query could just list all L2 resources.

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Resource",
        classification AS "Classification",
        owner AS "Owner/Custodian (if available)" 
        // Add other relevant fields like 'data_type' or 'description'
    FROM "" // Or specify a folder like "systems/resources/"
    WHERE type = "resource" AND classification = "L2" 
        // AND requires_access_approval = true // Uncomment if you have this explicit field
    SORT file.name ASC
    ```

---

## F. Document Review and Compliance Metrics

### F1. Documents Overdue for Review

*   **Purpose:** To list all documents that have passed their `next_review_date` and need attention.
*   **Operator Variables:**
    *   `DOCUMENT_TYPE_TAGS`: A list of types or tags identifying reviewable documents (e.g., `type: "policy"`, `type: "procedure"`, or a tag like `#document/reviewable`).
    *   `NEXT_REVIEW_DATE_FIELD`: `next_review_date`.
    *   `DATE_FORMAT`: Assumed YYYY-MM-DD.

*   **Dataview Query (DQL):**
    ```dataview
    TABLE WITHOUT ID
        file.link AS "Document",
        next_review_date AS "Next Review Date",
        classification AS "Classification",
        owner AS "Owner (if available)"
    FROM "" // Or specify relevant folders like "policies/" OR #document/reviewable
    WHERE (type = "policy" OR type = "procedure" OR contains(file.tags, "#document/reviewable")) 
        AND next_review_date AND date(next_review_date) < date(today)
    SORT date(next_review_date) ASC
    ```

### F2. Count of Documents by Classification Not Reviewed in Last Year

*   **Purpose:** To identify how many documents, grouped by their classification, have not had a review logged in the `review_date` field within the last 365 days. This helps ensure that even documents without a set `next_review_date` are periodically checked.
*   **Operator Variables:**
    *   `DOCUMENT_TYPE_TAGS`: As above.
    *   `REVIEW_DATE_FIELD`: `review_date`.
    *   `CLASSIFICATION_FIELD`: `classification`.
    *   `REPORTING_PERIOD_DAYS`: 365.

*   **Dataview Query (DQL with DataviewJS for date logic):**
    ```dataviewjs
    const pages = dv.pages('type = "policy" OR type = "procedure" OR #document/reviewable'); // Adjust source
    const reportingPeriodDays = 365; // Operator Variable
    const cutoffDate = dv.date('today').minus(dv.duration(reportingPeriodDays + " days"));
    
    const unreviewedCounts = {
        "L0": 0,
        "L1": 0,
        "L2": 0,
        "Unclassified": 0 // For documents that might miss the classification field
    };

    for (let page of pages) {
        let reviewed = false;
        if (page.review_date) {
            let reviewDate = dv.date(page.review_date);
            if (reviewDate && reviewDate >= cutoffDate) {
                reviewed = true;
            }
        }
        
        if (!reviewed) {
            let classification = page.classification || "Unclassified";
            if (unreviewedCounts.hasOwnProperty(classification)) {
                unreviewedCounts[classification]++;
            } else {
                // If you have other classification values, they would be grouped under 'Unclassified'
                // or you could expand the unreviewedCounts object.
                unreviewedCounts["Unclassified"]++; 
            }
        }
    }

    dv.header(3, `Documents Not Reviewed in Last ${reportingPeriodDays} Days (by Classification)`);
    const output = [];
    for (const classification in unreviewedCounts) {
        if (unreviewedCounts.hasOwnProperty(classification)) {
            output.push([classification, unreviewedCounts[classification]]);
        }
    }
    dv.table(["Classification", "Count"], output);
    ```

This completes the drafting of queries for metrics D, E, and F. Each query aims to provide actionable insights based on the defined metadata structure. Users will need to adjust **Operator Variables** and potentially the query sources (`FROM` clauses) to match their specific Obsidian vault setup.
```
