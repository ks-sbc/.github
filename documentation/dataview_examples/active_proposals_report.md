# Active Proposals Report

This report lists all project proposals that are currently in 'draft' or 'under-review' status.

```dataview
TABLE title, proposer, submission_date, status, related_issue
FROM #proposal
WHERE status = "draft" OR status = "under-review"
SORT submission_date DESC
```

**Assumptions:**
- Documents tagged with `#proposal`.
- Frontmatter field `status` can be "draft" or "under-review".
- Frontmatter fields `title`, `proposer`, `submission_date`, `related_issue` exist.
