# Project overview

This is a Rails blog  application with posts as its root page and additional article, comment, user, group, like, and attachment resources. The overview captures the repository's current shape for fast orientation; verify behavior in code and tests before making decisions.

## Purpose and stack

This is a server-rendered blog application built with Ruby on Rails 8.1 and Ruby 4.0.7. It uses SQLite, Devise authentication, Pundit authorization, Action Text, Active Storage, and Rails Solid adapters for jobs, cache, and Action Cable.
<!-- The production container is defined by `Dockerfile`; deployment configuration is in `.kamal/` and `config/deploy.yml`. -->

## Architecture map

| Area | Location | Notes |
| --- | --- | --- |
| Domain models | `app/models/` | Active Record models, associations, and validations |
| HTTP endpoints | `config/routes.rb`, `app/controllers/` | Rails routes and request handling |
| Authorization | `app/policies/` | Pundit policies; check these for access changes |
| Views and UI | `app/views/`, `app/javascript/`, `app/assets/` | Server-rendered pages and front-end assets |
| Persistence | `db/migrate/`, `db/schema.rb` | Migration history and current schema |
| Tests | `test/` | Minitest models, controllers, integration, and system tests |
| Operations | `Dockerfile`, `.kamal/`, `config/` | Container, deployment, and runtime configuration |
| Data relationships | `docs/entity_relationship_diagram.md` | Maintained Mermaid ER diagram |

## Application entry points

- The root route renders the posts index (`PostsController#index`).
- Post routes include a management page and a member action to toggle publication; comments can be created or deleted under a post.
- Articles, article comments, users, groups, group memberships, likes, and attachments have resource routes.
- Devise supplies user routes and the Rails health endpoint is available at `/up`.

Routes describe available endpoints; inspect controllers, policies, and tests to confirm actual access rules and behavior.

## Domain model

- `Post` belongs to a user, has a unique title and published state, and stores its description through Action Text.
- `Comment` belongs to a post and a user. A nullable parent comment supports threaded replies.
- `Article` and `ArticleComment` form a separate article/comment pair.
- `UserGroup` joins users to groups.
- `Like` is polymorphic over its likeable target. `Attachment` is polymorphic over its attachable target.
- Devise provides authentication. Pundit provides authorization; authentication alone does not grant access to a record.

Confirm these details in the current model associations, schema, and tests before relying on them. Update the ERD when a schema relationship changes.
