# DRUIDS System Health and Performance Monitoring Guide

**Document Version:** 1.0
**Date:** YYYY-MM-DD

## 0. Table of Contents
1.  Introduction
2.  Key Areas to Monitor (Manual Checks)
    *   2.1. Obsidian Application
    *   2.2. Plugin Functionality
    *   2.3. Git Synchronization
    *   2.4. Data Integrity & Storage
    *   2.5. Security Anomalies
3.  Performance Baseline
4.  What to Do When Issues Are Noticed
5.  Frequency of Monitoring

## 1. Introduction

This guide provides procedures for manually monitoring the health and performance of the DRUIDS system (built on Obsidian). While DRUIDS does not currently feature automated, centralized monitoring tools managed by KSBC, individual users and designated personnel can perform regular checks to ensure the system remains stable, responsive, and secure.

The primary purpose of this monitoring is to:
*   Detect and address performance degradation early.
*   Identify malfunctioning plugins or features.
*   Ensure data integrity and availability.
*   Maintain a good user experience for all KSBC members.
*   Prompt timely reporting of issues for resolution.

## 2. Key Areas to Monitor (Manual Checks)

These checks are largely observational and comparative against your own experience of "normal" system behavior.

### 2.1. Obsidian Application

*   **Startup Time:**
    *   **Check:** When you launch Obsidian with the DRUIDS vault, does it feel significantly slower to load and become usable than it previously did?
    *   **Indicator:** Noticeable increase in the time from clicking the Obsidian icon to being able to interact with your notes.
*   **General Responsiveness:**
    *   **Check:** While navigating between notes, opening notes (especially larger ones), and using basic search, does the application feel sluggish, laggy, or unresponsive?
    *   **Indicator:** Delays in opening notes, stuttering when typing or scrolling, search results taking unusually long to appear.
*   **Error Messages:**
    *   **Check:** Are you seeing any new or frequent error pop-ups from Obsidian itself or from any plugins?
    *   **Indicator:** Notification pop-ups within Obsidian detailing errors.

### 2.2. Plugin Functionality

*   **Spot-Check Critical Plugins:**
    *   **Dataview:** Open a note that contains Dataview queries. Are the tables or lists rendering correctly and with reasonably up-to-date information?
    *   **Templater/QuickAdd:** Try creating a new note from a commonly used template via its QuickAdd command or the Templater interface. Does it populate correctly?
    *   **Obsidian Git:** Check if the plugin shows the current Git status correctly. Try a manual pull or check for uncommitted changes.
    *   **GPG-Encrypt (for L1/L2 users):** If you use GPG, try decrypting a test file or encrypting a new one (if applicable to your workflow).
    *   **Other key plugins:** Briefly test the core function of any other plugin critical to your workflow.
*   **Obsidian Console (Advanced Check):**
    *   **Check:** If you are comfortable, you can open the Obsidian Developer Console (`Ctrl+Shift+I` on Windows/Linux, `Cmd+Option+I` on macOS, then select the "Console" tab). Look for repeated error messages, often highlighted in red, which might indicate plugin issues.
    *   `[SCREENSHOT: Obsidian Developer Console showing example plugin errors.]`
    *   **Indicator:** Repeated error messages, especially those naming specific plugins.

### 2.3. Git Synchronization

*   **Frequency of Sync Errors:**
    *   **Check:** Are you experiencing more frequent errors when Obsidian Git (or your manual Git process) tries to pull, push, or commit changes?
    *   **Indicator:** Error messages related to merge conflicts, authentication failures, or inability to connect to the remote repository (GitHub).
*   **Time Taken for Sync Operations:**
    *   **Check:** Subjectively, are Git operations (pulling, pushing, committing) taking noticeably longer than they used to, especially for a similar amount of changes?
    *   **Indicator:** Prolonged "syncing" messages or slow command-line responses.

### 2.4. Data Integrity & Storage

*   **Link Integrity:**
    *   **Check:** Randomly click on a few internal links (`[[wikilinks]]`) in your notes. Do they lead to the correct document?
    *   **Indicator:** Links leading to non-existent notes or the wrong notes.
*   **Local Disk Space:**
    *   **Check:** If your DRUIDS vault is stored locally, periodically check the available disk space on the drive where it resides.
    *   **Indicator:** Low disk space warnings from your operating system, which can affect Obsidian's performance and ability to save files.

### 2.5. Security Anomalies

*   **File Classification:**
    *   **Check:** While browsing, do you notice any documents that seem to be in the wrong security tier folder (e.g., a sensitive L2 document in an L0 folder)? Do visual cues (if implemented) seem incorrect for a document's location?
    *   **Indicator:** Documents appearing in unexpected locations or with mismatched visual security indicators.
*   **Unusual File Activity:**
    *   **Check:** (More for advanced users or those with specific concerns) Any unexpected modification dates on files you haven't touched, or files appearing/disappearing without your action (could indicate sync issues or, rarely, unauthorized access).
*   **Referral:** For detailed security checks, refer to the `[[../testing-procedures/security_audit_procedures.md]]`.

## 3. Performance Baseline

Effective manual monitoring relies on your understanding of what "normal" performance feels like for DRUIDS on your specific hardware.

*   **Establish Your Baseline:** Pay attention to the system's responsiveness during your initial usage and after completing the setup and basic training. The `[[../testing-procedures/performance_testing_guidelines.md]]` can help you quantify some of these initial metrics.
*   **Notice Deviations:** The key is to notice when things become *slower than usual* or *behave differently* from this established baseline.

## 4. What to Do When Issues Are Noticed

1.  **Consult Troubleshooting Guide:** First, refer to the `[[../user-onboarding/troubleshooting_guide.md]]` for common issues and solutions.
2.  **Check Plugin Update Procedures:** If the issue started after a recent plugin update, consult the `[[plugin_update_procedures.md]]` for rollback or compatibility testing advice.
3.  **Gather Information:**
    *   Note the specific issue encountered.
    *   What were you doing when it happened?
    *   Are there any error messages? (Take a screenshot or copy the text).
    *   Is the issue reproducible?
4.  **Report Issues:** If you cannot resolve the issue using the troubleshooting guide or if it seems like a broader system problem:
    *   Report it to the designated KSBC support person, group, or Cadre member responsible for DRUIDS.
    *   Provide all the information you gathered.

## 5. Frequency of Monitoring

*   **Daily (Informal):**
    *   Be generally aware of Obsidian startup time and UI responsiveness during your normal daily use.
    *   Notice any new, persistent error messages.
*   **Weekly (Quick Checks):**
    *   Spot-check a critical plugin function (e.g., one Templater command, one Dataview page).
    *   Perform a manual Git sync (if not fully automated) and note any issues.
    *   Quickly check a few internal links.
*   **Monthly (More Thorough Spot Checks):**
    *   Review a wider range of plugin functions.
    *   Briefly check the Obsidian console for persistent errors if comfortable.
    *   Review local disk space.
*   **As Needed:** After any Obsidian update, plugin update, or system change.

This manual monitoring, while not exhaustive, provides a good first line of defense in maintaining a healthy and performant DRUIDS environment. Your observations are valuable!
