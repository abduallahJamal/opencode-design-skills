#!/usr/bin/env bash
# publish.sh — تهيئة المستودع محلياً ورفعه إلى GitHub
#
# الاستخدام:
#   ./scripts/publish.sh <github-username> [repo-name] [خيارات]
#
# خيارات:
#   --public | --private   ظهور المستودع (افتراضي: --public)
#   --ssh                  استخدم remote عبر SSH بدل HTTPS
#
# متغيرات بيئية:
#   GITHUB_TOKEN           Personal Access Token بصلاحية repo (للرفع غير التفاعلي)
#
# أمثلة:
#   ./scripts/publish.sh ahmed
#   GITHUB_TOKEN=ghp_xxx ./scripts/publish.sh ahmed opencode-design-skills --public
#   ./scripts/publish.sh ahmed opencode-design-skills --private --ssh

set -euo pipefail

USER_NAME=""
REPO_NAME="opencode-design-skills"
VISIBILITY="--public"
PROTOCOL="https"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --public|--private) VISIBILITY="$1"; shift ;;
    --ssh)              PROTOCOL="ssh"; shift ;;
    -h|--help)
      sed -n '2,20p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)
      if [[ -z "$USER_NAME" ]]; then USER_NAME="$1"
      elif [[ "$REPO_NAME" == "opencode-design-skills" ]]; then REPO_NAME="$1"
      else die "وسيط غير معروف: $1"; fi
      shift ;;
  esac
done

C_RESET=$'\033[0m'; C_OK=$'\033[32m'; C_ERR=$'\033[31m'; C_B=$'\033[1m'; C_DIM=$'\033[2m'
ok()  { printf '%s✔%s %s\n' "$C_OK" "$C_RESET" "$*"; }
info(){ printf '%s\n' "$*"; }
die() { printf '%s✖ %s%s\n' "$C_ERR" "$*" "$C_RESET" >&2; exit 1; }

[[ -n "$USER_NAME" ]] || { sed -n '2,20p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 1; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# ---------- 1) استبدال placeholder باسم المستخدم الحقيقي ----------
changed=0
for f in README.md README.ar.md docs/usage-examples.md docs/usage-examples.en.md; do
  [[ -f "$f" ]] || continue
  if grep -q "YOUR_USERNAME" "$f"; then
    sed -i.bak "s/YOUR_USERNAME/${USER_NAME}/g" "$f" && rm -f "$f.bak"
    changed=1
  fi
done
[[ $changed -eq 1 ]] && ok "حُدّثت روابط التوثيق إلى github.com/${USER_NAME}"

# ---------- 2) تهيئة git ----------
if [[ ! -d .git ]]; then
  git init -q -b main
  ok "أُنشئ مستودع git محلي (main)"
fi
git symbolic-ref -q HEAD >/dev/null || git checkout -q -b main

git add -A
if ! git diff --cached --quiet; then
  git -c user.name="${GIT_AUTHOR_NAME:-$USER_NAME}" \
      -c user.email="${GIT_AUTHOR_EMAIL:-${USER_NAME}@users.noreply.github.com}" \
      commit -q -m "docs: add English README alongside Arabic (bilingual documentation)

- README.md: English (primary), README.ar.md: Arabic, with language switchers
- docs/usage-examples.en.md: English prompt examples
- publish.sh: support GITHUB_TOKEN, SSH remotes, and both READMEs"
  ok "أُنشئ commit"
fi

# ---------- 3) بناء remote ----------
if [[ "$PROTOCOL" == "ssh" ]]; then
  REMOTE_URL="git@github.com:${USER_NAME}/${REPO_NAME}.git"
elif [[ -n "${GITHUB_TOKEN:-}" ]]; then
  REMOTE_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${USER_NAME}/${REPO_NAME}.git"
else
  REMOTE_URL="https://github.com/${USER_NAME}/${REPO_NAME}.git"
fi

# ---------- 4) gh CLI (المسار الأسهل) ----------
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  if ! gh repo view "${USER_NAME}/${REPO_NAME}" >/dev/null 2>&1; then
    gh repo create "${USER_NAME}/${REPO_NAME}" "${VISIBILITY}" --source=. --remote=origin \
      --description "Three professional Agent Skills for OpenCode: Word (.docx), PDF, and HTML — bilingual docs, Arabic RTL first." --push
    ok "أُنشئ المستودع ورُفع: https://github.com/${USER_NAME}/${REPO_NAME}"
    exit 0
  fi
  git remote remove origin 2>/dev/null || true
  git remote add origin "$REMOTE_URL"
  git push -u origin main
  ok "رُفع إلى https://github.com/${USER_NAME}/${REPO_NAME}"
  exit 0
fi

# ---------- 5) push مباشر (token أو HTTPS تفاعلي) ----------
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE_URL"

info ""
info "${C_B}محاولة الرفع إلى:${C_RESET} https://github.com/${USER_NAME}/${REPO_NAME}"
info ""

if git push -u origin main 2>/dev/null; then
  ok "رُفع بنجاح: https://github.com/${USER_NAME}/${REPO_NAME}"
  # إخفاء التوكن من الـ remote بعد النجاح
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    git remote set-url origin "https://github.com/${USER_NAME}/${REPO_NAME}.git"
    ok "أُزيل التوكن من إعدادات remote (بقي محفوظاً في ذاكرة git فقط)"
  fi
  exit 0
fi

# ---------- 6) فشل الرفع → إرشاد ----------
cat <<EOF

${C_ERR}لم ينجح الدفع.${C_RESET} السبب الأكثر شيوعاً: المستودع غير موجود بعد على GitHub.

${C_B}أنشئه أولاً${C_RESET} — افتح https://github.com/new
  الاسم: ${C_B}${REPO_NAME}${C_RESET}
  ${C_DIM}بلا README ولا .gitignore (المستودع لديك بالفعل)${C_RESET}

${C_B}ثم أعد المحاولة بأحد الخيارين:${C_RESET}

  ${C_DIM}# أ) باستخدام توكن (موصى به، غير تفاعلي)${C_RESET}
  GITHUB_TOKEN=ghp_xxxxxxxx ./scripts/publish.sh ${USER_NAME} ${REPO_NAME}

  ${C_DIM}# ب) باستخدام SSH${C_RESET}
  ./scripts/publish.sh ${USER_NAME} ${REPO_NAME} --ssh

${C_DIM}للتحقق من المصادقة: gh auth status   أو   ssh -T git@github.com${C_RESET}

EOF
exit 1
