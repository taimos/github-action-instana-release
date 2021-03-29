# How to release

Go to the Git Actions panel, and run a `Release new version` manual workflow, specifying the name of the new version (which will be used, among other things, for the tab and the suffix of the user-agent).
The [Release workflow](.github/workflows/create-release.yml) will:

1. Insert the version in the [Dockerfile](./Dockerfile) and [README.md](./README.md) files, create a new commit and tag it
2. Build the Docker file and push it to DockerHub
3. Create a new GitHub Release based on the tag created previously

It's really that simple :-)
