# Contributing to KSBC

Thank you for your interest in contributing to the Kansas Socialist Book Club! We follow democratic centralist principles where all members can participate in discussion, and we act unified after decisions are made.

## 🌟 Getting Started

### Prerequisites
1. GitHub account with [two-factor authentication enabled](https://github.com/settings/security)
2. Git installed locally
3. Familiarity with our [Key Principles](#key-principles)
4. Review our [Code of Conduct](CODE_OF_CONDUCT.md)

### Key Principles
- **Democratic Centralism**: Free discussion, unified action
- **Mass Line**: From the masses, to the masses
- **Criticism & Self-Criticism**: Continuous improvement
- **Security Consciousness**: Respect classification levels

## 🔄 Contribution Workflow

### 1. Find or Create an Issue
- Check existing issues in the relevant repository
- For new ideas, create a discussion first in [.github Discussions](https://github.com/ks-sbc/.github/discussions)
- Once consensus reached, create an issue with FULL metadata

### 2. Create Issues with Complete Metadata

**REQUIRED for ALL issues:**

```bash
gh issue create -R ks-sbc/[REPO] \
  --title "Clear, specific title" \
  --label "type:task,priority:p3,status:todo,time:M,security:public,issue:tech:github" \
  --milestone "Tech Infrastructure" \
  --body "$(cat <<'EOF'
## Description
[Clear description of the task/issue]

## Related Issues
- Parent: #XX (if applicable)
- Related to: #YY

## Acceptance Criteria
- [ ] Specific measurable outcome
- [ ] Another specific outcome

## Implementation Notes
[Technical details or considerations]
EOF
)"

# Then add to project
gh project item-add 12 --owner ks-sbc --url [ISSUE_URL]
```

**Label Requirements:**
- **Type** (required): `type:task`, `type:document`, `type:training`, `type:event`, `type:reference`, `type:theory`
- **Priority** (required): `priority:p0` through `priority:p5` (p5 = most urgent)
- **Status** (required): `status:todo`, `status:doing`, `status:review`, `status:blocked`, `status:done`
- **Time** (required): `time:XS` (0-15min), `time:S` (15-60min), `time:M` (1-3hr), `time:L` (3-8hr), `time:XL` (8+hr)
- **Security** (if applicable): `security:public`, `security:candidate`, `security:cadre`
- **Technical area** (if applicable): `issue:tech:github`, `issue:tech:obsidian`, etc.

### 3. Work on Your Contribution

#### Clone and Branch
```bash
# Clone the repository
git clone https://github.com/ks-sbc/[REPOSITORY].git
cd [REPOSITORY]

# Create a feature branch
git checkout -b [ISSUE_NUMBER]-brief-description
```

#### Make Your Changes
- Follow repository-specific guidelines (see below)
- Write clear, purposeful commit messages
- Include issue number in commits: `fix: resolve auth bug (#123)`
- Test your changes thoroughly

#### Commit with Metadata
```bash
# Stage your changes
git add .

# Commit with clear message
git commit -m "type: clear description (#ISSUE_NUMBER)

Detailed explanation of what changed and why.

Resolves #ISSUE_NUMBER"
```

### 4. Submit Pull Request

#### Push Your Branch
```bash
git push origin [ISSUE_NUMBER]-brief-description
```

#### Create PR with Template
```bash
gh pr create \
  --title "type: clear description (#ISSUE_NUMBER)" \
  --body "$(cat <<'EOF'
## Summary
Brief description of changes

## Related Issues
Resolves #ISSUE_NUMBER

## Type of Change
- [ ] Bug fix (non-breaking change)
- [ ] New feature (non-breaking change)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] Added new tests for changes
- [ ] Updated documentation

## Security Classification
- [ ] Changes maintain appropriate security levels
- [ ] No sensitive information exposed

## Checklist
- [ ] Code follows repository style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No merge conflicts
EOF
)"
```

### 5. Review Process
- CODEOWNERS automatically assigns reviewers
- Address review feedback promptly
- Maintain respectful discussion
- Once approved, maintainers will merge

## 📚 Repository-Specific Guidelines

### `.github` Repository
- Changes to organization-wide policies require Steering Committee review
- Template changes need testing in multiple contexts
- Workflow changes must include documentation

### `public-repo` Repository  
- Use Obsidian templates from `_templates/`
- Include security classification in frontmatter
- Follow naming conventions for document types
- Test that documents render correctly

### `os` Repository
- Follow Tails development guidelines
- Include tests for new features
- Update documentation in `/wiki/src/`
- Ensure changes work in offline mode

### `quartz-website` Repository
- Test builds locally with `npm run build`
- Verify only L0 content is published
- Check responsive design
- Follow Neobrutalist style guide

## 🛡️ Security Considerations

### Classification Levels
- **L0 (Public)**: Educational materials, public statements
- **L1 (Candidate)**: Member resources, development docs
- **L2 (Cadre)**: Strategic planning, sensitive operations

### Security Best Practices
- Never commit secrets or credentials
- Respect document classification levels
- Report security issues via [SECURITY.md](SECURITY.md)
- Use GPG signing for sensitive commits

## 🤝 Community

### Getting Help
- Check repository documentation and README files
- Search existing issues and discussions
- Ask in [GitHub Discussions](https://github.com/ks-sbc/.github/discussions)
- Reference our [guides](/) for common tasks

### Code of Conduct
We follow our [Code of Conduct](CODE_OF_CONDUCT.md). Key points:
- Respectful communication
- Constructive criticism
- Solidarity with all oppressed peoples
- No tolerance for oppressive behavior

## 🎯 What We Need

### High Priority Contributions
1. Documentation improvements
2. Test coverage increases
3. Accessibility enhancements
4. Security reviews
5. Template development

### Good First Issues
Look for issues labeled `good-first-issue` or `help-wanted`

## 📋 Development Setup

### General Requirements
```bash
# Install Git
sudo apt-get install git

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Install GitHub CLI
sudo apt-get install gh

# Authenticate
gh auth login
```

### Repository-Specific Setup
Each repository has specific setup instructions in its README.md

## ✅ Pull Request Checklist

Before submitting a PR, ensure:
- [ ] Issue exists with full metadata
- [ ] Branch follows naming convention
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] PR template completed
- [ ] No merge conflicts
- [ ] Security classification respected

## 📊 Recognition

Contributors are recognized through:
- Commit history (permanent record)
- CONTRIBUTORS.md file updates  
- Issue/PR assignments
- Committee membership eligibility

---

*Thank you for contributing to building revolutionary organizational memory! Your work helps ensure our movement survives and thrives beyond any individual participant.*