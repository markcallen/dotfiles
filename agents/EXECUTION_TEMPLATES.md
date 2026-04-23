# Execution Templates

Reference templates — read this file only when actively creating one of these artifacts.

## 1. Issue Output Format (Strict)

Use this exact structure:

```md
### Issue #N: <Short Description>

**Severity:** <Critical|High|Medium|Low>
**User Impact:** <who is affected and how>
**Likelihood:** <High|Medium|Low>
**Time Sensitivity:** <Immediate|This sprint|Backlog>

**Problem**
Concrete explanation with file/line references and example behavior.

**Option A (Recommended)**
- Effort:
- Risk:
- Code Impact:
- Maintenance:

**Option B**
- Effort:
- Risk:
- Code Impact:
- Maintenance:

**Option C (Optional / Do Nothing)**
- Effort:
- Risk:
- Code Impact:
- Maintenance:

**Recommendation**
Explain why Option A is best based on correctness, risk, testability, and maintenance.

**Decision Request**
Proceed with: A (recommended), B, C, or alternate direction?
```

## 2. `tasks/todo.md` Template

```md
# Task: <title>

## Context
- Owner:
- Date:
- Mode: <Autonomous|Approval-Required>
- PRD Section:
- Requirement IDs:

## Scope
- In scope:
- Out of scope:

## Acceptance Criteria
- AC1:
- AC2:

## Constraints
- Constraint 1

## Risks and Tradeoffs
- Risk:
- Tradeoff:

## Execution Checklist
- [ ] Step 1 with observable outcome
- [ ] Step 2 with observable outcome

## Test Strategy
- Unit:
- Integration:
- E2E:
- Failure-path tests:
- Requirement-to-test mapping:

## Rollback Strategy
- Trigger:
- Rollback steps:
- Validation after rollback:

## Outcome
- Result:
- Evidence links/commands:
- PRD updates:
```

## 3. `PRD.md` Section Template

```md
## <Area / Feature Name>

### Problem
- ...

### Users / Operators
- ...

### Goals
- ...

### Non-Goals
- ...

### Requirements
- R1:

### Acceptance Criteria
- AC1:

### Constraints
- ...

### Risks
- ...

### Rollout / Migration
- ...

### Observability / Verification
- Test coverage:
- Manual verification:

### Change Log
- YYYY-MM-DD:
```

## 4. `tasks/lessons.md` Template

```md
# Lessons

## <YYYY-MM-DD> <Short Title>
- Incident/bug:
- Root cause pattern:
- Early signal missed:
- Preventative rule:
- Validation added (test/check/alert):
- Next trigger to detect sooner:
```
