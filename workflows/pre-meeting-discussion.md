name: Create Pre-Meeting Discussion

on:
  workflow_dispatch:
    inputs:
      meeting_date:
        description: 'Date of meeting (YYYY-MM-DD)'
        required: true
      meeting_type:
        description: 'Type of meeting'
        required: true
        default: 'general'
      security_level:
        description: 'Security classification'
        required: true
        default: 'L1'

jobs:
  create-premeeting-discussion:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v6
        with:
          github-token: ${{ secrets.DISCUSSION_TOKEN }}
          script: |
            const discussion = await github.rest.discussions.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              category_id: 'DIC_kwDOIlE1cc4CU2Mc', // ID of meeting-preparation category
              title: `Agenda Discussion: ${{ github.event.inputs.meeting_type }} Meeting - ${{ github.event.inputs.meeting_date }}`,
              body: `# Agenda Discussion: ${{ github.event.inputs.meeting_type }} Meeting - ${{ github.event.inputs.meeting_date }}

## Security Classification
${{ github.event.inputs.security_level }}

## Context
This discussion thread is for developing the agenda for the ${{ github.event.inputs.meeting_type }} meeting scheduled for ${{ github.event.inputs.meeting_date }}.

## Proposed Agenda Items
Please comment with suggested agenda items using the following format:

- **Item:** [Brief description]
- **Time needed:** [Estimated minutes]
- **Priority:** [High/Medium/Low]
- **Supporting materials:** [Links or attachments]
- **Related discussions:** [Links to relevant discussions]

## Current Draft Agenda
1. Opening and attendance (5 min)
2. [TBD based on comments]
3. [TBD based on comments]
4. Action item review (10 min)
5. Closing (5 min)`
            });
            
            // Add labels based on meeting type and status
            await github.rest.issues.addLabels({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: discussion.data.number,
              labels: ['${{ github.event.inputs.meeting_type }}-meeting', 'status:pre-meeting', 'security:${{ github.event.inputs.security_level }}']
            });
