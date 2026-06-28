# GitHub Pages Deployment

A GitHub Actions workflow that automatically deploys a static site to GitHub Pages on every push to `main`.

## How It Works

The workflow file at `.github/workflows/static.yml` is triggered on push to `main` (and can also be run manually via the Actions tab). It runs three steps:

1. Checks out the repository.
2. Uploads the repository contents as a Pages artifact.
3. Deploys the artifact to GitHub Pages.

The site is then live at `https://<username>.github.io/<repo-name>/`.

## Enabling GitHub Pages

Before the workflow can deploy, Pages must be configured to use GitHub Actions as the source:

1. Go to **Settings > Pages** in the repository.
2. Under **Build and deployment**, set the source to **GitHub Actions**.

## Workflow Configuration

```yaml
on:
  push:
    branches: ["main"]
  workflow_dispatch:
```

- `push` to `main` triggers an automatic deployment.
- `workflow_dispatch` allows manual runs from the Actions tab without a code push.

The `concurrency` block prevents overlapping deployments: if a deployment is in progress and a new one is queued, the queued one will wait rather than cancelling the in-progress run.

## Permissions

The workflow requires these GitHub token permissions to deploy to Pages:

| Permission | Reason |
|------------|--------|
| `contents: read` | Check out repository files |
| `pages: write` | Upload and publish the Pages artifact |
| `id-token: write` | OIDC authentication for the deploy step |

## Files

```
04-github-pages-deployment/
  index.html                            Static site entry point
  .github/
    workflows/
      static.yml                        Deployment workflow
  README.md
```

## Reference

[roadmap.sh — GitHub Actions Deployment Workflow](https://roadmap.sh/projects/github-actions-deployment-workflow)
