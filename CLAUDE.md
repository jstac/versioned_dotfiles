# Operating notes for Claude

This repo is the canonical config for two machines: `xps` (laptop, Ubuntu 24.04) and `grips-zilla` (workstation, Ubuntu 26.04). Hardware specs and Tailscale IPs live in `README.md`'s Machines section.

## Workflow

- **Two-machine sessions:** Label every command's target host (e.g. `# ON LAPTOP`, `# ON WORKSTATION`). Mixing them up has caused near-misses with destructive commands.
- **Operating the workstation from the laptop:** SSH via `ssh john@100.91.249.128` or the `ssh-grips` alias. Run non-sudo commands directly through `ssh '...'`; for sudo, surface the command and let the user run it in their interactive SSH terminal.
- **Propagating changes:** edit/commit/push from either machine, `git pull` on the other. The workstation has `gh` set up via mobile MFA device flow — git operations over HTTPS work without prompting.
- **`lazy-lock.json` is gitignored** (root `.gitignore`). Each machine pins its own plugin commits; don't try to commit it.

## Setup invariants — don't break these

- **Neovim** is built from source at `~/neovim_build` and installed to `/usr/local/bin/nvim`. Apt's nvim (0.11) is too old. Both machines target the same nightly commit; rebuild together when refreshing.
- **`nvim-treesitter` is on the `main` branch** and requires `tree-sitter-cli ≥ 0.26.1` (`cargo install tree-sitter-cli`, latest is fine). Master is archived. Pinning tree-sitter-cli to <0.25 would resurface the legacy `--no-bindings` workaround we deliberately removed.
- **TeXlive PATH lives in `top_level/zshenv`**, not `zshrc`. Non-interactive shells (and headless nvim) source zshenv only — moving it back into zshrc would re-break VimTeX's latexmk lookup.
- **Conda init block is in `zshrc` already.** Don't run `conda init zsh` again — it'd duplicate the block. The block uses absolute paths to `~/anaconda3` so it works on both machines without modification.
- **Wayland on the workstation, X11 on the laptop.** Ubuntu 26.04 GNOME has no X11 session at all (no `gnome-session-xsession` package). The shortcut for the launcher is `wofi --show drun` on the workstation, `rofi -show drun` on the laptop — `install.sh` installs both packages.
- **Auto-suspend disabled on the workstation.** It must stay reachable for the user's remote stretches. Don't re-enable.

## Repo-specific gotchas

- **`versioned_tools` is private.** Fresh installs need `gh auth login` before `install.sh` can clone it. The script falls back gracefully and prints a hint if it fails.
- **`install.sh` is idempotent** — phase-by-phase "already installed?" checks. Safe to re-run after a partial failure.
- **The `cmu_2026` repo name appears under both `gh_synced/teaching/` (jstac/cmu_2026) and `gh_synced/quantecon/workshops/upcoming/` (QuantEcon/cmu_2026).** Different orgs, different content. Don't confuse them.

## LaTeX

LaTeX engine, standard preamble, and known traps live in `LATEX.md`. Apply those conventions when fixing, reviewing, or scaffolding `.tex` files.

## Pending / queued work

- Decommissioning of `nuc-zilla`, `ssh-gpu`, and `precision` is in progress / mostly complete — see `/data/archive/decommission-log.md` for the running record. Archive of nuc-zilla data lives at `/data/archive/nuc-zilla/` on grips.
- Bitwarden CLI not yet logged in on the workstation; runtime task, do when needed.
- Custom LaTeX `.bst` files (e.g. `ecta.bst`) not migrated to the workstation; see README's bibstyle recipe if needed.
