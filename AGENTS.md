# AGENTS.md

## Repository Purpose

This repository is a reference implementation of AI Agent-friendly software engineering practices.

Its purpose is to demonstrate how repository structure, explicit contracts, architecture rules, and executable verification can improve collaboration between humans and coding agents.

## Start Here

Before making a change:

1. Identify the affected area.
2. Read `.agents/architecture.md` for system boundaries.
3. Read `.agents/playbook.md` for the expected engineering workflow.
4. Read any relevant file under `contracts/`.
5. Inspect the current implementation and tests before making assumptions.

For architectural changes, also inspect relevant ADRs under `docs/decisions/`.

## Repository Map

- `apps/` — runnable applications.
- `packages/` — reusable application or domain packages.
- `migrations/` — versioned database schema changes.
- `tests/` — repository-level and cross-module tests.
- `.agents/` — concise Agent-oriented engineering context.
- `contracts/` — stable engineering constraints.
- `docs/decisions/` — significant architecture decisions.
- `.github/` — contribution and CI workflows.

## Sources of Truth

Prefer authoritative, executable sources over descriptive documentation.

In general:

1. source code and tests;
2. schemas, migrations, specifications, and generated contracts;
3. repository configuration;
4. engineering documentation.

Documentation explains intent and constraints but MUST NOT be used to override the actual implementation or machine-readable contract.

If documentation and implementation disagree, identify the inconsistency rather than silently choosing one.

## Core Rules

- Keep changes minimal and coherent.
- Do not introduce unrelated refactoring.
- Do not silently break public contracts.
- Do not manually edit generated artifacts.
- Preserve architectural dependency boundaries.
- Add or update tests when observable behavior changes.
- Use versioned migrations for persistent schema changes.
- Do not modify released migrations in place.
- Record significant architectural decisions as ADRs when appropriate.

## Verification

Before considering a change complete, run:

```bash
make check
```

If the full check cannot be completed, clearly report what was and was not verified.

Before finishing:

1. inspect the final diff;
2. remove unrelated changes;
3. confirm affected contracts remain valid;
4. update `CHANGELOG.md` when the change is notable;
5. add or update an ADR when a significant architectural decision was made.
