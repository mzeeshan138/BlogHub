# Repository instructions for coding agents

These instructions apply to the entire repository. Read the relevant reference in [`.codex/`](.codex/README.md) before making a change that touches architecture, data, security, or release workflows.

## Project at a glance

This repository contains a Ruby on Rails 8.1 application for practicing blog features. It uses Ruby 4.0.7, SQLite, Devise for authentication, Pundit for authorization, Action Text for post descriptions, Active Storage, and Rails' Solid adapters for background jobs, cache, and Action Cable. The production image is built with Docker and deployed with Kamal.

## Engineering rules

- Read the relevant model, controller, policy, view, migration, and tests before changing behavior. Follow existing Rails conventions and keep changes focused.
- Treat authorization as part of every user-facing change. Check the relevant Pundit policy and controller authorization, especially for records owned by a user.
- When changing data structure, add a migration; do not edit an already-applied migration or `db/schema.rb` by hand. Keep `docs/entity_relationship_diagram.md` consistent with the schema and associations when relationships change.
- Add or update tests for behavior changes. Prefer the existing Minitest layout under `test/`.
- Keep the version-controlled `.codex/` Markdown current as part of the same change whenever architecture, domain behavior, setup, commands, or conventions it describes change. Record lasting project knowledge there, not session notes or speculative plans.
- Never expose or commit secrets, credentials, local database files, generated assets, or user uploads. Do not run destructive database or git commands without an explicit request.
- Preserve unrelated user changes. Inspect `git status` before editing and before wrapping up.
- Avoid adding dependencies or changing deployment, authentication, authorization, or data-retention behavior unless the task requires it.

## Common commands

- `bin/rails server` — run the development server.
- `bin/rails test` — run the test suite.
- `bin/rails test test/models` — run model tests.
- `bin/rubocop` — run the configured Ruby style checks.
- `bin/rails db:migrate` — apply migrations to the configured database.
- `bin/rails routes` — inspect application routes.

Use the repository's `bin/` wrappers so the locked bundle is used. If a command is unavailable in the current environment, report that instead of assuming it passed.

## References

See [`.codex/README.md`](.codex/README.md) for the agent documentation index, [`.codex/project.md`](.codex/project.md) for the current project overview and architecture, and [`.codex/workflow.md`](.codex/workflow.md) for development, memory maintenance, and verification workflows. See [`docs/entity_relationship_diagram.md`](docs/entity_relationship_diagram.md) for the documented data relationships.
