# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Project Overview

CodingTool (程序员编码辅助工具, a coding helper for programmers) is a Free Pascal / Lazarus LCL desktop GUI application for batch line/column transformations on plain text: adding prefixes/suffixes, splitting/joining lines, case conversion, converting between tabs/spaces/commas, sorting, column extraction, and language-specific processing. It was migrated from Delphi VCL to Lazarus LCL and targets Linux, Windows and macOS. Local development happens mainly on `x86_64-linux`.

## Build and Run

```bash
# Build (recommended; uses the compiler options in the .lpi)
lazbuild CodingTool.lpi

# Run
./CodingTool
```

- The executable is `CodingTool` in the repository root. It is ignored by `.gitignore` and not committed.
- Build artifacts (`.ppu`/`.o`) go to `lib/x86_64-linux/`, which is also ignored.
- Dependencies: Lazarus 4.x + FPC 3.2.x. The only required package is `LCL` (see `RequiredPackages` in `CodingTool.lpi`).
- There are no automated tests and no lint configuration. Verify changes by building successfully and exercising the behavior manually in the GUI.
- Release builds: `.github/workflows/release.yml` runs on `v*` tags or manual dispatch and builds and packages Windows (x64/x86), Linux (amd64/arm64) and macOS (x64/arm64). Both macOS jobs pin Xcode 16.2. The arm64 job also passes `-k-ld_classic` to use the classic linker, because Xcode 16's new linker crashes when linking FPC 3.2.x aarch64 output.

## Architecture

The core data flow is: **GUI event → `Tool.<Category>.<Operation>` → in-place modification of the memo's `TStrings`**.

- `CodingTool.lpr` — Program entry point; creates `TfrmMain` (`Unit1`).
- `Unit1.pas` / `Unit1.lfm` — The single main form, `TfrmMain`. All button/menu/Action event handlers are thin, usually a one-line forward to `Tool.XXX.YYY(...)`. The UI is split into TabSheets by function, captioned in Chinese: 通用 / 通用2 / 通用3 (General 1–3), 递增序列 (Incrementing Sequence), SQL, MASM.
- `Unit_Utility.pas` — The `TCodeUtility` facade. It exposes all tool classes as public fields: `Common`, `Sequence`, `SQL`, `MASM`.
- `Unit_UtilityCommon.pas` — `TCodeUtilityCommon`, the language-independent text operations. This is the largest tool unit and holds most features.
- `Unit_Utility<Lang>.pas` — Specialized tool classes (`TCodeUtilitySequence`, `TCodeUtilitySQL`, `TCodeUtilityMASM`). Each is bound to the same `TStrings`.

### Key Convention: TStrings Lifetime (Common Pitfall)

No tool class **keeps its own copy of the text**. Each holds a reference to the memo's `TStrings` (`txtMemo.Lines`) and modifies it in place. Two pieces of code matter here:

1. `TfrmMain.GetTool` (`Unit1.pas`): every access through the `Tool` property first rebinds with `FTool.Lines := txtMemo.Lines`. **LCL recreates the `Lines` object when the memo's handle is recreated**, so a reference captured at construction time becomes invalid (this caused an earlier access violation; see commit `04e5f21`). Always access tools through the `Tool` property and never cache `FTool`.
2. `TCodeUtility.SetLines` (`Unit_Utility.pas`): propagates the new `TStrings` to every child tool class. When adding a tool class, register it in all three places: `Create`, `SetLines` and `Destroy`.

### How to Add Features

- A general text operation: add a public method to `TCodeUtilityCommon` → add a control in `Unit1.lfm` → add a one-line forwarding event handler in `Unit1.pas`.
- A new language: create `Unit_Utility<Lang>.pas` (`{$mode Delphi}{$H+}`, with a constructor taking `theLines: TStrings`) → register it in the uses clause of `CodingTool.lpr`, the Units of `CodingTool.lpi`, and the field/`Create`/`SetLines`/`Destroy` of `Unit_Utility.pas`.

## Code Conventions

- **Every unit must declare `{$mode Delphi}{$H+}` at the top**: the build no longer relies on the global mode setting in the `.lpi` (see commit `94c2808`), so removing it breaks compilation.
- All source files are UTF-8 (migrated from GBK; see commit `8943281`). UI text is in Chinese.
- Cross-platform: avoid calling Windows APIs directly; use LCL equivalents (such as `OpenURL`, `CaretPos`). Wrap platform-specific code in `{$IFDEF WINDOWS}` / `{$IFDEF UNIX}` (for example, line-ending normalization on paste only applies on Windows; see commit `86c200d`).
