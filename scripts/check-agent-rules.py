#!/usr/bin/env python3
"""Check agent-rule entrypoints and exercise Dotbot links in a disposable home."""

import os
from pathlib import Path
import subprocess
import sys
import tempfile


ROOT = Path(__file__).resolve().parent.parent
VENDORED_YAML = ROOT / "dotbot" / "lib" / "pyyaml" / "lib3"
if not (VENDORED_YAML / "yaml" / "__init__.py").is_file():
    raise RuntimeError("Initialize recursive Dotbot submodules before checking agent rules")
sys.path.insert(0, str(VENDORED_YAML))
import yaml  # noqa: E402 - use Dotbot's pinned YAML parser


EXPECTED = {
    "~/.agents": ROOT / "agents",
    "~/.codex/AGENTS.md": ROOT / "codex" / "AGENTS.md",
    "~/.claude/CLAUDE.md": ROOT / "claude" / "CLAUDE.md",
}


def main():
    config = yaml.safe_load((ROOT / "install.conf.yaml").read_text(encoding="utf-8"))
    links = next(item["link"] for item in config if isinstance(item, dict) and "link" in item)
    for destination, source in EXPECTED.items():
        if destination not in links:
            raise AssertionError("Missing installer mapping: " + destination)
        settings = links[destination] or {}
        actual_source = ROOT / settings.get("path", destination.replace("~/.", ""))
        if actual_source.resolve() != source.resolve() or not source.exists():
            raise AssertionError("Incorrect or missing source for " + destination)

    core = (ROOT / "agents" / "AGENTS.md").read_bytes()
    if (ROOT / "codex" / "AGENTS.md").read_bytes() != core:
        raise AssertionError("Codex copy differs from canonical core")
    claude = (ROOT / "claude" / "CLAUDE.md").read_text(encoding="utf-8")
    if "@~/.agents/AGENTS.md" not in claude:
        raise AssertionError("Claude entrypoint does not import the canonical core")

    with tempfile.TemporaryDirectory(prefix="agent-rules-") as temporary:
        home = Path(temporary) / "home"
        home.mkdir()
        isolated = Path(temporary) / "links.yaml"
        isolated.write_text(
            yaml.safe_dump([{"link": {key: links[key] for key in EXPECTED}}]),
            encoding="utf-8",
        )
        environment = os.environ.copy()
        environment["HOME"] = str(home)
        result = subprocess.run(
            [sys.executable, str(ROOT / "dotbot" / "bin" / "dotbot"),
             "-d", str(ROOT), "-c", str(isolated)],
            cwd=temporary,
            env=environment,
            timeout=30,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        )
        if result.returncode:
            raise AssertionError("Disposable-home Dotbot failed:\n" + result.stdout)
        for destination, source in EXPECTED.items():
            linked = home / destination.replace("~/", "")
            if not linked.is_symlink() or linked.resolve() != source.resolve():
                raise AssertionError("Disposable-home link failed: " + destination)

    print("Agent-rule sources, import, and disposable-home Dotbot links passed")


if __name__ == "__main__":
    main()
