---
name: agent-engineering-foundation
description: Use when initializing a project, designing or restructuring a repository, or improving engineering foundations. Prefer an Agent-friendly repository model with concise context routing, explicit constraints, durable decisions, clear sources of truth, and reproducible executable verification.
---

# Agent Engineering Foundation

Design repositories so humans and coding agents can understand, modify, and verify the project with minimal ambiguity and context overhead.

Reference model:
https://github.com/librecosta/agent-engineering-template

Repository-local requirements and the project's real architecture take precedence over the reference structure.

Preserve the responsibilities of the model, not necessarily its exact filenames or directories.

## Core Principles

Prefer:

- small, high-signal Agent context;
- explicit architectural and compatibility boundaries;
- authoritative machine-readable sources of truth;
- executable constraints over prose-only rules;
- one stable repository verification path;
- durable records for significant engineering decisions;
- minimal documentation that explains intent rather than duplicates implementation.

Do not add engineering files merely for completeness.

## Repository Model

When useful, establish these responsibilities:

```text
Context
├── AGENTS.md
└── .agents/

Constraints
└── contracts/

Verification
├── Makefile / Taskfile / justfile / equivalent
└── CI

History
├── CHANGELOG.md
└── architecture decision records
```

The names and locations may differ when the repository already has suitable conventions.

## Agent Context

Provide one obvious Agent entry point, preferably `AGENTS.md`.

It SHOULD briefly explain:

- repository purpose;
- important areas;
- where deeper context lives;
- important sources of truth;
- essential engineering rules;
- how changes are verified.

Treat `AGENTS.md` as a router, not an encyclopedia.

Use focused supporting documents only when they have distinct responsibilities.

Typical examples:

- architecture — mental model, dependency direction, invariants;
- playbook — repository-specific change workflow.

Do not duplicate information already obvious from source code or configuration.

## Contracts

Document stable constraints only when the project actually has them.

Useful contract categories may include:

- compatibility;
- persistent data;
- upstream systems or protocols.

Contracts SHOULD explain semantics, assumptions, and boundaries.

Machine-readable specifications, schemas, migrations, APIs, and source code remain authoritative for concrete implementation details.

Do not create empty or hypothetical contracts.

## Architecture

Make important boundaries and invariants explicit.

Prefer concrete rules such as dependency direction and forbidden coupling over architecture terminology.

Do not prescribe a universal application structure.

For closely related applications or packages that frequently evolve together, prefer considering a monorepo when shared repository context materially improves system-wide reasoning and atomic changes.

Do not force a monorepo when independent ownership, security, lifecycle, or release boundaries make separate repositories more appropriate.

## Decisions

Use ADRs or an equivalent mechanism only for significant decisions that:

- affect important architecture;
- establish long-term constraints;
- are expensive to reverse;
- reject plausible alternatives future maintainers may reconsider.

Do not record routine implementation decisions as ADRs.

Preserve historical decisions rather than rewriting them to match the present.

## Verification

Prefer a small stable command surface such as:

```text
make check
task check
just check
```

The exact tool does not matter.

The repository SHOULD provide an obvious final verification path that combines the checks appropriate to the project.

CI SHOULD reuse the same underlying verification logic whenever practical.

If a rule can be reliably enforced by tests, linters, schemas, generators, dependency checks, or other tooling, prefer executable enforcement over repeatedly instructing the Agent to remember it.

## Sources of Truth

Prefer authoritative implementation artifacts over descriptive prose.

A useful default order is:

1. source code and tests;
2. schemas, migrations, specifications, and generated contracts;
3. repository configuration;
4. explanatory engineering documentation.

When documentation and implementation disagree, surface the inconsistency instead of silently trusting stale prose.

## Existing Projects

Before adding Agent engineering structure:

1. inspect existing repository conventions;
2. reuse existing documentation and verification mechanisms;
3. identify real context or constraint gaps;
4. add only the minimum structure needed to close those gaps.

Do not mechanically copy the reference repository into every project.

During normal feature work, do not expand Agent infrastructure unless the task exposes a real engineering gap.

## New Projects

When establishing a new project, consider Agent collaboration early rather than adding it after the repository becomes difficult to understand.

Start small:

- one Agent entry point;
- one concise architecture model when useful;
- explicit contracts only for real stable boundaries;
- one verification entry point;
- decision records only when significant decisions occur.

Allow the structure to grow with the project.

## Quality Bar

A repository is Agent-friendly when a capable coding agent can quickly answer:

- What is this system?
- Where should this change happen?
- What must not be broken?
- Which artifact is authoritative?
- How can the change be verified?
- Why do important architectural constraints exist?

Optimize for clarity and signal, not maximum documentation.

Adapt the structure to the project. Preserve the responsibilities.
