# Contributing

Thanks for contributing to Better ShanghaiTech.

This public repository is designed for community-facing work. Production-only
systems remain private for security, privacy, and business reasons.

## Contribution Flow

1. Open an issue for non-trivial work before sending a large PR.
2. Keep the change scoped to public code and public docs.
3. Run formatting and tests for the files you touch.
4. Explain user impact, screenshots for UI changes, and any privacy risks.
5. Wait for maintainer review. Accepted public changes may be mirrored into the
   private production repository.

## Pull Request Requirements

Each PR should include:

- a clear summary
- test notes or a reason tests were not run
- screenshots or screen recordings for UI changes
- migration notes if the public contract changes
- confirmation that no secrets, private endpoints, logs, or user data are added

## Boundaries

Do not contribute:

- admin console code
- production API docs
- private deployment configuration
- commercial billing or credit logic
- private prompts or model routing logic
- automation for restricted systems
- code that stores real user credentials
- crawlers for protected or high-risk data sources
- logs, database snapshots, session files, or tokens

## Coding Style

For Flutter code:

- follow the existing theme and shared widget patterns
- support light and dark themes
- keep touch targets comfortable on mobile
- avoid page-level network calls that block the first frame
- prefer small reusable widgets over one-off visual forks

For extension manifests:

- use stable keys
- document required user permissions
- describe failure states
- keep the extension disabled by default until reviewed

## Security Reports

Do not open public issues for vulnerabilities that expose user data, credentials,
or production behavior. Follow [SECURITY.md](SECURITY.md).

