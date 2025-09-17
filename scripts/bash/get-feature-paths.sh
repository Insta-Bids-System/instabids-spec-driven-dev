#!/bin/bash
# Get paths for a specific feature

set -e

# Source common utilities
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

# Function to show usage
show_usage() {
    echo "Usage: $0 <feature-id>"
    echo ""
    echo "Gets the paths for a specific feature."
    echo ""
    echo "Example:"
    echo "  $0 001-user-dashboard"
    echo ""
    echo "Output format:"
    echo "  SPEC_DIR=/path/to/specs/001-user-dashboard"
    echo "  SPEC_FILE=/path/to/specs/001-user-dashboard/spec.md"
    echo "  PLAN_FILE=/path/to/specs/001-user-dashboard/plan.md"
    echo "  TASKS_FILE=/path/to/specs/001-user-dashboard/tasks.md"
    exit 1
}

# Check arguments
if [ $# -eq 0 ]; then
    log_error "No feature ID provided."
    show_usage
fi

feature_id="$1"
spec_dir="specs/$feature_id"

# Check if feature exists
if [ ! -d "$spec_dir" ]; then
    log_error "Feature directory not found: $spec_dir"
    exit 1
fi

# Output paths
echo "SPEC_DIR=$spec_dir"
echo "SPEC_FILE=$spec_dir/spec.md"
echo "PLAN_FILE=$spec_dir/plan.md"
echo "TASKS_FILE=$spec_dir/tasks.md"
echo "CONTRACTS_DIR=$spec_dir/contracts"
echo "RESEARCH_FILE=$spec_dir/research.md"
echo "DATA_MODEL_FILE=$spec_dir/data-model.md"
echo "QUICKSTART_FILE=$spec_dir/quickstart.md"