# Cadre Documents Overview

This report lists all documents classified with `security: "cadre"` in their frontmatter.

```dataview
TABLE title, created, tags, issue
FROM "" // Searches all notes in the vault
WHERE security = "cadre"
SORT created DESC
```

**Assumptions:**
- Documents have a `security` field in their YAML frontmatter set to "cadre".
- Frontmatter fields `title`, `created`, `tags`, `issue` may exist.
