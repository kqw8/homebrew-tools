English | [简体中文](README.zh-CN.md)

# Homebrew Tools

Homebrew formulae for [Inverso](https://github.com/kqw8/inverso) and [Dusk](https://github.com/kqw8/Dusk).

| Tool | Platform / package |
| --- | --- |
| Inverso | Apple Silicon, macOS 13+; prebuilt with original signature |
| Dusk | macOS 13+; source build requires Apple Command Line Tools with Swift 5.9+ |

## Install and manage

```sh
brew tap kqw8/tools
brew install kqw8/tools/inverso
brew services start kqw8/tools/inverso
brew services stop kqw8/tools/inverso
brew upgrade kqw8/tools/inverso
brew services start kqw8/tools/inverso
```

For Dusk, replace `kqw8/tools/inverso` with `kqw8/tools/dusk` and process name `inverso` with `dusk`.
Installation does not start a service; `services start` starts it now and at login. Run without `sudo`.
Do not mix Homebrew services with native service-management commands. Signature changes may require renewed macOS permissions.

## Uninstall

```sh
brew services stop kqw8/tools/inverso
pgrep -fl -x inverso
brew services list
```

Only after all matching processes exit (`pgrep` status 1) and the service is stopped:

```sh
brew uninstall kqw8/tools/inverso
```

User data, logs and TCC permissions remain; never delete an active lock file.
See the [full guide](docs/guide.md) for trust prompts and packaging details, and [complete cleanup](docs/guide.md#uninstall-completely) for safe removal and permission cleanup.
