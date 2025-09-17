#!/bin/bash
# Update agent-specific context file (CLAUDE.md, .github/copilot-instructions.md, etc.)

set -e

# Source common utilities
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

# Function to show usage
show_usage() {
    echo "Usage: $0 <agent-type>"
    echo ""
    echo "Updates the agent-specific context file with current project information."
    echo ""
    echo "Supported agent types:"
    echo "  claude    - Updates CLAUDE.md"
    echo "  copilot   - Updates .github/copilot-instructions.md"
    echo "  cursor    - Updates .cursorrules"
    echo "  gemini    - Updates GEMINI.md"
    echo ""
    echo "Example:"
    echo "  $0 claude"
    exit 1
}

# Check arguments
if [ $# -eq 0 ]; then
    log_error "No agent type provided."
    show_usage
fi

agent_type="$1"

# Check prerequisites
check_git_repo

# Determine agent file path and format
case "$agent_type" in
    claude)
        agent_file="CLAUDE.md"
        ;;
    copilot)
        agent_file=".github/copilot-instructions.md"
        ensure_directory ".github"
        ;;
    cursor)
        agent_file=".cursorrules"
        ;;
    gemini)
        agent_file="GEMINI.md"
        ;;
    *)
        log_error "Unsupported agent type: $agent_type"
        show_usage
        ;;
esac

log_info "Updating agent context file: $agent_file"

# Get project information
project_name=$(basename "$(git rev-parse --show-toplevel)")
current_date=$(get_current_date)
constitution_version="1.0.0"

