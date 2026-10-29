# Development workflow

## Before editing

1. Inspect `git status` and preserve all existing user changes.
2. Trace the current behavior through routes, controller, policy, model, view, and tests as applicable.
3. Check schema constraints and existing conventions before planning a data or API change.

## While editing

- Keep changes small and consistent with Rails conventions already in use.
- Include authorization checks for user-facing actions and ownership boundaries.
- Add a new migration for schema changes. Do not rewrite applied migrations or hand-edit `db/schema.rb`.
- Add or update focused Minitest coverage for changed behavior.
- Update documentation in the same change as the implementation. Keep `.codex/project.md` aligned with lasting changes to features, architecture, routes, dependencies, or key code paths; update `.codex/workflow.md` when contributor or agent practices and commands change; update the ERD when relationships change.
- Treat `.codex/` as durable project memory: record confirmed facts and useful conventions, not temporary task notes, personal session history, or speculative future work. Prefer updating the existing relevant section over adding duplicate documents.
- Do not add a dependency without a clear need. Never add secrets, personal data, local database files, or generated user content.

## Verification commands

Use the repository's `bin/` wrappers and run the checks relevant to the change:

| Check | Command |
| --- | --- |
| Full test suite | `bin/rails db:test:prepare test` |
| System tests | `bin/rails db:test:prepare test:system` |
| Ruby lint | `bin/rubocop` |
| Rails security scan | `bin/brakeman --no-pager` |
| JavaScript dependency audit | `bin/importmap audit` |
| Ruby dependency audit | `bin/bundler-audit` |

These match the checks configured in `.github/workflows/ci.yml`. Report which commands were run and whether they passed. If the environment prevents a check, say so plainly; do not imply it passed.

## Change review

Before finishing, review the diff for unintended edits, leaked secrets, missing tests, and documentation drift. Check that any project fact changed in code is reflected in the relevant Markdown and that the Markdown still matches code, schema, and CI. Do not commit, push, deploy, or run destructive commands unless explicitly requested.
