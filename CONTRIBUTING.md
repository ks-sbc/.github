# Contributing to KSBC

Thank you for your interest in contributing to the Kansas Socialist Book Club's repositories. This document outlines our contribution process, which follows democratic centralist principles.

## Table of Contents
- [Democratic Centralist Workflow](#democratic-centralist-workflow)
- [Security Classification System](#security-classification-system)
- [Getting Started](#getting-started)
- [Contribution Process](#contribution-process)
- [Commit Guidelines](#commit-guidelines)
- [Documentation Standards](#documentation-standards)
- [Review Process](#review-process)
- [Code of Conduct](#code-of-conduct)

## Democratic Centralist Workflow

Our contribution process follows a democratic centralist model:

1. **Discussion Phase**: Open and thorough discussion of issues and proposals
2. **Decision Phase**: Formal decision through democratic process
3. **Implementation Phase**: Unified action to implement decisions
4. **Review Phase**: Critical evaluation of implementation

Once a decision has been made through proper channels, all members are expected to work toward its implementation regardless of their position during the discussion phase.

## Security Classification System

We operate with a three-tier security classification system:

### Public (L0)
- General educational content and resources
- Available in public repositories
- Can be shared freely

### Candidate (L1)
- Development materials for potential cadre
- Limited to contributors with appropriate clearance
- Not for public distribution

### Cadre (L2)
- Strategic and operational documentation
- Strict need-to-know basis
- Highly restricted access

**Always verify the appropriate security classification before contributing content.**

## Getting Started

1. **Familiarize yourself with our structure**:
   - Review our repositories and documentation
   - Understand our democratic centralist workflow
   - Learn about our security model

2. **Set up your environment**:
   - Install Obsidian with required plugins
   - Configure standard linting and formatting rules
   - Set up Git with appropriate credentials

3. **Understand our standards**:
   - Review documentation templates
   - Familiarize yourself with our YAML frontmatter requirements
   - Learn our tag taxonomy

## Contribution Process

### 1. Identify an Area for Contribution

Before creating a proposal or implementation issue, determine:
- The political need being addressed
- The appropriate security classification
- The relevant committee for review

### 2. Create an Issue

Use the appropriate issue template:
- **Proposal**: For new ideas requiring discussion
- **Implementation**: For executing approved proposals
- **Documentation**: For improvements to existing documentation
- **Criticism**: For constructive criticism of existing work

### 3. Branch Creation

Branches follow our naming conventions:
- `proposal/[issue-topic]`: For proposal development
- `implement/[issue-topic]`: For implementation work
- `contributor/[username]`: For personal development work

### 4. Development Work

When working on content:
- Follow our documentation standards
- Include appropriate frontmatter with security classification
- Use the established tag taxonomy
- Run linting tools before submission

### 5. Pull Request

Submit your work using the appropriate PR template:
- Link to the original issue
- Summarize the changes
- Indicate the security classification
- Request review from appropriate committee(s)

## Commit Guidelines

All commits should follow this format:
```
[TYPE]: Short summary (50 chars or less)

More detailed explanatory text, if necessary. Wrap to about 72
characters. The blank line separating the summary from the body
is critical.

Closes #123
```

Types include:
- `[DOCS]`: Documentation changes
- `[PROP]`: Proposal development
- `[IMPL]`: Implementation of approved proposal
- `[CRIT]`: Criticism or self-criticism
- `[TECH]`: Technical infrastructure changes

## Documentation Standards

All documentation must include:

1. **YAML Frontmatter**:
   ```yaml
   ---
   title: "Document Title"
   date: YYYY-MM-DD
   lastmod: YYYY-MM-DD
   draft: boolean
   security_classification: "public|candidate|cadre"
   version: "X.Y.Z"
   document_id: "DEPT-TYPE-YEARSEQ-SECURITY"
   tags:
     - type/document-type
     - security/level
     - function/area
     - status/draft
   ---
   ```

2. **Standard Headers**:
   - H1 for document title
   - H2 for major sections
   - H3 for subsections
   - Proper heading incrementing

3. **Security Markings**:
   - Each section should indicate its security level: `## Section Title (L0)`
   - Higher classification sections must come after lower ones

## Review Process

1. **Initial Review**: Technical validation of format, structure, and security
2. **Committee Review**: Evaluation by appropriate committee(s)
3. **Feedback Phase**: Contributors address feedback
4. **Approval**: Formal acceptance through committee decision
5. **Implementation**: Merging into appropriate branch

Reviewers will check for:
- Political alignment with organizational principles
- Technical correctness and standards compliance
- Security classification appropriateness
- Documentation quality and completeness

## Code of Conduct

All contributors are expected to follow our [Code of Conduct](CODE_OF_CONDUCT.md), which emphasizes:
- Comradely behavior
- Constructive criticism
- Political development
- Collective accountability

## Questions?

If you have questions about contributing, please:
1. Check existing documentation
2. Review past issues and discussions
3. Create a new issue using the "question" template
4. Reach out to the appropriate committee

Thank you for contributing to our collective work!
