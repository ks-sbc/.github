# Pending Action Items Report

This report lists all incomplete action items (tasks) from notes tagged with `#meeting-notes`, grouped by the meeting note.

```dataview
TASK
FROM #meeting-notes
WHERE !completed
GROUP BY file.link
SORT date ASC
```

**Assumptions:**
- Documents tagged with `#meeting-notes`.
- Tasks are in the standard format recognized by the Tasks plugin and Dataview (e.g., `- [ ] Task description`).
