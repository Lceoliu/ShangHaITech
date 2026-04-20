from __future__ import annotations

from pydantic import BaseModel, Field


class ExtensionWebManifest(BaseModel):
    entry_path: str


class ExtensionApiManifest(BaseModel):
    base_path: str


class ExtensionManifest(BaseModel):
    key: str
    name: str
    description: str
    version: str
    enabled: bool = False
    required_role: str = "user"
    web: ExtensionWebManifest
    api: ExtensionApiManifest
    jobs: list[str] = Field(default_factory=list)
    owner: str = "community"
    source_dir: str | None = None
