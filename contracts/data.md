# Data Contract

## Purpose

This document defines stable rules for persistent data, schema evolution, and data-access boundaries.

It does not duplicate the complete database schema.

## Requirement Language

The keywords **MUST**, **MUST NOT**, **SHOULD**, and **SHOULD NOT** express the strength of a rule.

## Sources of Truth

Persistent schema definitions and versioned migrations are authoritative for the physical database structure.

Application documentation MUST NOT silently override the schema or migration history.

If generated database code is used, its generator inputs remain authoritative.

## Schema Evolution

### Use versioned migrations

Persistent schema changes MUST be represented by versioned migrations.

Production schema changes MUST NOT depend on implicit runtime schema mutation.

### Do not rewrite released history

A migration that has already been released or applied outside local disposable environments MUST NOT be edited in place.

Corrections MUST be introduced through a new migration.

### Preserve existing data

Schema changes SHOULD preserve valid existing data by default.

Destructive operations require explicit intent and SHOULD document:

- what data may be lost;
- why the loss is acceptable;
- whether backup or migration steps are required;
- rollout considerations.

### Prefer reversible rollout design

Even when down migrations are not supported, schema changes SHOULD be designed so application rollout and rollback remain operationally safe when practical.

Examples include:

- add before remove;
- backfill before enforcing stricter constraints;
- deploy readers before writers when formats change.

## Data Semantics

### Identifiers

Persistent identifiers MUST have stable meaning once exposed or stored.

Identifier reuse SHOULD be avoided unless reuse is an explicit part of the domain model.

### Null and empty values

`NULL`, empty strings, zero values, missing fields, and empty collections MUST NOT be treated as interchangeable unless their equivalence is explicitly defined.

### Time

Projects SHOULD use an explicit time policy.

Unless the project defines otherwise:

- persistent timestamps SHOULD be stored in UTC;
- timezone conversion SHOULD occur at system boundaries;
- timestamp precision SHOULD remain consistent across reads and writes.

### Defaults

Database defaults and application defaults SHOULD NOT contradict each other.

Changing a default that affects persisted meaning MAY be a compatibility-sensitive change.

### Constraints

Important data invariants SHOULD be enforced as close to the data source as practical.

Examples include:

- uniqueness;
- foreign keys;
- non-null constraints;
- valid ranges;
- transactional invariants.

Application validation MAY supplement database constraints but SHOULD NOT silently replace critical persistence guarantees.

## Data-Access Boundaries

Database access SHOULD remain behind explicit data-access boundaries.

Transport or presentation code SHOULD NOT directly perform persistence operations when a repository, query, or service boundary exists.

Business rules SHOULD NOT depend on generated database implementation details.

## Transactions

Transactions SHOULD follow business invariants rather than arbitrary statement boundaries.

Operations that must succeed or fail together SHOULD execute within the same transaction when supported by the storage system.

Transaction ownership SHOULD remain explicit.

## Generated Data Access

When database access code is generated:

- generated files MUST NOT be manually edited;
- schema or query sources MUST be changed instead;
- generation SHOULD be reproducible;
- CI SHOULD detect stale generated output when practical.

## Data Migration Safety

Before completing a persistent data change, verify:

1. Is a new migration required?
2. Has any released migration been modified?
3. Can existing production data still be read?
4. Is a backfill required?
5. Does deployment order matter?
6. Can application rollback still operate safely?
7. Are constraints and defaults consistent?
8. Does the change affect compatibility expectations?

## Non-Goals

This document SHOULD NOT contain:

- the full database schema;
- every table or column;
- complete SQL queries;
- environment-specific credentials;
- operational backup procedures.

Those belong in their authoritative schema, query, configuration, or operations artifacts.
