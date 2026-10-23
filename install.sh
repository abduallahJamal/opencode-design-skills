#!/usr/bin/env bash
# install.sh — تثبيت مهارات opencode-design-skills في وكلاء البرمجة
#
# الاستخدام:
#   ./install.sh --opencode --global          → ~/.config/opencode/skills/
#   ./install.sh --claude   --global          → ~/.claude/skills/
#   ./install.sh --codex    --global          → ~/.agents/skills/
#   ./install.sh --all      --global          → الثلاثة معاً (المستوى الشخصي)
#
#   ./install.sh --all --project /path/repo   → داخل المشروع (.opencode + .claude + .agents)
#   ./install.sh --list                       → عرض المهارات في هذا المستودع
#   ./install.sh --uninstall --all --global   → إزالة
#
# ملاحظة Codex: التوثيق الحالي لـ OpenAI يقرأ .agents/skills (شخصي) و.agents/skills (مشروع).
# النسخ القديمة كانت تقرأ ~/.codex/skills — استخدم --codex-legacy إن كنت عليها.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/.opencode/skills"
SKILLS=(sword spdf shtml)

C_RESET=$'\033[0m'; C_DIM=$'\033[2m'; C_OK=$'\033[32m'
C_WARN=$'\033[33m'; C_ERR=$'\033[31m'; C_B=$'\033[1m'

info() { printf '%s\n' "$*"; }
ok()   { printf '%s✔%s %s\n' "$C_OK" "$C_RESET" "$*"; }
warn() { printf '%s!%s %s\n' "$C_WARN" "$C_RESET" "$*"; }
die()  { printf '%s✖ %s%s\n' "$C_ERR" "$*" "$C_RESET" >&2; exit 1; }

usage() { sed -n '2,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0; }

TARGETS=(); SCOPE=""; PROJECT_PATH=""; ACTION="install"

add_target() {
  [[ " ${TARGETS[*]:-} " == *" $1 "* ]] || TARGETS+=("$1")
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --opencode|--claude|--codex|--codex-legacy) add_target "${1#--}"; shift ;;
    --all)          add_target opencode; add_target claude; add_target codex; shift ;;
    --global)       SCOPE="global"; shift ;;
    --project)      SCOPE="project"; PROJECT_PATH="${2:-}"; [[ -n "$PROJECT_PATH" ]] || die "--project يحتاج مساراً"; shift 2 ;;
    --uninstall)    ACTION="uninstall"; shift ;;
    --list)         ACTION="list"; shift ;;
    -h|--help)      usage ;;
    *)              die "خيار غير معروف: $1  (جرّب --help)" ;;
  esac
done

# ---------- القائمة ----------
if [[ "$ACTION" == "list" ]]; then
  info "${C_B}المهارات المتاحة في هذا المستودع:${C_RESET}"
  for s in "${SKILLS[@]}"; do
    desc="$(awk '/^description:/{sub(/^description: */,""); print; exit}' "$SRC_DIR/$s/SKILL.md")"
    printf '  %s•%s %s%-6s%s %s\n' "$C_OK" "$C_RESET" "$C_B" "$s" "$C_RESET" \
      "${C_DIM}${desc:0:84}…${C_RESET}"
  done
  info ""
  info "${C_DIM}المسارات: .opencode (OpenCode) · .claude (Claude Code) · .agents (Codex/Cursor)${C_RESET}"
  exit 0
fi

[[ ${#TARGETS[@]} -gt 0 ]] || die "حدّد الوكيل: --opencode | --claude | --codex | --all"
[[ -n "$SCOPE" ]]        || die "حدّد النطاق: --global أو --project <path>"
[[ -d "$SRC_DIR" ]]      || die "لم أجد .opencode/skills بجانب السكربت."

# ---------- مسار الهدف لكل وكيل ----------
dest_for() {
  local agent="$1"
  if [[ "$SCOPE" == "global" ]]; then
    case "$agent" in
      opencode)     printf '%s/opencode/skills' "${XDG_CONFIG_HOME:-$HOME/.config}" ;;
      claude)       printf '%s/.claude/skills' "$HOME" ;;
      codex)        printf '%s/.agents/skills' "$HOME" ;;
      codex-legacy) printf '%s/.codex/skills'  "$HOME" ;;
    esac
  else
    local base; base="$(cd "$PROJECT_PATH" 2>/dev/null && pwd)" || die "المسار غير موجود: $PROJECT_PATH"
    case "$agent" in
      opencode)     printf '%s/.opencode/skills' "$base" ;;
      claude)       printf '%s/.claude/skills'   "$base" ;;
      codex)        printf '%s/.agents/skills'   "$base" ;;
      codex-legacy) printf '%s/.codex/skills'    "$base" ;;
    esac
  fi
}

label_for() {
  case "$1" in
    opencode)     printf 'OpenCode' ;;
    claude)       printf 'Claude Code' ;;
    codex)        printf 'Codex CLI (+ Cursor/Antigravity/Gemini)' ;;
    codex-legacy) printf 'Codex CLI (مسار قديم)' ;;
  esac
}

# ---------- إلغاء التثبيت ----------
if [[ "$ACTION" == "uninstall" ]]; then
  for agent in "${TARGETS[@]}"; do
    dest="$(dest_for "$agent")"
    for s in "${SKILLS[@]}"; do
      [[ -d "$dest/$s" ]] && { rm -rf "$dest/$s"; ok "أُزيلت $s من $dest"; }
    done
  done
  exit 0
fi

# ---------- التثبيت ----------
info ""
info "${C_B}تثبيت مهارات التصميم${C_RESET}"
info "${C_DIM}من: $SRC_DIR${C_RESET}"
info ""

for agent in "${TARGETS[@]}"; do
  dest="$(dest_for "$agent")"
  info "${C_B}$(label_for "$agent")${C_RESET} ${C_DIM}→ $dest${C_RESET}"
  mkdir -p "$dest"
  for s in "${SKILLS[@]}"; do
    [[ -f "$SRC_DIR/$s/SKILL.md" ]] || { warn "تخطّي $s (لا يوجد SKILL.md)"; continue; }
    rm -rf "$dest/$s"
    cp -R "$SRC_DIR/$s" "$dest/$s"
    name="$(awk '/^name:/{sub(/^name: */,""); gsub(/"/,""); print; exit}' "$dest/$s/SKILL.md")"
    [[ "$name" == "$s" ]] || warn "$s: name داخل SKILL.md ($name) لا يطابق اسم المجلد"
    printf '   %s✔%s %s\n' "$C_OK" "$C_RESET" "$s"
  done
  info ""
done

ok "اكتمل التثبيت."
info ""
info "  ${C_B}OpenCode${C_RESET}    ${C_DIM}اختيار تلقائي — أو اطلب: use skill sword${C_RESET}"
info "  ${C_B}Claude Code${C_RESET} ${C_DIM}اطلب /sword أو /spdf أو /shtml${C_RESET}"
info "  ${C_B}Codex${C_RESET}       ${C_DIM}اطلب \$sword أو استخدم /skills — أعد تشغيل Codex أولاً${C_RESET}"
info ""
