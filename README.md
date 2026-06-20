# AIPM 面试复盘 Plugin

[中文](README.md) | [English](README.en.md)

![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-6B46C1)
![Skills](https://img.shields.io/badge/Skills-5-111827)
![AIPM](https://img.shields.io/badge/AIPM-Interview%20Prep-00B96B)
![Self-improving Loop](https://img.shields.io/badge/Loop-Self--improving-7B61FF)
![Language](https://img.shields.io/badge/Language-ZH%20%2B%20EN-blue)
![License](https://img.shields.io/github/license/VioletScar-Hui/aipm-coach-plugin)
![Status](https://img.shields.io/badge/Status-Active-success)

`aipm-coach` 是一个 Claude Code 插件——一套**跨面试持续累积、越用越准**的 AI 产品经理（AIPM）面试备战 loop 系统。它面向正在求职 AIPM / AI 应用 PM 的人，把"每一场面试"变成可复盘、可沉淀、可针对性补强的闭环。

它不是静态题库，也不是一次性的"帮你改简历"。核心心智是 **loop engineering**：每次会话都是一个"失忆的换班工人"，上一班的记忆只存在知识库文件里——所以系统**先读状态、小步做、即时落盘**，让 面试 → 复盘 → 沉淀 → 补强 → 下场更强 形成闭环。

它还自带一道别处少见的保障：**writer-vs-checker 独立质检**——复盘由一个 agent 写，再派一个**全新上下文**的检查者按统一评分标准给它挑错（防自我感觉良好），并用机器护栏防止编造与误改你的简历。

本仓库包含 [`LICENSE`](LICENSE)。

---

## 它怎么工作（闭环）

```text
   ┌─────────── aipm-coach/（跨面试累积的知识库 = 记忆）───────────┐
   │  _rubric · weak-spots · question-bank · star-stories · evals │
   └───▲────────────▲─────────────▲──────────────▲───────────────┘
       │写           │读写          │读            │读
 面完→ /aipm-retro → /aipm-eval   /aipm-resume   /aipm-prep →面前
       逐题复盘诊断   新上下文质检   简历&话术       冲刺简报
```

每复盘一场，`weak-spots.md` 累积变强，`/aipm-prep` 永远先攻你最常错的点——这就是"越用越准"。

---

## 适用场景

适合：正在准备 AIPM / AI 应用 PM 面试，想要**诚实诊断 + 可直接背的优质答案 + 跨场次累积**的人。

- "面完了，帮我复盘这场面试" → 复盘诊断 + 沉淀
- "检查一下刚才那次复盘靠不靠谱" → 独立质检
- "帮我改简历 / 提炼自我介绍话术" → 简历 & 话术
- "我明天要面 X，帮我冲刺" → 针对性简报

不适合：只想要一份通用面试题、或一句话的泛泛建议——这套工具的价值随你复盘的场次累积，空跑没意义。

---

## 前置条件

只需要 **Claude Code**（桌面端 / CLI / IDE 插件均可）。**无任何外部依赖**——不需要 API key、数据库或第三方 CLI，所有状态都是本地 markdown 文件。

---

## 安装

`aipm-coach` 通过 marketplace 安装。下面三种方式等价，区别只在**命令敲在哪里**。

### 方式一：在 Claude Code 会话里（推荐）

先在系统终端（PowerShell / Terminal / bash）启动 Claude Code：

```bash
claude
```

进入交互界面后会看到输入提示符 `>`。**在这个 `>` 提示符后**逐条输入下面的斜杠命令（不是在系统终端里）：

```text
/plugin marketplace add VioletScar-Hui/aipm-coach-plugin
/plugin install aipm-coach@aipm-coach-marketplace
```

> `/plugin` 是 Claude Code 的**内置斜杠命令**，只能在 Claude Code 会话内输入；直接粘到 PowerShell / bash 里会报 `command not found`。

### 方式二：在系统终端里（不进会话）

直接用 `claude` 的子命令安装，适合写进脚本：

```bash
claude plugin marketplace add VioletScar-Hui/aipm-coach-plugin
claude plugin install aipm-coach@aipm-coach-marketplace
```

### 方式三：本地试用（不安装，开发用）

```bash
claude --plugin-dir ./plugins/aipm-coach
```

**安装后重启 Claude Code**，技能才会加载，并以命名空间形式出现：`/aipm-coach:aipm-retro`、`/aipm-coach:aipm-eval` 等（`/help` 可见）。

---

## 第一次使用

1. **脚手架知识库**：说"初始化 aipm 知识库"触发 `/aipm-coach:aipm-setup`，把模板复制到当前项目的 `aipm-coach/`（已存在的文件**绝不覆盖**）。
2. **填两份源文件**：`aipm-coach/profile.md`（求职画像）+ `aipm-coach/resume-current.md`（贴简历原文）。
3. **复盘第一场**：说"复盘面试"并贴上逐字稿 / 回忆 → `/aipm-coach:aipm-retro` 开始诊断并沉淀。复盘过 1–2 场后，`/aipm-prep` 的简报才真正有针对性。

---

## 五个 Skill

| 命令 | 作用 | 触发语示例 |
|---|---|---|
| `aipm-retro` | 面完一场逐题诊断 + 给基于真实简历的优质答案 + 沉淀知识库 | "复盘面试 / 面完了 / 帮我看看我答得怎么样" |
| `aipm-eval` | 派全新上下文检查者按 `_rubric.md` 给复盘打分（writer-vs-checker），漏判回流 | "检查这次复盘 / 这次复盘靠谱吗 / 跑评测" |
| `aipm-resume` | 面向 AIPM 改写简历 bullet（XYZ 句式）+ 提炼自我介绍 / 项目 / AI 话术 | "改简历 / 提炼话术 / 自我介绍怎么说" |
| `aipm-prep` | 读累积经验出"今天练得完"的针对性简报 + 模拟追问 | "我明天要面 X / 面前冲刺" |
| `aipm-setup` | 首次把知识库模板幂等脚手架到 `aipm-coach/` | "初始化 aipm 知识库" |

---

## 核心设计（为什么可靠）

- **为失忆者设计**：所有经验沉淀进 `aipm-coach/` 文件，新会话先读状态再动手，跨会话 / 上下文重置不丢。
- **机器可核对的完成判据**：每题有诊断、每条薄弱点配具体改进动作、产物文件存在非空——不靠"感觉答得不错"。
- **writer-vs-checker 独立验证**：`aipm-eval` 永远派**全新上下文**子代理打分，写手不给自己打分（太宽容）。
- **防编造**：优质答案只用简历 / STAR 真实经历，缺事实标 `[需你补充：…]`，绝不虚构数字或项目。
- **机器护栏（hook）**：写"标准件"（简历 / 画像 / 度量衡 / 评测样本期望）前强制确认，防越权覆盖与 reward hacking。
- **崩溃安全 + 幂等**：逐题即时落盘，中断不丢；相似题合并去重，不产生重复条目。
- **越用越准**：`weak-spots.md` 累积计数，`/aipm-prep` 永远先攻你复发最多的点。

---

## 知识库（aipm-coach/）

| 文件 | 作用 |
|---|---|
| `_rubric.md` | 统一评分度量衡（十维 + 优质答案硬约束）——受护栏保护 |
| `weak-spots.md` | 薄弱点台账（系统进步的核心累积状态） |
| `question-bank.md` | 题库 + 优质答案（跨面试累积，幂等去重） |
| `star-stories.md` | 可复用 STAR 真实素材 |
| `profile.md` / `resume-current.md` | 求职画像 / 简历原文（你的源文件，受护栏保护） |
| `evals/` + `eval-log.md` | 评测样本 + 质检流水账 |
| `sessions/` | 每场复盘 / 冲刺存档 |

---

## 仓库结构

```text
aipm-coach-plugin/
  README.md / README.en.md         # 中 / 英首页
  LICENSE
  .claude-plugin/marketplace.json  # marketplace 清单
  plugins/aipm-coach/
    .claude-plugin/plugin.json
    README.md                      # 插件级说明
    skills/   aipm-retro | resume | prep | eval | setup
    agents/   aipm-reviewer.md      # 全新上下文检查者
    hooks/    hooks.json + guard-source-files.sh
    templates/aipm-coach/           # 空知识库模板 + 通用 _rubric + 评测样本
```

---

## 更新

- **作为用户**：`/plugin marketplace update` 后重启 Claude Code。
- **作为维护者**：改完 `git push`，并 bump `plugins/aipm-coach/.claude-plugin/plugin.json` 的 `version`，用户才会收到更新。

---

## 常见问题

**Skill 没触发** — 用明确触发语（见上表），或直接 `/aipm-coach:aipm-retro` 显式调用。

**老弹写入确认框** — 那是护栏在保护你的简历 / 画像 / 度量衡 / 评测样本期望。确认即可；这些"标准件"本就该只读不写。脚手架用的 `cp` 不会触发它。

**数据隐私** — 你的真实简历 / 薄弱点 / 复盘只存在你本地的 `aipm-coach/`，**不随插件分发**；插件仓库只含逻辑与空模板。

---

## License

本仓库包含 [`LICENSE`](LICENSE) 文件，详见该文件。
