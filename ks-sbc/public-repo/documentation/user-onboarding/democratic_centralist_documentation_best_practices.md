# Best Practices for Democratic Centralist Documentation in DRUIDS

This guide outlines how our documentation practices within DRUIDS (Democratic Repository and Universal Information Distribution System) can actively support and reflect KSBC's commitment to democratic centralist principles. Effective documentation is not just about recording information; it's a vital tool for collective understanding, unified action, and continuous improvement.

## Core Principles Reiteration

*   **Democracy:** Open discussion, participation in formulating ideas and plans, and the ability for members to contribute to the collective knowledge base.
*   **Centralism:** Once a decision is made through democratic processes, it is binding on all members. Unified action requires clear, centralized understanding of plans and positions.

## Best Practices in DRUIDS Documentation

**1. Clarity and Accessibility:**

*   **Principle:** Documents should be understandable by all members to whom they are relevant, regardless of their technical expertise or tenure. This ensures everyone can participate meaningfully in discussions and understand decisions.
*   **Best Practices in DRUIDS:**
    *   **Simple Language:** Avoid jargon where possible. If technical terms are necessary, provide definitions or link to a glossary within DRUIDS.
    *   **Clear Structure:** Use headings, subheadings, bullet points, and numbered lists to organize information logically. (Leverage Markdown formatting in Obsidian).
    *   **Summaries:** For longer documents, include a brief summary or abstract at the beginning.
    *   **Accessibility Checks:** Consider if your document is accessible (e.g., good contrast if using colors, descriptive link text). While Obsidian is primarily text, be mindful if exporting or sharing.
    *   **Example:** Instead of "Perfidious cadres obfuscated veridical data," write "Some members intentionally hid correct information."

**2. Unity in Action: Documenting Finalized Plans and Positions:**

*   **Principle:** Centralism requires that once a plan or position is democratically decided, it is clearly documented and serves as the unified guide for action.
*   **Best Practices in DRUIDS:**
    *   **Clear "Final" Versions:** Clearly mark documents containing decided plans or official positions as "Final," "Approved," or "Official Position." Use consistent naming conventions or tags (e.g., `#status-final`, `#official-position`).
    *   **Version Control:** Utilize DRUIDS' Git backend. When a plan is updated, ensure the new version is clearly marked, and older versions are archived but accessible (Git history does this automatically). Major changes should result in a new explicitly versioned document if the changes are substantial.
    *   **Central Location:** Store these key documents in easily identifiable, central locations within DRUIDS (e.g., `L1_Internal/Official_Plans/`, `L2_Cadre_Secure/Strategic_Directives/`).
    *   **Link, Don't Duplicate:** Refer back to the single source of truth for a plan or position using internal DRUIDS links (`[[Official Plan XYZ]]`) rather than copying content into multiple documents.

**3. Theory -> Plan -> Practice -> Summation (TPPS) Cycle:**

*   **Principle:** Our work follows a cycle of developing theory, forming plans, putting them into practice, and then summing up the results to refine theory. Documentation is crucial at each stage.
*   **Best Practices in DRUIDS:**
    *   **Dedicated Sections/Tags:** Organize documents or use tags to indicate which phase of the TPPS cycle they belong to (e.g., `#theory`, `#plan`, `#practice-report`, `#summation`).
    *   **Interlinking Documents:** This is key.
        *   A **Theory** document (e.g., `[[Analysis of Local Housing Crisis - Theory.md]]`) should link to the **Plan** documents derived from it.
        *   **Plan** documents (e.g., `[[Tenant Outreach Program - Plan.md]]`) should link to **Practice Reports** detailing implementation.
        *   **Practice Reports** (e.g., `[[2023-Q4 Tenant Outreach - Practice Report.md]]`) should link back to the Plan and inform **Summation** documents.
        *   **Summation** documents (e.g., `[[Summation of 2023 Tenant Outreach Program.md]]`) should analyze the practice, refer back to the original theory and plan, and potentially propose new theories or plan revisions.
    *   **Templates:** Use templates in DRUIDS for each TPPS stage to ensure consistent information is captured (see `creating_new_document_from_template.md`).

