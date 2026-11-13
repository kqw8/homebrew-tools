English | [简体中文](README.zh-CN.md)

# Homebrew Tools

Homebrew formulae for [Inverso](https://github.com/kqw8/inverso) and
[Dusk](https://github.com/kqw8/Dusk).

| Tool | Version | Requirements | Package |
| --- | --- | --- | --- |
| Inverso | 0.4.0 | Apple Silicon (arm64), macOS 13+ | Prebuilt executable with its original signature; no Swift toolchain needed |
| Dusk | 0.3.0 | macOS 13+, Apple Command Line Tools with Swift 5.9+ | Source build pinned to `f91c413864fb417b2fdf4fb8ad41ced52be3d2c1` |

Both downloads are SHA-256 verified. The original Inverso archive is retained in
`Binaries/`; its `BUILD-INFO.json` records the source commit and executable hash.

## Install and manage

```sh
brew tap kqw8/tools
brew install kqw8/tools/inverso
```

If Homebrew asks you to trust a third-party formula, review it first, then run
`brew trust --formula kqw8/tools/inverso` (or `kqw8/tools/dusk`) and retry.

Installation alone does not start a service. To start it now and at login:

```sh
brew services start kqw8/tools/inverso
```

Use Homebrew consistently for updates and service management:

```sh
brew services stop kqw8/tools/inverso
brew upgrade kqw8/tools/inverso
brew services start kqw8/tools/inverso
```

For Dusk, replace `kqw8/tools/inverso` with `kqw8/tools/dusk` in these commands.
Run services as your login user, without `sudo`.
Do not mix Homebrew services with native `inverso install/start/stop/uninstall`
or `dusk install/start/login/stop/uninstall` commands. Dusk's native service uses
a different label. `inverso status` is available for health checks; a changed
executable signature may require the user to grant access again in System Settings.

## Uninstall completely

Stop the selected service first:

```sh
brew services stop kqw8/tools/inverso
pgrep -fl -x inverso
```

Wait until `pgrep` reports no matching processes (exit status 1), and confirm the
service is stopped with `brew services list`. If a process remains or restarts,
resolve its service ownership before proceeding. Do not delete a running binary
or its lock file. Only after confirming process exit:

```sh
brew uninstall kqw8/tools/inverso
```

For Dusk, use `brew services stop kqw8/tools/dusk`, check `pgrep -fl -x dusk`
and `brew services list`, then run `brew uninstall kqw8/tools/dusk` only after
all Dusk processes have exited. A normal Dusk shutdown restores the built-in display.

Homebrew removes the installed package; user data and logs are not automatically
deleted. Review these exact paths for optional manual cleanup after shutdown:

| Tool | Possible leftovers |
| --- | --- |
| Inverso | `~/Library/Application Support/Inverso/daemon.lock` |
| Inverso logs | `~/Library/Logs/inverso.out.log`, `~/Library/Logs/inverso.err.log` |
| Inverso service | `~/Library/LaunchAgents/com.kqw8.inverso.plist` |
| Dusk state | `~/Library/Application Support/dusk/state.json` |
| Dusk Homebrew logs | `$(brew --prefix)/var/log/dusk.log`, `$(brew --prefix)/var/log/dusk.err.log` |
| Dusk Homebrew service | `~/Library/LaunchAgents/homebrew.mxcl.dusk.plist` |
| Dusk legacy native service/logs, if previously used | `~/Library/LaunchAgents/com.kqw8.dusk.plist`, `~/Library/Logs/dusk.out.log`, `~/Library/Logs/dusk.err.log` |

`$(brew --prefix)` denotes your Homebrew prefix. Service plists should normally
be removed by `brew services stop`; inspect any that remain rather than deleting
a loaded service's files. Preserve any user data you want to keep. Never delete
an active `daemon.lock`: removing it can allow multiple daemons to run. Remove it
only after every Inverso process has exited and its service cannot restart.

Uninstalling does not revoke macOS TCC permissions. The user must remove any
remaining Inverso or Dusk authorization entries in **System Settings > Privacy &
Security**, in the relevant permission categories. No permission-reset or
automatic user-data deletion commands are provided.

## Packaging checks

Check formula Ruby syntax and Homebrew style before committing. Verify the
Inverso archive hash without modifying the archive. Packaging checks must not
start services, change display state, or request permissions.
