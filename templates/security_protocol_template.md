<%*
// Templater script for Security Protocol
let protocolTitle = await tp.system.prompt("Protocol Title", "Untitled Security Protocol");

let securityLevel = null;
const securityOptions = ["Public", "Candidate", "Cadre"]; // Standardized options
const securityValues = ["public", "candidate", "cadre"]; // Standardized values
while (securityLevel == null) { // Loop until a selection is made
    securityLevel = await tp.system.suggester(
        securityOptions, 
        securityValues, 
        false, 
        "Select Security Level (Required)"
    );
    if (securityLevel == null) {
        // Optional: new Notice("Security level selection is mandatory.");
    }
}
let classificationDate = tp.date.now("YYYY-MM-DD");

let version = await tp.system.prompt("Version Number (e.g., 1.0)", "1.0");
let protocolAuthor = await tp.system.prompt("Author/Originating Committee", "Security Committee");
let effectiveDate = tp.date.now("YYYY-MM-DD"); // Or prompt if a future date is needed

let docTitle = "Security Protocol: " + protocolTitle;
let suggestedFilename = "Security Protocol - " + protocolTitle.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
protocol_title: "<% protocolTitle %>"
security_level: "<% securityLevel %>"
classification_date: <% classificationDate %>
version: "<% version %>"
author: "<% protocolAuthor %>"
effective_date: <% effectiveDate %>
status: "active"
tags: [security-protocol, <% securityLevel.toLowerCase() %>]
---

# <% docTitle %>

## 1. Protocol Overview
- **Protocol Title:** <% protocolTitle %>
- **Security Level:** <% securityLevel %>
- **Version:** <% version %>
- **Effective Date:** <% effectiveDate %>
- **Author/Originating Committee:** <% protocolAuthor %>

## 2. Purpose of Protocol
*Clearly state the primary purpose and objectives of this security protocol.*

## 3. Scope
*Specify to whom this protocol applies (e.g., all cadre members, specific committees) and what systems, information, or activities it covers.*

## 4. Responsibilities
*Outline the specific responsibilities of different roles or individuals in relation to this protocol.*
- **[Role/Individual 1]:** [Responsibilities]
- **[Role/Individual 2]:** [Responsibilities]

## 5. Procedure Steps
*Provide detailed, step-by-step instructions for carrying out the protocol. Use numbered lists for clarity.*
1.  **Step 1:** [Description of action]
2.  **Step 2:** [Description of action]
    -   Sub-step 2a: [Detail]
    -   Sub-step 2b: [Detail]
3.  **Step 3:** [Description of action]

## 6. Contingency Plans/Emergency Actions (if applicable)
*Describe procedures to follow in case of breaches, failures, or emergencies related to this protocol.*
- **Scenario 1:** [Description of scenario]
  - **Action:** [Steps to take]
- **Scenario 2:** [Description of scenario]
  - **Action:** [Steps to take]

## 7. Contact Information for Queries/Reporting Incidents
*Provide contact details or channels for questions regarding this protocol or for reporting security incidents.*
- **For Queries:** [Contact Person/Committee, Email/Channel]
- **For Incident Reporting:** [Contact Person/Committee, Email/Channel, Phone (if applicable)]

## 8. Review and Update Schedule
*Specify how often this protocol will be reviewed and updated, and by whom.*
- **Review Frequency:** [e.g., Annually, Bi-annually]
- **Next Scheduled Review:** [Date or QX YYYY]
- **Responsible for Review:** [Committee/Role]

## 9. Acknowledgement/Training Log (Placeholder)
*This section serves as a placeholder. Actual acknowledgement or training records related to this protocol may be maintained in a separate system or document as per organizational policy.*

---
*This protocol is currently **active** and was last updated on <% effectiveDate %>.*
