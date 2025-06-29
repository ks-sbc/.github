---
name: Staging to Main Release
about: Merge staging branch changes to main (maintainers only)
---

## Release Summary

**Release Type:**
- [ ] Regular release (feature bundle)
- [ ] Hotfix release (critical fixes only)
- [ ] Major release (breaking changes)

**Included PRs:** 
<!-- List PR numbers merged to staging since last release -->
- #
- #

## Pre-Merge Checklist

### Testing Status
- [ ] All workflows pass on staging
- [ ] Integration tests complete
- [ ] No known regressions

### Security Review
- [ ] No secrets or credentials exposed
- [ ] Security classifications validated
- [ ] Access controls verified

### Documentation
- [ ] CHANGELOG.md updated
- [ ] Breaking changes documented
- [ ] Wiki documentation current

## Merge Strategy

**Selected Strategy:** Squash and merge

**Commit Message:**
```
chore: Release staging to main - [Brief description]

Includes:
- Feature: Brief description (#PR)
- Fix: Brief description (#PR)
- Docs: Brief description (#PR)

See staging branch for detailed history
```

## Post-Merge Actions
- [ ] Tag release if applicable
- [ ] Deploy to production
- [ ] Notify teams of changes
- [ ] Archive completed issue references

---
**Note:** This PR should only be created by maintainers after staging validation is complete.