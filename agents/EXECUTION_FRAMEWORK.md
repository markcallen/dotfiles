# Execution Framework

Operating model for designing, reviewing, and shipping software under production responsibility and CI/CD discipline.

## 0. Operating Modes and Decision Matrix

### 0.1 Modes

- **Autonomous Execution**: implement directly, then report evidence.
- **Approval-Required Execution**: present options and recommendation, then wait for explicit confirmation.


## 1. Orchestration Model

### 1.1 PRD First

For any non-trivial change, the governing product and operator requirements must be defined before implementation starts.

- Identify the relevant section in the repo-root `PRD.md`.
- If the work changes behavior, workflow, acceptance criteria, rollout, constraints, or operator expectations, update `PRD.md` first.
- Treat `PRD.md` as the canonical source for acceptance criteria and intended behavior.
- If implementation reveals a requirement change, stop and update `PRD.md` in the same branch before continuing.

Nothing ships if the code, tests, and `PRD.md` disagree.

### 1.2 Plan Before You Touch Code

For non-trivial changes (3+ steps, cross-cutting concern, or architectural impact):

- Enter explicit **Plan Mode**.
- Write a structured plan in `tasks/todo.md`.
- Define the governing `PRD.md` section, scope, constraints, tradeoffs, risks, test strategy, and rollback strategy.

If assumptions break mid-stream:

1. Stop.
2. Re-plan.
3. Document direction change and why.

Verification is planned work, not cleanup work.

### 1.3 Subagent Strategy (Separation of Cognitive Concerns)

Treat subagents as isolated review pods:

- One responsibility per subagent.
- Offload research, exploratory refactors, performance profiling, and edge-case analysis.
- Keep main context focused on architecture and decisions.

For complex work, parallelize investigations and consolidate findings into one structured summary.

### 1.4 Continuous Improvement Loop

After each correction:

- Update `tasks/lessons.md`.
- Capture the repeatable failure pattern.
- Add a preventative rule.
- Record the trigger that should catch this earlier next time.

At session start, review relevant lessons before implementation.

### 1.5 Proof Before Done

Nothing is complete until evidence is attached.

Required evidence:

- Governing `PRD.md` section and any changes made to it.
- Test commands executed and result status.
- Behavior diff summary (before vs after).
- Logs or traces validating expected path.
- Edge case and failure path validation.
- Rollback path validated and documented.

Completion gate:

> Would a staff engineer sign off based on the evidence alone?

### 1.6 Demand Elegance (Without Over-Engineering)

For non-trivial work, ask:

> Is this the cleanest reliable version of this solution?

If fix quality is hacky, redesign before merge.

For trivial changes:

- Avoid speculative abstractions.
- Prefer local clarity over generic frameworks.

### 1.7 TDD Execution Standard

For any bug fix, feature, refactor with behavioral impact, or contract change:

1. Derive tests from `PRD.md` acceptance criteria.
2. Write the smallest failing test that proves the requirement is not yet met.
3. Confirm the test fails for the right reason.
4. Implement the minimum change needed to make the test pass.
5. Refactor only with the full relevant test set green.
6. Record the requirement IDs and evidence linking acceptance criteria to tests.

If work cannot be covered by automation yet, document the gap explicitly and add the best available manual verification steps derived from the acceptance criteria.

### 1.8 Autonomous Bug Resolution

For bugs in Autonomous mode:

- Identify root cause and show evidence (logs, traces, failing tests, or repro steps).
- Update `PRD.md` if the shipped behavior or acceptance criteria need clarification.
- Fix the bug through the TDD execution standard.
- Add a regression test.
- Validate fix against failure path.
- Report evidence and blast radius.

For bugs that match Approval-Required criteria, switch modes and request confirmation before implementation.

## 2. Task Lifecycle Discipline

1. **Plan**: Add checklist items in `tasks/todo.md` with observable outcomes.
2. **Review**: Confirm the governing `PRD.md` section, direction, and mode (Autonomous vs Approval-Required).
3. **Execute**: Complete tasks through TDD and mark done only after verification.
4. **Explain**: Summarize milestone outcomes and tradeoffs.
5. **Document**: Record final outcomes and `PRD.md` updates in `tasks/todo.md`.
6. **Capture Lessons**: Add durable learnings to `tasks/lessons.md`.

## 3. Core Engineering Principles

- **Correctness and safety first**: no change is acceptable if correctness or security is uncertain.
- **PRD is the contract**: implementation, tests, and reviews anchor to the current `PRD.md`.
- **Simplicity first**: clear control flow and predictable behavior.
- **No lazy fixes**: root cause over patch.
- **Minimal surface area**: touch only required code paths.
- **Tests are mandatory**: derive them from acceptance criteria and include failure-path assertions.
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

### 4.2 Stage 0: PRD Review

Evaluate whether `PRD.md` is present, current, specific enough to build against, and consistent with the proposed implementation and tests.

### 4.3 Stage 1: Architecture Review

Evaluate component boundaries, dependency coupling, data ownership, scaling properties, single points of failure, and security architecture.

### 4.4 Stage 2: Code Quality Review

Evaluate module organization, separation of concerns, duplication, error handling, technical debt concentration, and over/under-engineering.

### 4.5 Stage 3: Test Review

Evaluate unit/integration/E2E coverage, assertion strength, traceability to acceptance criteria, failure-path coverage, edge cases, and flakiness risk.

### 4.6 Stage 4: Performance Review

Evaluate query patterns, DB access behavior, memory pressure, caching opportunities, high-complexity paths, and scaling limits.

## 5. Final Rule

Before implementation:

- Confirm mode from the decision matrix.
- Confirm the governing `PRD.md` section is current.
- If in Approval-Required mode, provide options, recommendation, and wait for confirmation.
- If in Autonomous mode, proceed through the TDD execution standard and attach proof of completion.

No silent assumptions. No surprise refactors. No hidden complexity.

We ship like we own production.
