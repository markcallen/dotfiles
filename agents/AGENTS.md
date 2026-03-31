# AGENTS.md

This file governs how agents design, review, and ship software in this project.

See [EXECUTION_FRAMEWORK.md](./EXECUTION_FRAMEWORK.md) for the full execution framework covering operating modes, orchestration, task lifecycle, engineering principles, review structure, and artifact templates.

See [PROJECTS.md](./PROJECTS.md) for a catalog of first-party tools and libraries that agents should prefer when building new applications.

## Mandatory Pre-Task Checklist

Before starting any task, an agent MUST:

1. Read this file (`AGENTS.md`) and the [Execution Framework](./EXECUTION_FRAMEWORK.md).
2. Check for Ballast project configuration in `.rulesrc.json` and apply any generated project support files and rule targets.
3. Confirm the operating mode (Autonomous vs Approval-Required) using the decision matrix.

These are not optional — they apply to every task, every time.

## Bug Fixes

1. **Write a failing test first**: before touching any implementation, create a test that reproduces the bug and confirm it fails.
2. **Fix via subagent**: delegate the fix to a subagent, passing it the failing test as the acceptance criterion.
3. **Proof of fix**: the subagent must demonstrate the previously failing test now passes — that is the definition of done.

The test exists before the fix. The fix is proven by the test.

## Test Coverage

- Maintain **minimum 75% test coverage** at all times.
- Never merge code that drops coverage below this threshold.
- Run tests before creating or updating a PR and confirm coverage is met.

## Pull Requests

### Workflow (follow this every time)

1. **Create a branch** — never commit directly to `main`.
2. **Run the full test suite** — confirm all tests pass and coverage is ≥ 75%.
3. **Push and open a PR** — assign **Copilot** as a reviewer immediately.
4. **Check GitHub Actions** — after every push, monitor the CI run. If any check fails, investigate and fix before continuing.
5. **Review Copilot feedback** — be ruthless: only fix comments that are genuinely necessary or correct.
   - **Fix it**: apply the change, then reply directly on the review comment explaining what was changed and why.
   - **Create a GitHub issue**: for valid but out-of-scope suggestions, open an issue and reply on the comment with the issue link.
   - **Ignore it**: for noise or intentional design decisions, reply on the comment with a clear reason and close it.
   - No comment should be silently dismissed or silently resolved.
6. **Push fixes** — after addressing all Copilot comments, push to the same PR branch.
7. **Repeat steps 4–6** until CI is green and all review comments are resolved.

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
