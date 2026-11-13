[English](README.md) | 简体中文

# Homebrew Tools

[Inverso](https://github.com/kqw8/inverso) 和 [Dusk](https://github.com/kqw8/Dusk) 的 Homebrew 配方。

| 工具 | 版本 | 要求 | 软件包 |
| --- | --- | --- | --- |
| Inverso | 0.4.0 | Apple Silicon（arm64）、macOS 13+ | 保留原始签名的预编译程序；无需 Swift 工具链 |
| Dusk | 0.3.0 | macOS 13+、包含 Swift 5.9+ 的 Apple Command Line Tools | 从固定提交 `f91c413864fb417b2fdf4fb8ad41ced52be3d2c1` 构建 |

两项下载均使用 SHA-256 校验。Inverso 原始压缩包保存在 `Binaries/`；其中的 `BUILD-INFO.json` 记录源码提交和可执行文件哈希。

## 安装与管理

```sh
brew tap kqw8/tools
brew install kqw8/tools/inverso
```

如果 Homebrew 要求信任第三方配方，请先审阅，再执行 `brew trust --formula kqw8/tools/inverso`（或 `kqw8/tools/dusk`）并重试。

仅安装不会启动服务。立即启动并启用登录启动：

```sh
brew services start kqw8/tools/inverso
```

统一使用 Homebrew 升级和管理服务：

```sh
brew services stop kqw8/tools/inverso
brew upgrade kqw8/tools/inverso
brew services start kqw8/tools/inverso
```

Dusk 使用相同命令，将 `kqw8/tools/inverso` 替换为 `kqw8/tools/dusk`。以当前登录用户运行服务，不要使用 `sudo`。
不要混用 Homebrew 服务与原生 `inverso install/start/stop/uninstall` 或 `dusk install/start/login/stop/uninstall` 命令。Dusk 原生服务使用不同的标签。可使用 `inverso status` 检查健康状态；可执行文件签名改变后，可能需要用户在系统设置中重新授权。

## 完整卸载

先停止所选服务：

```sh
brew services stop kqw8/tools/inverso
pgrep -fl -x inverso
```

等待 `pgrep` 找不到匹配进程（退出状态为 1），并用 `brew services list` 确认服务已停止。如果进程仍存在或再次启动，请先查明由谁管理该服务。不要删除正在运行的程序或其锁文件。确认进程退出后再执行：

```sh
brew uninstall kqw8/tools/inverso
```

Dusk 先执行 `brew services stop kqw8/tools/dusk`，通过 `pgrep -fl -x dusk` 和 `brew services list` 检查，确认所有 Dusk 进程退出后再执行 `brew uninstall kqw8/tools/dusk`。Dusk 正常退出会恢复内置显示屏。

Homebrew 会移除已安装的软件包，但不会自动删除用户数据和日志。停止服务后，可检查以下准确路径并按需手动清理：

| 工具 | 可能残留 |
| --- | --- |
| Inverso | `~/Library/Application Support/Inverso/daemon.lock` |
| Inverso 日志 | `~/Library/Logs/inverso.out.log`、`~/Library/Logs/inverso.err.log` |
| Inverso 服务 | `~/Library/LaunchAgents/com.kqw8.inverso.plist` |
| Dusk 状态 | `~/Library/Application Support/dusk/state.json` |
| Dusk Homebrew 日志 | `$(brew --prefix)/var/log/dusk.log`、`$(brew --prefix)/var/log/dusk.err.log` |
| Dusk Homebrew 服务 | `~/Library/LaunchAgents/homebrew.mxcl.dusk.plist` |
| Dusk 旧版原生服务及日志（如曾使用） | `~/Library/LaunchAgents/com.kqw8.dusk.plist`、`~/Library/Logs/dusk.out.log`、`~/Library/Logs/dusk.err.log` |

`$(brew --prefix)` 表示 Homebrew 安装前缀。`brew services stop` 通常会删除服务 plist；如有残留，应先检查，不要删除仍加载的服务文件。保留需要的用户数据。绝不能删除正在使用的 `daemon.lock`，否则可能允许多个后台实例同时运行。只有全部 Inverso 进程退出且服务不会重启后，才能删除它。

卸载不会撤销 macOS TCC 权限。用户需在**系统设置 > 隐私与安全性**对应权限分类中，手动移除残留的 Inverso 或 Dusk 授权条目。本文不提供重置权限或自动删除用户数据的命令。

## 打包检查

提交前检查配方的 Ruby 语法和 Homebrew 风格，并核验 Inverso 压缩包哈希，不修改压缩包。打包检查不得启动服务、改变显示状态或请求权限。
