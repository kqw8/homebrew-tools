# 自制工具的 Homebrew tap

当前包含 Dusk 0.3.0 和 Inverso 0.4.0。源码分别保留在 `~/Developer/dusk`、`~/Developer/inverso`。

Dusk 固定到上游提交 `f91c413864fb417b2fdf4fb8ad41ced52be3d2c1`，下载时校验 SHA-256；编译使用 Apple Command Line Tools 自带的 Swift 5.9 或更新版本。

Inverso 使用 `Binaries/` 内的 Apple Silicon 安装包，保留本机正常工作的 0.4.0 程序及其原有签名，安装时不引入 Swift 工具链或其他第三方运行依赖。安装包内的 BUILD-INFO.json 记录源码提交及程序 SHA-256。两个工具均要求 macOS 13 或更新版本；目前没有发布远端 tap。

## Inverso

注册本地 tap 后安装并管理后台：

```sh
brew tap kqw8/tools /Users/kw/Developer/homebrew-tools
brew install kqw8/tools/inverso
brew services start kqw8/tools/inverso
inverso status
```

保留原启动项名称 `com.kqw8.inverso`、Interactive 调度和原日志路径。更新、重启、卸载统一使用 Homebrew：

```sh
brew upgrade kqw8/tools/inverso
brew services restart kqw8/tools/inverso
brew services stop kqw8/tools/inverso
brew uninstall kqw8/tools/inverso
```

不要混用 Inverso 自带的 `install/start/stop/uninstall` 管理服务。新版本如果更换程序签名，可能需要重新允许设备控制权限；更新后用 `inverso status` 确认实际后台进程的 Scroll event tap 为 enabled。

## Dusk：当前仅保留源码和打包定义

本机停用 Dusk，不安装或启动它。以后确实需要时：

先把这个目录作为本地 tap 注册（Git 仓库须有提交）：

```sh
brew tap kqw8/tools /Users/kw/Developer/homebrew-tools
brew install kqw8/tools/dusk
```

只安装程序不会启动服务。需要登录时启动才运行：

```sh
brew services start kqw8/tools/dusk
```

该服务由 Homebrew 管理，不要再调用 Dusk 自带的 `install`、`start`、`login`、`stop` 或 `uninstall` 来管理它；那些命令使用另一套启动项名称。通过 Homebrew 停止服务时，Dusk 会处理退出信号并恢复内屏。

```sh
brew services stop kqw8/tools/dusk
brew uninstall kqw8/tools/dusk
```

本地 tap 是源仓库的克隆。修改打包定义并提交后，可运行 `brew update` 更新克隆。以后发布到 GitHub 时，再把 tap 的远端地址换成发布仓库；目前没有创建或发布远端仓库。

## 维护

更新时核对源码中的版本、上游提交和源码包 SHA-256，再运行 formula 语法检查与项目测试。不要给安装和测试步骤加服务启动、显示器操作或权限申请。

2026-10-22 已验证：源码包校验一致、Homebrew 能读取 formula、格式检查通过、源码 release 编译成功且版本输出为 `dusk 0.3.0`、46 个项目测试通过。验证只在临时目录中构建；没有运行 `brew install` 或启动服务。

2026-10-22 Inverso 已完成本机迁移：通过 Homebrew 实际安装和 `brew test`，程序 SHA-256 与原安装一致；后台从 `/opt/homebrew/opt/inverso/bin/inverso` 运行，`inverso status` 确认 Scroll event tap 为 enabled、Start at login 为 on。新位置已由用户允许设备控制访问，旧程序及其旧权限条目已移除。Dusk 继续保持未安装。
