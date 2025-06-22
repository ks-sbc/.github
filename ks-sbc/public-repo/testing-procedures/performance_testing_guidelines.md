# Performance Testing Guidelines for DRUIDS

**Document Version:** 1.0
**Date:** YYYY-MM-DD

## 0. Table of Contents
1.  Introduction and Objectives
2.  Key Performance Indicators (KPIs)
3.  Hardware Configuration Profiles for Testing
4.  Testing Methodology
5.  Metrics to Collect
6.  Performance Benchmarks (Future Goal)
7.  Reporting Performance Issues

## 1. Introduction and Objectives

Performance testing for DRUIDS (our Obsidian-based system) is crucial to ensure a good user experience for all KSBC members, regardless of their hardware capabilities. As DRUIDS grows in content and complexity, maintaining acceptable performance is key to its usability and adoption.

**Objectives:**

*   Identify performance bottlenecks in common DRUIDS operations.
*   Ensure DRUIDS remains usable and responsive, especially for users on less powerful hardware or constrained environments like Tails OS.
*   Establish a baseline for future performance comparisons as DRUIDS evolves.
*   Gather data to inform optimization efforts for the vault structure, plugin usage, and potentially hardware recommendations.

## 2. Key Performance Indicators (KPIs)

The following operations are critical for DRUIDS performance and should be tested:

1.  **Obsidian Application Startup Time:** Time taken for Obsidian to load the DRUIDS vault and become responsive.
2.  **Large Markdown File Opening Time:** Time taken to open and render a very large Markdown file (e.g., a lengthy summation or a compiled research document).
3.  **Vault-Wide Search Speed:** Time taken for global search results to appear for common and complex queries.
4.  **Git Operations:**
    *   Time for `git add .` and `git commit -m "Test commit"` (local commit).
    *   Time for `git pull` from the remote repository (simulating updates).
    *   Time for `git push` to the remote repository (simulating contributions).
    *   *(These may be tested via the Obsidian Git plugin interface or command line, depending on user proficiency and plugin stability).*
5.  **GPG Encryption/Decryption Time (for L1/L2 relevant testing):**
    *   Time to encrypt a sample large file (e.g., 5-10MB document).
    *   Time to decrypt a sample large file.
6.  **Plugin Responsiveness:**
    *   **Dataview:** Time to render a page with complex Dataview queries (e.g., a dashboard aggregating tasks from many notes).
    *   **Kanban:** Time to load a Kanban board with a significant number of cards/lanes.
    *   **Templater/QuickAdd:** Time to execute common template/macro actions, especially those involving user prompts or script execution.
7.  **General UI Responsiveness:** Subjective assessment of UI lag when typing, switching notes, or interacting with UI elements during high-load operations.

## 3. Hardware Configuration Profiles for Testing

Testing should be conducted on a range of hardware to ensure DRUIDS is accessible.

1.  **Baseline Profile:**
    *   **CPU:** Modern multi-core processor (e.g., Intel Core i5/i7 8th gen or newer, AMD Ryzen 5/7 3000 series or newer).
    *   **RAM:** 8GB or more.
    *   **Storage:** SSD.
    *   **OS:** Standard Windows 10/11, macOS (recent version), or common Linux distribution.

2.  **Low-End Profile:**
    *   **CPU:** Older dual-core processor (e.g., Intel Core i3 4th-6th gen, older AMD A-series).
    *   **RAM:** 4GB (minimum) to 8GB.
    *   **Storage:** HDD (if possible, to test worst-case disk I/O).
    *   **OS:** Windows 10, lightweight Linux distribution.

3.  **Tails OS Environment:**
    *   **Setup:** Running Tails OS from a USB drive (latest stable version).
    *   **Persistence:** Test with and without a persistent encrypted volume for the DRUIDS vault, if feasible.
    *   **Note:** Performance in Tails is expected to be slower due to its security features and running from USB. The goal is to ensure it remains *usable*.

Testers should document the specifications of the machine they are using for each test run.

## 4. Testing Methodology

For each KPI, a standardized approach should be used:

