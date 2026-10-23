#!/usr/bin/env bash
# install.sh — تثبيت مهارات opencode-design-skills في OpenCode
# الاستخدام:
#   ./install.sh --global                 → ~/.config/opencode/skills/
#   ./install.sh --project /path/to/repo  → <repo>/.opencode/skills/
#   ./install.sh --list                   → عرض المهارات المتاحة في هذا المستودع
#   ./install.sh --uninstall --global     → إزالة المهارات من النطاق المحدد

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/.opencode/skills"
SKILLS=(sword spdf shtml)

C_RESET=$'\033[0m'; C_DIM=$'\033[2m'; C_OK=$'\033[32m'
C_WARN=$'\033[33m'; C_ERR=$'\033[31m'; C_B=$'\033[1m'

info()  { printf '%s\n' "$*"; }
ok()    { printf '%s✔%s %s\n' "$C_OK" "$C_RESET" "$*"; }
warn()  { printf '%s!%s %s\n' "$C_WARN" "$C_RESET" "$*"; }
die()   { printf '%s✖ %s%s\n' "$C_ERR" "$*" "$C_RESET" >&2; exit 1; }

usage() {
  sed -n '2,7p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit 0
}

SCOPE=""
TARGET=""
ACTION="install"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global)    SCOPE="global"; shift ;;
    --project)   SCOPE="project"; TARGET="${2:-}"; [[ -n "$TARGET" ]] || die "--project يحتاج مساراً"; shift 2 ;;
    --uninstall) ACTION="uninstall"; shift ;;
    --list)      ACTION="list"; shift ;;
    -h|--help)   usage ;;
    *)           die "خيار غير معروف: $1  (جرّب --help)" ;;
  esac
done

# ---------- التحقق من المصدر ----------
[[ -d "$SRC_DIR" ]] || die "لم أجد .opencode/skills بجانب السكربت. شغّل السكربت من جذر المستودع."

# ---------- عرض القائمة (لا يحتاج نطاقاً) ----------
if [[ "$ACTION" == "list" ]]; then
  info "${C_B}المهارات المتاحة في هذا المستودع:${C_RESET}"
  for s in "${SKILLS[@]}"; do
    desc="$(awk '/^description:/{sub(/^description: */,""); print; exit}' "$SRC_DIR/$s/SKILL.md")"
    printf '  %s•%s %s%-6s%s %s\n' "$C_OK" "$C_RESET" "$C_B" "$s" "$C_RESET" \
      "${C_DIM}${desc:0:88}…${C_RESET}"
  done
  exit 0
fi

# ---------- تحديد مجلد الهدف ----------
case "$SCOPE" in
  global)  DEST="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills" ;;
  project)
    TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || die "المسار غير موجود: $TARGET"
    DEST="$TARGET/.opencode/skills"
    ;;
  *)       die "حدّد النطاق: --global أو --project <path>" ;;
esac

# ---------- إلغاء التثبيت ----------
if [[ "$ACTION" == "uninstall" ]]; then
  for s in "${SKILLS[@]}"; do
    if [[ -d "$DEST/$s" ]]; then rm -rf "$DEST/$s"; ok "أُزيلت $s من $DEST"; fi
  done
  exit 0
fi

# ---------- التثبيت ----------
mkdir -p "$DEST"
info ""
info "${C_B}تثبيت مهارات التصميم في OpenCode${C_RESET}"
info "${C_DIM}من:  $SRC_DIR${C_RESET}"
info "${C_DIM}إلى: $DEST${C_RESET}"
info ""

for s in "${SKILLS[@]}"; do
  [[ -f "$SRC_DIR/$s/SKILL.md" ]] || { warn "تخطّي $s (لا يوجد SKILL.md)"; continue; }
  rm -rf "$DEST/$s"
  cp -R "$SRC_DIR/$s" "$DEST/$s"
  # تحقق: اسم المجلد == حقل name
  name="$(awk '/^name:/{sub(/^name: */,""); gsub(/"/,""); print; exit}' "$DEST/$s/SKILL.md")"
  if [[ "$name" != "$s" ]]; then
    warn "$s: تحذير — name داخل SKILL.md ($name) لا يطابق اسم المجلد ($s)"
  fi
  ok "$s  →  $DEST/$s"
done

info ""
ok "اكتمل التثبيت."
info "${C_DIM}أعد تشغيل OpenCode، ثم اسأل: «أي مهارات متاحة لديك؟»${C_RESET}"
info "${C_DIM}إن لم تظهر، راجع قسم استكشاف الأخطاء في README.${C_RESET}"
info ""
