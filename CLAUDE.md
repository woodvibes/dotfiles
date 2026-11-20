# CLAUDE.md

## Commit messages

Format the commit subject as:

```
TICKET-ID: [config-type] description
```

- `TICKET-ID` is the Jira ticket key the work belongs to (e.g. `MISC-1`).
- `[config-type]` is the top-level config directory the change touches: `nvim`, `zsh`, or `ghostty`. Only include it when the change is specific to a config; omit it otherwise (e.g. README or repo-wide changes).
- `description` is a short, lowercase, imperative summary of the change.

Examples:

```
MISC-1: [nvim] stop formatting Go files twice on save
MISC-2: update README with install steps
```

## Changelog

Update the changelog any time a PR is opened.

- Each config keeps its own `CHANGELOG.md` in its directory (e.g. `nvim/CHANGELOG.md`). Update the changelog for every config the PR touches; create one if it doesn't exist yet.
- Add entries under a `## YYYY-MM-DD` heading for the date the PR is opened, newest date first. Reuse the heading if it already exists.
- Group entries under `### Added`, `### Changed`, `### Fixed`, or `### Removed` as appropriate.
