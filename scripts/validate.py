#!/usr/bin/env python3
"""Repository validation suite for opencode-design-skills.

Runs the exact quality gates enforced by GitHub Actions CI (`.github/workflows/validate.yml`):
1. YAML frontmatter schema & naming rules across all SKILL.md files.
2. Canonical-to-platform byte-for-byte sync check (`.opencode/skills` -> `.claude/skills`, `.agents/skills`).
3. Bilingual documentation structure check (balanced code fences, `<details>` blocks, relative links, images).

Usage:
    python3 scripts/validate.py
"""

from __future__ import annotations

import argparse
import hashlib
import pathlib
import re
import sys
from typing import Iterable

import yaml

ROOT = pathlib.Path(__file__).resolve().parent.parent
CANONICAL_DIR = ROOT / ".opencode" / "skills"
GENERATED_DIRS = (
    ROOT / ".claude" / "skills",
    ROOT / ".agents" / "skills",
)
EXPECTED_SKILLS = ("sword", "spdf", "shtml")
DOCUMENTATION_FILES = (
    "README.md",
    "README.ar.md",
    "AGENTS.md",
    "CHANGELOG.md",
    "CONTRIBUTING.md",
    "docs/usage-examples.md",
    "docs/usage-examples.en.md",
)

SKILL_NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
REQUIRED_FRONTMATTER_KEYS = ("name", "description")
CODE_FENCE_BLOCK_RE = re.compile(r"```.*?```", flags=re.DOTALL)
INLINE_CODE_RE = re.compile(r"`[^`]*`")
REL_MARKDOWN_LINK_RE = re.compile(r"\]\((?!https?:|mailto:|#)([^)#]+)")
HTML_IMG_SRC_RE = re.compile(r'src="([^"]+)"')


def sha256_digest(path: pathlib.Path) -> str:
    """Return the hex SHA-256 digest of a file."""
    hasher = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(65536), b""):
            hasher.update(chunk)
    return hasher.hexdigest()


def parse_frontmatter(path: pathlib.Path, text: str) -> tuple[dict | None, list[str]]:
    """Extract and parse YAML frontmatter from a SKILL.md document."""
    errors: list[str] = []
    if not text.startswith("---"):
        return None, [f"{path.relative_to(ROOT)}: missing YAML frontmatter delimiter '---'"]

    parts = text.split("---", 2)
    if len(parts) < 3:
        return None, [f"{path.relative_to(ROOT)}: unclosed YAML frontmatter block"]

    try:
        parsed = yaml.safe_load(parts[1])
    except yaml.YAMLError as exc:
        return None, [f"{path.relative_to(ROOT)}: invalid YAML frontmatter ({exc})"]

    if not isinstance(parsed, dict):
        errors.append(f"{path.relative_to(ROOT)}: frontmatter root must be a YAML mapping")
        return None, errors

    return parsed, errors


def validate_skill_frontmatter(skill_files: Iterable[pathlib.Path]) -> list[str]:
    """Validate Agent Skills standard frontmatter rules across all discovered SKILL.md files."""
    errors: list[str] = []
    discovered = list(skill_files)
    if not discovered:
        return ["no SKILL.md files found under .*/skills/*/SKILL.md"]

    for path in discovered:
        rel = path.relative_to(ROOT)
        text = path.read_text(encoding="utf-8")
        fm, fm_errors = parse_frontmatter(path, text)
        if fm_errors or fm is None:
            errors.extend(fm_errors)
            continue

        for key in REQUIRED_FRONTMATTER_KEYS:
            if not fm.get(key):
                errors.append(f"{rel}: missing required frontmatter field '{key}'")

        name = fm.get("name", "")
        if not isinstance(name, str) or not SKILL_NAME_RE.match(name) or len(name) > 64:
            errors.append(
                f"{rel}: invalid name '{name}' (must match ^[a-z0-9]+(-[a-z0-9]+)*$, max 64 chars)"
            )
        if name != path.parent.name:
            errors.append(f"{rel}: name '{name}' does not match parent directory '{path.parent.name}'")

        description = fm.get("description", "")
        if not isinstance(description, str) or not (1 <= len(description) <= 1024):
            length = len(description) if isinstance(description, str) else 0
            errors.append(f"{rel}: description must be 1-1024 chars (got {length})")

        metadata = fm.get("metadata") or {}
        if not isinstance(metadata, dict):
            errors.append(f"{rel}: 'metadata' must be a key-value mapping")
        else:
            for meta_key, meta_val in metadata.items():
                if not isinstance(meta_val, str):
                    errors.append(f"{rel}: metadata['{meta_key}'] must be a string")

        # Ensure mandatory 9-question ask-first section remains present in canonical skill body
        if "## 2." not in text and "## 2 " not in text:
            errors.append(f"{rel}: missing mandatory section 2 ('ask first' protocol)")

    return errors


