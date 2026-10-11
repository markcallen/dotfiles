# Product Requirements Document

This file records durable product and operator intent for this repository. Assigned issue acceptance criteria govern individual tasks; reconcile any conflict with this document. Update the relevant section when intended behavior, installation, or runtime expectations change, and keep it aligned with the delivered work.

## How To Use This Document

- Add or update a section when intended behavior changes; routine fixes and documentation edits do not need a new section.
- Keep requirement IDs and acceptance criteria stable when possible.
- Reference relevant requirement IDs in tests and pull requests where useful.
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
- Keep rule loading and behavior changes reviewable and verifiable.
- Make test and manual verification expectations traceable to requirements.

### Non-Goals
- End-user documentation for every tool in this repo
- Replacing focused README or app-specific docs

### Requirements
- R1: Changes to intended installation, runtime, or rule-loading behavior update the relevant `PRD.md` section before completion.
- R2: `PRD.md` must remain consistent with the code on the branch before work is considered done.
- R3: Requirements and acceptance criteria implemented in code must have meaningful automated checks or explicit manual verification steps.
- R4: Changes that affect macOS and Linux behavior must document platform-specific expectations and any verification gaps.
- R5: The canonical global core is checked in at `agents/AGENTS.md`; the Codex-discovered copy must match it, and installer mappings must point to valid files. Supporting playbooks load on demand.

### Acceptance Criteria
- AC1: Agent guidance directs contributors to reconcile assigned acceptance criteria with durable repo intent and update this document when intended behavior changes.
- AC2: A failing regression test is preferred for reproducible bugs; meaningful checks or documented manual verification cover other relevant behavior.
- AC3: Repo-local guidance explains how shell, dotbot, and cross-platform changes are verified.
- AC4: A reproducible check detects Codex-copy drift and validates the agent-rule link mapping in a disposable home.

### Constraints
- This repository is primarily configuration and scripting, so some behavior may require manual verification in addition to automated tests.
- The `docs/` directory remains reserved for user-facing documentation rather than the canonical PRD.

### Risks
- Contributors may treat PRD updates as bureaucracy and skip meaningful requirement changes.
- Some config changes are difficult to automate fully across both operating systems.

### Rollout / Migration
- Keep repo-local guidance, the canonical core, generated Codex copy, and link checks aligned.

### Observability / Verification
- Automated verification: Use the rule-maintenance checks for this guidance and the submodule's `dotbot/test/test` only for relevant Dotbot behavior.
- Manual verification: Record explicit macOS/Linux validation steps when automation is incomplete.

### Change Log
- 2026-04-12: Established repo-root `PRD.md` as the canonical product and operator contract for non-trivial changes in this repository.
- 2026-10-10: Made rule loading verifiable and changed requirement/test guidance to match task scope and actual repository checks.
