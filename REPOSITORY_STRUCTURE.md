# KSBC Repository Structure & Relationships

## 🏗️ Repository Architecture Overview

The Kansas Socialist Book Club maintains a distributed repository structure that reflects our democratic centralist principles. Each repository serves a specific purpose within the larger DRUIDS ecosystem.

```
KSBC Organization
├── .github (Governance & Configuration)
│   ├── Templates & Workflows
│   ├── Organization Documentation
│   └── Community Health Files
│
├── public-repo (Content Source)
│   ├── Public Documents (L0)
│   ├── Member Documents (L1)
│   ├── Cadre Documents (L2)
│   └── Obsidian Vault Structure
│
├── quartz-website (Public Interface)
│   ├── Static Site Generator
│   ├── Consumes public-repo via submodule
│   └── Neobrutalist Design Implementation
│
└── os (DRUIDS Implementation)
    ├── Modified Tails OS
    ├── DRUIDS Core Components
    └── Security Infrastructure
```

## 📦 Repository Details

### 1. `.github` - Organization Governance Hub
**Purpose**: Centralized configuration and governance for the entire organization

**Contains**:
- Issue and PR templates
- GitHub Actions workflows
- Community health files (CODE_OF_CONDUCT, CONTRIBUTING, SECURITY)
- Organization profile and documentation
- CODEOWNERS for democratic review process

**Relationships**:
- Provides templates used by all other repositories
- Houses organization-wide discussions
- Defines security and governance policies

**Key Issues**: #99 (cleanup), #52 (settings), #58 (2FA), #86 (CSC system)

---

### 2. `public-repo` - Obsidian Knowledge Vault
**Purpose**: Centralized content repository using Obsidian for knowledge management

**Contains**:
- Meeting minutes and organizational records
- Educational materials and lesson plans
- Public statements and pamphlets
- Internal documentation (security-classified)
- Templates for document creation

**Relationships**:
- **Consumed by**: `quartz-website` as Git submodule at `/content`
- **Syncs with**: Local Obsidian installations for editing
- **References**: GitHub issues for democratic proposals

**Key Issues**: #3 (anonymous submission), #10 (style guide)

---

### 3. `quartz-website` - Public Web Interface  
**Purpose**: Static site generator that publishes public content from public-repo

**Contains**:
- Quartz framework configuration
- React components for layout
- SCSS styling (Neobrutalist design)
- Build and deployment scripts

**Relationships**:
- **Depends on**: `public-repo` via Git submodule
- **Filters**: Only publishes L0 (public) classified content
- **Implements**: Design system from public-repo issues

**Key Issues**: #15 (repo restructure), #12 (Neobrutalist design)

---

### 4. `os` - KSBC Operating System
**Purpose**: Revolutionary operating system extending Tails with DRUIDS

**Contains**:
- Tails OS base configuration
- DRUIDS Python packages
- Automated test suites
- Build infrastructure

**Relationships**:
- **Will integrate**: public-repo for offline documentation
- **Will implement**: Security model from .github policies
- **Future home**: DRUIDS sync and workflow tools

**Key Issues**: #6 (DRUIDS master tracking)

---

## 🔄 Data Flow & Integration Points

### Content Flow
```
Obsidian Editor → public-repo → quartz-website → Public Web
                      ↓
                  Git History
                      ↓
                  DRUIDS OS
```

### Security Classification Flow
```
Document Created → Frontmatter Classification → Automated Validation
                                                         ↓
                                              L0: Public Website
                                              L1: Member Access
                                              L2: Cadre Only
```

### Issue-to-Implementation Flow
```
Discussion → Issue Creation → Democratic Vote → Implementation PR
    ↓            ↓                                      ↓
GitHub      Full Metadata                        Feature Branch
Discussions (labels, etc.)                          Review
```

## 🔐 Security & Access Model

### Repository Visibility
- `.github`: Public (transparency in governance)
- `public-repo`: Public (but contains classified subdirectories)
- `quartz-website`: Public (only shows L0 content)
- `os`: Public (open source security)

### Content Security
- **L0 (Public)**: Educational materials, public statements
- **L1 (Candidate)**: Development docs, member resources  
- **L2 (Cadre)**: Strategic planning, sensitive operations

### Access Control
- Managed through GitHub teams
- CODEOWNERS enforces committee review
- Security classification in document frontmatter
- Automated validation prevents classification errors

## 🚀 Future Integration Plans

### Phase 1: Current State (May 2025)
- Separate repositories with manual coordination
- Git submodules for content sharing
- GitHub-based workflow

### Phase 2: DRUIDS Integration (Q3 2025)
- DRUIDS OS includes offline public-repo mirror
- Automated sync between Obsidian and GitHub
- Integrated security validation

### Phase 3: Full Implementation (Q4 2025)
- Distributed repository sync via DRUIDS
- Offline-first operation with periodic sync
- Complete organizational memory system

## 📋 Repository Maintenance

### Active Repositories (4)
- Regular updates and maintenance
- Clear ownership and purpose
- Active issue tracking

### Archived Repositories (4)
- `DRUIDS` - Functionality moved to `os`
- `discussion` - Replaced by GitHub Discussions
- `Website` -
- `demo-repository` - Test repo, no longer needed

### Private Repositories (2)
- `cadre-repo` - L2 secure communications
- `member-repo` - L1 member resources

## 🤝 Contributing

Each repository follows the organization-wide contributing guidelines found in [.github/CONTRIBUTING.md](https://github.com/ks-sbc/.github/blob/main/CONTRIBUTING.md). 

Repository-specific guidelines:
- **public-repo**: Use Obsidian templates, include security classification
- **os**: Follow Tails development practices, include tests
- **quartz-website**: Test builds locally, respect content filtering
- **.github**: Changes require steering committee review

---

*This document is part of the KSBC organizational documentation. For questions or updates, create an issue in the appropriate repository with full metadata.*