# Github Action for Instana Release markers

This action creates a new release on your Instana tenant via the [Instana Pipeline Feedback](https://www.instana.com/docs/pipeline_feedback/) capability.

## Variables

Set the following variables as secrets for your repository:

* `INSTANA_BASE`: The base url of your tenant (e.g. `https://test-example.instana.io`)
* `INSTANA_TOKEN`: The API token to create releases at Instana, which _must_ have the `Configuration of releases` permission.
  Refer to the [Tokens](https://www.instana.com/docs/api/web/#tokens) documentation on the Instana website for more information on how to create API tokens.

## Inputs

* `releaseName` (**required**): The name of the release to create
* `releaseScope` (**optional**): scoping information for the release in terms of Application Perspectives and Services.
  The file should contain valid JSON object that satisfies `jq type == 'object'`, and it can have as fields `applications` and `services`, which respectively have the same structure as in the [API documentation for creating releases](https://instana.github.io/openapi/#operation/postRelease), e.g.:

  ```json
  {
    "applications": [
      { "name": "My Awesome App" },
      { "name": "My Even More Awesome App" }
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

  **Note:** Release scoping is supported in Instana v190 and above; using release scoping with older versions of Instana will not lead to issues, but the scoping specification will be ignored.

## Outputs

* `id`: The id of the newly-created release

## Example usage

### Without Release Scoping

```yaml
uses: taimos/github-action-instana-release@%%version%%
with:
  releaseName: 'Deployed version 42'
env:
  INSTANA_BASE: ${{ secrets.INSTANA_BASE }}
  INSTANA_TOKEN: ${{ secrets.INSTANA_TOKEN }}
```

### With Release Scoping

```yaml
uses: taimos/github-action-instana-release@%%version%%
with:
  releaseName: 'Deployed version 42'
  releaseScope: >
    {
      "services": [
        {
          "name": "spring-webflux",
          "scopedTo": {
            "applications": [{ "name": "All Services" }]
          }
        },
        { "name": "spring-boot" }
      ]
    }
env:
  INSTANA_BASE: ${{ secrets.INSTANA_BASE }}
  INSTANA_TOKEN: ${{ secrets.INSTANA_TOKEN }}
```

Notice that, to nest a JSON datastructure in YAML without dealing with conversion issues, we are actually using a YAML multiline string by adding `>` at the beginning of the value for `releaseScope`.
When using YAML multiline string, each line of the string must be indented at least one level deeper than the key.
The [YAML Multiline](https://yaml-multiline.info/) is excellent to understand the nuances of multiline in YAML.

## Testing
To test a new version of this GitHub Action, copy the `test/test-action.yml` to `.github/workflows`. The test can be executed
locally with [act](https://github.com/nektos/act).
```
act -s INSTANA_BASE=<<INSTANA_BASE>> -s INSTANA_TOKEN="<<INSTANA_TOKEN>>" [--env version=<<VERSION>>]
```
The `version` is optional and will be used to identify the user-agent. If not set `dev` will used as version.
