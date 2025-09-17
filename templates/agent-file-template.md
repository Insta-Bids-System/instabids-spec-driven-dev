# [AGENT_NAME] Context for [PROJECT_NAME]

## Project Overview
**Type**: InstaBids System Component  
**Architecture**: Spec-Driven Development  
**Last Updated**: [CURRENT_DATE]  
**Constitution Version**: [VERSION]

## Development Commands

### /specify [description]
Create business requirements specification:
- Template: `templates/spec-template.md`
- Focus: WHAT users need and WHY
- Audience: Business stakeholders
- Output: `specs/###-feature-name/spec.md`

### /plan [tech details]  
Create technical implementation plan:
- Template: `templates/plan-template.md`
- Focus: HOW to implement the feature
- Includes: Architecture, APIs, data models
- Output: `specs/###-feature-name/plan.md`

### /tasks
Generate actionable development tasks:
- Template: `templates/tasks-template.md`
- Approach: Test-driven development
- Order: Dependencies and parallel execution
- Output: `specs/###-feature-name/tasks.md`

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
[RECENT_FEATURES_LIST]

## Constitution Compliance

All development must comply with the InstaBids Constitution:
- Specification-first development
- Test-driven development (non-negotiable)
- API-first design
- Modular architecture
- InstaBids domain focus

Review `memory/constitution.md` for complete requirements.

---
*This file is automatically updated by the development workflow.*