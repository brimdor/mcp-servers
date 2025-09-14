#!/usr/bin/env bash
set -euo pipefail
cd /workdir
rm -rf Agent-MCP || true
printf "Cloning https://github.com/rinadelph/Agent-MCP.git into /workdir/Agent-MCP\n"
if git clone https://github.com/rinadelph/Agent-MCP.git Agent-MCP; then
  printf "Clone succeeded\n"
else
  printf "Clone failed (continuing with whatever exists)\n"
fi
printf "\n=== pyproject.toml (first 200 lines) ===\n"
if [ -f Agent-MCP/pyproject.toml ]; then sed -n '1,200p' Agent-MCP/pyproject.toml; else printf "(no pyproject.toml)\n"; fi
printf "\n=== setup.py (first 200 lines) ===\n"
if [ -f Agent-MCP/setup.py ]; then sed -n '1,200p' Agent-MCP/setup.py; else printf "(no setup.py)\n"; fi
printf "\n=== README.md (first 200 lines) ===\n"
if [ -f Agent-MCP/README.md ]; then sed -n '1,200p' Agent-MCP/README.md; else printf "(no README.md)\n"; fi
printf "\n=== repository root listing ===\n"
ls -la Agent-MCP || true
printf "\n=== grep for entrypoints/__main__/mcp-server patterns ===\n"
grep -R --line-number -E "console_scripts|entry_points|__main__|if __name__ == '__main__'|mcp-server|agent_mcp|agent-mcp|entry_points" Agent-MCP || true
printf "\nDone.\n"
