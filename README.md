# Agent Engineering Template

A practical reference repository for AI Agent-friendly software engineering.

This project demonstrates how to structure a repository so that humans and coding agents can collaborate with clear context, explicit constraints, reproducible verification, and durable engineering decisions.

It is not tied to any specific AI model, coding agent, framework, or programming language.

## Why

Coding agents work best when a repository makes its engineering intent explicit.

A good Agent-friendly repository should make it easy to answer:

- What is this system?
- Where should I make a change?
- What must not be broken?
- Which source is authoritative?
- How do I verify my work?
- Why was an important architectural decision made?

This template provides a minimal structure for answering those questions without turning the repository into a large collection of Agent-specific documentation.

## Principles

### Keep context small and high-signal

Agents should not need to read the entire repository before making a safe change.

Documentation should route them toward the relevant source, contract, or decision.

### Prefer executable constraints over written instructions

If a rule can be enforced by tests, linters, schemas, dependency checks, or CI, prefer enforcement over prose.

### Prefer source code over duplicated documentation

Source code, schemas, migrations, generated specifications, and tests should remain the primary source of truth.

Documentation should explain intent and constraints rather than duplicate implementation details.

### Make boundaries explicit

Architecture and compatibility boundaries should be easy for both humans and agents to identify.

### Make verification reproducible

Local development and CI should use the same verification entry points whenever possible.

## Repository Structure

```text
.
├── AGENTS.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── Makefile
│
├── .agents/
│   ├── architecture.md
│   └── playbook.md
│
├── contracts/
│   ├── compatibility.md
│   ├── data.md
│   └── upstream.md
│
├── docs/
│   └── decisions/
│
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   └── pull_request_template.md
│
├── apps/
├── packages/
├── migrations/
└── tests/
```

### `AGENTS.md`

The primary entry point for coding agents.

It provides a concise repository map, points to relevant context, identifies sources of truth, and defines the minimum verification requirements.

### `.agents/`

High-signal context for agents and contributors.

- `architecture.md` explains the system structure and architectural invariants.
- `playbook.md` defines the expected workflow for making changes.

### `contracts/`

Stable engineering constraints.

- `compatibility.md` defines compatibility expectations.
- `data.md` defines persistent data and migration rules.
- `upstream.md` defines assumptions around external systems and dependencies.

### `docs/decisions/`

Architecture Decision Records (ADRs) explain significant engineering decisions and the reasoning behind them.

### `Makefile`

Provides a small, stable command surface for development and verification.

The preferred repository-wide verification command is:

```bash
make check
```

### `CHANGELOG.md`

Records notable released and unreleased changes.

It is not a replacement for Git history.

## Human-Agent Workflow

A typical change should follow this flow:

```text
Intent
  ↓
Issue / Task
  ↓
AGENTS.md
  ↓
Relevant architecture and contracts
  ↓
Implementation
  ↓
Tests and verification
  ↓
make check
  ↓
Pull Request
  ↓
Review
  ↓
CHANGELOG / ADR when applicable
```

The goal is not to make agents autonomous at any cost.

The goal is to make engineering intent, constraints, and verification sufficiently explicit that humans and agents can work within the same repository model.

## Using This Template

Use the structure as a starting point rather than a mandatory specification.

Remove documents that do not represent a real constraint in your project.

Add new Agent-facing documentation only when it has a clear and distinct responsibility.

A useful rule is:

> Prefer fewer high-signal documents and stronger executable verification.

## What This Project Is Not

This repository is not:

- an AI Agent framework;
- a prompt collection;
- a replacement for project documentation;
- a universal software architecture;
- a requirement to use a monorepo.

It is a reference model for designing repositories that are easier for coding agents and humans to understand, modify, and verify.

## License

See [LICENSE](LICENSE).
