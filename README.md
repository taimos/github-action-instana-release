# Github Action for Instana Release markers

This action creates a new release on your Instana tenant

## Variables

Set the following variables as secrets for your repository

### `INSTANA_BASE`

The base url of your tenant (e.g. `https://test-example.instana.io`)

### `INSTANA_TOKEN`

The API token to create releases at Instana

## Inputs

### `releaseName`

**Required** The name of the release to create

### `releaseScope`

**Note:** Release scoping is supported in Instana v190 and above; using release scoping with older versions of Instana will not lead to issues, but the scoping specification will be ignored.

**Optional** scoping information for the release in terms of Application Perspectives and Services.
  The file should contain valid JSON object that satisfies `jq type == 'object'`, and it can have as fields `applications` and `services`, which respectively have the same structure as in the [API documentation for creating releases](https://instana.github.io/openapi/#operation/postRelease), e.g.:

  ```json
  {
    "applications": [
      { "name": "My Awesome App" },
      { "name": "My Even More Awesome App" },
    ],
    "services": [
      { "name": "Cool service #1" },
      {
        "name": "Cool service #2",
        "scopedTo": {
          "applications": [
            { "name": "My Cool App" }
          ]
        }
      }
    ]
  }
  ```

  The JSON snippet above will scope the new release to apply to the entirety of the Application Perspectives `My Awesome App` and `My Even More Awesome App`, to the entirely of the `Cool service #1` service, and to the `Cool service #2` service, but only to what part of `Cool service #2` is included in the `My Cool App` Application Perspective.
  For more information on Application Perspectives, Services and the scoping, refer to the [Application Monitoring](https://www.instana.com/docs/application_monitoring) documentation.

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
