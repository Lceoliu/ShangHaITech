from __future__ import annotations

import json
from pathlib import Path

from app.core.config import get_settings
from app.schemas.extensions import ExtensionManifest


def discover_extensions() -> list[ExtensionManifest]:
    settings = get_settings()
    root = Path(settings.extensions_root)
    manifests: list[ExtensionManifest] = []

    if not root.exists():
        return manifests

    for manifest_path in sorted(root.glob("*/extension.json")):
        payload = json.loads(manifest_path.read_text(encoding="utf-8"))
        payload["source_dir"] = str(manifest_path.parent)
        manifests.append(ExtensionManifest(**payload))

    return manifests
