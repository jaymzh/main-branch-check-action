# main-branch-check action

[![Build](https://github.com/jaymzh/main-branch-check-action/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/jaymzh/main-branch-check-action/actions/workflows/build.yaml)

This check will determine the workflow it was called from, then
see if the workflow has run on master, and if it has, ensure
it is passing.

To bypass this (e.g. if your PR is the fix), you can add:

```text
[ci override_main_branch_checks $WORKFLOW]'
```

Or you to set all checks to non-fatal, you can do:

```text
[ci override_main_branch_checks]
```

to your PR description.

## Using

To use this, add a step into your workflow (or a separate job with this step)
like:

```yaml
- name: Main Branch Check
  # Do the check even if the PR failed elsewhere,
  # but don't do it if we're on main
  if: always() && github.ref != 'refs/heads/main'
  uses: jaymzh/main-branch-check-action@main
  with:
    gh_token: ${{ secrets.GITHUB_TOKEN }}
    workflow_ref: ${{ github.workflow_ref }}
```

If your branch name is different than "main" you will need to update
the ref in the `if` as well as pass it in using `with`:

```yaml
...
  with:
    ...
    main_branch: "some_branch_name"
```

In most cases the standard dyanmic per-PR token that GitHub generates
will work just fine.

## Updating

If you update the code, run:

```bash
make
```

to build the self-contained bundle.

If you update dependencies you'll need to run `npm install` first
