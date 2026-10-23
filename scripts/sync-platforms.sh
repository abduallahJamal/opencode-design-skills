#!/usr/bin/env bash
# sync-platforms.sh — توليد مسارات المنصات الثلاث من مصدر واحد
#
# المصدر الوحيد (single source of truth):  .opencode/skills/<name>/SKILL.md
# المخرجات المولّدة:
#   .claude/skills/<name>/SKILL.md     → Claude Code
#   .agents/skills/<name>/SKILL.md     → Codex CLI (+ Cursor, Antigravity, Gemini CLI، وتوافق OpenCode)
#
# الاستخدام:
#   ./scripts/sync-platforms.sh          # توليد/تحديث الملفات
#   ./scripts/sync-platforms.sh --check  # تحقق فقط (مناسب لـ CI) — يفشل إن كانت النسخ متباعدة

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SRC=".opencode/skills"
PLATFORMS=(".claude/skills" ".agents/skills")
SKILLS=(sword spdf shtml)

C_RESET=$'\033[0m'; C_OK=$'\033[32m'; C_ERR=$'\033[31m'; C_WARN=$'\033[33m'; C_B=$'\033[1m'; C_DIM=$'\033[2m'
ok()   { printf '%s✔%s %s\n' "$C_OK" "$C_RESET" "$*"; }
warn() { printf '%s!%s %s\n' "$C_WARN" "$C_RESET" "$*"; }
die()  { printf '%s✖ %s%s\n' "$C_ERR" "$*" "$C_RESET" >&2; exit 1; }

CHECK=0
[[ "${1:-}" == "--check" ]] && CHECK=1

[[ -d "$SRC" ]] || die "لم أجد $SRC — شغّل السكربت من جذر المستودع."

drift=0

for plat in "${PLATFORMS[@]}"; do
  [[ $CHECK -eq 1 ]] || mkdir -p "$plat"
  for s in "${SKILLS[@]}"; do
    src="$SRC/$s/SKILL.md"
    dst="$plat/$s/SKILL.md"
    [[ -f "$src" ]] || die "المصدر مفقود: $src"

    if [[ $CHECK -eq 1 ]]; then
      if [[ ! -f "$dst" ]]; then
        warn "مفقود: $dst"; drift=1; continue
      fi
      if [[ "$(sha256sum "$src" | cut -d' ' -f1)" != "$(sha256sum "$dst" | cut -d' ' -f1)" ]]; then
        warn "متباعد: $dst  ←  أعد التشغيل بلا --check"; drift=1
      fi
    else
      mkdir -p "$plat/$s"
      cp "$src" "$dst"
    fi
  done
done

if [[ $CHECK -eq 1 ]]; then
  if [[ $drift -eq 1 ]]; then
    die "النسخ المولّدة لا تطابق المصدر. شغّل: ./scripts/sync-platforms.sh"
  fi
  ok "كل المنصات متطابقة مع المصدر ($((${#SKILLS[@]} * ${#PLATFORMS[@]})) ملفاً)"
  exit 0
fi

printf '\n%s\n' "${C_B}تم التوليد من مصدر واحد${C_RESET}"
printf '  %s← %s%s\n' "${C_DIM}.opencode/skills/" "OpenCode" "$C_RESET"
printf '  %s← %s%s\n' "${C_DIM}.claude/skills/"   "Claude Code" "$C_RESET"
printf '  %s← %s%s\n' "${C_DIM}.agents/skills/"   "Codex CLI / Cursor / Antigravity / Gemini" "$C_RESET"
printf '\n%s\n\n' "${C_DIM}لا تعدّل النسخ المولّدة يدوياً — عدّل .opencode/skills ثم أعد التوليد.${C_RESET}"
