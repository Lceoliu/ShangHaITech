# Better ShanghaiTech Community

This repository is the public community contribution surface for the Better
ShanghaiTech app.

The production app is commercial software. This public repository intentionally
contains only the parts that are useful for community contributions:

- Flutter mobile architecture examples
- shared UI widgets and theme conventions
- API client and error-handling patterns
- extension manifest examples
- selected non-sensitive service code used to load community extensions
- contribution, review, and release documentation

It does not contain the private backend, admin console, production API
documentation, production deployment configuration, commercial billing logic,
automation features, sensitive crawlers, private prompts, secrets, logs, or user
data.

## What You Can Contribute

Good public contributions include:

- UI polish for shared widgets
- new community feature proposals
- extension manifests and extension documentation
- accessibility and dark-mode improvements
- tests for public utility code
- documentation improvements
- localization and copy improvements

Do not submit code that automates restricted campus systems, stores private
credentials, bypasses rate limits, scrapes protected data, or depends on
undocumented production APIs.

## Repository Shape

```text
mobile/                  Public Flutter architecture subset
api/app/services/        Selected non-sensitive service examples
api/app/schemas/         Schemas needed by the public service examples
extensions/              Community extension manifests
docs/                    Community development and release guides
```

The public subset is not guaranteed to be a full replacement for the production
app. Treat it as the contribution contract and reference implementation for
features that may later be reviewed and integrated into the private production
repository.

## Start Here

Read these documents first:

- [Developer Guide](docs/DEV_GUIDE.md)
- [Contribution Guide](CONTRIBUTING.md)
- [Release Guide](docs/RELEASE_GUIDE.md)
- [Extension Contract](docs/extensions.md)

## API Boundary

The production API contract is private. Public contributions should avoid
hard-coding production endpoints beyond generic client patterns. If a feature
needs backend support, open an issue describing:

- the user problem
- the desired frontend behavior
- the minimum data shape required
- failure states and privacy considerations

Maintainers will decide whether a private API change is appropriate.

## Releases

Installable APKs are distributed manually through GitHub Releases. Source code
and release artifacts are versioned separately; a public source contribution
does not automatically imply a production app release.

