# GitHub Workflow Testing Guide for KS-SBC .github Repository

**Document Version:** 1.0  
**Date:** 2024-08-01  
**Purpose:** This document provides comprehensive testing procedures for the GitHub Actions workflows implemented in the KS-SBC .github repository, ensuring all automation supports democratic centralist principles and organizational efficiency.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Testing Environment Setup](#testing-environment-setup)
3. [Workflow Test Procedures](#workflow-test-procedures)
   - [Report Processing Workflows](#report-processing-workflows)
   - [Education Workflows](#education-workflows)
   - [Democratic Centralist Workflows](#democratic-centralist-workflows)
4. [Integration Testing](#integration-testing)
5. [Test Data Management](#test-data-management)
6. [Troubleshooting](#troubleshooting)
7. [Test Result Documentation](#test-result-documentation)

---

## Prerequisites

### Required Access
- **Repository Permissions**: Write access to the test repository
- **Team Memberships**: Member of relevant teams (@cadre, @education-committee, @security-committee)
- **GitHub CLI**: Installed and authenticated (`gh auth login`)
- **Secrets Configuration**:
  - `REPO_ACCESS_TOKEN` - Personal access token with repo scope
  - Team assignments configured in repository settings

### Tools Required
- GitHub CLI (`gh`) - [Installation guide](https://cli.github.com/)
- Git command line tools
- Text editor for creating test files
- (Optional) `act` for local testing - [Installation guide](https://github.com/nektos/act)

### Knowledge Requirements
- Basic understanding of GitHub Actions
- Familiarity with YAML syntax
- Understanding of KS-SBC organizational structure
- Knowledge of democratic centralist principles

---

## Testing Environment Setup

### 1. Create Test Repository (Optional)
For safe testing without affecting production:

```bash
# Fork the repository
gh repo fork ks-sbc/.github --clone

# Navigate to the forked repo
cd .github

# Set up upstream
git remote add upstream https://github.com/ks-sbc/.github.git
```

### 2. Enable GitHub Actions
1. Go to Settings → Actions → General
2. Select "Allow all actions and reusable workflows"
3. Under "Workflow permissions", select "Read and write permissions"
4. Save changes

### 3. Configure Required Secrets
```bash
# Add repository access token
gh secret set REPO_ACCESS_TOKEN --body "$YOUR_PAT"
```

### 4. Create Test Teams (if using test repo)
```bash
# Create required teams
gh api /orgs/{org}/teams -X POST -f name="cadre" -f privacy="closed"
gh api /orgs/{org}/teams -X POST -f name="education-committee" -f privacy="closed"
gh api /orgs/{org}/teams -X POST -f name="security-committee" -f privacy="closed"
```

---

## Workflow Test Procedures

### Report Processing Workflows

#### Test Case: Mass Conditions Report Processing

**File:** `.github/workflows/reports/process-mass-report.yml`  
**Purpose:** Validate automatic processing and security classification of mass reports

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Create L0 Report** | 1. Run: `gh issue create --template mass-conditions-report.yml` <br> 2. Fill template with: <br> - Title: "[MASS REPORT] Downtown conditions" <br> - Security: L0 (Public) <br> - Location: "Downtown District" <br> - Conditions: "Rising rent prices affecting workers" | - Issue created with label `type:mass-report` <br> - Workflow triggers automatically | [ ] | |
| **2. Verify Processing** | Check Actions tab for workflow run | - Workflow completes successfully <br> - Security label `security:L0` added <br> - Location label added <br> - Processing comment posted | [ ] | |
| **3. Create L1 Report** | Create another report with L1 classification | - Security label `security:L1` added <br> - Different routing applied | [ ] | |

#### Test Case: Cadre Work Report Processing

**File:** `.github/workflows/reports/process-cadre-report.yml`  
**Purpose:** Validate cadre report processing and committee routing

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Create Report** | `gh issue create --template cadre-work-report.yml` <br> Select committee: "Education" | - Issue created with `type:cadre-report` <br> - Workflow triggers | [ ] | |
| **2. Verify Routing** | Check issue labels and assignees | - Committee label added <br> - Assigned to committee secretary | [ ] | |

### Education Workflows

#### Test Case: Study Session Scheduling

**File:** `.github/workflows/education/schedule-study-sessions.yml`  
**Purpose:** Validate bi-weekly study session creation

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Manual Trigger** | `gh workflow run schedule-study-sessions.yml -f session_date_override="2024-08-06" -f create_tuesday=true` | - Workflow runs successfully <br> - Creates session for specified date | [ ] | |
| **2. Verify Issue** | `gh issue list --label "type:study-session"` | - Study session issue created <br> - Correct date and materials assigned <br> - Zoom link placeholder included | [ ] | |
| **3. Test Rotation** | Run workflow multiple times | - Different study materials each time <br> - Follows rotation schedule | [ ] | |

#### Test Case: Study Session Reminders

**File:** `.github/workflows/education/study-session-reminder.yml`  
**Purpose:** Validate reminder notifications

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Create Session** | Create study session for tomorrow | - Session issue exists | [ ] | |
| **2. Trigger Reminder** | `gh workflow run study-session-reminder.yml` | - Reminder comment posted <br> - Notification sent (if configured) | [ ] | |

### Democratic Centralist Workflows

#### Test Case: Proposal Voting

**File:** `.github/workflows/demcent/proposal-voting.yml`  
**Purpose:** Validate democratic voting process

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Create Proposal** | 1. `git checkout -b proposal/test-voting` <br> 2. Make changes and commit <br> 3. `gh pr create --title "Test Proposal"` | - PR created <br> - Voting comment posted <br> - Labels applied | [ ] | |
| **2. Cast Votes** | Add comments: <br> - "VOTE: FOR" <br> - "VOTE: AGAINST" <br> - "VOTE: ABSTAIN" | - Votes acknowledged with reactions <br> - Only authorized users can vote | [ ] | |
| **3. Check Results** | Wait for deadline or manually trigger | - Results tallied <br> - Decision label applied <br> - PR approved/rejected based on outcome | [ ] | |

#### Test Case: Decision Tracking

**File:** `.github/workflows/demcent/track-decisions.yml`  
**Purpose:** Validate decision implementation tracking

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Merge Decision** | 1. Label PR with `decision:approved` <br> 2. Merge PR | - Implementation issue created <br> - Links back to original PR | [ ] | |
| **2. Weekly Check** | `gh workflow run track-decisions.yml` | - Accountability report generated <br> - Overdue items flagged | [ ] | |

#### Test Case: Action Item Extraction

**File:** `.github/workflows/demcent/create-action-items.yml`  
**Purpose:** Validate automatic task creation from decisions

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Create Decision** | Create issue with: <br> `ACTION: Review security protocols @security-team due:2024-08-15` | - Workflow triggers <br> - Action item issue created | [ ] | |
| **2. Verify Details** | Check created action item | - Correct assignee <br> - Due date set <br> - Links to source | [ ] | |

#### Test Case: Meeting Automation

**File:** `.github/workflows/demcent/meeting-automation.yml`  
**Purpose:** Validate meeting agenda generation

| Test Step | Actions | Expected Result | Pass/Fail | Notes |
|-----------|---------|-----------------|-----------|-------|
| **1. Generate Agenda** | `gh workflow run meeting-automation.yml -f meeting_type="general-body"` | - Meeting issue created <br> - Dynamic agenda based on pending items | [ ] | |
| **2. Verify Content** | Review meeting issue | - All pending items included <br> - Time estimates calculated <br> - Minutes template provided | [ ] | |

---

## Integration Testing

### End-to-End Scenarios

#### Scenario 1: Complete Report Flow
1. Create mass conditions report (L1)
2. Verify security classification
3. Check routing to appropriate repository
4. Confirm tracking in project board

#### Scenario 2: Decision Implementation
1. Create proposal PR
2. Complete voting process
3. Merge decision
4. Verify implementation tracking
5. Check action item creation
6. Review in accountability report

#### Scenario 3: Meeting Cycle
1. Generate meeting agenda
2. Add discussion items
3. Complete meeting (close issue)
4. Verify minutes archival
5. Check action item creation

---

## Test Data Management

### Creating Test Data

```bash
# Create test labels
gh label create "test-label" --description "For testing only"

# Create test issues
for i in {1..5}; do
  gh issue create --title "Test Issue $i" --body "Test content" --label "test-label"
done

# Create test branches
git checkout -b test/workflow-testing
echo "test" > test.txt
git add test.txt
git commit -m "Test commit"
git push origin test/workflow-testing
```

### Cleaning Test Data

```bash
# Close test issues
gh issue list --label "test-label" --json number --jq '.[].number' | \
  xargs -I {} gh issue close {}

# Delete test branches
git push origin --delete test/workflow-testing

# Remove test labels
gh label delete "test-label" --yes
```

---

## Troubleshooting

### Common Issues and Solutions

| Issue | Possible Cause | Solution |
|-------|---------------|----------|
| Workflow doesn't trigger | Incorrect trigger conditions | Check workflow logs, verify branch/path filters |
| Permission denied | Missing secrets or permissions | Verify REPO_ACCESS_TOKEN, check team memberships |
| Label not found | Label doesn't exist | Run setup-labels.yml workflow first |
| Team assignment fails | Team doesn't exist or no permission | Create teams or adjust permissions |
| Scheduled workflows don't run | Cron syntax or timezone issue | Verify cron expression, check UTC time |

### Debugging Commands

```bash
# View workflow runs
gh run list --limit 10

# View specific run details
gh run view <run-id>

# Download workflow logs
gh run download <run-id>

# Re-run failed workflow
gh run rerun <run-id>

# View workflow file
gh workflow view <workflow-name>
```

### Local Testing with act

```bash
# Test specific workflow
act -W .github/workflows/education/schedule-study-sessions.yml

# Test with specific event
act issues -W .github/workflows/reports/process-mass-report.yml \
  --eventpath test-events/issue-opened.json

# Test with secrets
act --secret-file .secrets
```

---

## Test Result Documentation

### Test Summary Template

```markdown
## Workflow Testing Summary

**Test Date:** YYYY-MM-DD  
**Tester:** [Name]  
**Environment:** [Production/Test]  

### Test Results

| Workflow | Version | Tests Passed | Tests Failed | Notes |
|----------|---------|--------------|--------------|-------|
| process-mass-report.yml | 1.0 | 3/3 | 0/3 | All security levels tested |
| schedule-study-sessions.yml | 1.0 | 2/3 | 1/3 | Manual trigger failed, investigating |

### Issues Found

1. **Issue:** [Description]
   - **Severity:** High/Medium/Low
   - **Steps to Reproduce:** [Steps]
   - **Expected:** [Expected behavior]
   - **Actual:** [Actual behavior]
   - **Resolution:** [Status/Fix]

### Recommendations

- [Recommendation 1]
- [Recommendation 2]

### Sign-off

- [ ] All critical workflows tested
- [ ] No blocking issues remain
- [ ] Documentation updated
- [ ] Ready for production

**Approved by:** _______________  
**Date:** _______________
```

---

## Appendix: Quick Reference

### Useful GitHub CLI Commands

```bash
# Workflow management
gh workflow list
gh workflow run <workflow> [flags]
gh workflow view <workflow>
gh workflow disable <workflow>
gh workflow enable <workflow>

# Issue management  
gh issue create --template <template>
gh issue list --label <label>
gh issue view <number>
gh issue edit <number> --add-label <label>

# PR management
gh pr create --title <title> --body <body>
gh pr list --label <label>
gh pr merge <number>
gh pr close <number>

# Label management
gh label create <name> --description <desc>
gh label list
gh label delete <name>
```

### Workflow Triggers Reference

| Workflow | Trigger Type | Schedule/Event |
|----------|-------------|----------------|
| schedule-study-sessions | schedule, workflow_dispatch | Tue/Fri 10 AM UTC |
| process-mass-report | issues | opened, labeled |
| proposal-voting | pull_request, schedule | opened, daily 9 AM |
| track-decisions | pull_request, schedule | closed, Mon 9 AM |
| accountability-report | schedule, workflow_dispatch | Mon 8 AM UTC |
| meeting-automation | schedule, workflow_dispatch | Fri 5 PM, Sun 12 PM |

---

*This testing guide is a living document. Please report any issues or suggestions for improvement to the DRUIDS technical team.*