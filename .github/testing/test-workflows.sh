#!/bin/bash

# KS-SBC GitHub Workflows Test Script
# This script helps automate testing of various workflows

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_OWNER="ks-sbc"
REPO_NAME=".github"
TEST_LABEL="test-automation"

# Helper functions
print_header() {
    echo -e "\n${GREEN}=== $1 ===${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check gh CLI
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) not found. Please install it first."
        exit 1
    fi
    
    # Check authentication
    if ! gh auth status &> /dev/null; then
        print_error "Not authenticated with GitHub. Run 'gh auth login'"
        exit 1
    fi
    
    print_success "Prerequisites checked"
}

# Test report workflows
test_report_workflows() {
    print_header "Testing Report Processing Workflows"
    
    # Test mass conditions report
    print_info "Creating test mass conditions report..."
    ISSUE_NUMBER=$(gh issue create \
        --title "[MASS REPORT] Test Downtown Conditions" \
        --body "### Security Classification
L0 (Public)

### Location
Downtown Test District

### Material Conditions
Test report for workflow validation

### Political Consciousness
Testing automated processing" \
        --label "$TEST_LABEL" \
        --label "type:mass-report" \
        --json number --jq '.number')
    
    print_success "Created test issue #$ISSUE_NUMBER"
    
    # Wait for workflow to process
    print_info "Waiting for workflow to process (10 seconds)..."
    sleep 10
    
    # Check if labels were applied
    LABELS=$(gh issue view $ISSUE_NUMBER --json labels --jq '.labels[].name' | tr '\n' ' ')
    if [[ $LABELS == *"security:L0"* ]]; then
        print_success "Security classification applied correctly"
    else
        print_error "Security classification not applied"
    fi
    
    # Clean up
    gh issue close $ISSUE_NUMBER
    print_success "Closed test issue #$ISSUE_NUMBER"
}

# Test education workflows
test_education_workflows() {
    print_header "Testing Education Workflows"
    
    # Test study session scheduling
    print_info "Triggering study session scheduling..."
    gh workflow run schedule-study-sessions.yml \
        -f session_date_override="2024-08-20" \
        -f create_tuesday=true \
        -f create_friday=false
    
    # Wait for workflow
    print_info "Waiting for workflow to complete (15 seconds)..."
    sleep 15
    
    # Check for created session
    SESSIONS=$(gh issue list --label "type:study-session" --limit 5 --json number,title)
    if [[ -n "$SESSIONS" ]]; then
        print_success "Study session created successfully"
        echo "$SESSIONS" | jq -r '.[] | "  Issue #\(.number): \(.title)"'
    else
        print_error "No study session found"
    fi
}

# Test democratic centralist workflows
test_demcent_workflows() {
    print_header "Testing Democratic Centralist Workflows"
    
    # Create test proposal branch
    BRANCH_NAME="proposal/test-voting-$(date +%s)"
    print_info "Creating test proposal branch: $BRANCH_NAME"
    
    git checkout -b "$BRANCH_NAME"
    echo "Test change for voting" > test-voting.txt
    git add test-voting.txt
    git commit -m "Test proposal for automated voting"
    git push origin "$BRANCH_NAME"
    
    # Create PR
    PR_NUMBER=$(gh pr create \
        --title "Test Democratic Voting Process" \
        --body "This is a test proposal to validate the voting workflow" \
        --base main \
        --head "$BRANCH_NAME" \
        --json number --jq '.number')
    
    print_success "Created test PR #$PR_NUMBER"
    
    # Simulate voting
    print_info "Simulating votes..."
    gh pr comment $PR_NUMBER --body "VOTE: FOR - Testing the voting system"
    
    # Clean up
    print_info "Cleaning up test PR and branch..."
    gh pr close $PR_NUMBER
    git checkout main
    git branch -D "$BRANCH_NAME"
    git push origin --delete "$BRANCH_NAME"
}

# Test meeting automation
test_meeting_workflows() {
    print_header "Testing Meeting Automation"
    
    # Trigger meeting agenda generation
    print_info "Generating test meeting agenda..."
    gh workflow run meeting-automation.yml -f meeting_type="general-body"
    
    # Wait for workflow
    print_info "Waiting for workflow to complete (10 seconds)..."
    sleep 10
    
    # Check for meeting issue
    MEETINGS=$(gh issue list --label "meeting" --label "status:scheduled" --limit 3 --json number,title)
    if [[ -n "$MEETINGS" ]]; then
        print_success "Meeting agenda created successfully"
        echo "$MEETINGS" | jq -r '.[] | "  Issue #\(.number): \(.title)"'
    else
        print_error "No meeting agenda found"
    fi
}

# View recent workflow runs
view_workflow_runs() {
    print_header "Recent Workflow Runs"
    
    gh run list --limit 10 --json databaseId,status,conclusion,name,createdAt | \
        jq -r '.[] | "\(.databaseId)\t\(.status)\t\(.conclusion // "pending")\t\(.name)\t\(.createdAt)"' | \
        column -t -s $'\t'
}

# Main menu
main_menu() {
    while true; do
        echo -e "\n${GREEN}KS-SBC Workflow Testing Menu${NC}"
        echo "1. Test Report Processing Workflows"
        echo "2. Test Education Workflows"
        echo "3. Test Democratic Centralist Workflows"
        echo "4. Test Meeting Automation"
        echo "5. View Recent Workflow Runs"
        echo "6. Run All Tests"
        echo "0. Exit"
        
        read -p "Select option: " choice
        
        case $choice in
            1) test_report_workflows ;;
            2) test_education_workflows ;;
            3) test_demcent_workflows ;;
            4) test_meeting_workflows ;;
            5) view_workflow_runs ;;
            6) 
                test_report_workflows
                test_education_workflows
                test_demcent_workflows
                test_meeting_workflows
                view_workflow_runs
                ;;
            0) 
                print_info "Exiting test script"
                exit 0
                ;;
            *) print_error "Invalid option" ;;
        esac
    done
}

# Main execution
main() {
    print_header "KS-SBC GitHub Workflows Test Script"
    check_prerequisites
    
    # Check if we're in the right repository
    if [[ ! -f ".github/workflows/education/schedule-study-sessions.yml" ]]; then
        print_error "This script must be run from the root of the .github repository"
        exit 1
    fi
    
    # Create test label if it doesn't exist
    if ! gh label list | grep -q "$TEST_LABEL"; then
        print_info "Creating test label: $TEST_LABEL"
        gh label create "$TEST_LABEL" --description "For automated testing only" --color "FFA500"
    fi
    
    main_menu
}

# Run main function
main "$@"