# Contributing to DRUIDS

Thank you for your interest in contributing to the Distributed, Reproducible, Unifying, Ideological Documentation System (DRUIDS) for the Kansas Socialist Book Club (KSBC). Your participation is valuable to the success of this project.

## Table of Contents

- [Contributing to DRUIDS](#contributing-to-druids)
  - [Table of Contents](#table-of-contents)
  - [General Contribution Workflow](#general-contribution-workflow)
  - [Democratic Centralist Contribution Workflow](#democratic-centralist-contribution-workflow)
  - [Setting up Your Development Environment](#setting-up-your-development-environment)
  - [Code of Conduct](#code-of-conduct)
  - [Questions?](#questions)
  - [Democratic Centralist Workflow](#democratic-centralist-workflow)
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
  - [Documentation Standards](#documentation-standards)
  - [Review Process](#review-process)
  - [Code of Conduct](#code-of-conduct-1)
  - [Questions?](#questions-1)

## General Contribution Workflow

We follow a standard GitHub flow for contributions:

1. **Fork the Repository:** Create your own fork of the main DRUIDS repository.
2. **Create a Branch:** For any new feature, bug fix, or documentation change, create a new branch in your fork, usually from the `main` branch.
    - Branch naming convention: `feature/your-feature-name`, `fix/bug-description`, `docs/topic-update`.
3. **Make Your Changes:** Implement your changes, write code, or update documentation.
    - Ensure your work aligns with the project's goals and coding/style guidelines (to be documented).
4. **Commit Your Changes:** Write clear, concise commit messages. We encourage signing your commits.
    - Example commit message: `feat: Add initial structure for L0 content`
5. **Push to Your Fork:** Push your branch to your forked repository.
6. **Open a Pull Request (PR):**
    - Navigate to the main DRUIDS repository and open a Pull Request from your branch to the `main` branch of the DRUIDS repository.
    - Fill out the PR template with details about your changes.
    - Ensure your PR references any relevant issues (e.g., "Fixes #123" or "Implements #456").

## Democratic Centralist Contribution Workflow

Beyond the standard GitHub flow, DRUIDS adheres to specific democratic centralist principles in its development and contribution process.

**[Placeholder: Detailed Democratic Centralist Workflow]**

*(This section will be expanded with specific details on how democratic centralist principles (e.g., Theory -> Plan -> Practice -> Summation, criticism/self-criticism, collective decision-making on significant changes) are implemented in the DRUIDS contribution process. This may include:

- How proposals for major changes are discussed and approved.
- The role of different member tiers (if applicable to contribution rights).
- Processes for review and summation of contributions from an ideological and practical standpoint.
- How feedback and criticism are integrated into the development cycle.)*

For now, please ensure that your contributions are well-motivated and clearly explained in your Pull Request descriptions, considering their potential impact on the project's goals and usability.

## Setting up Your Development Environment

**[Placeholder: Development Environment Setup]**

*(This section will include specific instructions for setting up a local development environment, including any necessary tools, Obsidian configuration, or scripts. Refer to `OBSIDIAN_INTEGRATION_GUIDE.md` for initial Obsidian setup.)*

## Code of Conduct

All contributors are expected to adhere to the KSBC Code of Conduct.

**[Placeholder: Link to or text of Code of Conduct]**
*(Ensure a `CODE_OF_CONDUCT.md` file is created or link to an existing one.)*

## Questions?

If you have questions about contributing, please:

- Check existing issues and discussions.
- Ask in the project's designated communication channels (see `README.md`).

---

## Democratic Centralist Workflow

Our contribution process follows a democratic centralist model:

1. **Discussion Phase**: Open and thorough discussion of issues and proposals
2. **Decision Phase**: Formal decision through democratic process
3. **Implementation Phase**: Unified action to implement decisions
4. **Review Phase**: Critical evaluation of implementation

Once a decision has been made through proper channels, all members are expected to work toward its implementation regardless of their position during the discussion phase.


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

Remember, contributing to DRUIDS isn't just about technical skills—it's about contributing to a system that enhances our collective organizing capacity. Every contribution, regardless of technical complexity, has value in our revolutionary documentation effort.

Thank you for contributing to our collective work!
