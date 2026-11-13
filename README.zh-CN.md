[English](README.md) | 简体中文

# Homebrew Tools

[Inverso](https://github.com/kqw8/inverso) 和 [Dusk](https://github.com/kqw8/Dusk) 的 Homebrew 配方。

| 工具 | 平台 / 软件包 |
| --- | --- |
| Inverso | Apple Silicon、macOS 13+；保留原始签名的预编译程序 |
| Dusk | macOS 13+；源码构建需要包含 Swift 5.9+ 的 Apple Command Line Tools |

## 安装与管理

```sh
brew tap kqw8/tools
brew install kqw8/tools/inverso
brew services start kqw8/tools/inverso
brew services stop kqw8/tools/inverso
brew upgrade kqw8/tools/inverso
brew services start kqw8/tools/inverso
```

Dusk 将 `kqw8/tools/inverso` 替换为 `kqw8/tools/dusk`，进程名 `inverso` 替换为 `dusk`。
仅安装不会启动服务；`services start` 会立即启动并启用登录启动。不要使用 `sudo`。
不要混用 Homebrew 服务与原生服务管理命令。签名改变后，可能需要重新授予 macOS 权限。

## 卸载

```sh
brew services stop kqw8/tools/inverso
pgrep -fl -x inverso
brew services list
```

仅在全部匹配进程退出（`pgrep` 状态为 1）且服务已停止后执行：

```sh
brew uninstall kqw8/tools/inverso
```

用户数据、日志及 TCC 权限仍会保留；绝不能删除正在使用的锁文件。
信任提示及打包细节见[完整指南](docs/guide.zh-CN.md)，安全移除及权限清理见[完整清理说明](docs/guide.zh-CN.md#完整卸载)。
