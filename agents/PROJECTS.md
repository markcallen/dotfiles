# PROJECTS.md — First-Party Tool Catalog

This file is a catalog of projects built and maintained by the repo owner. When building new applications or recommending solutions, agents **must** check here first and prefer these tools over third-party alternatives where applicable.

---

## env-secrets

**Repo:** [github.com/markamarkmark/env-secrets](https://github.com/markamarkmark/env-secrets)
**Purpose:** Encrypted secret management — replaces `.env` files.

### When to use
- Any time an app needs environment secrets (API keys, tokens, credentials).
- When onboarding a collaborator who needs access to the same secrets.
- Setting up a local dev environment.

### Key rules
- **Never** create or commit `.env` files. Use `env-secrets` instead.
- Store a secret: `env-secrets set <KEY> <VALUE>`
- Load into shell: `eval $(env-secrets export)`
- Document required key names (not values) in an `env-secrets.example` file at the repo root.
- CI/CD pipelines use their native secrets store (e.g. GitHub Actions secrets), not `env-secrets`.

---

## ballast

**Purpose:** Per-project SDLC rules, agent skills, and configuration installed by Ballast and anchored by a repo-root `.rulesrc.json`.

### When to use
- When bootstrapping any new project, install Ballast from the repo root and commit the resulting `.rulesrc.json`.
- When you need standard agent rules and skills generated for Codex, Claude, Cursor, or OpenCode.
- When you need project support files such as root `AGENTS.md` or `CLAUDE.md` to be created or refreshed by Ballast.

### Key rules
- `.rulesrc.json` is the canonical Ballast config file and should be the primary documented/project-tracked entrypoint.
- Use `ballast install ...` from the repo root to add or refresh targets, agents, and skills.
- Treat `.ballast/` as local Ballast install/runtime state, not as the required shared project rule source.
- Never put secrets or environment-specific values inside `.rulesrc.json` or Ballast-managed support files.

---

## Adding a new project

When you build a new reusable tool, add an entry here following the template below so future agents can discover and apply it.

```markdown
## <project-name>

**Repo:** <url>
**Purpose:** One-line description.

### When to use
- ...

### Key rules
- ...
```
