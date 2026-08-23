# Architecture

## Purpose

This document provides a compact mental model of the repository.

It describes structural boundaries and architectural invariants rather than implementation details.

The source code remains the authoritative description of the current implementation.

## Repository Model

The repository is organized around four primary implementation areas:

```text
apps/
    │
    ▼
packages/
    │
    ▼
infrastructure / external systems

migrations/
    │
    ▼
database schema
```

Supporting engineering context lives outside the implementation tree:

```text
AGENTS.md
    │
    ├── .agents/
    ├── contracts/
    └── docs/decisions/
```

## Applications

`apps/` contains runnable entry points.

Applications may:

- compose packages;
- configure infrastructure;
- expose transport interfaces;
- initialize runtime dependencies.

Applications SHOULD contain composition and delivery concerns rather than reusable domain logic.

Reusable behavior SHOULD live under `packages/`.

## Packages

`packages/` contains reusable components, domain logic, and infrastructure abstractions.

Packages SHOULD have explicit responsibilities and minimal dependency surfaces.

A package MUST NOT depend on an application under `apps/`.

## Data Layer

Persistent schema changes live under `migrations/`.

The database schema MUST evolve through versioned migrations.

Runtime database access should remain behind explicit data-access boundaries rather than being spread throughout transport or application entry points.

See `contracts/data.md` for persistent data rules.

## Dependency Direction

Prefer dependencies that move from orchestration toward reusable implementation:

```text
application
    ↓
service / use case
    ↓
domain
    ↓
data-access abstraction
    ↓
infrastructure
```

Exact layers may differ between projects.

The important rule is that dependency direction remains explicit and does not form accidental cycles.

## Architecture Invariants

The following rules should remain true unless an explicit architectural decision changes them.

### Applications do not become reusable dependencies

Code under `packages/` MUST NOT import code from `apps/`.

### Transport does not own business rules

HTTP handlers, CLI commands, message consumers, and similar adapters SHOULD translate external input into application operations rather than contain core business behavior.

### Persistent access remains bounded

Transport code SHOULD NOT directly perform database operations when a defined application or data-access boundary exists.

### Generated code is not a business-logic layer

Generated artifacts MUST NOT contain manually maintained domain logic.

Change their source specification or generator input instead.

### Schema changes are explicit

Persistent schema changes MUST be represented by versioned migrations.

### Cross-module dependencies are intentional

Adding a dependency between major modules should be treated as an architectural decision rather than an incidental implementation shortcut.

## Architectural Changes

Consider creating or updating an ADR when a change:

- alters dependency direction;
- introduces a new major infrastructure component;
- changes persistence strategy;
- changes repository organization;
- affects multiple modules;
- is expensive to reverse;
- deliberately rejects a plausible alternative.

Routine implementation decisions do not require ADRs.

See `docs/decisions/README.md`.

## What Does Not Belong Here

This file SHOULD NOT contain:

- detailed API documentation;
- complete database schemas;
- coding-style rules;
- library-specific tutorials;
- temporary implementation notes;
- duplicated information already encoded in source or configuration.

Those details belong in their authoritative source.
