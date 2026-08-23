# Engineering Playbook

## Purpose

This document defines the default workflow for making changes in this repository.

It is intentionally procedural.

Architecture belongs in `architecture.md`.
Stable constraints belong in `contracts/`.

## Before Editing

### 1. Understand the task

Identify:

- the intended outcome;
- the affected modules;
- explicit constraints;
- acceptance criteria;
- what is out of scope.

Do not expand the scope without a clear engineering reason.

### 2. Inspect repository context

Read:

1. `AGENTS.md`;
2. the relevant section of `.agents/architecture.md`;
3. relevant files under `contracts/`;
4. related ADRs when architecture is involved.

### 3. Inspect the implementation

Before changing code:

- locate the current implementation;
- inspect nearby patterns;
- inspect relevant tests;
- identify the authoritative schema or specification when applicable.

Do not assume documentation is perfectly synchronized with the implementation.

### 4. Establish a baseline

When practical, run the relevant existing tests or checks before editing.

This helps distinguish pre-existing failures from regressions introduced by the change.

## During Editing

### Keep the change coherent

Prefer the smallest change that fully satisfies the task.

Avoid unrelated:

- refactoring;
- renaming;
- dependency upgrades;
- formatting changes;
- architectural restructuring.

### Follow existing patterns

Prefer established repository conventions before introducing new abstractions or patterns.

A new abstraction should solve a concrete problem rather than merely make the code appear more generalized.

### Respect contracts

Before changing a public API, persistent representation, or upstream integration, inspect the corresponding contract.

Breaking changes MUST be explicit.

### Preserve sources of truth

Do not manually modify generated artifacts.

Change the authoritative source and regenerate them instead.

Examples include:

- generated database access code;
- API clients;
- schema-derived types;
- generated documentation.

### Test behavior

Observable behavior changes SHOULD be accompanied by tests.

Bug fixes SHOULD include regression coverage when practical.

Tests should verify behavior rather than implementation details unless the implementation detail itself is an architectural constraint.

## Before Finishing

### 1. Run repository verification

Run:

```bash
make check
```

Use narrower checks during development when useful, but the repository-wide check is the preferred final verification path.

### 2. Inspect the final diff

Review the complete diff for:

- accidental edits;
- unrelated formatting;
- dead code;
- temporary debugging output;
- unintended generated changes;
- unexpected dependency changes.

### 3. Re-check contracts

Confirm that affected:

- compatibility;
- data;
- upstream;

contracts remain valid.

If a contract intentionally changed, update the relevant contract and clearly describe the impact.

### 4. Update engineering history when appropriate

Update `CHANGELOG.md` for notable user-facing or engineering changes.

Create or update an ADR only for significant architectural decisions.

Do not use either file as a substitute for Git history.

### 5. Report verification accurately

Do not claim a check passed unless it was actually executed successfully.

If verification is incomplete, state:

- what was executed;
- what passed;
- what failed;
- what could not be executed.

## When Unsure

Do not invent repository conventions.

Resolve uncertainty in this order:

1. inspect the implementation;
2. inspect tests;
3. inspect machine-readable specifications;
4. inspect contracts;
5. inspect ADRs;
6. inspect Git history when historical intent matters.

If a consequential ambiguity remains, surface it explicitly rather than silently choosing a new architectural direction.
