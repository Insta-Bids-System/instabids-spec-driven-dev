# InstaBids Spec-Driven Development Framework

<div align="center">
    <h1>🚀 Build Better Software Faster</h1>
    <h3><em>AI-Assisted Spec-Driven Development for InstaBids System</em></h3>
</div>

<p align="center">
    <strong>A development methodology that puts specifications first, enabling AI coding agents to build high-quality software systematically.</strong>
</p>

---

## 🤔 What is Spec-Driven Development?

Spec-Driven Development **flips the script** on traditional software development. Instead of jumping straight to code, we start with clear specifications that define **what** we're building and **why**. This approach is particularly powerful when working with AI coding agents, as it provides them with the structured context they need to generate high-quality code.

This repository is based on [GitHub's spec-kit](https://github.com/github/spec-kit) and adapted specifically for the InstaBids ecosystem.

## ⚡ Get Started

### 1. Use the Templates

This repository provides three key templates for your development process:

- **📋 Spec Template** (`templates/spec-template.md`) - Define WHAT you want to build
- **🏗️ Plan Template** (`templates/plan-template.md`) - Define HOW you'll build it  
- **✅ Tasks Template** (`templates/tasks-template.md`) - Break it down into actionable steps

### 2. Follow the Three-Step Process

```bash
# Step 1: Create the specification
/specify Build a user dashboard that shows recent bids, project status, and notification preferences

# Step 2: Create technical implementation plan  
/plan The dashboard uses React with TypeScript, integrates with our existing API, and follows our design system

# Step 3: Break down into tasks
/tasks Create specific, actionable development tasks
```

### 3. AI Agent Commands

This framework provides three main commands for AI agents:

| Command | Purpose | Output |
|---------|---------|--------|
| `/specify` | Create business requirements specification | `specs/###-feature-name/spec.md` |
| `/plan` | Generate technical implementation plan | `specs/###-feature-name/plan.md` |
| `/tasks` | Break down into actionable development tasks | `specs/###-feature-name/tasks.md` |

## 📚 Core Methodology

### Development Phases

| Phase | Focus | Key Activities |
|-------|-------|----------------|
| **Specification** | Define the problem | <ul><li>User scenarios and acceptance criteria</li><li>Functional requirements</li><li>Success metrics</li></ul> |
| **Planning** | Design the solution | <ul><li>Technical architecture</li><li>API contracts</li><li>Data models</li></ul> |
| **Task Creation** | Break into actionable work | <ul><li>Development tasks</li><li>Testing requirements</li><li>Implementation order</li></ul> |
| **Implementation** | Build the solution | <ul><li>Follow test-driven development</li><li>Implement according to plan</li><li>Validate against specs</li></ul> |

### Why This Works with AI Agents

- **🎯 Clear Context**: AI agents work best with structured, unambiguous requirements
- **🔄 Iterative Refinement**: Each phase builds on the previous one, allowing for refinement
- **📊 Measurable Success**: Clear acceptance criteria make it easy to validate results
- **🧩 Modular Approach**: Break complex features into manageable pieces
- **📖 Documentation**: Every feature is documented before implementation

## 🏗️ Project Structure

```
your-project/
├── specs/                          # Feature specifications
│   └── 001-user-dashboard/         # Numbered feature folders
│       ├── spec.md                 # Business requirements
│       ├── plan.md                 # Technical implementation plan
│       ├── tasks.md                # Development tasks
│       ├── contracts/              # API specifications
│       └── research.md             # Technical research notes
├── memory/                         # Project constitution and guidelines
│   ├── constitution.md             # Development principles
│   └── constitution_update_checklist.md
├── scripts/                        # Automation scripts
│   ├── bash/                       # Bash scripts
│   └── powershell/                 # PowerShell scripts
└── templates/                      # Template files
    ├── spec-template.md
    ├── plan-template.md
    └── tasks-template.md
```

## 🎯 InstaBids-Specific Features

This framework has been customized for the InstaBids ecosystem:

### Built-in InstaBids Context
- Understanding of auction/bidding domain
- Integration patterns with InstaBids architecture
- Common InstaBids entities and workflows

### AI Agent Optimization
- Templates optimized for Claude Code, Cursor, GitHub Copilot
- Structured prompts that work well with coding assistants
- Progressive context building for complex features

### Quality Gates
- Constitution-based development principles
- Automated validation of specs and plans
- Test-driven development enforcement

## 🔧 Usage with Different AI Agents

### Claude Code
```bash
# Initialize with Claude Code support
specify init my-project --ai claude
```

### GitHub Copilot
```bash  
# Initialize with GitHub Copilot support
specify init my-project --ai copilot
```

### Cursor
```bash
# Initialize with Cursor support  
specify init my-project --ai cursor
```

### Gemini CLI
```bash
# Initialize with Gemini CLI support
specify init my-project --ai gemini
```

## 📖 Examples

### Example Specification
```markdown
# Feature Specification: User Bid History

## User Scenarios & Testing
- **Given** a user has submitted multiple bids, **When** they view their dashboard, **Then** they see all bids with current status
- **Given** a user clicks on a bid, **When** the detail view opens, **Then** they see bid amount, submission time, and project details

## Requirements
- **FR-001**: System MUST display user's bid history in reverse chronological order
- **FR-002**: System MUST show current status for each bid (pending, accepted, rejected)  
- **FR-003**: System MUST allow filtering by bid status
```

### Example Plan
```markdown  
# Implementation Plan: User Bid History

## Technical Context
**Language/Version**: TypeScript 5.0, React 18
**Primary Dependencies**: React Query, InstaBids Design System
**Storage**: PostgreSQL via InstaBids API
**Testing**: Jest, React Testing Library
```

## 🤝 Contributing

1. Use the spec-driven methodology for all new features
2. Follow the three-phase approach: Specify → Plan → Tasks  
3. Validate against the project constitution
4. Test specifications with real AI agents

## 🙏 Acknowledgements

This framework is built on the foundation of [GitHub's spec-kit](https://github.com/github/spec-kit), adapted and enhanced for the InstaBids ecosystem and AI-assisted development.

## 📄 License

MIT License - see [LICENSE](./LICENSE) file for details.

---

**Ready to build better software faster?** Start with a clear specification and let AI agents handle the implementation details. 🚀