# Get recent features
recent_features=""
if [ -d "specs" ]; then
    for dir in specs/*/; do
        if [ -d "$dir" ]; then
            feature_name="$(basename "$dir")"
            if [ -f "$dir/spec.md" ]; then
                recent_features="${recent_features}- ${feature_name}\n"
            fi
        fi
    done | head -5
fi

# Get tech stack information from existing files
tech_stack="InstaBids System"
if [ -f "package.json" ]; then
    tech_stack="${tech_stack}, Node.js/TypeScript"
elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    tech_stack="${tech_stack}, Python"
fi

# Create or update the agent file
case "$agent_type" in
    claude)
        create_claude_file
        ;;
    copilot)
        create_copilot_file
        ;;
    cursor)
        create_cursor_file
        ;;
    gemini)
        create_gemini_file
        ;;
esac

log_success "Agent context file updated: $agent_file"

# Function to create Claude.md
create_claude_file() {
    cat > "$agent_file" << EOF
# Claude Code Context for $project_name

## Project Overview
**Type**: InstaBids System Component  
**Architecture**: Spec-Driven Development  
**Last Updated**: $current_date  
**Constitution Version**: $constitution_version

## Development Methodology

This project follows **Spec-Driven Development** with three key commands:

### /specify Command
Create business requirements specification:
- Focus on WHAT users need and WHY
- Written for business stakeholders
- No implementation details
- Complete acceptance criteria
- Output: \`specs/###-feature-name/spec.md\`

### /plan Command  
Generate technical implementation plan:
- Define HOW to build the feature
- Technical architecture and dependencies
- API contracts and data models
- Output: \`specs/###-feature-name/plan.md\`

### /tasks Command
Break down into actionable development tasks:
- Test-driven development approach
- Ordered task list with dependencies
- Implementation guidance
- Output: \`specs/###-feature-name/tasks.md\`

## InstaBids Domain Context

### Core Entities
- **Projects**: Construction/service requests posted by homeowners
- **Contractors**: Service providers who submit bids
- **Bids**: Offers from contractors for specific projects
- **Users**: Both homeowners and contractors
- **Notifications**: Real-time updates about bid/project status

### Key Workflows
- Project posting and discovery
- Bid submission and evaluation
- Contractor verification and licensing
- Payment processing and escrow
- Review and rating systems

## Technical Standards

### Development Principles
- API-first design with OpenAPI specs
- Test-driven development (TDD mandatory)
- Contract tests validate API specifications
- Integration tests validate user scenarios
- Performance: <200ms API response time

### Architecture Patterns
- Models: Data entities and validation
- Services: Business logic orchestration
- Controllers: API endpoint handling  
- Repositories: Data access patterns

## Recent Features
EOF

    if [ -n "$recent_features" ]; then
        echo -e "$recent_features" >> "$agent_file"
    else
        echo "No features created yet." >> "$agent_file"
    fi

    cat >> "$agent_file" << EOF

## File Structure
\`\`\`
specs/                          # Feature specifications
├── 001-feature-name/           # Numbered feature folders
│   ├── spec.md                 # Business requirements
│   ├── plan.md                 # Technical plan
│   ├── tasks.md                # Development tasks
│   └── contracts/              # API specifications
memory/                         # Project constitution
├── constitution.md             # Development principles
└── constitution_update_checklist.md
templates/                      # Development templates
├── spec-template.md
├── plan-template.md
└── tasks-template.md
\`\`\`

## Constitution Compliance

All development must comply with the InstaBids Constitution:
- Specification-first development
- Test-driven development (non-negotiable)
- API-first design
- Modular architecture
- InstaBids domain focus

Review \`memory/constitution.md\` for complete requirements.

---
*This file is automatically updated by the development workflow.*
EOF
}

# Function to create Copilot instructions
create_copilot_file() {
    cat > "$agent_file" << EOF
# GitHub Copilot Instructions for $project_name

You are working on an InstaBids System component that follows Spec-Driven Development methodology.

## Development Commands

When the user types these commands, follow the specific workflows:

### /specify [description]
Create a business specification:
1. Use \`templates/spec-template.md\` as the base
2. Focus on WHAT users need and WHY (not HOW to implement)
3. Mark ambiguities with [NEEDS CLARIFICATION: question]
4. Write for business stakeholders, not developers
5. Output to \`specs/###-feature-name/spec.md\`

### /plan [tech details]
Create technical implementation plan:
1. Use \`templates/plan-template.md\` as the base
2. Define technical architecture and dependencies
3. Create API contracts and data models
4. Follow TDD principles
5. Output to \`specs/###-feature-name/plan.md\`

### /tasks
Break down into development tasks:
1. Use \`templates/tasks-template.md\` as the base
2. Generate ordered, testable tasks
3. Mark parallel tasks with [P]
4. Follow test-first approach
5. Output to \`specs/###-feature-name/tasks.md\`

## InstaBids Domain Knowledge

Core entities: Projects, Contractors, Bids, Users, Notifications
Key workflows: Project posting, bid submission, contractor verification, payments

## Code Standards

- API-first design with OpenAPI specifications
- Test-driven development (TDD mandatory)
- TypeScript for frontend, Python/Node.js for backend
- <200ms API response time requirement
- Contract tests for all API endpoints

## Architecture Patterns

Use these patterns consistently:
- Models: Data entities with validation
- Services: Business logic orchestration
- Controllers: API endpoint handling
- Repositories: Data access patterns

Follow the constitution in \`memory/constitution.md\` for all development decisions.

Last updated: $current_date
EOF
}

# Function to create Cursor rules
create_cursor_file() {
    cat > "$agent_file" << EOF
# Cursor Rules for $project_name

## Project Type
InstaBids System component using Spec-Driven Development

## Development Commands

/specify [description] - Create business specification (use templates/spec-template.md)
/plan [tech details] - Create implementation plan (use templates/plan-template.md)  
/tasks - Generate development tasks (use templates/tasks-template.md)

## Code Standards

- Follow TDD: Tests before implementation
- API-first: OpenAPI specs for all endpoints
- <200ms API response times
- TypeScript for frontend, Python/Node.js backend
- Contract tests validate API specs

## InstaBids Domain

Entities: Projects, Contractors, Bids, Users, Notifications
Workflows: Project posting, bidding, verification, payments

## Architecture

Models → Services → Controllers → API
Use dependency injection patterns
Repository pattern for data access

## Constitution

Follow memory/constitution.md for all development decisions.
Specification-first, test-driven, API-first, modular architecture.

Updated: $current_date
EOF
}

# Function to create Gemini context
create_gemini_file() {
    cat > "$agent_file" << EOF
# Gemini CLI Context for $project_name

## Project Overview
**Type**: InstaBids System Component  
**Methodology**: Spec-Driven Development  
**Updated**: $current_date

## Available Commands

### /specify [feature description]
Creates business requirements specification:
- Template: \`templates/spec-template.md\`
- Focus: WHAT users need and WHY
- Audience: Business stakeholders
- Output: \`specs/###-feature-name/spec.md\`

### /plan [technical details]  
Creates technical implementation plan:
- Template: \`templates/plan-template.md\`
- Focus: HOW to implement the feature
- Includes: Architecture, APIs, data models
- Output: \`specs/###-feature-name/plan.md\`

### /tasks
Generates actionable development tasks:
- Template: \`templates/tasks-template.md\`
- Approach: Test-driven development
- Order: Dependencies and parallel execution
- Output: \`specs/###-feature-name/tasks.md\`

## InstaBids Context

### Domain Entities
- Projects: Construction/service requests
- Contractors: Service providers  
- Bids: Contractor offers for projects
- Users: Homeowners and contractors
- Notifications: Real-time status updates

### Key Processes
1. Project posting and discovery
2. Bid submission and evaluation  
3. Contractor verification
4. Payment and escrow management
5. Reviews and ratings

## Development Standards

### Required Practices
- Specification-first development
- Test-driven development (TDD)
- API-first design with contracts
- Modular, testable architecture
- Performance: <200ms API responses

### Technology Stack
$tech_stack

### Testing Approach
- Contract tests for API validation
- Integration tests for user scenarios
- Unit tests for business logic
- Test coverage >80% for critical paths

## Current Features
EOF

    if [ -n "$recent_features" ]; then
        echo -e "$recent_features" >> "$agent_file"
    else
        echo "No features created yet." >> "$agent_file"
    fi

    cat >> "$agent_file" << EOF

## File Organization
- \`specs/\`: Feature specifications and plans
- \`memory/\`: Project constitution and guidelines
- \`templates/\`: Development templates
- \`src/\`: Source code (created during implementation)
- \`tests/\`: Test suites (created during implementation)

Refer to \`memory/constitution.md\` for complete development guidelines.

---
*Auto-updated by development workflow*
EOF
}
