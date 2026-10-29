# Codex project guide

This directory is the repository's durable, version-controlled project memory for AI coding agents. It gives a newcomer a quick overview and records conventions that should survive between coding sessions. Keep it concise, specific to this repository, and consistent with the application code and CI configuration.

## Documents

- [`project.md`](project.md) - current application overview, architecture, domain model, and important code paths.
- [`workflow.md`](workflow.md) - change process, memory maintenance, local commands, and CI checks.

## Source of truth

The code, migrations, `db/schema.rb`, tests, and GitHub Actions workflows are authoritative. These notes are an overview, never a substitute for inspecting the implementation. Update the relevant Markdown in the same change when the implementation changes a documented fact or convention. Root [`AGENTS.md`](../AGENTS.md) contains instructions that apply to every coding task.
