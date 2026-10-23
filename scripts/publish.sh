#!/usr/bin/env bash
# publish.sh — تهيئة المستودع محلياً ورفعه إلى GitHub
#
# الاستخدام:
#   ./scripts/publish.sh <github-username> <repo-name> [--public|--private]
#
# مثال:
#   ./scripts/publish.sh ahmed opencode-design-skills --public
#
# يتطلب: git، ووصولاً إلى GitHub (HTTPS مع Personal Access Token، أو gh CLI مسجّل الدخول).

set -euo pipefail

USER_NAME="${1:-}"
REPO_NAME="${2:-opencode-design-skills}"
VISIBILITY="${3:---public}"

C_RESET=$'\033[0m'; C_OK=$'\033[32m'; C_ERR=$'\033[31m'; C_B=$'\033[1m'; C_DIM=$'\033[2m'
ok()  { printf '%s✔%s %s\n' "$C_OK" "$C_RESET" "$*"; }
die() { printf '%s✖ %s%s\n' "$C_ERR" "$*" "$C_RESET" >&2; exit 1; }

[[ -n "$USER_NAME" ]] || die "الاستخدام: ./scripts/publish.sh <github-username> [repo-name] [--public|--private]"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# ---------- 1) استبدال placeholder باسم المستخدم الحقيقي ----------
if grep -rq "YOUR_USERNAME" README.md 2>/dev/null; then
  sed -i.bak "s/YOUR_USERNAME/${USER_NAME}/g" README.md && rm -f README.md.bak
  ok "تم تحديث روابط README إلى github.com/${USER_NAME}"
fi

# ---------- 2) تهيئة git ----------
if [[ ! -d .git ]]; then
  git init -q -b main
  ok "أُنشئ مستودع git محلي (main)"
fi

git add -A
if ! git diff --cached --quiet; then
  git -c user.name="${GIT_AUTHOR_NAME:-$USER_NAME}" \
      -c user.email="${GIT_AUTHOR_EMAIL:-${USER_NAME}@users.noreply.github.com}" \
      commit -q -m "feat: three professional document skills for OpenCode (sword, spdf, shtml)

- sword: branded .docx via python-docx with full Arabic RTL support
- spdf: print-ready PDF via WeasyPrint with real TOC page numbers
- shtml: self-contained responsive HTML with design tokens
- shared design system: 5 palettes, type scale, 8 principles
- mandatory ask-first protocol (9 questions) in every skill"
  ok "أُنشئ الـ commit الأول"
else
  ok "لا تغييرات جديدة للـ commit"
fi

# ---------- 3) إنشاء المستودع على GitHub ----------
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  if ! gh repo view "${USER_NAME}/${REPO_NAME}" >/dev/null 2>&1; then
    gh repo create "${USER_NAME}/${REPO_NAME}" "${VISIBILITY}" \
      --source=. --remote=origin --description "Three professional Agent Skills for OpenCode: Word (.docx), PDF, and HTML — Arabic RTL first." --push
    ok "أُنشئ المستودع ورُفع: https://github.com/${USER_NAME}/${REPO_NAME}"
    exit 0
  fi
  git remote get-url origin >/dev/null 2>&1 || \
    git remote add origin "https://github.com/${USER_NAME}/${REPO_NAME}.git"
  git push -u origin main
  ok "رُفع إلى https://github.com/${USER_NAME}/${REPO_NAME}"
  exit 0
fi

# ---------- 4) المسار اليدوي ----------
cat <<EOF

${C_B}الخطوة الأخيرة يدوياً${C_RESET} (لم يُعثر على gh CLI مسجّل الدخول):

  1) أنشئ مستودعاً فارغاً باسم ${C_B}${REPO_NAME}${C_RESET} على https://github.com/new
     ${C_DIM}(بلا README ولا .gitignore — المستودع موجود لديك بالفعل)${C_RESET}

  2) اربط وارفع:

     git remote add origin https://github.com/${USER_NAME}/${REPO_NAME}.git
     git push -u origin main

${C_DIM}إن طُلبت كلمة مرور، استخدم Personal Access Token بصلاحية repo بدل كلمة المرور.${C_RESET}

EOF
