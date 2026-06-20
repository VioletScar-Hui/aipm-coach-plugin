# Obsidian 风味知识库变体

把 `aipm-coach/` 知识库做成 **Obsidian 原生**布局——**一条目 = 一篇笔记** + frontmatter + wikilinks + 一个 Dataview 仪表盘，让**图谱 / 查询 / 间隔复习**全都顺。

## 和默认模板的区别

| | 默认 `templates/`（flat） | 本变体 `templates-obsidian/` |
|---|---|---|
| 结构 | 单文件 + markdown 表格 | 每条目一篇笔记，按文件夹归类 |
| 连接 | 文本提及 | `[[wikilinks]]`，**图谱可视化** |
| 查询 | 人工翻 | **Dataview** 按 `tags` 聚合 |
| 复习 | prep 捞"今日到期" | `_dashboard` 的"到期重练"视图（`due` 字段）|

## 前置：装 Dataview

Obsidian → 设置 → 第三方插件 → 搜 **Dataview** → 安装并启用。仪表盘的视图全用 DQL（不需要开 JS 查询）。

## 怎么用

1. 把本目录整个 `aipm-coach/` 复制进你的 Obsidian vault（参考文件 `_rubric.md` / `_diagnosis-plus.md` / `profile.md` / `resume-current.md` 从默认 `../templates/aipm-coach/` 拷过来即可，可选加一行 `tags: [aipm/ref]`）。
2. 打开 `_dashboard.md` —— 就是你的复习主页：今日到期重练、未克服薄弱点、待练题、最近复盘、已克服里程碑。
3. 打开图谱视图，能看到 薄弱点 ↔ 题 ↔ 故事 ↔ 复盘 的连线。

## frontmatter 约定（Dataview 据此查询）

| 笔记类型 | 文件夹 | `tags` | 关键字段 |
|---|---|---|---|
| 薄弱点 | `weak-spots/` | `aipm/weak-spot` | `id` `dimension` `layer` `status`(🔴/🟡/✅) `count` |
| 题 | `question-bank/` | `aipm/question` | `qid` `qtype` `mastery`(❌/🔄/⭐) `company` |
| 训练项 | `drills/` | `aipm/drill` | `due`(YYYY-MM-DD) `interval` `layer` `mastery` |
| STAR 故事 | `star-stories/` | `aipm/star-story` | `covers`(题型数组) |
| 复盘存档 | `sessions/` | `aipm/session` | `company` `round` `date` |

正文里用 `[[笔记名]]` 互链（弱点↔题↔故事↔复盘），图谱才连得起来。

## 间隔复习（spaced repetition）

每个 `drills/` 笔记带 `due` 日期；`_dashboard` 自动把 `due <= 今天` 的捞出来。练过一次就把 `due` 往后推（1d→3d→7d→14d），连过 3 次把 `mastery` 标 ✅。想要闪卡式复习也可以另装 "Spaced Repetition" 插件，但本变体用 Dataview 的 `due` 视图已经够用、且零额外依赖。

## ⚠️ 和自动 loop 的兼容性（重要）

默认插件的 skill（retro/eval/prep）写的是 **flat 单文件**格式（`weak-spots.md` 一个文件）。本变体是 **Obsidian 优先**模式——按笔记维护条目。两种用法：

- **手动 / 半自动**：你在 Obsidian 里维护笔记；复盘时让 Claude 帮你写成笔记，例如：「把这条薄弱点记成 `weak-spots/W3 xxx.md`，带 frontmatter 和到 [[相关题]] 的链接」。Claude 照 frontmatter 约定写即可。
- **想让自动 loop 原生写这个布局**：需要给 skill 加一个"Obsidian 模式"（把 Record 从写单文件改成写 per-note）。这是一个独立的后续增强，可按需再做。

> 选型建议：要**全自动跨面试累积** → 用默认 flat 模板；要**在 Obsidian 里图谱/查询/间隔复习的学习体验** → 用本变体。两者数据可手动互导，但别同时混用同一份 `aipm-coach/`。
