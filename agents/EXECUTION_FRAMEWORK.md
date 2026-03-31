# Execution Framework

Operating model for designing, reviewing, and shipping software under production responsibility and CI/CD discipline.

## 0. Operating Modes and Decision Matrix

### 0.1 Modes

- **Autonomous Execution**: implement directly, then report evidence.
- **Approval-Required Execution**: present options and recommendation, then wait for explicit confirmation.

### 0.2 Decision Matrix

| Change Type | Default Mode | Why |
| --- | --- | --- |
| Small bug fix, localized code path, no external contract changes | Autonomous | Fast, low blast radius |
| Refactor with no behavior change and low risk | Autonomous | Safe to execute with proof |
| API contract change (request/response), schema migration, auth/permission logic | Approval-Required | High compatibility and security risk |
| Infra/runtime/config change affecting production behavior | Approval-Required | Operational risk and rollback complexity |
| Security-sensitive changes (secrets, access control, data exposure) | Approval-Required | High impact if wrong |
| Cross-service or cross-team dependency changes | Approval-Required | Coordination and rollback risk |

When uncertain, default to **Approval-Required Execution**.

## 1. Orchestration Model

### 1.1 Plan Before You Touch Code

For non-trivial changes (3+ steps, cross-cutting concern, or architectural impact):

- Enter explicit **Plan Mode**.
- Write a structured plan in `tasks/todo.md`.
- Define scope, constraints, tradeoffs, risks, test strategy, and rollback strategy.

If assumptions break mid-stream:

1. Stop.
2. Re-plan.
3. Document direction change and why.

Verification is planned work, not cleanup work.

### 1.2 Subagent Strategy (Separation of Cognitive Concerns)

Treat subagents as isolated review pods:

- One responsibility per subagent.
- Offload research, exploratory refactors, performance profiling, and edge-case analysis.
- Keep main context focused on architecture and decisions.

For complex work, parallelize investigations and consolidate findings into one structured summary.

### 1.3 Continuous Improvement Loop

After each correction:

- Update `tasks/lessons.md`.
- Capture the repeatable failure pattern.
- Add a preventative rule.
- Record the trigger that should catch this earlier next time.

At session start, review relevant lessons before implementation.

### 1.4 Proof Before Done

Nothing is complete until evidence is attached.

Required evidence:

- Test commands executed and result status.
- Behavior diff summary (before vs after).
- Logs or traces validating expected path.
- Edge case and failure path validation.
- Rollback path validated and documented.

Completion gate:

> Would a staff engineer sign off based on the evidence alone?

### 1.5 Demand Elegance (Without Over-Engineering)

For non-trivial work, ask:

> Is this the cleanest reliable version of this solution?

If fix quality is hacky, redesign before merge.

For trivial changes:

- Avoid speculative abstractions.
- Prefer local clarity over generic frameworks.

### 1.6 Autonomous Bug Resolution

For bugs in Autonomous mode:

- Identify root cause and show evidence (logs, traces, failing tests, or repro steps).
- Fix the bug.
- Add a regression test.
- Validate fix against failure path.
- Report evidence and blast radius.

For bugs that match Approval-Required criteria, switch modes and request confirmation before implementation.

## 2. Task Lifecycle Discipline

1. **Plan**: Add checklist items in `tasks/todo.md` with observable outcomes.
2. **Review**: Confirm direction and mode (Autonomous vs Approval-Required).
3. **Execute**: Complete tasks and mark done only after verification.
4. **Explain**: Summarize milestone outcomes and tradeoffs.
5. **Document**: Record final outcomes in `tasks/todo.md`.
6. **Capture Lessons**: Add durable learnings to `tasks/lessons.md`.

## 3. Core Engineering Principles

- **Correctness and safety first**: no change is acceptable if correctness or security is uncertain.
- **Simplicity first**: clear control flow and predictable behavior.
- **No lazy fixes**: root cause over patch.
- **Minimal surface area**: touch only required code paths.
- **Tests are mandatory**: include failure-path assertions.
- **Explicit over clever**: optimize for maintainability.
- **Edge-case bias**: assume misuse and validate inputs.
- **DRY with judgment**: deduplicate when it improves clarity and reduces risk.

### 3.1 Tie-Break Priority (When Principles Conflict)

1. Correctness and security
2. Operability and rollback safety
3. Local clarity and maintainability
4. Minimal surface area
5. DRY improvements

## 4. Structured Engineering Review Framework

All reviews use the same structure and severity model.

### 4.1 Severity Model

- **Critical**: security, data loss, production outage, or irreversible impact.
- **High**: major user-impacting bug or strong regression risk.
- **Medium**: correctness, reliability, or maintainability issues with bounded impact.
- **Low**: clarity, style, or minor optimization.

Each issue must include:

- Severity
- User impact
- Likelihood
- Time sensitivity

### 4.2 Stage 1: Architecture Review

Evaluate component boundaries, dependency coupling, data ownership, scaling properties, single points of failure, and security architecture.

### 4.3 Stage 2: Code Quality Review

Evaluate module organization, separation of concerns, duplication, error handling, technical debt concentration, and over/under-engineering.

### 4.4 Stage 3: Test Review

Evaluate unit/integration/E2E coverage, assertion strength, failure-path coverage, edge cases, and flakiness risk.

### 4.5 Stage 4: Performance Review

Evaluate query patterns, DB access behavior, memory pressure, caching opportunities, high-complexity paths, and scaling limits.

## 5. Issue Output Format (Strict)

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

## 6. Artifact Templates

### 6.1 `tasks/todo.md` Template

```md
# Task: <title>

## Context
- Owner:
- Date:
- Mode: <Autonomous|Approval-Required>

## Scope
- In scope:
- Out of scope:

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

## Rollback Strategy
- Trigger:
- Rollback steps:
- Validation after rollback:

## Outcome
- Result:
- Evidence links/commands:
```

### 6.2 `tasks/lessons.md` Template

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

## 7. Final Rule

Before implementation:

- Confirm mode from the decision matrix.
- If in Approval-Required mode, provide options, recommendation, and wait for confirmation.
- If in Autonomous mode, proceed directly and attach proof of completion.

No silent assumptions. No surprise refactors. No hidden complexity.

We ship like we own production.
