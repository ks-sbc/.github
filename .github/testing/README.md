# GitHub Workflows Testing

This directory contains testing resources for the KS-SBC GitHub Actions workflows.

## Contents

- **workflow-testing-guide.md** - Comprehensive testing procedures and documentation
- **test-workflows.sh** - Automated test script for workflow validation
- **test-events/** - Sample event payloads for local testing with `act`

## Quick Start

### 1. Prerequisites
```bash
# Install GitHub CLI
brew install gh  # macOS
# or see https://cli.github.com for other platforms

# Authenticate
gh auth login

# (Optional) Install act for local testing
brew install act
```

### 2. Run Automated Tests
```bash
# Make script executable
chmod +x test-workflows.sh

# Run test menu
./test-workflows.sh
```

### 3. Manual Testing
Follow the procedures in `workflow-testing-guide.md` for comprehensive testing.

### 4. Local Testing with act
```bash
# Test specific workflow with event
act issues -W ../.github/workflows/reports/process-mass-report.yml \
  --eventpath test-events/issue-opened.json

# Test with secrets (create .secrets file first)
act --secret-file .secrets
```

## Test Coverage

The testing suite covers:

- ✅ Report Processing (Mass, Cadre, CSC, Security)
- ✅ Education Workflows (Study Sessions, Reminders)
- ✅ Democratic Centralist Automation
  - Proposal Voting
  - Decision Tracking
  - Action Item Creation
  - Meeting Automation
  - Accountability Reporting
- ✅ Security Classification
- ✅ Cross-repository Operations

## Important Notes

1. **Always test in a non-production environment first**
2. **Clean up test data after testing**
3. **Document any issues found**
4. **Never commit real secrets or sensitive data**

## Troubleshooting

See the troubleshooting section in `workflow-testing-guide.md` for common issues and solutions.

## Support

For questions or issues, contact the DRUIDS technical team or post in the development discussions.