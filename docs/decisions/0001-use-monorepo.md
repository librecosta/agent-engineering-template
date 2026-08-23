# ADR-0001: Use a Monorepo

**Status:** Accepted

## Context

This repository is intended to demonstrate engineering practices for collaboration between humans and coding agents.

Coding agents perform better when relevant application code, shared packages, contracts, migrations, tests, and engineering context are available within one discoverable repository boundary.

A multi-repository layout can provide stronger organizational isolation, but it also increases context discovery and coordination cost.

Cross-repository changes may require an agent or contributor to:

- discover related repositories;
- reconstruct relationships between them;
- synchronize incompatible revisions;
- coordinate multiple pull requests;
- verify system-wide behavior across repository boundaries.

For closely related components, these costs make it harder to reason about the system as a whole.

## Decision

Use a monorepo for closely related applications, packages, migrations, tests, contracts, and engineering documentation.

The monorepo is an organizational choice, not permission for unrestricted coupling.

Internal boundaries MUST remain explicit.

Applications SHOULD be composed from reusable packages, and reusable packages MUST NOT depend on application entry points.

Repository-wide tooling SHOULD provide common development and verification entry points.

## Alternatives Considered

### Multiple repositories

Advantages:

- stronger repository-level ownership boundaries;
- smaller individual repositories;
- independent release and access-control models.

Disadvantages:

- fragmented system context;
- higher cross-repository coordination cost;
- harder atomic changes;
- duplicated tooling and engineering instructions;
- more difficult whole-system verification for coding agents.

This remains appropriate when systems have genuinely independent ownership, security, lifecycle, or release requirements.

### Single application repository without explicit internal boundaries

Advantages:

- minimal initial structure;
- low setup cost.

Disadvantages:

- architectural coupling can grow invisibly;
- reusable code and application composition become mixed;
- agents may treat repository-wide visibility as permission to modify unrelated areas.

This does not provide enough structural guidance for the goals of this template.

## Consequences

### Positive

- Humans and coding agents can inspect the relevant system context in one repository.
- Cross-cutting changes can be implemented and reviewed atomically.
- Contracts, migrations, tests, and implementation evolve together.
- CI and local verification can share repository-wide entry points.
- Architectural context is easier to discover.

### Negative

- The repository may become large over time.
- Tooling must avoid unnecessary work across unaffected areas.
- Internal module boundaries require deliberate enforcement.
- Repository-wide visibility can encourage accidental coupling if architecture rules are weak.

## Constraints

Adopting a monorepo does not remove architectural boundaries.

The repository SHOULD maintain:

- explicit dependency direction;
- clear ownership of applications and packages;
- bounded data access;
- focused contracts;
- reproducible repository-wide verification.

If a component later develops substantially independent ownership, security, deployment, or lifecycle requirements, moving it to a separate repository may be reconsidered through a new ADR.
