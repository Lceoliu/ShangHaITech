# Release Guide

Releases are managed by maintainers. Community contributors do not publish
production builds.

## Versioning

Recommended tag format:

```text
mobile-vYYYY.MM.DD.N
api-vYYYY.MM.DD.N
prod-vYYYY.MM.DD.N
```

Examples:

```text
mobile-v2026.04.20.1
prod-v2026.04.20.1
```

## Android APK Release

Maintainers build release APKs from the private production repository:

```bash
cd mobile
flutter clean
flutter pub get
flutter build apk --release --dart-define=API_BASE_URL=<production-api-base-url>
```

The generated artifact is usually:

```text
mobile/build/app/outputs/flutter-apk/app-release.apk
```

Before uploading to GitHub Releases:

- verify the API base URL
- verify app icon and version code
- smoke-test login/session, home, course, mail, and profile flows
- confirm no dev endpoint is compiled into the APK
- write release notes with known issues

## Manual GitHub Release Upload

1. Create or select the release tag.
2. Upload the APK artifact manually.
3. Add checksums when possible.
4. Include compatibility notes and rollback guidance.
5. Keep older stable APKs available unless there is a security reason to remove
   them.

## Public Source vs Release Artifacts

The public repository is a community source subset. APK releases may include
private production code and are uploaded manually by maintainers.