def validate_platform_sync() -> list[str]:
    """Verify generated platform skill directories match `.opencode/skills` byte-for-byte."""
    errors: list[str] = []
    for skill in EXPECTED_SKILLS:
        canonical = CANONICAL_DIR / skill / "SKILL.md"
        if not canonical.is_file():
            errors.append(f"missing canonical skill source: {canonical.relative_to(ROOT)}")
            continue

        canonical_hash = sha256_digest(canonical)
        for platform_dir in GENERATED_DIRS:
            target = platform_dir / skill / "SKILL.md"
            if not target.is_file():
                errors.append(
                    f"missing generated copy: {target.relative_to(ROOT)} (run ./scripts/sync-platforms.sh)"
                )
                continue
            if sha256_digest(target) != canonical_hash:
                errors.append(
                    f"platform drift detected in {target.relative_to(ROOT)} "
                    "(run ./scripts/sync-platforms.sh)"
                )
    return errors


def validate_documentation() -> list[str]:
    """Validate balanced Markdown code fences, HTML `<details>`, relative links, and image paths."""
    errors: list[str] = []
    for rel_doc in DOCUMENTATION_FILES:
        path = ROOT / rel_doc
        if not path.is_file():
            errors.append(f"missing expected documentation file: {rel_doc}")
            continue

        text = path.read_text(encoding="utf-8")
        if text.count("```") % 2 != 0:
            errors.append(f"{rel_doc}: unbalanced triple-backtick code fences")

        prose = CODE_FENCE_BLOCK_RE.sub("", text)
        prose = INLINE_CODE_RE.sub("", prose)
        if prose.count("<details>") != prose.count("</details>"):
            errors.append(f"{rel_doc}: unbalanced <details> / </details> HTML blocks")

        for target in REL_MARKDOWN_LINK_RE.findall(prose):
            resolved = (path.parent / target.strip()).resolve()
            if not resolved.exists():
                errors.append(f"{rel_doc}: broken relative link -> {target}")

        for img_src in HTML_IMG_SRC_RE.findall(prose):
            if img_src.startswith(("http://", "https://", "data:")):
                continue
            resolved = (path.parent / img_src.strip()).resolve()
            if not resolved.exists():
                errors.append(f"{rel_doc}: missing referenced image -> {img_src}")

    return errors


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Validate SKILL.md frontmatter, multi-agent sync, and bilingual documentation."
    )
    parser.add_argument(
        "--github-annotations",
        action="store_true",
        help="Format failures as GitHub Actions ::error:: workflow commands.",
    )
    args = parser.parse_args(argv)

    skill_files = sorted(ROOT.glob(".*/skills/*/SKILL.md"))
    errors: list[str] = []
    errors.extend(validate_skill_frontmatter(skill_files))
    errors.extend(validate_platform_sync())
    errors.extend(validate_documentation())

    if errors:
        for err in errors:
            prefix = "::error::" if args.github_annotations else "ERROR: "
            print(f"{prefix}{err}", file=sys.stderr if not args.github_annotations else sys.stdout)
        return 1

    print(
        f"OK — validated {len(skill_files)} SKILL.md files, "
        f"{len(EXPECTED_SKILLS) * len(GENERATED_DIRS)} synced copies, "
        f"and {len(DOCUMENTATION_FILES)} documentation files."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
