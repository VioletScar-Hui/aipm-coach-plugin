#!/usr/bin/env bash
# PreToolUse 护栏：当 Edit/Write/MultiEdit 想写 aipm-coach/ 下的"标准件"
# （resume-current.md 简历 / profile.md 画像 / _rubric.md 度量衡 / evals/case-*.md 评测样本）时，
# 升级为 ask 让用户确认。这些是"考试标准"，改它们可能构成 reward hacking，故只读不写。
# 注意：只锁 evals/case-*.md；eval-log.md（追加写）与 evals/README.md 不锁。
# 纯 bash + grep，无 jq/python/node 依赖；命中则输出 ask 决策，否则静默放行。
input=$(cat)
fp=$(printf '%s' "$input" | grep -oiE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1)
if printf '%s' "$fp" | grep -qi 'aipm-coach' \
   && printf '%s' "$fp" | grep -qiE '(resume-current\.md|profile\.md|_rubric\.md|evals[\\/]+case-)'; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"这是受保护的标准件（简历原文 / 求职画像 / 评分度量衡 _rubric / evals 评测样本）。改它们可能动摇「考试标准」本身（reward hacking）。确认要写入吗？改简历走 /aipm-resume；改评分标准 / 样本期望请你本人手动改。"}}'
fi
exit 0
