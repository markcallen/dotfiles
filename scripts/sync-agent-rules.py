#!/usr/bin/env python3
"""Copy the canonical global rules into Codex's discovered entrypoint.

Usage: python3 scripts/sync-agent-rules.py [--check]
"""

import argparse
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "agents" / "AGENTS.md"
TARGET = ROOT / "codex" / "AGENTS.md"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="fail if the Codex copy is stale")
    args = parser.parse_args()

    source = SOURCE.read_bytes()
    if args.check:
        if not TARGET.is_file() or TARGET.read_bytes() != source:
            print("codex/AGENTS.md is stale; run python3 scripts/sync-agent-rules.py", file=sys.stderr)
            return 1
        print("Codex rules match the canonical core")
        return 0

    TARGET.write_bytes(source)
    print("Updated codex/AGENTS.md from agents/AGENTS.md")
    return 0


if __name__ == "__main__":
    sys.exit(main())
