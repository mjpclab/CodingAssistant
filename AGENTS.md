# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## 项目概述

CodingTool（程序员编码辅助工具）是一个 Free Pascal / Lazarus LCL 桌面 GUI 程序，用于对纯文本做批量的行/列文本变换（加前后缀、拆分/合并行、大小写转换、Tab/空格/逗号互转、排序、列抽取，以及按语言的专用处理）。项目由 Delphi VCL 迁移到 Lazarus LCL，目标是跨平台（Linux/Windows/macOS），本地开发主要在 `x86_64-linux` 上进行。

## 构建与运行

```bash
# 构建（推荐，使用 .lpi 中的编译选项）
lazbuild CodingTool.lpi

# 运行
./CodingTool
```

- 输出可执行文件为仓库根目录下的 `CodingTool`（已被 `.gitignore` 忽略，不提交）。
- 编译产物（`.ppu`/`.o`）落在 `lib/x86_64-linux/`，同样被忽略。
- 依赖：Lazarus 4.x + FPC 3.2.x，唯一必需包是 `LCL`（见 `CodingTool.lpi` 的 `RequiredPackages`）。
- 无自动化测试、无 lint 配置：验证方式是构建通过 + 手动在 GUI 中操作验证行为。
- 发布构建：`.github/workflows/release.yml` 在推送 `v*` tag 或手动触发时构建 Windows（x64/x86）、Linux（amd64/arm64）、macOS（x64/arm64）并打包。macOS 两个 job 固定使用 Xcode 16.2；arm64 还需 `-k-ld_classic` 改用经典链接器，因为 Xcode 16 的新链接器链接 FPC 3.2.x 的 aarch64 产物会崩溃。

## 架构

数据流的核心是：**GUI 事件 → `Tool.<语言>.<操作>` → 直接原地改写 memo 的 `TStrings`**。

- `CodingTool.lpr` — 程序入口，创建 `TfrmMain`（`Unit1`）。
- `Unit1.pas` / `Unit1.lfm` — 唯一的主窗体 `TfrmMain`。所有按钮/菜单/Action 的事件处理都很薄，基本是一行转发到 `Tool.XXX.YYY(...)`。UI 按功能分 TabSheet（通用 / 通用2 / 通用3 / 递增序列 / SQL / MASM）。
- `Unit_Utility.pas` — `TCodeUtility` 门面（facade）。聚合所有工具类为公开字段：`Common`、`Sequence`、`SQL`、`MASM`。
- `Unit_UtilityCommon.pas` — `TCodeUtilityCommon`，与语言无关的文本操作主体（最大的工具单元，绝大多数功能在此）。
- `Unit_Utility<Lang>.pas` — 专用工具类（`TCodeUtilitySequence`、`TCodeUtilitySQL`、`TCodeUtilityMASM`），每个类同样绑定同一份 `TStrings`。

### 关键约定：TStrings 生命周期（易踩坑）

所有工具类**不持有自己的文本副本**，而是持有对 memo 的 `TStrings`（`txtMemo.Lines`）的引用，直接原地修改。要理解两处关键代码：

1. `TfrmMain.GetTool`（`Unit1.pas`）：每次通过 `Tool` 属性访问前，都会执行 `FTool.Lines := txtMemo.Lines` 重新绑定。**因为 LCL 在 memo 句柄重建时会重新创建 `Lines` 对象**，构造时捕获的引用会失效（此前的访问违例 bug 即源于此，见 commit `04e5f21`）。因此务必通过 `Tool` 属性访问工具，不要缓存 `FTool`。
2. `TCodeUtility.SetLines`（`Unit_Utility.pas`）：把新的 `TStrings` 传播给全部子工具类。新增语言工具类时必须在 `Create`、`SetLines`、`Destroy` 三处同步登记。

### 新增功能的典型改法

- 加一个通用文本操作：在 `TCodeUtilityCommon` 增加 public 方法 → 在 `Unit1.lfm` 加控件 → 在 `Unit1.pas` 加一行转发的事件处理。
- 加一门新语言：新建 `Unit_Utility<Lang>.pas`（`{$mode Delphi}{$H+}`，类构造函数接收 `theLines: TStrings`）→ 在 `CodingTool.lpr` 的 uses、`CodingTool.lpi` 的 Units、以及 `Unit_Utility.pas` 的字段/Create/SetLines/Destroy 中登记。

## 代码约定

- **每个单元头部必须声明 `{$mode Delphi}{$H+}`**：构建不再依赖 `.lpi` 里的全局 mode 设置（见 commit `94c2808`），删掉会导致编译失败。
- 源码统一 UTF-8 编码（此前从 GBK 迁移，见 commit `8943281`）；界面文案为中文。
- 跨平台注意：避免直接调用 Windows API，改用 LCL 等价物（如 `OpenURL`、`CaretPos`）。平台相关代码用 `{$IFDEF WINDOWS}` / `{$IFDEF UNIX}` 包裹（例如粘贴时的换行归一化仅在 Windows 生效，见 commit `86c200d`）。
