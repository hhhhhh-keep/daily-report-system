"""Build deterministic, validator-compatible scripted Skill release ZIPs."""

from __future__ import annotations

import json
import zipfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILLS = ROOT / "deliverables" / "skills"
OUTPUT = ROOT / "deliverables" / "skill-packages"


def package(skill_name: str) -> Path:
    skill = SKILLS / skill_name
    manifest = json.loads((skill / "manifest.json").read_text(encoding="utf-8"))
    paths = {"SKILL.md", "manifest.json"}
    paths.update(manifest["entrypoints"].values())
    paths.update(manifest.get("modules", []))
    for directory, patterns in {
        "schemas": ("*.json",), "references": ("*.md",),
        "assets": ("*.css", "*.png", "*.jpg", "*.jpeg", "*.gif", "*.svg", "*.webp", "*.docx"),
    }.items():
        base = skill / directory
        if base.exists():
            for pattern in patterns:
                paths.update(path.relative_to(skill).as_posix() for path in base.glob(pattern))
    OUTPUT.mkdir(parents=True, exist_ok=True)
    destination = OUTPUT / f"{skill_name}-v{manifest['skill_version']}.zip"
    with zipfile.ZipFile(destination, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for relative in sorted(paths):
            source = skill / relative
            if not source.is_file():
                raise FileNotFoundError(source)
            info = zipfile.ZipInfo(relative, date_time=(2026, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            archive.writestr(info, source.read_bytes())
    return destination


if __name__ == "__main__":
    for name in ("daily-work-analysis", "daily-report-docx-template"):
        print(package(name))
