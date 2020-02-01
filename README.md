# Github Action for Instana Release markers

This action creates a new release on your Instana tenant

## Variables

Set the following variables as secrets for your repository

`INSTANA_BASE`: The base url of your tenant (e.g. `https://test-example.instana.io`)
`INSTANA_TOKEN`: The API token to create releases

## Inputs

### `releaseName`

**Required** The name of the release to create

## Outputs

### `id`

The id of the created release

## Example usage

```yaml
uses: taimos/github-action-instana-release@v1
with:
  releaseName: 'Deployed version 42'
env:
  INSTANA_BASE: ${{ secrets.INSTANA_BASE }}
  INSTANA_TOKEN: ${{ secrets.INSTANA_TOKEN }}
```
