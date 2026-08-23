# Upstream Contract

## Purpose

This document defines how the repository interacts with systems and dependencies that it does not control.

Upstream behavior must be treated as an external contract, not as an implementation detail we can freely change.

## Requirement Language

The keywords **MUST**, **MUST NOT**, **SHOULD**, and **SHOULD NOT** express the strength of a rule.

## What Counts as Upstream

Upstreams may include:

- third-party APIs;
- SDKs and libraries;
- external services;
- protocols;
- remote schemas;
- upstream repositories;
- scraped or undocumented external data sources;
- infrastructure provider APIs.

Not every dependency requires an entry here.

Document an upstream when its behavior materially affects correctness, compatibility, or maintenance risk.

## Rules

### Validate at the boundary

External input MUST be treated as untrusted or changeable.

Responses SHOULD be validated before they become internal domain data.

### Isolate upstream assumptions

Important upstream-specific behavior SHOULD be isolated behind a clear integration boundary.

Core domain logic SHOULD NOT depend directly on incidental upstream response shapes when an adapter can contain that dependency.

### Do not rely on undocumented behavior casually

Undocumented upstream behavior SHOULD NOT become a critical dependency without an explicit reason.

When such reliance is unavoidable, the assumption SHOULD be documented as fragile.

### Preserve error provenance

Upstream failures SHOULD remain distinguishable from internal failures when that distinction matters operationally or semantically.

Avoid converting every external failure into an indistinguishable generic error too early.

### Define timeout and retry ownership

Timeouts, retries, and rate-limit handling SHOULD have a clear owner.

Retries MUST NOT be added blindly to non-idempotent operations.

Backoff behavior SHOULD respect upstream limits and failure modes.

### Treat parsing as a compatibility boundary

For scraped pages, undocumented payloads, or loosely specified formats, parsers SHOULD fail predictably when expected structure changes.

Silent partial corruption is usually worse than an explicit parsing failure.

## Dependency Upgrades

Before upgrading an important upstream dependency:

1. review relevant release notes or migration guides;
2. identify breaking or semantic changes;
3. inspect affected adapters and tests;
4. update documented assumptions when needed;
5. run repository verification.

Routine low-risk dependency updates do not require an ADR.

A major dependency change MAY require an ADR when it changes architecture or introduces a difficult-to-reverse commitment.

## Upstream Registry

Real projects SHOULD keep this section concise and include only material dependencies.

Example:

| Upstream | Purpose | Stability | Important Assumptions |
| --- | --- | --- | --- |
| Example API | Metadata lookup | Documented API | IDs remain stable; responses may be rate-limited |
| Example SDK | Service integration | Versioned library | Major versions may change error semantics |

Remove example rows when adapting this template.

## Testing

Important upstream integrations SHOULD have tests at the boundary.

Depending on the integration, useful approaches include:

- fixture-based parser tests;
- adapter unit tests;
- contract tests;
- integration tests against a sandbox;
- recorded response tests where legally and operationally appropriate.

Tests SHOULD focus on assumptions the repository actually depends on.

## Change Checklist

Before completing an upstream-related change, verify:

1. Which upstream assumption changed?
2. Is the change documented or inferred?
3. Does the adapter still isolate external behavior?
4. Are errors still classified correctly?
5. Are timeout, retry, and rate-limit behaviors safe?
6. Are tests updated for the changed assumption?
7. Does `CHANGELOG.md` or an ADR need an update?

## Non-Goals

This file SHOULD NOT duplicate:

- full third-party documentation;
- complete SDK APIs;
- every transitive dependency;
- lockfiles or dependency manifests.

Those artifacts remain authoritative for dependency versions and concrete external specifications.
