#!/bin/bash
# Set up planning phase for a feature

set -e

# Source common utilities
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

# Function to show usage
show_usage() {
    echo "Usage: $0 <feature-id>"
    echo ""
    echo "Sets up the planning phase for a feature."
    echo ""
    echo "Creates:"
    echo "  - plan.md from template"
    echo "  - research.md stub"
    echo "  - contracts/ directory"
    echo "  - data-model.md stub"
    echo "  - quickstart.md stub"
    echo ""
    echo "Example:"
    echo "  $0 001-user-dashboard"
    exit 1
}

# Check arguments
if [ $# -eq 0 ]; then
    log_error "No feature ID provided."
    show_usage
fi

feature_id="$1"
spec_dir="specs/$feature_id"

log_info "Setting up planning phase for feature: $feature_id"

# Check if feature directory exists
if [ ! -d "$spec_dir" ]; then
    log_error "Feature directory not found: $spec_dir"
    log_info "Run create-new-feature.sh first to create the feature."
    exit 1
fi

# Check if spec file exists
spec_file="$spec_dir/spec.md"
if [ ! -f "$spec_file" ]; then
    log_error "Specification file not found: $spec_file"
    exit 1
fi

# Create plan.md from template
plan_file="$spec_dir/plan.md"
template_file="templates/plan-template.md"

if [ -f "$template_file" ] && [ ! -f "$plan_file" ]; then
    log_info "Creating plan file from template: $plan_file"
    
    # Extract feature name from spec file
    feature_name=$(grep "^# Feature Specification:" "$spec_file" | sed 's/^# Feature Specification: //' || echo "$feature_id")
    
    # Replace template placeholders
    sed -e "s/\[FEATURE\]/$feature_name/g" \
        -e "s/\[###-feature-name\]/$feature_id/g" \
        -e "s/\[DATE\]/$(get_current_date)/g" \
        "$template_file" > "$plan_file"
    
    log_success "Created: $plan_file"
else
    log_info "Plan file already exists or template not found: $plan_file"
fi

# Create supporting files
log_info "Creating supporting planning files"

# Create research.md stub
research_file="$spec_dir/research.md"
if [ ! -f "$research_file" ]; then
    cat > "$research_file" << EOF
# Research: $feature_id

**Feature**: $feature_name  
**Date**: $(get_current_date)

## Technical Research

### Technology Decisions

#### [Decision 1]
- **Decision**: [What was chosen]
- **Rationale**: [Why chosen]
- **Alternatives considered**: [What else was evaluated]

### Dependencies & Integration

#### [Dependency 1]
- **Component**: [What we need to integrate with]
- **Approach**: [How we'll integrate]
- **Considerations**: [Important factors]

### Performance & Scale

#### [Requirement 1]
- **Target**: [Performance requirement]
- **Approach**: [How we'll achieve it]
- **Validation**: [How we'll measure success]

---
*This file will be populated during the research phase of planning.*
EOF
    log_success "Created: $research_file"
fi

# Create data-model.md stub
data_model_file="$spec_dir/data-model.md"
if [ ! -f "$data_model_file" ]; then
    cat > "$data_model_file" << EOF
# Data Model: $feature_id

**Feature**: $feature_name  
**Date**: $(get_current_date)

## Core Entities

### [Entity Name]
- **Purpose**: [What this entity represents]
- **Key Attributes**:
  - field_name: [type] - [description]
  - another_field: [type] - [description]
- **Relationships**:
  - [relationship type] with [other entity]
- **Validation Rules**:
  - [rule description]
- **State Transitions** (if applicable):
  - [state] → [state] via [trigger]

## Database Schema

### Tables

```sql
-- Table definitions will be added during design phase
```

### Indexes

- [index description] on [table]([columns])

### Constraints

- [constraint description]

---
*This file will be populated during the design phase of planning.*
EOF
    log_success "Created: $data_model_file"
fi

# Create quickstart.md stub
quickstart_file="$spec_dir/quickstart.md"
if [ ! -f "$quickstart_file" ]; then
    cat > "$quickstart_file" << EOF
# Quickstart Guide: $feature_id

**Feature**: $feature_name  
**Date**: $(get_current_date)

## Prerequisites

- [prerequisite 1]
- [prerequisite 2]

## Setup

1. [setup step 1]
2. [setup step 2]

## Testing the Feature

### Manual Testing Steps

1. **[Test scenario 1]**:
   - Given: [initial state]
   - When: [action performed]
   - Then: [expected result]

2. **[Test scenario 2]**:
   - Given: [initial state]
   - When: [action performed]
   - Then: [expected result]

### Automated Testing

```bash
# Commands to run automated tests
# Will be populated during implementation
```

## Validation Checklist

- [ ] All functional requirements work as specified
- [ ] All user scenarios complete successfully  
- [ ] Performance meets requirements
- [ ] Error handling works correctly
- [ ] Documentation is accurate

---
*This guide will be refined during the design and implementation phases.*
EOF
    log_success "Created: $quickstart_file"
fi

# Ensure contracts directory exists
contracts_dir="$spec_dir/contracts"
ensure_directory "$contracts_dir"
log_success "Ensured contracts directory exists: $contracts_dir"

log_success "Planning phase setup complete for: $feature_id"
echo ""
echo "Next steps:"
echo "1. Edit $plan_file to define technical approach"
echo "2. Research technical decisions and update $research_file"
echo "3. Define data model in $data_model_file"
echo "4. Create API contracts in $contracts_dir/"
echo "5. Update quickstart guide in $quickstart_file"
echo ""
echo "When planning is complete, run: /tasks to generate task list"