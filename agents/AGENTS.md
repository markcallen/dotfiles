# AGENTS.md

This file governs how agents design, review, and ship software in this project.

See [EXECUTION_FRAMEWORK.md](./EXECUTION_FRAMEWORK.md) for the full execution framework covering orchestration, task lifecycle, engineering principles, and review structure.

See [PROJECTS.md](./PROJECTS.md) for a catalog of first-party tools and libraries that agents should prefer when building new applications.

See [EXECUTION_TEMPLATES.md](./EXECUTION_TEMPLATES.md) for issue output format and artifact templates (read only when creating those artifacts).

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

For any non-trivial change, agents must identify or update the governing section in the repo-root `PRD.md` before implementation starts.

A PRD update is required for:

- new features
- behavioral changes
- workflow or UX changes
- API, integration, or config contract changes
- infra/runtime changes with user or operator impact

The PRD is the canonical product and operator contract for the repository. If behavior, scope, constraints, rollout, or acceptance criteria change during implementation, `PRD.md` must be updated in the same branch before the work is considered done.

No PR may merge unless:

- the PR links the governing `PRD.md` section
- acceptance criteria are traceable to tests or explicit manual verification steps
- `PRD.md` reflects the shipped behavior

## TDD For All Behavioral Changes

For any bug fix, feature, refactor with behavioral impact, or contract change:

1. **Start from acceptance criteria**: define or update acceptance criteria in `PRD.md` before implementation.
2. **Write a failing test first**: create the smallest test that proves the requirement is not yet met and confirm it fails.
3. **Implement the minimum change**: change only what is needed to make the failing test pass.
4. **Refactor with tests green**: improve the design only after the tests pass.
5. **Proof of completion**: demonstrate the previously failing test passes and record the evidence.

Tests exist before implementation. The implementation is proven by the tests.

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
6. **Review Copilot feedback** — be ruthless: only fix comments that are genuinely necessary or correct.
   - **Fix it**: apply the change, then reply directly on the review comment explaining what was changed and why.
   - **Create a GitHub issue**: for valid but out-of-scope suggestions, open an issue and reply on the comment with the issue link.
   - **Ignore it**: for noise or intentional design decisions, reply on the comment with a clear reason and close it.
   - No comment should be silently dismissed or silently resolved.
7. **Push fixes** — after addressing all Copilot comments, push to the same PR branch.
8. **Repeat steps 5–7** until CI is green, `PRD.md` matches the branch, and all review comments are resolved.

### Reviewers

- Always add **Copilot** as a reviewer on every PR.

### Responding to Review Feedback

- When fixing or ignoring an item raised in a review, always reply **directly on that review comment** (not as a general PR comment).
- If accepting the fix: briefly describe what was changed and why.
- If ignoring the suggestion: explain the reasoning clearly (e.g., out of scope, intentional design decision, trade-off accepted).

No review item should be silently dismissed or silently resolved.

### GitHub Actions

- After every push to a PR, check the GitHub Actions run.
- If any check fails: read the logs, identify the root cause, fix it, and push again.
- Do not ask the user to check CI — own it.
- Do not mark work as done while CI is red.

## Secrets Management

Use [env-secrets](https://github.com/markamarkmark/env-secrets) to manage secrets instead of `.env` files.

- **Never commit `.env` files** or any file containing raw secrets.
- Store all secrets via `env-secrets set <KEY> <VALUE>` — they are encrypted and stored outside the repo.
- Load secrets into the shell with `eval $(env-secrets export)` or configure your shell profile to do this automatically.
- Reference secrets in code and tooling as normal environment variables — the loading mechanism is external.
- When onboarding a new secret, document its name (not value) in `env-secrets.example` or equivalent so collaborators know what keys are required.
- CI/CD pipelines should inject secrets via their native secrets store (e.g., GitHub Actions secrets), not via `env-secrets`.

## Project Ballast

Each project should have Ballast installed and configured from the repo root. The canonical project contract is `.rulesrc.json`, which records the selected Ballast targets, agents, skills, and any language/path metadata Ballast manages for that repo.

### What to check

1. Look for a repo-root `.rulesrc.json`.
2. If present, treat the project as Ballast-managed.
3. Read any Ballast-managed support files that exist for the active tooling context, especially root `AGENTS.md` and `CLAUDE.md`.
4. Apply rules and skills from the target-specific install paths Ballast manages, such as `.codex/rules/`, `.claude/rules/`, `.claude/skills/`, `.cursor/rules/`, or `.opencode/`.

### Conventions

- `.rulesrc.json` is the canonical shared Ballast config file. Legacy per-language files are compatibility fallbacks, not the primary documented path.
- Install Ballast in every project that should inherit the standard SDLC rule set and agent skills.
- Ballast may create or update root `AGENTS.md` and `CLAUDE.md` when required by the selected targets; these files extend the global framework for that project.
- The repo-local `.ballast/` directory is Ballast runtime/install state for local tooling, not the required project override surface. It is typically ignored rather than committed.
- Do not put secrets, credentials, or environment-specific values in `.rulesrc.json`, Ballast-generated support files, or target rule directories.
