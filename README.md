# metalinter

[![Build Status](https://drone.weastur.com/api/badges/weastur/metalinter/status.svg)](https://drone.weastur.com/weastur/metalinter)
[![Docker Pulls](https://img.shields.io/docker/pulls/weastur/metalinter)](https://hub.docker.com/r/weastur/metalinter/)
![GitHub](https://img.shields.io/github/license/weastur/metalinter)

Docker image with useful linters:

- [yamllint](https://github.com/adrienverge/yamllint)
- [hadolint](https://github.com/hadolint/hadolint)
- [checkmake](https://github.com/mrtazz/checkmake)
- [dotenv-linter](https://github.com/dotenv-linter/dotenv-linter)
- [shellcheck](https://github.com/koalaman/shellcheck)
- [markdownlint](https://github.com/igorshubovych/markdownlint-cli)
- [jsonlint](https://github.com/zaach/jsonlint)
- [sqlfluff](https://github.com/sqlfluff/sqlfluff)

The main motivation is the need to lint some non-code files, like `.env`,
`Dokerfile`, `*.yml` etc. Such kind of linting is definitely non-first-priority
tasks, so I created this image to do it with almost zero effort.
The image is designed to run on CI/CD.

## Usage

Exaple for Drone CI:

```yaml
  - name: lint
    image: weastur/metalinter
    commands:
      - hadolint Dockerfile
```

As soon as the image contain a bunch of tools, There are
two types of tags: `latest` and date-of-build, like `20220705`.

### Usage with `docker run`

The image can be run with `docker run` command. Notice that there is no
`COMMAND` inside. So you need provide your own. For example:

```shell
docker run --rm -i weastur/metalinter:latest hadolint - < tests/Dockerfile
```

## Internals

The image is based on the latest Ubuntu. Some things are installed
directly from an APT repo, some things are built from source with
multi-stage build.

There is no guarantee of using the latest version of every tool.
Also, there was no goal to make the slimmest ever image, so ubuntu has been
used as a base. The compressed image size is around 100MB which is quite well.

Every single step of build process runs with Drone CI/CD.

## Contributing

You need an amd64 Linux host with Docker installed.
macOS and Windows + WSL would likely work,
but I haven't tested it.
You can start from `.drone.yml` to inspect the build process.
The main files are `Dockerfile` and `test.sh`.

Also, you can use [pre-commit](https://pre-commit.com) to run some checks
locally before commit.

```bash
pre-commit install
```