1.  **Preparation:**
    *   Ensure the DRUIDS vault is synced to the latest version.
    *   Close unnecessary applications to free up system resources.
    *   Have a stopwatch (physical or digital) ready for time-based measurements.
    *   Prepare any specific sample files needed (e.g., a very large Markdown file, a sample file for GPG).

2.  **Execution & Measurement:**
    *   **Obsidian Startup:** Close Obsidian completely. Start Obsidian and immediately start the stopwatch. Stop when the vault is fully loaded and responsive (e.g., cursor is active, sidebars are loaded).
    *   **File Opening:** From the File Explorer, click to open the designated large file. Start stopwatch on click, stop when the file is fully rendered and scrollable.
    *   **Search:** Open the search pane. Start stopwatch, type in a pre-defined complex query (e.g., searching for a common phrase across many notes), and stop when results are fully displayed.
    *   **Git Operations:**
        *   Use the Obsidian Git plugin or command line.
        *   For `commit`: Start stopwatch before initiating commit, stop when commit confirmation is received.
        *   For `pull`/`push`: Start stopwatch before initiating, stop when operation completes successfully. Note vault size/number of changes if relevant.
    *   **GPG Operations:** Use the GPG plugin or command line. Start stopwatch before initiating encryption/decryption, stop when the operation is complete and the output file is created/readable.
    *   **Plugin Responsiveness:**
        *   **Dataview/Kanban:** Navigate to a note containing a complex Dataview query or a large Kanban board. Start stopwatch when initiating navigation, stop when the view is fully rendered and interactive.
        *   **Templater/QuickAdd:** Start stopwatch before triggering the template/macro, stop when its action is fully complete (e.g., new note created and populated, prompts finished).
    *   **Subjective Responsiveness:** While performing other tests (especially under load like Git operations or complex queries), note any significant UI lag, typing delays, or stuttering.

3.  **Repetition:**
    *   Perform each timed test at least 3 times.
    *   Discard any extreme outliers if an obvious external interruption occurred (e.g., system update).
    *   Record all readings and calculate an average if appropriate.

## 5. Metrics to Collect

For each test run, record the following:

*   **Test Case ID** (from this document or a more detailed test suite).
*   **KPI Being Tested.**
*   **Hardware Profile Used** (Baseline, Low-End, Tails OS - with brief specs if not standard).
*   **Time Taken** (in seconds, for timed operations).
*   **Success/Failure of Operation** (Yes/No).
*   **Error Messages** (if any, verbatim).
*   **Subjective Responsiveness Rating** (e.g., Scale 1-5: 1=Very Slow/Unusable, 3=Acceptable, 5=Very Fast/Smooth).
*   **CPU/RAM Usage (Optional):** If monitoring tools are available, note any significant spikes or sustained high usage during the operation.
*   **Notes:** Any other observations (e.g., "UI froze for 2 seconds," "search results were slow to filter").

## 6. Performance Benchmarks (Future Goal)

Initially, performance testing will focus on identifying major bottlenecks, regressions, and ensuring basic usability across defined hardware profiles.
Over time, as DRUIDS matures and more data is collected, KSBC may establish specific performance benchmarks (e.g., "Obsidian startup on Low-End profile should not exceed X seconds," "Global search for Y query should return results within Z seconds"). These benchmarks will help in ongoing performance monitoring.

## 7. Reporting Performance Issues

When a performance issue is identified (e.g., an operation is excessively slow, fails, or makes the UI unresponsive):

1.  **Document Thoroughly:** Use the "Metrics to Collect" as a guide.
2.  **Reproducibility:** Note if the issue is consistently reproducible.
3.  **Comparison:** If possible, compare with previous test runs or different hardware profiles.
4.  **Context:** Provide context, such as the size of the vault at the time of testing, number of plugins enabled, and any specific files/queries involved.
5.  **Submit Report:** Report the issue to the DRUIDS administration team or the designated KSBC technical lead, providing all collected details. This will help in diagnosing and addressing the performance problem.

---

Regular performance testing is essential for maintaining a healthy and efficient DRUIDS environment for all KSBC members.
