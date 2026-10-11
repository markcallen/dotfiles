# Optional execution templates

Use only when the artifact helps communicate the task. Short work can be reported directly; options and decision requests belong only to real tradeoffs or missing authorization.

## Finding

```md
### <severity>: <concrete finding>
Location: <file:line or evidence URL>
Impact: <who/what fails and when>
Evidence: <reproduction, code path, check or log excerpt>
Fix: <specific change>
```

## Task/run plan (complex work only)

Use a unique path such as `tasks/<issue-or-run-id>.md` when the repo wants a file.

```md
# <task and issue link>
Repo/branch/run ID: <...>
Scope and acceptance criteria: <...>
Dependencies/owners: <...>
Steps and verification: <...>
Risks, migration and rollback: <...>
Result and evidence: <...>
```

## Pull request evidence

```md
Issue/spec: <link and acceptance criteria>
Behavior: <change and affected users/operators>
Checks: <exact commands and results; CI run for latest pushed SHA>
Review: <tool/reviewer, reviewed SHA, valid findings and disposition>
Limits: <untested platforms, integrations, deployment or live delivery>
Migration/rollback: <only when relevant>
State: <implemented / locally verified / CI verified / reviewed; later states only with proof>
```

## Worker handoff

```md
Run/repo/branch/SHA: <...>
Task scope and authority: <...>
Completed work and evidence: <...>
Unresolved work and risks: <...>
Authorized next actions: <...>
```

Keep a lesson only when a repeatable failure pattern and a useful early signal justify a durable rule. Review it before promoting it to global guidance.
