# .github/scripts/validate_classifications.py
import os
import sys
import yaml # PyYAML
from pathlib import Path

def get_frontmatter(filepath):
    try:
        text = Path(filepath).read_text(encoding='utf-8')
        if not text.startswith("---"):
            return None # No frontmatter
        
        end_fm = text.find("---", 3)
        if end_fm == -1:
            return None # Malformed frontmatter
        
        frontmatter_text = text[3:end_fm]
        return yaml.safe_load(frontmatter_text)
    except Exception as e:
        print(f"Error reading/parsing frontmatter for {filepath}: {e}", file=sys.stderr)
        return None

def get_classification_level(frontmatter, filepath_for_warning):
    if not frontmatter or 'classification_level' not in frontmatter:
        # print(f"Info: No 'classification_level' in frontmatter for {filepath_for_warning}. Defaulting to L0.", file=sys.stderr)
        return 0 # Default to L0 if not specified
    
    level_str = str(frontmatter['classification_level']).upper()
    if level_str == 'L0': return 0
    if level_str == 'L1': return 1
    if level_str == 'L2': return 2
    print(f"Warning: Unknown classification_level '{frontmatter['classification_level']}' in {filepath_for_warning}. Defaulting to L0.", file=sys.stderr)
    return 0 # Default for unknown values

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python validate_classifications.py \"<space_separated_filenames>\" <max_allowed_level_int>", file=sys.stderr)
        sys.exit(2) # Different exit code for usage error

    changed_files_str = sys.argv[1]
    max_allowed_level = int(sys.argv[2])
    
    if not changed_files_str.strip():
        print("No markdown files changed or passed to script.")
        sys.exit(0)

    # Handle cases where all_changed_files might be quoted or have extra spaces
    changed_files = [f.strip() for f in changed_files_str.split(' ') if f.strip() and f.strip().endswith('.md')]
    
    if not changed_files:
        print("No valid markdown file names (.md extension) after parsing input.")
        sys.exit(0)

    violations = []

    print(f"Max allowed level for this PR target branch: L{max_allowed_level}")
    print(f"Checking {len(changed_files)} file(s): {changed_files}")


    for filepath_str in changed_files:
        filepath = Path(filepath_str) # Convert to Path object
        if not filepath.exists():
            print(f"Warning: File '{filepath}' does not exist (perhaps it was deleted in this PR). Skipping.", file=sys.stderr)
            continue

        print(f"Checking file: {filepath} ...")
        frontmatter = get_frontmatter(filepath)
        file_level = get_classification_level(frontmatter, str(filepath))
        
        classification_display = "N/A"
        if frontmatter:
            classification_display = frontmatter.get('classification_level', 'L0 (defaulted, not specified)')
        elif frontmatter is None and filepath.read_text(encoding='utf-8').startswith("---"): # check if it was a parsing error vs no frontmatter
             classification_display = 'Error parsing frontmatter'
        else: # No frontmatter block at all
            classification_display = 'L0 (no frontmatter)'


        print(f"  - Found classification: {classification_display} (parsed as L{file_level})")

        if file_level > max_allowed_level:
            violations.append(f"File '{filepath}' (classified as L{file_level}, displayed as '{classification_display}') exceeds max allowed L{max_allowed_level} for target branch.")
    
    if violations:
        print("\nSecurity Classification Violations Found:", file=sys.stderr)
        for v in violations:
            print(f"- {v}", file=sys.stderr)
        sys.exit(1) # Fail the script
    else:
        print("\nAll checked files comply with security classification policy.")
        sys.exit(0)
