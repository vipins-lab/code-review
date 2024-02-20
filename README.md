# GitHub Action to Assign reviewer automatically to pull requests.
Workflows GitHub action for assigning reviewers, requesting reviews automatically on pull request.
[![Lint Code Base](https://github.com/vipins-lab/code-review/actions/workflows/super-linter.yml/badge.svg?branch=main)](https://github.com/vipins-lab/code-review/actions/workflows/super-linter.yml)


## Inputs

| Parameter                   | Type    | Required                             | Default                     | Description                                                                                                                                                                                                                                                                                |
| --------------------------- | ------- | ------------------------------------ | -------                     | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `reviewers`                 | String  | Yes                                  | n/a                         | Comma separated list of usernames. Pull Request Review will be requested to those users.                                                                                                                                                                                                   |
| `repository`                | String  | No                                   | `${{ github.repository }}`  | Repository Name as `<orgname>/<repository_name>`, default is evalulated from GitHub context `github.repository`                                                                                                                                                                            |

## Examples

### Auto Assignment of reviewers to Pull Request

This example auto-assigns reviewers to pull requests.

```yml
name: Auto Assingment of reviewers

on:
  workflow_dispatch:
  pull_request:
  
jobs:
  auto-assignment:
    runs-on: ubuntu-latest
    steps:
      - uses: vipins-lab/code-review@main
        id: codereview
        env:
          GITHUB_TOKEN: ${{ secrets.GH_TOKEN }}
        with:
          reviewers: 'foo,user2'

      # Use the output message the `codereview` step
      - name: Get the output message
        run: echo "Output = ${{ steps.codereview.outputs.message }}"

```
