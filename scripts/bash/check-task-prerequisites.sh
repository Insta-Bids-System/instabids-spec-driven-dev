#!/bin/bash
# Check prerequisites for task execution

set -e

# Source common utilities
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

# Function to show usage
show_usage() {
    echo "Usage: $0 <feature-id>"
    echo ""
    echo "Checks if all prerequisites are met before task execution."
    echo ""
    echo "Validates:"
    echo "  - Feature specification exists and is complete"
    echo "  - Implementation plan exists and is complete"
    echo "  - Task list exists"
    echo "  - Constitution compliance"
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

log_info "Checking prerequisites for feature: $feature_id"

# Check if feature directory exists
if [ ! -d "$spec_dir" ]; then
    log_error "Feature directory not found: $spec_dir"
    exit 1
fi

# Initialize status
all_checks_passed=true

# Check specification file
spec_file="$spec_dir/spec.md"
if file_exists_and_not_empty "$spec_file"; then
    log_success "Specification file exists: $spec_file"
    
    # Check if spec is marked as complete
    if grep -q "Status.*Draft" "$spec_file"; then
        log_warning "Specification is still in Draft status"
        all_checks_passed=false
    fi
    
    # Check for unresolved clarifications
    if grep -q "\[NEEDS CLARIFICATION:" "$spec_file"; then
        log_error "Specification has unresolved clarifications"
        all_checks_passed=false
    fi
else
    log_error "Specification file missing or empty: $spec_file"
    all_checks_passed=false
fi

# Check implementation plan
plan_file="$spec_dir/plan.md"
if file_exists_and_not_empty "$plan_file"; then
    log_success "Implementation plan exists: $plan_file"
    
    # Check for unresolved technical context
    if grep -q "NEEDS CLARIFICATION" "$plan_file"; then
        log_error "Implementation plan has unresolved technical issues"
        all_checks_passed=false
    fi
else
    log_error "Implementation plan missing or empty: $plan_file"
    all_checks_passed=false
fi

# Check task list
tasks_file="$spec_dir/tasks.md"
if file_exists_and_not_empty "$tasks_file"; then
    log_success "Task list exists: $tasks_file"
else
    log_error "Task list missing or empty: $tasks_file"
    all_checks_passed=false
fi

# Check constitution compliance
constitution_file="memory/constitution.md"
if file_exists_and_not_empty "$constitution_file"; then
    log_success "Constitution file exists: $constitution_file"
else
    log_warning "Constitution file not found: $constitution_file"
fi

# Check git repository status
if git diff --quiet && git diff --staged --quiet; then
    log_success "Git repository is clean"
else
    log_warning "Git repository has uncommitted changes"
fi

# Check branch name matches feature
if git rev-parse --verify --quiet "$feature_id" >/dev/null; then
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_branch" = "$feature_id" ]; then
        log_success "On correct feature branch: $feature_id"
    else
        log_warning "Not on feature branch. Current: $current_branch, Expected: $feature_id"
    fi
else
    log_warning "Feature branch does not exist: $feature_id"
fi

# Final status
if [ "$all_checks_passed" = true ]; then
    log_success "All prerequisites met! Ready for task execution."
    exit 0
else
    log_error "Prerequisites not met. Please resolve issues before proceeding."
    exit 1
fi