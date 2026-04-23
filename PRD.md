# Product Requirements Document

This file is the canonical product and operator contract for this repository.

Update the relevant section before implementing any non-trivial change that affects behavior, workflow, configuration, installation, or runtime expectations. Keep this file in sync with the shipped code.

## How To Use This Document

- Add or update the relevant section before implementation starts.
- Keep requirement IDs and acceptance criteria stable when possible.
- Reference requirement IDs in tasks, tests, commits, and pull requests.
- Update the change log in the touched section whenever shipped behavior changes.

## Exemptions

The following normally do not require a PRD update unless they change behavior:

- typo fixes
- comment-only edits
- formatting-only edits
- dependency or tooling maintenance with no user or operator impact

## Section Template

Copy this structure for each significant area of work.

```md
## <Area / Feature Name>

### Problem
- What problem is being solved?

### Users / Operators
- Who is affected?

### Goals
- Goal 1

### Non-Goals
- Non-goal 1

### Requirements
- R1:

### Acceptance Criteria
- AC1:

### Constraints
- Constraint 1

### Risks
- Risk 1

### Rollout / Migration
- Rollout step 1

### Observability / Verification
- Test coverage:
- Manual verification:

### Change Log
- YYYY-MM-DD: Initial entry.
```

## Repository Workflow and Configuration Changes

### Problem
- Changes to install scripts, shell setup, editor config, and dotbot behavior can drift from the intended repository workflow if they are not described in one canonical place.

### Users / Operators
- Repository owner
- Anyone installing or updating these dotfiles on macOS or Linux
- Agents making future changes

### Goals
- Keep behavioral expectations for this repo explicit and reviewable.
- Require requirement-driven implementation for non-trivial changes.
- Make test and manual verification expectations traceable to requirements.

### Non-Goals
- End-user documentation for every tool in this repo
- Replacing focused README or app-specific docs

### Requirements
- R1: Non-trivial changes affecting behavior, workflow, installation, or runtime expectations must update this `PRD.md` before implementation starts.
- R2: `PRD.md` must remain consistent with the code on the branch before work is considered done.
- R3: Requirements and acceptance criteria implemented in code must be traceable to automated tests or explicit manual verification steps.
- R4: Changes that affect macOS and Linux behavior must document platform-specific expectations and any verification gaps.

### Acceptance Criteria
- AC1: Agent guidance in this repo directs contributors to update `PRD.md` for non-trivial changes before implementation.
- AC2: Agent guidance requires tests to be derived from acceptance criteria and written before implementation for behavioral changes.
- AC3: Repo-local guidance explains how shell, dotbot, and cross-platform changes are verified.

### Constraints
- This repository is primarily configuration and scripting, so some behavior may require manual verification in addition to automated tests.
- The `docs/` directory remains reserved for user-facing documentation rather than the canonical PRD.

### Risks
- Contributors may treat PRD updates as bureaucracy and skip meaningful requirement changes.
- Some config changes are difficult to automate fully across both operating systems.

### Rollout / Migration
- Update shared agent guidance to point to this file.
- Update repo-local guidance to explain how this repo applies the PRD and TDD workflow.

### Observability / Verification
- Test coverage: Use the existing dotbot and repo test commands where behavior can be automated.
- Manual verification: Record explicit macOS/Linux validation steps when automation is incomplete.

### Change Log
- 2026-04-12: Established repo-root `PRD.md` as the canonical product and operator contract for non-trivial changes in this repository.
