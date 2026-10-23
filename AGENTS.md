# AGENTS.md

Always-on context for any coding agent working in this repository (Codex CLI, Claude Code, Cursor, Copilot, Gemini CLI, OpenCode).

> This file is loaded into context on **every** session, so it stays deliberately short. Task-specific instructions live in the skills themselves under `.opencode/skills/<name>/SKILL.md`.

---

## What this repo is

Three Agent Skills that make an agent produce **professional documents** instead of merely formatted files:

| Skill | Output | Engine |
|---|---|---|
| `sword` | Word `.docx` | `python-docx` |
| `spdf` | Print-ready PDF | `weasyprint` / Chromium |
| `shtml` | Self-contained responsive HTML | hand-written CSS |

Written in Arabic (بفصحى واضحة), frontmatter in English, Arabic RTL is a first-class requirement.

---

## Golden rules

1. **`.opencode/skills/` is the single source of truth.** `.claude/skills/` and `.agents/skills/` are **generated copies** — never edit them by hand. Edit the canonical file, then run `./scripts/sync-platforms.sh`.
2. **Never weaken the "ask first" protocol.** Section `## 2` in every skill (the 9 mandatory questions + the "minimum viable answers" table + the explicit default bundle) is the reason this project exists. Do not delete, merge, or shorten it. Any PR that does is rejected.
3. **Bilingual docs stay in sync.** `README.md` (English) and `README.ar.md` (Arabic) must describe the same thing. Same for `docs/usage-examples.en.md` ↔ `docs/usage-examples.md`.
4. **Every new rule needs a home.** Add it to the matching section of the skill (design principles / technical recipe / pitfalls / final checklist) — never as a loose note at the end of the file.
5. **No external runtime dependencies in `shtml`.** No CDN CSS, no Google Fonts, no icon libraries. Generated HTML must work offline and inside a sandboxed iframe.

---

## Layout

```text
.opencode/skills/<name>/SKILL.md   canonical skills (edit here)
.claude/skills/                    generated → Claude Code
.agents/skills/                    generated → Codex, Cursor, Antigravity, Gemini
docs/                              usage examples (EN + AR)
assets/banner.svg                  README banner (hand-written SVG)
install.sh                         multi-agent installer
scripts/sync-platforms.sh          generator + drift check
scripts/publish.sh                 repo init + push to GitHub
```

---

## Commands

```bash
./install.sh --list                              # list skills in this repo
./install.sh --all --project /tmp/sandbox        # install into a scratch dir
./install.sh --claude --global                   # Claude Code  → ~/.claude/skills/
./install.sh --codex  --global                   # Codex        → ~/.agents/skills/

./scripts/sync-platforms.sh                      # regenerate generated copies
./scripts/sync-platforms.sh --check              # fail on drift (same check CI runs)

bash -n install.sh scripts/*.sh                  # syntax check
pip install pyyaml                               # needed for frontmatter validation
```

---

## Editing a skill

1. Edit `.opencode/skills/<name>/SKILL.md`.
2. Keep the 11-section order intact (when to use → ask first → decision table → principles → design system → structure → technical recipe → visual elements → best practices → pitfalls → final checklist).
3. Frontmatter rules: `name` must match the folder and match `^[a-z0-9]+(-[a-z0-9]+)*$`; `description` is English, 1–1024 chars, and must say **when** to use it; `metadata` values are all strings. Keep `allowed-tools` (used by Claude Code) and `metadata.short-description` (shown by Codex).
4. Update `## 11. قائمة التحقق النهائية` if you add a delivery requirement.
5. Regenerate and verify:

```bash
./scripts/sync-platforms.sh && ./scripts/sync-platforms.sh --check
```

6. If behavior changed, add a line to `CHANGELOG.md` under a new version.

---

## Adding a skill

1. Create `.opencode/skills/<name>/SKILL.md` with valid frontmatter.
2. Add `<name>` to the `SKILLS=(...)` array in **both** `install.sh` and `scripts/sync-platforms.sh`.
3. Regenerate, then install into `/tmp` and generate one real file with it — an untested skill is not done.
4. Add it to the skills list in both READMEs and to the roadmap checkboxes.

---

## Verification before you push

```bash
bash -n install.sh scripts/*.sh
./scripts/sync-platforms.sh --check     # must exit 0
```

CI (`.github/workflows/validate.yml`) runs the same two checks plus frontmatter validation on every push and PR. A red run means the generated copies drifted from the canonical source.

---

## Never do

- Edit files under `.claude/skills/` or `.agents/skills/` directly.
- Commit credentials, tokens, or `.env` files — `publish.sh` supports `GITHUB_TOKEN` via environment only.
- Add generated output (`*.docx`, `*.pdf`, `preview/`) to the repo — see `.gitignore`.
- Use a real customer's data, logo, or financials in examples.
- Copy the Arabic body of a skill into English or vice versa — the skills are Arabic by design; only the frontmatter and the docs are bilingual.
