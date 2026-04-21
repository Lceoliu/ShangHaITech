# ShangHaITech: All In One App

ShangHaITech is an all-in-one campus life app for ShanghaiTech University. It brings courses, deadlines, mail, announcements, Blackboard, AI tools, and common campus utilities into a faster mobile-first experience, so students spend less time switching systems and more time acting on what matters.

中文版本: [README.md](README.md)

## Why This Matters

Campus information is often fragmented across course platforms, mailbox threads, Blackboard pages, deadlines, file downloads, evaluations, and temporary notices. ShangHaITech aims to turn that fragmented workflow into a trustworthy, extensible, student-centered campus assistant.

The project focuses on three outcomes:

- Find information faster: bring courses, deadlines, mail, and frequent actions into one entry point.
- Miss fewer important items: use red dots, reminders, action lists, announcements, and update prompts to surface what needs attention.
- Feel native on mobile: redesign workflows for phone screens instead of wrapping scattered websites.

## App Features

Planned and actively improved capabilities include:

- Home dashboard: courses, plans, announcements, messages, and high-frequency actions in one place.
- Course helper: semester courses, course detail pages, exam schedules, reviews, and related course information.
- Deadline center: aggregated deadlines from course work, Gradescope, Blackboard, and other sources.
- Smart mail: campus mailbox sync, summaries, relevance ranking, and actionable items.
- Blackboard tools: mobile-friendly access to course content, notices, files, and tasks.
- Smart Q / GenAI: campus-aware question answering, summarization, and assisted workflows.
- File transfer: lower-friction file movement between phone and desktop.
- One-tap evaluation: simplify repetitive campus form workflows.
- Message center: system messages, announcements, and future push reminders.
- Account and settings: account binding, mailbox binding, privacy documents, and theme preferences.

## Current Progress

The project is already running online and will continue to evolve with stability as the first priority.

Near-term plan:

- Android releases: distribute APKs through GitHub Releases with in-app update prompts.
- Push reminders: gradually connect FCM for important announcements, deadlines, and actionable items.
- Mail experience: improve first sync, summary reliability, action-item ranking, and cross-device state consistency.
- Course experience: improve reviews, exam schedules, detail pages, and semester switching.
- Dark mode: keep auditing text, tags, buttons, and cards for readability.
- Performance: reduce blocking requests, keep cached content visible, and refresh quietly in the background.
- Community extensions: keep a clean path for lightweight tools and campus utilities.

Longer-term direction:

- A more complete campus search and knowledge entry point.
- More reliable cross-device sync.
- Finer-grained reminders and subscriptions.
- Plugin-style capabilities for clubs, courses, and campus services.
- Clearer privacy explanations and user data controls.

## Start Here

If you only want to install the app, watch GitHub Releases. Maintainers will upload official APKs and include version changes, compatibility notes, and known issues in release notes.

If you want to contribute or propose features, read:

- [Developer Guide](docs/DEV_GUIDE.md)
- [Contribution Guide](CONTRIBUTING.md)
- [Release Guide](docs/RELEASE_GUIDE.md)
- [Extension Contract](docs/extensions.md)

Local Flutter checks:

```bash
cd mobile
flutter pub get
flutter analyze
```

The public test API is not announced yet. Developers may use their own test service:

```bash
flutter run --dart-define=API_BASE_URL=http://TO_BE_RELEASED/api/v1
```

## QA

**Q: What is ShangHaITech?**
A: A campus life app for ShanghaiTech students, focused on courses, deadlines, mail, announcements, AI tools, and common campus services.

**Q: Can I install it now?**
A: APKs will be published through GitHub Releases. Available features depend on the specific release notes.

**Q: Why does this app exist?**
A: Campus information is split across many systems, and mobile workflows are often inconsistent. ShangHaITech organizes high-frequency information and action items into a better mobile entry point.

**Q: Will it support update prompts?**
A: Yes. Future APKs will be distributed through GitHub Releases, and the app can show recommended or required update prompts based on version policy.

**Q: Can I propose features?**
A: Yes. Open an issue with the user scenario, expected behavior, required data, failure states, and privacy impact.

**Q: What contributions are useful?**
A: Mobile UI, dark mode, accessibility, copywriting, localization, lightweight tools, extension manifests, tests, and documentation are all useful.

## Releases

Installable APKs are available through GitHub Releases. Official releases prioritize stable login, home, course, mail, message, and profile/settings flows.
