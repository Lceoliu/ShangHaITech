# Security Policy

Do not report sensitive vulnerabilities in public issues.

Email or privately contact the maintainers for issues involving:

- account takeover
- credential exposure
- production API behavior
- private backend endpoints
- payment or credit logic
- user data leakage
- bypasses of campus system restrictions

## Do Not Commit

- `.env` files
- API keys
- JWT secrets
- Cloudflare credentials
- database snapshots
- logs containing user data
- session files
- private API documentation
- production deployment configuration

## Supported Scope

The public repository supports community-facing code and docs. The private
production repository may contain additional security fixes that are not mirrored
publicly.

