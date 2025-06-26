# Cole's Lab Computer OS

## Workflows

### build.yml

This workflow creates your custom OCI image and publishes it to the Github Container Registry (GHCR).

### build-disk.yml

This workflow creates a disk images from your OCI image by utilizing the [bootc-image-builder](https://osbuild.org/docs/bootc/).

Once the workflow is done, you'll find the disk images in the bucket configured after the workflow is completed.

# Community

- [**bootc discussion forums**](https://github.com/bootc-dev/bootc/discussions) - Nothing in this template is ublue specific, the upstream bootc project has a discussions forum where custom image builders can hang out and ask questions.

## Artifacthub

This template comes with the necessary tooling to index your image on [artifacthub.io](https://artifacthub.io), use the `artifacthub-repo.yml` file at the root to verify yourself as the publisher. This is important to you for a few reasons:

- The value of artifacthub is it's one place for people to index their custom images, and since we depend on each other to learn, it helps grow the community. 
- You get to see your pet project listed with the other cool projects in Cloud Native.
- Since the site puts your README front and center, it's a good way to learn how to write a good README, learn some marketing, finding your audience, etc. 

[Discussion thread](https://universal-blue.discourse.group/t/listing-your-custom-image-on-artifacthub/6446)


### Justfile Documentation

This `Justfile` contains various commands and configurations for building and managing container images and virtual machine images using Podman and other utilities.

#### Environment Variables

- `image_name`: The name of the image (default: "image-template").
- `default_tag`: The default tag for the image (default: "latest").
- `bib_image`: The Bootc Image Builder (BIB) image (default: "quay.io/centos-bootc/bootc-image-builder:latest").

#### Aliases

- `build-vm`: Alias for `build-qcow2`.
- `rebuild-vm`: Alias for `rebuild-qcow2`.
- `run-vm`: Alias for `run-vm-qcow2`.


#### Commands

###### `check`

Checks the syntax of all `.just` files and the `Justfile`.

###### `fix`

Fixes the syntax of all `.just` files and the `Justfile`.

###### `clean`

Cleans the repository by removing build artifacts.

##### Build Commands

###### `build`

Builds a container image using Podman.

```bash
just build $target_image $tag
```

Arguments:
- `$target_image`: The tag you want to apply to the image (default: `$image_name`).
- `$tag`: The tag for the image (default: `$default_tag`).

##### Building Virtual Machines and ISOs

###### `build-qcow2`

Builds a QCOW2 virtual machine image.

```bash
just build-qcow2 $target_image $tag
```

###### `build-raw`

Builds a RAW virtual machine image.

```bash
just build-raw $target_image $tag
```

###### `build-iso`

Builds an ISO virtual machine image.

```bash
just build-iso $target_image $tag
```

###### `rebuild-qcow2`

Rebuilds a QCOW2 virtual machine image.

```bash
just rebuild-qcow2 $target_image $tag
```

###### `rebuild-raw`

Rebuilds a RAW virtual machine image.

```bash
just rebuild-raw $target_image $tag
```

###### `rebuild-iso`

Rebuilds an ISO virtual machine image.

```bash
just rebuild-iso $target_image $tag
```

##### Run Virtual Machines

###### `run-vm-qcow2`

Runs a virtual machine from a QCOW2 image.

```bash
just run-vm-qcow2 $target_image $tag
```

###### `run-vm-raw`

Runs a virtual machine from a RAW image.

```bash
just run-vm-raw $target_image $tag
```

###### `run-vm-iso`

Runs a virtual machine from an ISO.

```bash
just run-vm-iso $target_image $tag
```

###### `spawn-vm`

Runs a virtual machine using systemd-vmspawn.

```bash
just spawn-vm rebuild="0" type="qcow2" ram="6G"
```

##### Lint and Format

###### `lint`

Runs shell check on all Bash scripts.

###### `format`

Runs shfmt on all Bash scripts.
