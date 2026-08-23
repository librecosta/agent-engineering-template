# Compatibility Contract

## Purpose

This document defines the compatibility boundaries that contributors and coding agents must preserve unless a breaking change is explicitly authorized.

It describes stable behavior, not implementation details.

## Requirement Language

The keywords **MUST**, **MUST NOT**, **SHOULD**, and **SHOULD NOT** express the strength of a rule.

## Compatibility Boundaries

The following interfaces are considered compatibility-sensitive when they are exposed outside their implementation module:

- public library APIs;
- HTTP or RPC APIs;
- CLI commands, flags, and exit behavior;
- configuration keys and file formats;
- serialized or persisted data formats;
- externally consumed events or messages;
- documented user-visible behavior.

Internal implementation details are not compatibility guarantees unless another contract explicitly says otherwise.

## Rules

### Preserve stable interfaces

Existing public interfaces MUST remain backward compatible within the compatibility policy of the project.

A refactor MUST NOT silently change externally observable behavior.

### Make breaking changes explicit

A breaking change MUST be intentional.

When a breaking change is required, the change SHOULD include:

- a clear rationale;
- affected interfaces;
- migration guidance when applicable;
- versioning or rollout implications;
- an updated changelog entry.

Breaking changes MUST NOT be hidden inside unrelated maintenance work.

### Prefer additive evolution

When practical, evolve public interfaces additively.

Prefer:

- adding optional fields;
- adding new endpoints or methods;
- introducing new configuration keys with safe defaults;
- deprecating before removing.

Avoid changing the meaning of an existing field or operation without an explicit compatibility decision.

### Preserve semantic behavior

Compatibility includes behavior, not only type signatures.

A change MAY be breaking even when the public shape is unchanged if it alters semantics that callers reasonably depend on.

Examples include:

- changing error classification;
- changing ordering guarantees;
- changing default behavior;
- changing identifier meaning;
- changing whether a field may be absent or null.

### Deprecation

Deprecated interfaces SHOULD remain functional for a documented transition period when the project supports staged migration.

Deprecation SHOULD identify the preferred replacement.

## Versioning

Projects using semantic versioning SHOULD treat compatibility approximately as follows:

- **patch** — backward-compatible fixes;
- **minor** — backward-compatible features;
- **major** — intentionally breaking changes.

A project MAY use another versioning policy, but that policy should be explicit.

## Verification

Compatibility-sensitive changes SHOULD be covered by executable checks where practical.

Useful mechanisms include:

- API contract tests;
- golden tests;
- schema compatibility checks;
- CLI behavior tests;
- package API checks;
- integration tests.

Written rules SHOULD NOT replace executable compatibility verification when such verification is practical.

## Change Checklist

Before completing a compatibility-sensitive change, verify:

1. Which public boundary is affected?
2. Is the change backward compatible?
3. Does observable behavior change?
4. Is migration guidance required?
5. Are tests or contract checks updated?
6. Does `CHANGELOG.md` need an entry?

## Non-Goals

This file SHOULD NOT duplicate:

- complete API specifications;
- generated schemas;
- implementation details;
- package documentation.

Those artifacts remain authoritative for their concrete interface definitions.
