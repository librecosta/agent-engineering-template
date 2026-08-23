# ADR-0002: Prefer Executable Constraints

**Status:** Accepted

## Context

Human-readable engineering documentation is useful for explaining intent, but written instructions alone are weak enforcement mechanisms.

A rule such as:

> Run formatting, linting, tests, and contract checks before completing a change.

still depends on every contributor or coding agent remembering:

- which tools to run;
- which arguments to use;
- which order to run them in;
- which failures are acceptable;
- whether local checks match CI.

The same problem applies to architectural boundaries, generated files, schema consistency, compatibility checks, and other engineering constraints.

Coding agents are especially sensitive to ambiguous or duplicated instructions. Requiring them to reconstruct verification procedures from prose increases token usage and creates opportunities for inconsistent behavior.

## Decision

Prefer executable enforcement whenever a meaningful engineering constraint can be checked automatically.

Written documentation SHOULD explain intent, scope, and exceptions.

Executable tooling SHOULD enforce the rule itself.

Examples include:

```text
Written intent                 Executable enforcement

Formatting policy        →     formatter
Code-quality rules       →     linter
Behavior expectations    →     tests
Schema evolution         →     migration tooling
Generated-code freshness →     generation checks
API compatibility        →     contract tests
Dependency boundaries    →     architecture checks
Repository verification  →     make check
```

The repository SHOULD expose a small and stable command surface for common engineering actions.

The preferred final verification entry point is:

```bash
make check
```

CI SHOULD reuse the same underlying verification commands used locally rather than implementing an unrelated validation path.

## Alternatives Considered

### Documentation-only rules

Advantages:

- simple to create;
- flexible;
- easy for humans to read.

Disadvantages:

- cannot enforce compliance;
- easily becomes stale;
- different contributors may interpret rules differently;
- coding agents must translate prose into commands;
- CI may diverge from documented expectations.

Documentation remains necessary for rules that cannot be meaningfully automated, but it should not substitute for practical enforcement.

### CI-only enforcement

Advantages:

- centralized;
- difficult to bypass in protected workflows.

Disadvantages:

- feedback arrives late;
- contributors cannot always reproduce failures locally;
- coding agents may finish work before discovering invalid changes;
- CI configuration can become a separate source of engineering truth.

CI remains essential, but local and CI verification should share the same command surface whenever practical.

### Agent-specific prompts and instructions

Advantages:

- can encode detailed workflow behavior;
- may improve performance for one Agent implementation.

Disadvantages:

- tied to specific tools or models;
- difficult to keep synchronized;
- not automatically useful to human contributors;
- cannot reliably enforce repository correctness.

Agent instructions may provide routing and context, but repository correctness should not depend on a particular Agent obeying a prompt.

## Consequences

### Positive

- Engineering rules become reproducible.
- Humans and coding agents receive the same verification behavior.
- CI becomes easier to understand.
- Written Agent context can remain smaller.
- Failures provide concrete feedback instead of ambiguous guidance.
- Repository rules are less dependent on contributor memory.

### Negative

- Automated checks require maintenance.
- Some rules are expensive or impractical to automate.
- Overly strict checks can slow development or encode poor assumptions.
- Tooling itself can become complex if too many commands are exposed.

## Implementation Guidance

Automation SHOULD remain proportional to the value of the constraint.

Do not automate a rule merely because automation is possible.

Prefer checks that are:

- deterministic;
- fast enough for their intended workflow;
- reproducible locally;
- clear when they fail;
- aligned with actual engineering risk.

When a constraint cannot reasonably be automated, document it concisely in the most relevant contract, architecture document, or playbook.

The goal is not maximum automation.

The goal is to move important correctness rules from memory into the repository wherever doing so materially improves reliability.
