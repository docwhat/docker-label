# Docker Labeller

Generates [oci image spec annotations](https://github.com/opencontainers/image-spec/blob/master/annotations.md).

## Usage

```sh
label.bash docker build -t imgname .
```

## Plans

I'm hoping that a generic-ish config file can be created and used for adding all labels.

It'll have different formats for different use cases.

```sh
# example usage
$ label.bash init
$ vim label.bash.yaml
```