**4. Criticism/Self-Criticism (Constructive Documentation):**

*   **Principle:** Honest and constructive criticism/self-criticism is vital for growth and correcting errors. Documentation should facilitate this in a productive way.
*   **Best Practices in DRUIDS:**
    *   **Focus on Actions and Outcomes:** When documenting critiques (e.g., in a summation or a meeting record), focus on specific actions, strategies, and their outcomes rather than personal attacks.
    *   **Objective Language:** Use neutral and objective language.
    *   **Record Decisions and Improvements:** If criticism leads to changes in plans or procedures, document these decisions and link back to the critique that spurred them. This shows learning and responsiveness.
    *   **Secure and Appropriate Forum:** Ensure such critiques are documented at the appropriate security level (L1 or L2) and within the correct group context, not for public (L0) consumption unless specifically decided for transparency on a non-sensitive issue.
    *   **Example:** Instead of "Person X's idea was terrible," document "The proposed strategy 'Alpha' did not achieve its objectives because of [reason 1, reason 2]. An alternative approach, 'Beta,' is now proposed."

**5. Collective Work (Democratic Input, Centralized Decisions):**

*   **Principle:** Documents, especially plans and position papers, should reflect collective input during their formative stages, and the final, centrally-agreed-upon version after a decision.
*   **Best Practices in DRUIDS:**
    *   **Drafting and Feedback:**
        *   Use DRUIDS for collaborative drafting if tools allow (or manage drafts via Git commits). Clearly mark drafts (e.g., `_DRAFT_Plan_Proposal_v0.2.md`).
        *   Collect feedback in associated discussion notes or via designated review periods. Link feedback documents to the draft.
    *   **Recording Input:** Summarize significant input or differing viewpoints considered during the democratic phase, perhaps in an appendix or a related "Discussion Summary" document linked to the final version. This shows that input was valued.
    *   **Clear Finalization:** Once a decision is made by the appropriate body/process, the document should be finalized and clearly marked as such (see "Unity in Action"). Further edits should go through a new democratic process or amendment procedure.
    *   **Attribution (Contextual):** While work is collective, sometimes noting key contributors or a responsible committee for a document can be useful for accountability and follow-up. This should be balanced with the emphasis on collective ownership of final decisions.

**6. Historical Record (Learning and Accountability):**

*   **Principle:** DRUIDS serves as KSBC's collective memory. An accurate and comprehensive historical record is essential for learning from past successes and failures, understanding the evolution of our thought, and maintaining accountability.
*   **Best Practices in DRUIDS:**
    *   **Preserve Documents:** Avoid deleting documents, especially those related to decisions, plans, and summations. Git's history inherently preserves past versions.
    *   **Consistent Naming and Dating:** Use clear and consistent naming conventions for files, including dates (e.g., `YYYY-MM-DD_MeetingType_Topic.md`). This makes chronological review easier.
    *   **Link Related Documents:** The more interconnected our documents (via wikilinks), the richer our historical understanding becomes.
    *   **Protect Integrity:** Follow security procedures to prevent unauthorized alteration or deletion of historical records.

**7. Security Consciousness (Protecting the Collective):**

*   **Principle:** Protecting sensitive information and the integrity of our documented knowledge is a collective responsibility that aligns with protecting the organization, its members, and its ability to function effectively.
*   **Best Practices in DRUIDS:**
    *   **Adhere to Classification:** Strictly follow the L0/L1/L2 security classifications when creating, storing, and sharing documents (see `security_procedures_manual.md`).
    *   **Secure Communication:** Use secure channels recommended by KSBC when discussing sensitive information contained in documents.
    *   **Report Breaches:** Promptly report any suspected security breaches or misclassifications. Protecting our documented strategy and internal discussions is key to effective centralist action.

By consciously applying these documentation best practices within DRUIDS, we strengthen KSBC's democratic centralist operations, enhance our collective intelligence, and ensure our actions are unified, informed, and effective. This is an ongoing effort that requires active participation from all members.
