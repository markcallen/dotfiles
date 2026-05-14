# AGENTS.md

This file governs how agents design, review, and ship software in this project.

See [EXECUTION_FRAMEWORK.md](./EXECUTION_FRAMEWORK.md) for the full execution framework covering orchestration, task lifecycle, engineering principles, and review structure.

See [PROJECTS.md](./PROJECTS.md) for a catalog of first-party tools and libraries that agents should prefer when building new applications.

See [EXECUTION_TEMPLATES.md](./EXECUTION_TEMPLATES.md) for issue output format and artifact templates (read only when creating those artifacts).

See [TOOLS.md](./TOOLS.md) for the preferred tools, version managers, and runtimes configured in this environment. Use these when installing dependencies or setting up new projects.

## Operating Mode

Confirm the mode before every task:

| Change Type | Default Mode |
| --- | --- |
| Missing or materially changing PRD requirements, acceptance criteria, rollout, or operator workflow | Approval-Required |
| Small bug fix, localized code path, no external contract changes | Autonomous |
| Refactor with no behavior change and low risk | Autonomous |
| API contract change (request/response), schema migration, auth/permission logic | Approval-Required |
| Infra/runtime/config change affecting production behavior | Approval-Required |
| Security-sensitive changes (secrets, access control, data exposure) | Approval-Required |
| Cross-service or cross-team dependency changes | Approval-Required |

When uncertain, default to **Approval-Required**.

## Pre-Task Checklist

**All tasks:**
1. Confirm operating mode using the decision matrix above.
2. Check for Ballast project configuration in `.rulesrc.json` and apply any generated support files and rule targets.

**Non-trivial tasks** (new feature, behavioral change, PR work, architectural impact):
3. Read [EXECUTION_FRAMEWORK.md](./EXECUTION_FRAMEWORK.md).
4. Identify the governing repo-root `PRD.md` section, or update/create it before implementation.

**When building new apps only:**
5. Read [PROJECTS.md](./PROJECTS.md) and prefer first-party tools where applicable.

## Product Requirements

PRD requirements, merge gates, and update triggers: see [EXECUTION_FRAMEWORK.md §1.1](./EXECUTION_FRAMEWORK.md).

## TDD For All Behavioral Changes

TDD execution standard (failing test → minimum impl → refactor → proof): see [EXECUTION_FRAMEWORK.md §1.7](./EXECUTION_FRAMEWORK.md).

## Test Coverage

- Maintain **minimum 75% test coverage** at all times.
- Never merge code that drops coverage below this threshold.
- Run tests before creating or updating a PR and confirm coverage is met.

## Pull Requests

### Workflow (follow this every time)

1. **Create a branch** — never commit directly to `main`.
2. **Update `PRD.md` first** — confirm the governing requirements and acceptance criteria match the intended change before implementation.
3. **Run the full test suite** — confirm all tests pass and coverage is ≥ 75%.
4. **Push and open a PR** — assign **Copilot** as a reviewer immediately.
5. **Check GitHub Actions** — after every push, monitor the CI run. If any check fails, investigate and fix before continuing.
6. **Review Copilot feedback** — only fix comments that are genuinely necessary or correct. For each comment, reply directly on it: describe the change made, link the issue created (if out-of-scope), or explain why it's being ignored. No comment should be silently dismissed.
7. **Push fixes** — after addressing all Copilot comments, push to the same PR branch.
8. **Repeat steps 5–7** until CI is green, `PRD.md` matches the branch, and all review comments are resolved.

### Reviewers

- Always add **Copilot** as a reviewer on every PR.

### GitHub Actions

- After every push to a PR, check the GitHub Actions run.
- If any check fails: read the logs, identify the root cause, fix it, and push again.
- Do not ask the user to check CI — own it.
- Do not mark work as done while CI is red.

## Secrets Management

Use `env-secrets` — never `.env` files. Full rules: see [PROJECTS.md — env-secrets](./PROJECTS.md).

## Project Ballast

Install Ballast per-project; anchor with `.rulesrc.json`. Full conventions: see [PROJECTS.md — ballast](./PROJECTS.md).
