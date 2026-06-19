# aipm-coach-marketplace

分发 **aipm-coach** 插件的 Claude Code marketplace——一套 AIPM 面试复盘 loop 系统（复盘 / 简历 / 冲刺 / 质检 + 累积知识库 + 护栏）。

## 安装

**方式一·本地试用（不装，最快）**
```bash
claude --plugin-dir ./plugins/aipm-coach
```
进去后技能以 `/aipm-coach:aipm-retro` 等形式出现。

**方式二·从 marketplace 安装（推荐分享）**
先把本仓库推到 GitHub，然后：
```
/plugin marketplace add VioletScar-Hui/aipm-coach-plugin
/plugin install aipm-coach@aipm-coach-marketplace
```
本地路径也行：`/plugin marketplace add /d/CC_project/aipm-coach-plugin`

装好后说"初始化 aipm 知识库"触发 `/aipm-coach:aipm-setup`，再填 `aipm-coach/profile.md` 和 `resume-current.md`，即可开始。详见 [`plugins/aipm-coach/README.md`](plugins/aipm-coach/README.md)。

## 发布前务必做（隐私红线）

本仓库**只含通用逻辑与空模板，不含任何个人数据**——这是有意的。打包来源系统（如 `D:\CC_project\loop`）里的 `weak-spots.md` / `resume-current.md` / `profile.md` / `eval-log.md` / 真实 `evals/case-*.md` 都**没有**被复制进来。推到公开仓库前，再 `git status` 扫一遍，确认没有混入任何真实简历、面试记录或目标公司信息。

## 自定义

- 作者字段为 `VioletScar-Hui`；要换显示名就改 `plugin.json` 的 `author` 与本目录 `marketplace.json` 的 `owner`。
- 改版本就 bump `plugin.json` 的 `version`（用户据此收到更新）。
