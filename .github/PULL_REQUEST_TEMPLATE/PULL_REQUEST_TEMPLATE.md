---
name: DRUIDS Pull Request
about: Democratic centralist PR workflow for DRUIDS system changes
---

<!-- 
This PR template supports the DRUIDS democratic centralist workflow.
For PRs drafted in Obsidian: Check the "Obsidian-Git Workflow Notes" section
For proposal branches: Focus on the "Proposal Details" section
For implementation branches: Complete all sections
-->

## Branch Type and Security Classification

**Branch Type**: 
- [ ] `proposal/*` - Democratic discussion and deliberation
- [ ] `implement/*` - Executing decided work
- [ ] `contributor/*` - Personal development
- [ ] `hotfix/*` - Critical security or bug fixes

**Security Classification**:
- [ ] L0 (Public) - Educational materials, public statements
- [ ] L1 (Member) - Internal documentation, development resources
- [ ] L2 (Cadre) - Strategic planning (requires special handling)

## Description

<!-- For Obsidian users: This section can be drafted in your vault and copied here -->
<!-- Include motivation, context, and link to any proposal discussions -->

### Summary of Changes
<!-- Brief overview of what this PR accomplishes -->

### Related Issues/Proposals
- Fixes #
- Implements proposal #
- Related to discussion #

## Proposal Details (For `proposal/*` branches)

### Democratic Process Stage
- [ ] Stage 1: Proposal Creation
- [ ] Stage 2: Submission for Review
- [ ] Stage 3: Democratic Discussion
- [ ] Stage 4: Decision Making
- [ ] Stage 5: Implementation Planning
- [ ] Stage 6: Evaluation Criteria

### Proposal Metadata
```yaml
proposal_id: # e.g., PROP-2024-001
author: # GitHub username or pseudonym
date_proposed: # YYYY-MM-DD
voting_deadline: # YYYY-MM-DD
min_approvals_required: # Usually 2-3 for proposals
```

### Voting Record
<!-- Updated as reviews come in -->
| Member | Vote | Comments |
|--------|------|----------|
| @reviewer1 | ⬜ Pending | |
| @reviewer2 | ⬜ Pending | |

## Implementation Details (For `implement/*` branches)

### Type of Change
- [ ] Bug fix (non-breaking)
- [ ] New feature (non-breaking)
- [ ] Breaking change
- [ ] Documentation update
- [ ] Security enhancement
- [ ] Workflow automation
- [ ] Infrastructure change

### Implementation Checklist
- [ ] Links to approved proposal PR: #
- [ ] Implements agreed-upon specifications
- [ ] Maintains backward compatibility (or documents breaking changes)
- [ ] Includes necessary migrations or upgrade paths

## Testing and Validation

### Local Testing (Obsidian Environment)
- [ ] Changes work correctly in Obsidian
- [ ] Obsidian-Git syncs without conflicts
- [ ] Security classifications are maintained

### GitHub Actions Testing
- [ ] Workflows pass with `act` local testing
- [ ] CI/CD pipelines pass
- [ ] Security validation checks pass

### Test Details
```bash
# Commands used for testing
# Include act commands, pytest results, etc.
```

## Documentation and Communication

### Documentation Updates
- [ ] README.md updated (if needed)
- [ ] Wiki documentation updated
- [ ] API/Interface changes documented
- [ ] Security implications documented

### Member Communication
- [ ] Changes announced in appropriate channels
- [ ] Training materials updated (if needed)
- [ ] Migration guide provided (for breaking changes)

## Democratic Centralist Principles Adherence

### TPPS Cycle Alignment
Explain how this change supports the Theory → Plan → Practice → Summation cycle:
- **Theory**: What theoretical understanding does this implement?
- **Plan**: How does this fit into our strategic plans?
- **Practice**: What practical problem does this solve?
- **Summation**: How will we evaluate success?

### Collective Benefit
- [ ] Enhances democratic participation
- [ ] Improves security and compartmentalization
- [ ] Facilitates member development
- [ ] Strengthens organizational unity

## Security and Compliance

### Security Checklist
- [ ] No hardcoded secrets or credentials
- [ ] Proper access controls implemented
- [ ] Security tier boundaries respected
- [ ] Audit logging included where appropriate

### Pre-merge Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added and passing
- [ ] Documentation updated
- [ ] No new warnings or errors
- [ ] Approved by required reviewers
- [ ] Proposal vote passed (if applicable)

## Obsidian-Git Workflow Notes

<!-- For PRs initiated from Obsidian -->
**Obsidian Draft Origin**: <!-- e.g., vault/member/.github/pr-queue/2024-01-15-feature.md -->
**Draft Template Used**: <!-- OBSIDIAN_PR_DRAFT.md or custom -->
**Meta Bind Export**: <!-- Yes/No - was this exported via Meta Bind? -->
**Sync Method**: <!-- manual commit, auto-sync, PR queue -->

---

<!-- 
For maintainers: 
- Check if PR was drafted in Obsidian (see workflow notes)
- Ensure proper branch protections are enabled
- Verify security classifications match repository
- Check proposal approval before merging implementation
- For Obsidian-originated PRs, verify the draft was properly validated
-->