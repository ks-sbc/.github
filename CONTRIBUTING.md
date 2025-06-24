# Contributing to DRUIDS

Thank you for your interest in contributing to the Kansas Socialist Book Club's Distributed, Reproducible, Unifying, Ideological Documentation System (DRUIDS). This document outlines our contribution process, which follows democratic centralist principles and welcomes contributions from people with all levels of technical expertise.

## Table of Contents
- [Contributing to DRUIDS](#contributing-to-druids)
  - [Table of Contents](#table-of-contents)
  - [Democratic Centralist Workflow](#democratic-centralist-workflow)
  - [Security Classification System](#security-classification-system)
    - [Public (L0)](#public-l0)
    - [Candidate (L1)](#candidate-l1)
    - [Cadre (L2)](#cadre-l2)
  - [Getting Started](#getting-started)
  - [Technical Contributions](#technical-contributions)
  - [Non-Technical Contributions](#non-technical-contributions)
    - [Documentation \& Content Creation](#documentation--content-creation)
    - [Testing \& User Experience](#testing--user-experience)
    - [Organization \& Metadata](#organization--metadata)
    - [Training Materials](#training-materials)
  - [Contribution Process](#contribution-process)
    - [1. Identify an Area for Contribution](#1-identify-an-area-for-contribution)
    - [2. Create an Issue](#2-create-an-issue)
    - [3. Branch Creation](#3-branch-creation)
    - [4. Development Work](#4-development-work)
    - [5. Pull Request](#5-pull-request)
  - [Commit Guidelines](#commit-guidelines)
  - [Documentation Standards](#documentation-standards)
  - [Review Process](#review-process)
  - [Code of Conduct](#code-of-conduct)
  - [🎯 What We Need](#-what-we-need)
    - [High Priority Contributions](#high-priority-contributions)
    - [Good First Issues](#good-first-issues)
  - [📋 Development Setup](#-development-setup)
    - [General Requirements](#general-requirements)
    - [Repository-Specific Setup](#repository-specific-setup)
  - [✅ Pull Request Checklist](#-pull-request-checklist)
  - [📊 Recognition](#-recognition)

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

## Technical Contributions

If you have technical skills, consider helping with:

- GitHub Actions workflow development
- Obsidian plugin configuration and scripting
- Security model implementation
- Documentation system automation

Technical contributors should consult our [Development Guide](./docs/development.md) for coding standards and technical requirements.

## Non-Technical Contributions

There are many valuable ways to contribute without technical expertise:

### Documentation & Content Creation

- **Create Document Templates**  
  Design Markdown templates for frequently used document types with clear placeholder text.

- **Develop Visual Security Classification Guide**  
  Create visual explanations of our three-tier security model (L0/L1/L2) with examples.

- **Create Step-by-Step Workflow Guides**  
  Develop user-friendly guides showing common workflows with screenshots.

### Testing & User Experience

- **Conduct Usability Testing**  
  Test the system by following specific scenarios and document your experience.

- **Create Glossary of Terms**  
  Compile and define terms used throughout the system.

### Organization & Metadata

- **Organize Tag Taxonomy**  
  Help organize and structure the hierarchical tag system.

- **Review and Improve Error Messages**  
  Suggest more user-friendly alternatives to current error messages.

### Training Materials

- **Create FAQ Document**  
  Compile common questions and answers about using the system.

- **Develop Training Scenarios**  
  Create realistic scenarios for training exercises.

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