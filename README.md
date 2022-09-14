# GitHub Action: Lint Annotations

Create annotations from log output on your GitHub Actions workflows using
[problem matchers](https://github.com/actions/toolkit/blob/main/docs/problem-matchers.md)
for common linters (see [list](#available-problem-matchers) below).

## Inputs

| Variable           | Default     | Description |
| ------------------ | ----------- | ----------- |
| `problem_matchers` | `"all"`     | Space-separated list of problem matchers to select (without .json file extension) |
| `enable`           | `"true"`    | Whether to add or remove problem matchers |

### Available problem matchers

* actionlint
* ansible-lint (requires `--parseable` flag or `parseable: true` in config)
* black
* eslint
* isort
* markdownlint
* mypy
* pycodestyle-error
* pycodestyle-warning
* pydocstyle
* pylint-error
* pylint-warning
* shellcheck (requires shellcheck >= 0.8.0)
* vulture
* yamllint (requires `--format parsable`)

## Sample usage

```yaml
---
name: Lint checks

on:
  push:
    branches-ignore:
      - main
  pull_request:
    branches:
      - main

jobs:
  lint:
    name: Lint
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: Enable annotations
        uses: wanduow/action-lint-annotations@v1
      - name: Lint code base
        uses: github/super-linter/slim@v4
        env:
          VALIDATE_ALL_CODEBASE: false
          DEFAULT_BRANCH: main
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

If you want to select specific problem matchers:

```yaml
      - name: Enable annotations
        uses: wanduow/action-lint-annotations@v1
        with:
          problem_matchers: >-
            pylint-error
            pylint-warning
```

If you want to disable problem matchers

```yaml
      - name: Disable annotations
        uses: wanduow/action-lint-annotations@v1
        with:
          enable: "false"
```
