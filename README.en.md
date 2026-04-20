# Better ShanghaiTech

Better ShanghaiTech is a semi-open public-interest project for ShanghaiTech campus life. The goal is to provide a clearer and more useful mobile experience for courses, notices, common information, and campus tools.

This repository is the public community collaboration surface. It is not the full production repository. To protect user privacy, campus system safety, and long-term reliability, some backend code, admin tooling, production deployment, sensitive automation, internal data-processing logic, and API documentation remain private.

中文版本: [README.md](README.md)

## What You Can Do Here

Good public contributions include:

- Flutter public architecture and shared widget improvements
- dark-mode, accessibility, mobile layout, and interaction polish
- public feature proposals and prototypes
- community extension manifests and documentation
- tests and quality improvements for public utility code
- documentation, Chinese/English copy, and localization improvements

Do not submit code that bypasses campus system restrictions, stores real user credentials, scrapes protected data, depends on private production APIs, adds high-risk automation, or includes logs, databases, secrets, or user data.

## Repository Shape

```text
mobile/                  Public Flutter architecture subset
api/app/services/        Selected non-sensitive service examples
api/app/schemas/         Schemas used by the public service examples
extensions/              Community extension examples and manifests
docs/                    Development, contribution, and release guides
```

The public repository is not a complete replacement for the production app. Treat it as a community collaboration contract: the parts that are useful and safe for shared work are public, while privacy-sensitive, safety-sensitive, and campus-compliance-sensitive capabilities are maintained privately.

## Start Here

Read these documents first:

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

The public repository does not include the production API URL by default. For local runs, provide your own test service:

```bash
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:18000/api/v1
```

## API Boundary

Production API documentation and full backend implementation are outside the public scope. Public contributions should not hard-code production endpoints or infer private contracts from online behavior.

If a feature needs backend support, open an issue describing:

- the user problem
- the expected frontend behavior
- the minimum required data shape
- failure states and privacy impact
- whether user authorization or explicit notice is required

Maintainers will decide whether private backend support is appropriate.

## Semi-Open Principle

The goal of this public repository is to let the community safely participate in experience improvements and public capability building. It is not intended to expose every production implementation detail.

Private areas usually include:

- admin tooling and production operations configuration
- full backend routes and production API documentation
- private model routing, prompts, and data-processing logic
- internal implementations for sensitive mail, course, notice, and user-data flows
- important crawling, automation, and risk-control code
- secrets, logs, database snapshots, sessions, and real user data

## Releases

Installable APKs are manually uploaded by maintainers to GitHub Releases. Public source code and release artifacts are not identical: release builds may come from the private production repository and go through additional testing, signing, and configuration checks.
