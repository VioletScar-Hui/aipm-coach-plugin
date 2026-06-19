# aipm-coach 插件

一套**跨面试累积、越用越准**的 AIPM（AI 产品经理）面试备战 loop 系统，打包成 Claude Code 插件。

## 它装了什么

| 组件 | 文件 | 作用 |
|---|---|---|
| 复盘（写手） | `skills/aipm-retro` | 面完一场逐题诊断 + 给基于真实简历的优质答案 + 沉淀知识库 |
| 简历话术 | `skills/aipm-resume` | 面向 AIPM 改写简历 bullet + 提炼可直接说的话术 |
| 面前冲刺 | `skills/aipm-prep` | 读累积经验，出"今天练得完"的针对性简报 |
| 复盘质检（检查者） | `skills/aipm-eval` + `agents/aipm-reviewer.md` | 派**全新上下文**子代理给复盘打分（writer-vs-checker），闭合循环 |
| 首次脚手架 | `skills/aipm-setup` | 把知识库模板幂等复制到你的 `./aipm-coach/` |
| 护栏 | `hooks/` | 写"标准件"（简历 / 画像 / 度量衡 / 评测样本）前强制确认，防越权与 reward hacking |
| 知识库模板 | `templates/aipm-coach/` | 空模板 + 通用评分度量衡 `_rubric.md` + 3 个评测样本 |

## 安装与首次使用

1. **装插件**（见仓库根 README 的 marketplace 安装法，或本地 `claude --plugin-dir`）。
2. **脚手架知识库**：在你的项目目录里说"初始化 aipm 知识库"触发 `/aipm-coach:aipm-setup`，它会把模板复制到 `./aipm-coach/`（已存在的不覆盖）。
   - 也可手动：`cp -rn <本插件>/templates/aipm-coach ./aipm-coach`
3. **填两份源文件**：`aipm-coach/profile.md`（求职画像）+ `aipm-coach/resume-current.md`（贴简历原文）。
4. **开始用**：面完一场说"复盘面试"→ `/aipm-coach:aipm-retro`；接着说"检查这次复盘"→ `/aipm-coach:aipm-eval`；面前说"我明天要面 X"→ `/aipm-coach:aipm-prep`。

## 用法须知

- **技能是命名空间化的**：调用名是 `/aipm-coach:aipm-retro` 这种形式（`/help` 里能看到）。技能正文里写的 `/aipm-prep` 等是建议指引文字，对应到 `/aipm-coach:aipm-prep`。
- **护栏会在首次脚手架后生效**：之后任何想改 `resume-current.md`/`profile.md`/`_rubric.md`/`evals/case-*.md` 的写操作都会先弹确认——这是有意的（防误改你的"标准件"）。`aipm-setup` 用 `cp -n` 复制，不触发它。
- **知识库是你的私有状态**，不随插件分发；你的真实简历 / 薄弱点 / 复盘只存在你自己的 `aipm-coach/` 里。

## 红线

不编造（缺事实标 `[需你补充：…]`）· 不奉承 · 不冒充工程师 · 不擅自覆盖你的源文件。详见各 `SKILL.md` 与 `templates/aipm-coach/_rubric.md`。
