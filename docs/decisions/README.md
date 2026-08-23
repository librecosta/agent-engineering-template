# Architecture Decision Records

Architecture Decision Records (ADRs) capture significant engineering decisions and the reasoning behind them.

They exist to preserve context that may not be obvious from the current implementation alone.

## When to Write an ADR

Create an ADR when a decision:

- changes an important architectural boundary;
- affects multiple modules or applications;
- introduces a major infrastructure or persistence choice;
- is difficult or expensive to reverse;
- establishes a long-term engineering constraint;
- rejects a plausible alternative that future maintainers may reconsider.

Routine implementation choices do not require ADRs.

Examples that usually do **not** need an ADR:

- renaming a local function;
- choosing between equivalent helper APIs;
- small refactors;
- routine dependency updates;
- bug-fix implementation details.

## ADR Structure

Each ADR should contain:

```text
Title
Status
Context
Decision
Alternatives Considered
Consequences
```

Additional sections may be added when they materially improve understanding.

## Status

Use one of the following states:

- `Proposed` — under discussion and not yet adopted.
- `Accepted` — currently adopted.
- `Superseded` — replaced by a newer ADR.
- `Deprecated` — no longer recommended, but not necessarily replaced.

When an ADR is superseded, keep the original document and link to the replacement.

## Naming

Use a monotonically increasing numeric prefix and a short descriptive name:

```text
0001-use-monorepo.md
0002-prefer-executable-constraints.md
0003-example-future-decision.md
```

Do not renumber existing ADRs.

## Writing Principles

ADRs SHOULD be:

- concise;
- focused on one significant decision;
- explicit about trade-offs;
- understandable without reading Git history.

ADRs SHOULD NOT:

- duplicate implementation documentation;
- become design specifications for every detail;
- describe temporary work;
- be rewritten to hide historical reasoning.

If a decision changes, prefer a new ADR that supersedes the old one.

## Relationship to Other Documents

- `AGENTS.md` routes agents to relevant engineering context.
- `.agents/architecture.md` describes the current architectural model and invariants.
- `contracts/` defines stable constraints.
- ADRs explain **why significant decisions were made**.
- `CHANGELOG.md` records notable changes over time.

The current architecture is authoritative for how the repository works today.

ADRs preserve the reasoning that led there.
