# BlogHub

BlogHub is a Ruby on Rails application for publishing and discussing posts and articles. It includes user accounts, threaded post comments, article comments, groups and memberships, likes, and file attachments. Post descriptions use Action Text, with Active Storage for uploaded files.

## Technology

- Ruby 4.0.7 and Rails 8.1
- SQLite
- Devise authentication and Pundit authorization
- Rails Solid adapters for background jobs, caching, and Action Cable
- Minitest, RuboCop, Brakeman, and Bundler Audit

## Getting started

Install Ruby 4.0.7 and Bundler, then from the repository root run:

```sh
bundle install
rails db:prepare
rails server
```

Open <http://localhost:3000>. Uploaded image processing uses `libvips`; install it if your platform requires the native package separately.

## Development

```sh
rails test                 # Unit, controller, and integration tests
rails test:system          # Browser-based system tests
rubocop                    # Ruby style checks
brakeman --no-pager        # Rails security scan
bundler-audit              # Ruby dependency vulnerability scan
importmap audit            # JavaScript dependency audit
```

The CI workflows run these checks on pull requests and pushes to `main`. System tests may require a working browser/WebDriver installation.

## Project documentation

- [Entity relationship diagram](docs/entity_relationship_diagram.md)
- [AI agent instructions](AGENTS.md)
- [Codex project overview and workflow](.codex/README.md)

## Deployment

The production container is defined in `Dockerfile`; deployment settings are in `config/deploy.yml` and `.kamal/`. Production requires the Rails credentials key to be provided securely as `RAILS_MASTER_KEY`. Never commit that key or other secrets.
