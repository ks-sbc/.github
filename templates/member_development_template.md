<%*
// Templater script for Member Development Plan
let memberName = await tp.system.prompt("Member Name", "Untitled Member");

let securityLevel = null;
const securityOptions = ["Public", "Candidate", "Cadre"];
const securityValues = ["public", "candidate", "cadre"];
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

let reviewPeriod = await tp.system.prompt("Review Period (e.g., YYYY Q1, or specific date range)", tp.date.now("YYYY") + " Q" + (Math.floor(tp.date.now("M") / 3) + 1));
let mentorName = await tp.system.prompt("Mentor/Reviewer Name", "To Be Assigned");
let planDate = tp.date.now("YYYY-MM-DD");

let docTitle = "Development Plan: " + memberName + " - " + reviewPeriod;
let suggestedFilename = "Member Dev Plan - " + memberName.replace(/[\/:?"<>|]/g, '_') + " - " + reviewPeriod.replace(/[\/:?"<>|]/g, '_');
await tp.file.rename(suggestedFilename);
-%>
---
title: "<% docTitle %>"
member_name: "<% memberName %>"
review_period: "<% reviewPeriod %>"
mentor: "<% mentorName %>"
plan_date: <% planDate %>
security: <% securityLevel %>
classification_date: <% classificationDate %>
status: "active"
tags: [member-development, cadre]
---

# <% docTitle %>

## Member Information
- **Member Name:** <% memberName %>
- **Review Period:** <% reviewPeriod %>
- **Date of Plan:** <% planDate %>
- **Mentor/Reviewer:** <% mentorName %>

---

## Section 1: Reflection on Previous Period

### Goals from Previous Period
- *[List previous goals, if applicable]*

### Achievements & Contributions
- *[Detail specific achievements and contributions during the last period]*

### Challenges Encountered
- *[Describe any challenges faced]*

### Areas for Development Identified
- *[List areas identified for development from the previous period or self-reflection]*

---

## Section 2: Goals for Current Review Period

### Political Education Goals
- [ ] *[Specific Reading/Study Topic 1]* (Target: <% tp.date.now("YYYY-MM-DD", 30) %>)
- [ ] *[Attend Study Group X on Y topic]* (Target: <% tp.date.now("YYYY-MM-DD", 60) %>)

### Practical Skills Development Goals
- [ ] *[Develop Skill X, e.g., writing articles]* (Target: <% tp.date.now("YYYY-MM-DD", 90) %>)
- [ ] *[Learn Tool Y, e.g., basic video editing]* (Target: <% tp.date.now("YYYY-MM-DD", 60) %>)

### Organizational Contribution Goals
- [ ] *[Participate actively in Campaign Z]* (Target: Throughout Period)
- [ ] *[Take on responsibility for Task A in Committee B]* (Target: <% tp.date.now("YYYY-MM-DD", 45) %>)

---

## Section 3: Support & Resources Needed
*What support is needed from the mentor, specific committees, or the organization as a whole to achieve these goals? (e.g., access to specific materials, guidance on certain tasks, introductions)*

---

## Section 4: Mentor/Reviewer Feedback (Initial)
*(Space for mentor to add initial comments, suggestions, or agreement on the plan)*

---

## Section 5: Mid-Period Check-in (Optional)
- **Date:** 
- **Progress Update:**
  - *[Member's summary of progress towards goals]*
- **Adjustments to Plan (if any):**
  - *[Any agreed changes to goals, timelines, or support]*
- **Mentor Feedback:**

---

## Section 6: End-of-Period Review & Summation
*(To be filled at the end of the review period)*
- **Overall Assessment of Progress:**
- **Achievements this Period:**
- **Challenges Encountered this Period:**
- **Areas for Continued Development:**
- **Goals for Next Period (Preliminary):**
- **Mentor's Summation:**

---
*This development plan is currently **active**.*
