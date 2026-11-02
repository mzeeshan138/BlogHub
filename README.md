# BlogHub

BlogHub is a Ruby on Rails application for publishing and discussing posts and articles. It includes user accounts, threaded post comments, article comments, groups and memberships, likes, file attachments, and an admin dashboard. Post descriptions use Action Text, while Active Storage handles uploaded files and user avatars.

## Technology

- Ruby 4.0.7 and Rails 8.1
- SQLite
- Devise authentication and Pundit authorization
- Bootstrap 5.3.3 via jsDelivr, with Propshaft for application assets
- Action Text and Active Storage
- Rails Solid adapters for background jobs, caching, and Action Cable
- Minitest, RuboCop, Brakeman, and Bundler Audit

## Getting started

Install Ruby 4.0.7 and Bundler, then from the repository root run:

```sh
bundle install
bin/rails db:prepare
bin/rails server
```

Open <http://localhost:3000>. Uploaded image processing uses `libvips`; install it if your platform requires the native package separately.

After signing in, users can manage their profile, create and discuss posts, and interact with published content. Administrators can use the protected `/admin/dashboard` area to manage users and posts, change publication status, and update their own password. The application also exposes a health check at `/up` and renders a branded page for unmatched routes.

## Development

```sh
bin/rails test                 # Unit, controller, and integration tests
bin/rails test:system          # Browser-based system tests
bin/rubocop                    # Ruby style checks
bin/brakeman --no-pager        # Rails security scan
bin/bundler-audit              # Ruby dependency vulnerability scan
bin/importmap audit            # JavaScript dependency audit
```

The CI workflows run these checks on pull requests and pushes to `main`. System tests may require a working browser/WebDriver installation.

## Project documentation

- [Entity relationship diagram](docs/entity_relationship_diagram.md)
- [AI agent instructions](AGENTS.md)
- [Codex project overview and workflow](.codex/README.md)

## Deployment

The production container is defined in `Dockerfile`; deployment settings are in `config/deploy.yml` and `.kamal/`. Production requires the Rails credentials key to be provided securely as `RAILS_MASTER_KEY`. Never commit that key or other secrets.

## License

BlogHub is available under the [MIT License](LICENSE.md).
