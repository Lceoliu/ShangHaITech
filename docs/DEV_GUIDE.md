# Developer Guide

This guide explains how community contributors should work with the public
subset of Better ShanghaiTech.

## Local Setup

Install Flutter and verify it first:

```bash
flutter doctor
```

Then fetch packages:

```bash
cd mobile
flutter pub get
```

The public repository is a contribution subset. Some production routes and
backend-backed features are intentionally absent. Public Flutter code should be
treated as reference architecture for shared UI, theme, API envelope handling,
and feature proposal work.

## API Configuration

The public app should not hard-code the production API. Use a build-time value:

```bash
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:18000/api/v1
```

For production release builds, maintainers set the real API URL in the private
release pipeline.

## Frontend Architecture

The public Flutter subset keeps these layers:

```text
mobile/lib/core/          API envelope, config, theme, secure storage patterns
mobile/lib/shared/        reusable widgets, models, utility helpers
mobile/lib/features/      safe feature examples and public-facing patterns
```

Recommended feature shape:

```text
features/your_feature/
  your_feature_page.dart
  your_feature_repository.dart
  your_feature_models.dart
```

Keep page code focused on UI state. Put network parsing and caching in the
repository layer. Use shared widgets for loading, error, search, and navigation
patterns.

## Loading And Refresh Behavior

User-facing features should:

- render cached or placeholder content quickly
- use local loading indicators instead of blocking full pages
- keep previous content visible during background refresh
- show concise toasts for optimistic updates
- classify errors as auth, network, server, validation, or unavailable

Avoid full-page reloads when switching tabs.

## Theme Requirements

All UI changes must support both light and dark themes. Avoid hard-coded text
colors. Prefer:

```dart
final cs = Theme.of(context).colorScheme;
```

Use shared widgets and theme tokens before introducing new visual primitives.

## Extension Development

Community extensions start with a manifest:

```json
{
  "key": "hello-world",
  "name": "Hello World",
  "description": "Example extension manifest",
  "version": "0.1.0",
  "enabled": false,
  "required_role": "user",
  "web": {
    "entry_path": "/extensions/hello-world"
  },
  "api": {
    "base_path": "/api/v1/extensions/hello-world"
  },
  "jobs": ["hello.run"],
  "owner": "community"
}
```

Production maintainers decide when an extension can be enabled and whether it
requires private backend support.

## Backend Boundary

The public repository includes only selected non-sensitive service examples.
Production routers, admin APIs, billing, AI routing, mail processing, and
automation services are private.

If a contribution needs backend changes, document the proposed data shape in an
issue instead of adding private API assumptions to public code.

## Checklist Before PR

- `flutter analyze` for touched Flutter code when possible
- no secrets, tokens, logs, private endpoints, or database snapshots
- no private API documentation
- screenshots for UI changes
- dark-mode behavior checked
- privacy impact explained if user data is involved

