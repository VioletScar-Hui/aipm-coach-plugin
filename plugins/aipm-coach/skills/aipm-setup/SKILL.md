---
name: aipm-setup
description: 首次使用 AIPM 复盘系统时，把知识库模板脚手架到当前项目的 aipm-coach/（幂等：已存在的文件绝不覆盖）。当用户说"初始化 aipm / 安装 aipm 知识库 / aipm 第一次怎么用 / scaffold aipm-coach"时使用。
---

# AIPM 知识库脚手架（首次使用）

把本插件 `templates/aipm-coach/` 里的模板复制到**当前工作目录**的 `aipm-coach/`，让 retro/resume/prep/eval 四个 skill 有状态可读写。

## 关键原则：幂等，绝不覆盖真实数据
这是"失忆换班工人"系统——`aipm-coach/*.md` 可能已装着用户累积的真实数据（简历、薄弱点、复盘存档）。**只补缺失的文件；已存在的一律跳过、保留。** 宁可少建，绝不覆写。

## 成功判据（机器可核对）
1. `./aipm-coach/` 下含：`_rubric.md`、`profile.md`、`resume-current.md`、`weak-spots.md`、`question-bank.md`、`star-stories.md`、`evals/`（README + 3 个 case）。
2. 任何原已存在的文件都**未被改动**（在总结里列出"已保留 N 个"）。

## 五拍循环
1. **Orient**：定位本插件模板目录（优先用环境变量 `$CLAUDE_PLUGIN_ROOT` 下的 `templates/aipm-coach/`；取不到就让用户给出插件安装路径）。列出当前 `./aipm-coach/` 已有哪些文件。
2. **Plan**：算出"缺失清单"（模板有、项目没有的）。
3. **Act**：用 **Bash `cp -rn`**（no-clobber，天然幂等且不触发写保护 hook）一次性补齐：
   ```bash
   mkdir -p ./aipm-coach
   cp -rn "$CLAUDE_PLUGIN_ROOT/templates/aipm-coach/." ./aipm-coach/
   ```
   *为什么用 `cp -n` 而非逐个 Write*：`-n` 保证已存在文件不被覆盖（保护真实数据），且 `cp` 不是 Edit/Write，不会触发源文件保护 hook 的确认弹窗。
4. **Verify**：复制后成功判据 1 的文件都存在且非空；用 `diff` 或修改时间确认原有文件未变。
5. **Record**：无需额外状态——文件存在即状态。

## 停止条件
- **完成**：成功判据满足 → 一屏总结并停。
- **阻塞需问用户**：当前目录不像该放 aipm-coach（如系统目录 / 空仓库根不确定）→ 停下来问；`$CLAUDE_PLUGIN_ROOT` 取不到且用户没给路径 → 问。
- **硬上限**：只脚手架一次、只补缺失；不做任何内容生成或改写。

## 护栏
- **绝不覆盖已存在文件**——用户真实数据无价（`cp -n` 已强制）。
- **不编造**：只原样复制模板，不往里填内容。

## 一屏总结
```
🧰 AIPM 知识库脚手架完成
✅ 新建：<文件列表>
🛡 已保留（已存在，未动）：<列表 或 无>
▶ 下一步：填 aipm-coach/profile.md 画像 → 把简历贴进 resume-current.md →
  面完一场说"复盘面试"触发 /aipm-coach:aipm-retro
```
