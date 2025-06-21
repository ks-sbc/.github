# DRUIDS Visual Security Guide (Neobrutalist Edition)

This guide details the custom CSS snippets designed to provide clear visual indicators for security classifications (L0 Public, L1 Candidate, L2 Cadre) within the DRUIDS Obsidian vault. The aesthetic approach is based on the "ULTIMATE NEOBRUTALIST QUARTO STYLE GUIDE."

## Core Principles Applied

The visual system aims to translate the following neobrutalist principles into functional security indicators:

-   **Aggressive Contrast:** Utilizing pure black (#000000), electric yellow (#FFE200), and blood red (#FF0000) to create stark visual differences between security levels.
-   **Typography as Weapon:** Employing "EB Garamond" and all-caps styling for emphasis where appropriate, particularly for L2 Cadre indicators.
-   **Structural Brutality:** Incorporating strong borders and pronounced shadows to define and highlight elements, especially for higher security levels.

## Enabling CSS Snippets in Obsidian

To use these visual security indicators, you need to enable the created CSS snippets in Obsidian:

1.  Ensure the CSS snippet files (e.g., `00-neobrutal-base.css`, `01-security-L0.css`, etc.) are placed in your vault's `.obsidian/snippets/` directory. This should be handled by cloning/pulling this repository.
2.  Open Obsidian's settings (click the gear icon).
3.  Navigate to the "Appearance" tab.
4.  Scroll down to the "CSS snippets" section.
5.  You should see the available snippets listed. Toggle the switch ON for each snippet you wish to activate. It's recommended to enable all snippets in this system for the full effect (i.e., `00-neobrutal-base.css`, `01-security-L0.css`, `02-security-L1.css`, `03-security-L2.css`).
6.  Changes should apply immediately. You might need to close and reopen notes or Obsidian for all styles to take full effect.

## CSS Snippet Details

### Snippet: `00-neobrutal-base.css`

**Goal:** To establish the foundational neobrutalist aesthetic for the Obsidian vault, including core color variables, typography, and base styling for common Markdown elements in the preview mode.

**Neobrutalist Principles:** Aggressive Contrast, Typography as Weapon, Structural Brutality.

**CSS Code:**
```css
/* 00-neobrutal-base.css */
/* Establishes core neobrutalist variables and base styling for DRUIDS vault */

/* --- Core Neobrutalist Variables --- */
:root {
  --neobrutal-primary: #FF0000; /* Screaming Red */
  --neobrutal-dark: #000000;    /* Pure Black */
  --neobrutal-light: #FFE200;  /* Warning Yellow */
  --neobrutal-white: #FFFFFF;  /* Use Sparingly White */

  --neobrutal-border-strong: 5px solid var(--neobrutal-dark);
  --neobrutal-border-medium: 3px solid var(--neobrutal-dark);
  
  /* Adjusted shadow to be less offset for typical UI, can be overridden for specific components */
  --neobrutal-shadow-strong: 6px 6px 0 var(--neobrutal-dark); 
  --neobrutal-shadow-medium: 4px 4px 0 var(--neobrutal-dark);

  --font-text-theme: "EB Garamond", serif; /* For body text */
  --font-monospace-theme: monospace; /* Keep monospaced as is or choose a brutalist one if specified */
}

/* --- Font Import --- */
@import url('https://fonts.googleapis.com/css2?family=EB+Garamond:wght@400;500;700&display=swap');

/* --- General Body & Content Styling (Scoped to preview mode) --- */
.markdown-preview-view {
  background-color: var(--neobrutal-light) !important; /* Warning Yellow background */
  color: var(--neobrutal-dark) !important;             /* Pure Black text */
  font-family: var(--font-text-theme);
  font-size: 1.2rem; /* Body text (400WT, 1.2REM, line-height: 1.6) */
  line-height: 1.6;
}

/* Ensure editor mode is not overly affected if possible, or apply similar for consistency if desired */
/* For now, primarily targeting preview view for the aggressive background */

/* --- Link Styling --- */
.markdown-preview-view a,
.markdown-preview-view a.internal-link,
.markdown-preview-view a.external-link {
  color: var(--neobrutal-primary) !important; /* Screaming Red */
  text-decoration: underline 3px var(--neobrutal-dark) !important;
  font-weight: bold; /* Add boldness to make links stand out more */
}

.markdown-preview-view a:hover,
.markdown-preview-view a.internal-link:hover,
.markdown-preview-view a.external-link:hover {
  background-color: var(--neobrutal-dark) !important; /* Pure black on hover */
  color: var(--neobrutal-light) !important;          /* Warning yellow text on hover */
}

/* --- Heading Typography --- */
.markdown-preview-view h1 {
  font-family: var(--font-text-theme);
  font-weight: 700 !important;
  text-transform: uppercase !important;
  font-size: 3.5rem !important;
  color: var(--neobrutal-dark) !important; /* Or primary for more aggression: var(--neobrutal-primary) */
  border-bottom: var(--neobrutal-border-medium); /* Add border for structural feel */
  padding-bottom: 0.2em;
  margin-bottom: 0.5em;
}

.markdown-preview-view h2 {
  font-family: var(--font-text-theme);
  font-weight: 700 !important;
  /* Title Case is default for H2, no text-transform needed */
  font-size: 2.5rem !important;
  color: var(--neobrutal-dark) !important;
  border-bottom: 2px solid var(--neobrutal-dark);
  padding-bottom: 0.15em;
  margin-bottom: 0.4em;
}

/* Other headings for consistency */
.markdown-preview-view h3,
.markdown-preview-view h4,
.markdown-preview-view h5,
.markdown-preview-view h6 {
  font-family: var(--font-text-theme);
  font-weight: 700 !important; /* Bold for all headings */
  color: var(--neobrutal-dark) !important;
}

/* --- Basic Structural Elements (Example: Blockquotes) --- */
.markdown-preview-view blockquote {
  border-left: var(--neobrutal-border-medium) !important;
  border-top: 1px solid var(--neobrutal-dark) !important; /* Lighter top/bottom for effect */
  border-bottom: 1px solid var(--neobrutal-dark) !important;
  box-shadow: var(--neobrutal-shadow-medium);
  background-color: var(--neobrutal-white); /* Use sparingly white */
  color: var(--neobrutal-dark);
  padding: 1em;
  margin: 1.5em 0;
}

/* --- Code Blocks (Basic Brutalist Touch) --- */
.markdown-preview-view pre {
  border: var(--neobrutal-border-medium);
  box-shadow: var(--neobrutal-shadow-medium);
  padding: 1em;
  background-color: var(--neobrutal-dark); /* Dark background for code */
  color: var(--neobrutal-light); /* Light text for code */
}
.markdown-preview-view pre code {
  font-family: var(--font-monospace-theme);
}
```

**Explanation:**
-   **`:root` variables:** Defines `--neobrutal-primary` (Screaming Red), `--neobrutal-dark` (Pure Black), `--neobrutal-light` (Warning Yellow), `--neobrutal-white`, border styles, shadow styles, and the primary text font (`--font-text-theme: "EB Garamond"`). These variables are central to applying the neobrutalist theme consistently.
-   **`@import url(...)`:** Imports the "EB Garamond" font from Google Fonts, making it available for use in the vault.
-   **`.markdown-preview-view`:** Styles the main reading area (preview mode) with a Warning Yellow background (`var(--neobrutal-light)`) and Pure Black text (`var(--neobrutal-dark)`). It also sets the base font to "EB Garamond" and specifies a default font size and line height, aligning with the "Aggressive Contrast" principle.
-   **`a, .internal-link, .external-link`:** Styles links to be Screaming Red (`var(--neobrutal-primary)`) with a thick black underline. The hover effect inverts this to a black background with yellow text, enhancing the "Aggressive Contrast."
-   **`h1, h2, ... h6`:** Applies "EB Garamond" and bold weight to all headings. H1 is styled to be ALL CAPS, significantly larger, and with a medium black bottom border. H2 is also large, with a thinner black bottom border. This reflects "Typography as Weapon" and "Structural Brutality."
-   **`blockquote`:** Styled with a medium black left border, lighter top/bottom borders, a medium black shadow, and a white background, using "Use Sparingly White" for contrast and "Structural Brutality."
-   **`pre` (code blocks):** Styled with a medium black border, medium black shadow, a black background, and yellow text, providing high contrast for readability and a brutalist feel.

### Snippet: `01-security-L0.css`

**Goal:** To define the visual style for L0 (Public) security level content, ensuring it's distinct and primarily leverages the base neobrutalist theme as the most accessible default.

**Neobrutalist Principles:** Primarily relies on the base theme's "Aggressive Contrast" (Yellow/Black). Subtle "Structural Brutality" in tag styling.

**CSS Code:**
```css
/* 01-security-L0.css */
/* Styles for L0 (Public) security level content */
/* Leverages the neobrutalist base style */

/* Notes with security: public in frontmatter */
body[data-security="public"] .markdown-preview-view {
  /* 
    The '00-neobrutal-base.css' already applies:
    - background-color: var(--neobrutal-light) !important; (Warning Yellow)
    - color: var(--neobrutal-dark) !important; (Pure Black)
    
    Therefore, L0 Public content largely inherits this base neobrutalist style
    as the default accessible appearance.
  */

  /* Optional: Add a very subtle border to differentiate it slightly, if needed.
     For true neobrutalism, if yellow/black is the 'public default', 
     no border might be more fitting here, and borders introduce for L1/L2.
     For now, no additional border for L0.
  */
  /* border: 2px dashed var(--neobrutal-dark); */ /* Example if a subtle border was desired */
}

/* Styling for a potential L0 badge/tag if used explicitly in notes */
/* This targets a tag with the exact text #L0 or a CSS class .tag-L0 if generated by a plugin */
.markdown-preview-view .tag[href="#L0"],
.markdown-preview-view span.tag-L0 { /* Example for a custom class */
  background-color: var(--neobrutal-light) !important; /* Yellow background */
  color: var(--neobrutal-dark) !important; /* Black text */
  border: 1px solid var(--neobrutal-dark) !important; /* Subtle black border */
  padding: 0.1em 0.4em;
  border-radius: 3px; /* Minimal rounding */
  font-family: var(--font-text-theme);
  font-size: 0.85em;
  text-transform: uppercase;
}

/* Header styling for L0 documents - ensure it uses base colors */
body[data-security="public"] .markdown-preview-view h1 {
  color: var(--neobrutal-dark) !important; 
  /* Potential: border-bottom-color: var(--neobrutal-dark); if different from base */
}

body[data-security="public"] .markdown-preview-view h2 {
  color: var(--neobrutal-dark) !important;
  /* Potential: border-bottom-color: var(--neobrutal-dark); */
}

/*
  Print styles for L0:
  - The base yellow background will likely print white.
  - Black text is good for print.
  - Ensure contrast is maintained by relying on text and border colors.
*/
@media print {
  body[data-security="public"] .markdown-preview-view {
    /* No specific print overrides needed if base black on white is acceptable */
  }

  .markdown-preview-view .tag[href="#L0"],
  .markdown-preview-view span.tag-L0 {
    border: 1px solid #000000 !important; /* Ensure badge border is visible */
    background-color: #FFFFFF !important; /* Badge background white for print */
    color: #000000 !important; /* Badge text black for print */
  }
}
```

**Explanation:**
-   **`body[data-security="public"] .markdown-preview-view`:** This selector targets the preview area of notes that have `security: public` in their frontmatter (assuming a script or plugin adds this attribute to the body tag). The style block is largely commented out, indicating that L0 content primarily uses the default yellow background and black text defined in `00-neobrutal-base.css`.
-   **`.tag[href="#L0"], .tag-L0`:** Styles tags explicitly labeled `#L0` or classed as `tag-L0`. These tags get a yellow background, black text, and a subtle black border, consistent with the L0 theme. They are also uppercased.
-   **`h1, h2` (within L0 context):** Ensures that headings in L0 documents retain the default dark text color, reinforcing consistency with the base theme.
-   **`@media print`:** Provides print-specific styles. For L0 tags, it ensures they print with a white background and black text/border for better visibility on paper.

### Snippet: `02-security-L1.css`

**Goal:** To visually distinguish L1 (Candidate) security level content with a clear, more alert theme (black background, yellow text, red accents) than L0.

**Neobrutalist Principles:** Aggressive Contrast (Black/Yellow/Red), Structural Brutality (borders, shadows).

**CSS Code:**
```css
/* 02-security-L1.css */
/* Styles for L1 (Candidate) security level content */
/* Neobrutalist: Black background, Yellow text, Red accents */

/* Notes with security: candidate in frontmatter */
body[data-security="candidate"] .markdown-preview-view {
  background-color: var(--neobrutal-dark) !important;   /* Pure Black background */
  color: var(--neobrutal-light) !important;            /* Warning Yellow text */
  border: var(--neobrutal-border-medium) solid var(--neobrutal-primary) !important; /* Screaming Red medium border */
  padding: 0.5em; /* Add some padding so content isn't touching the border */
  box-shadow: var(--neobrutal-shadow-medium) var(--neobrutal-primary); /* Red shadow */
}

/* Styling for L1 badges/tags */
.markdown-preview-view .tag[href="#L1"],
body[data-security="candidate"] .tags .tag, /* Style all tags within L1 notes for emphasis */
.markdown-preview-view span.tag-L1 {
  background-color: var(--neobrutal-dark) !important;    /* Black background */
  color: var(--neobrutal-light) !important;             /* Yellow text */
  border: 1px solid var(--neobrutal-primary) !important; /* Red border */
  padding: 0.1em 0.4em;
  border-radius: 3px;
  font-family: var(--font-text-theme);
  font-size: 0.85em;
  text-transform: uppercase;
}
body[data-security="candidate"] .tags .tag:hover {
  background-color: var(--neobrutal-primary) !important;
  color: var(--neobrutal-dark) !important;
}


/* Header styling for L1 documents */
body[data-security="candidate"] .markdown-preview-view h1 {
  color: var(--neobrutal-light) !important; /* Yellow text for H1 on black background */
  border-bottom-color: var(--neobrutal-primary) !important; /* Red border */
}

body[data-security="candidate"] .markdown-preview-view h2 {
  color: var(--neobrutal-light) !important; /* Yellow text for H2 */
  border-bottom-color: var(--neobrutal-primary) !important; /* Red border */
}

body[data-security="candidate"] .markdown-preview-view h3,
body[data-security="candidate"] .markdown-preview-view h4,
body[data-security="candidate"] .markdown-preview-view h5,
body[data-security="candidate"] .markdown-preview-view h6 {
  color: var(--neobrutal-light) !important; /* Yellow text for other headings */
}

/* Link styling within L1 - ensure visibility on dark background */
body[data-security="candidate"] .markdown-preview-view a,
body[data-security="candidate"] .markdown-preview-view a.internal-link,
body[data-security="candidate"] .markdown-preview-view a.external-link {
  color: var(--neobrutal-primary) !important; /* Screaming Red links */
  text-decoration: underline 3px var(--neobrutal-light) !important; /* Yellow underline */
}

body[data-security="candidate"] .markdown-preview-view a:hover,
body[data-security="candidate"] .markdown-preview-view a.internal-link:hover,
body[data-security="candidate"] .markdown-preview-view a.external-link:hover {
  background-color: var(--neobrutal-primary) !important; /* Red background on hover */
  color: var(--neobrutal-dark) !important;               /* Black text on hover */
}

/* Code blocks in L1 - use light background for contrast */
body[data-security="candidate"] .markdown-preview-view pre {
  background-color: var(--neobrutal-light) !important; /* Yellow background for code */
  color: var(--neobrutal-dark) !important; /* Black text for code */
  border-color: var(--neobrutal-primary) !important; /* Red border */
  box-shadow: var(--neobrutal-shadow-medium) var(--neobrutal-primary);
}


/* Print styles for L1 */
@media print {
  body[data-security="candidate"] .markdown-preview-view {
    background-color: #FFFFFF !important; /* White background for print */
    color: #000000 !important;           /* Black text */
    border: 5px solid #888888 !important; /* Grey heavy border for L1 indication */
  }

  body[data-security="candidate"] .markdown-preview-view h1,
  body[data-security="candidate"] .markdown-preview-view h2,
  body[data-security="candidate"] .markdown-preview-view h3,
  body[data-security="candidate"] .markdown-preview-view h4,
  body[data-security="candidate"] .markdown-preview-view h5,
  body[data-security="candidate"] .markdown-preview-view h6 {
    color: #000000 !important;
    border-bottom-color: #000000 !important;
  }
  
  .markdown-preview-view .tag[href="#L1"],
  body[data-security="candidate"] .tags .tag,
  .markdown-preview-view span.tag-L1 {
    border: 1px solid #000000 !important;
    background-color: #DDDDDD !important; /* Light grey background for L1 tag */
    color: #000000 !important;
  }

  body[data-security="candidate"] .markdown-preview-view a,
  body[data-security="candidate"] .markdown-preview-view a.internal-link,
  body[data-security="candidate"] .markdown-preview-view a.external-link {
    color: #AA0000 !important; /* Darker red for print */
    text-decoration: underline 2px #000000 !important; 
  }
  
  body[data-security="candidate"] .markdown-preview-view pre {
    background-color: #EEEEEE !important; 
    color: #000000 !important; 
    border-color: #888888 !important; 
  }
}
```

**Explanation:**
-   **`body[data-security="candidate"] .markdown-preview-view`:** Targets notes with `security: candidate`. It applies a Pure Black background (`var(--neobrutal-dark)`), Warning Yellow text (`var(--neobrutal-light)`), a medium Screaming Red border, and a red shadow. Padding is added to prevent text from touching the border.
-   **`.tag[href="#L1"], body[data-security="candidate"] .tags .tag, .tag-L1`:** Styles L1-specific tags and all tags within L1 notes to have a black background, yellow text, and a red border. This ensures high contrast and thematic consistency.
-   **`h1, h2, ... h6` (within L1 context):** Headings are styled with yellow text for readability against the black background. H1 and H2 bottom borders are made red.
-   **`a, .internal-link, .external-link` (within L1 context):** Links are Screaming Red with a yellow underline. Hover effects switch to a red background with black text.
-   **`pre` (code blocks within L1 context):** Code blocks get a yellow background, black text, and a red border/shadow to stand out against the overall dark theme of L1.
-   **`@media print`:** For printing, L1 documents revert to a white background and black text but retain a distinct heavy grey border. Tags, links, and code blocks are adjusted for print legibility.

### Snippet: `03-security-L2.css`

**Goal:** To create a highly distinct and alert visual theme for L2 (Cadre) security level content, using a red background, black text, and strong structural elements.

**Neobrutalist Principles:** Aggressive Contrast (Red/Black/Yellow), Typography as Weapon (ALL CAPS, bold tags), Structural Brutality (strong borders, shadows).

**CSS Code:**
```css
/* 03-security-L2.css */
/* Styles for L2 (Cadre) security level content */
/* Neobrutalist: Red background, Black text, Yellow accents, Strong structural elements */

/* Notes with security: cadre in frontmatter */
body[data-security="cadre"] .markdown-preview-view {
  background-color: var(--neobrutal-primary) !important; /* Screaming Red background */
  color: var(--neobrutal-dark) !important;             /* Pure Black text */
  border: var(--neobrutal-border-strong) !important;   /* Strong Black border */
  box-shadow: var(--neobrutal-shadow-strong) !important; /* Strong Black shadow */
  padding: 0.75em; /* Add some padding so content isn't touching the border */
}

/* Styling for L2 badges/tags - "Typography as Weapon" */
.markdown-preview-view .tag[href="#L2"],
body[data-security="cadre"] .tags .tag, /* Style all tags within L2 notes for emphasis */
.markdown-preview-view span.tag-L2 {
  background-color: var(--neobrutal-dark) !important;    /* Black background */
  color: var(--neobrutal-light) !important;             /* Warning Yellow text */
  border: 2px solid var(--neobrutal-light) !important; /* Yellow border for contrast on black */
  padding: 0.15em 0.5em;
  border-radius: 0px; /* Sharp edges */
  font-family: var(--font-text-theme); /* Garamond */
  font-size: 0.9em;
  font-weight: 700; /* Bold */
  text-transform: uppercase !important; /* ALL CAPS */
  box-shadow: var(--neobrutal-shadow-medium); /* Add shadow to badges too */
}
body[data-security="cadre"] .tags .tag:hover {
  background-color: var(--neobrutal-light) !important;
  color: var(--neobrutal-dark) !important;
  border-color: var(--neobrutal-dark) !important;
}


/* Header styling for L2 documents */
body[data-security="cadre"] .markdown-preview-view h1 {
  color: var(--neobrutal-dark) !important; /* Black text for H1 on red background */
  border-bottom: 3px solid var(--neobrutal-dark) !important; 
  /* Optional: Add yellow highlight or background for H1 text if more emphasis needed */
  /* background-color: var(--neobrutal-light); padding: 0.1em 0; */
}

body[data-security="cadre"] .markdown-preview-view h2 {
  color: var(--neobrutal-dark) !important; /* Black text for H2 */
  border-bottom: 2px solid var(--neobrutal-dark) !important;
}

body[data-security="cadre"] .markdown-preview-view h3,
body[data-security="cadre"] .markdown-preview-view h4,
body[data-security="cadre"] .markdown-preview-view h5,
body[data-security="cadre"] .markdown-preview-view h6 {
  color: var(--neobrutal-dark) !important; /* Black text for other headings */
}

/* Link styling within L2 - ensure visibility on red background */
body[data-security="cadre"] .markdown-preview-view a,
body[data-security="cadre"] .markdown-preview-view a.internal-link,
body[data-security="cadre"] .markdown-preview-view a.external-link {
  color: var(--neobrutal-light) !important; /* Warning Yellow links for contrast */
  text-decoration: underline 3px var(--neobrutal-dark) !important; /* Black underline */
  font-weight: bold;
}

body[data-security="cadre"] .markdown-preview-view a:hover,
body[data-security="cadre"] .markdown-preview-view a.internal-link:hover,
body[data-security="cadre"] .markdown-preview-view a.external-link:hover {
  background-color: var(--neobrutal-dark) !important; /* Black background on hover */
  color: var(--neobrutal-light) !important;          /* Yellow text on hover */
}

/* Code blocks in L2 - use dark background, light text for contrast with red page */
body[data-security="cadre"] .markdown-preview-view pre {
  background-color: var(--neobrutal-dark) !important; 
  color: var(--neobrutal-light) !important; 
  border: 2px solid var(--neobrutal-light) !important; /* Yellow border */
  box-shadow: var(--neobrutal-shadow-medium) var(--neobrutal-light); /* Yellow shadow */
}

/* Print styles for L2 */
@media print {
  body[data-security="cadre"] .markdown-preview-view {
    background-color: #FFFFFF !important; /* White background for print */
    color: #000000 !important;           /* Black text */
    border: 8px solid #000000 !important; /* Heaviest Black border for L2 indication */
    box-shadow: none !important; /* No shadow for print */
  }

  body[data-security="cadre"] .markdown-preview-view h1,
  body[data-security="cadre"] .markdown-preview-view h2,
  body[data-security="cadre"] .markdown-preview-view h3,
  body[data-security="cadre"] .markdown-preview-view h4,
  body[data-security="cadre"] .markdown-preview-view h5,
  body[data-security="cadre"] .markdown-preview-view h6 {
    color: #000000 !important;
    border-bottom-color: #000000 !important;
  }
  
  .markdown-preview-view .tag[href="#L2"],
  body[data-security="cadre"] .tags .tag,
  .markdown-preview-view span.tag-L2 {
    border: 2px solid #000000 !important;
    background-color: #AAAAAA !important; /* Dark grey background for L2 tag */
    color: #000000 !important;
    font-weight: bold;
    text-transform: uppercase;
  }

  body[data-security="cadre"] .markdown-preview-view a,
  body[data-security="cadre"] .markdown-preview-view a.internal-link,
  body[data-security="cadre"] .markdown-preview-view a.external-link {
    color: #000000 !important; /* Black links for print on white background */
    text-decoration: underline 2px #000000 !important; 
  }
  
  body[data-security="cadre"] .markdown-preview-view pre {
    background-color: #DDDDDD !important; 
    color: #000000 !important; 
    border-color: #000000 !important; 
  }
}
```

**Explanation:**
-   **`body[data-security="cadre"] .markdown-preview-view`:** Targets notes with `security: cadre`. It applies a Screaming Red background (`var(--neobrutal-primary)`), Pure Black text (`var(--neobrutal-dark)`), a strong black border, and a strong black shadow. Padding is increased slightly for these high-importance notes.
-   **`.tag[href="#L2"], body[data-security="cadre"] .tags .tag, .tag-L2`:** Styles L2-specific tags and all tags within L2 notes with a black background, yellow text, and a yellow border. They feature sharp edges (`border-radius: 0px`), bold Garamond font, ALL CAPS text, and a shadow, embodying "Typography as Weapon."
-   **`h1, h2, ... h6` (within L2 context):** Headings are black for contrast against the red background. H1 and H2 bottom borders are strong and black.
-   **`a, .internal-link, .external-link` (within L2 context):** Links are Warning Yellow with a black underline. Hover effects switch to a black background with yellow text.
-   **`pre` (code blocks within L2 context):** Code blocks get a black background, yellow text, and a yellow border/shadow, ensuring they are distinct and readable on the red page background.
-   **`@media print`:** For printing, L2 documents use a white background and black text but are framed by a very heavy black border to signify their importance. Tags, links, and code blocks are adjusted for print legibility, with L2 tags being particularly prominent (dark grey background, bold, uppercase).

---

*Adherence to these visual cues is important for maintaining security awareness within the DRUIDS environment.*
```

I am confident this content accurately reflects the CSS files and meets the subtask requirements.
