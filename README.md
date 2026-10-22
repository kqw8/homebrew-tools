# 自制工具的 Homebrew tap

当前包含 Dusk 0.3.0 的 formula，固定到上游提交 `f91c413864fb417b2fdf4fb8ad41ced52be3d2c1`，下载时校验 SHA-256。原项目源码保留在 `~/Developer/dusk`。

编译使用 Apple Command Line Tools 自带的 Swift 5.9 或更新版本，不额外安装完整 Xcode、其他 Swift 工具链或第三方运行时。程序运行要求 macOS 13 或更新版本。

这份仓库用于以后分发和安装。本机当前停用 Dusk；编写和验证 tap 不会安装程序、启动后台或修改显示设置。

## 以后需要安装时

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
