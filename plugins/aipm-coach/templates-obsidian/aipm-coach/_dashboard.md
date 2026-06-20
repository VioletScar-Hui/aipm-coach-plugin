---
tags: [aipm/dashboard]
---
# 🎛 AIPM 复盘仪表盘

> 需启用 **Dataview** 社区插件。下面所有视图按 frontmatter 的 `tags` 聚合——**与文件放在哪个文件夹无关**，移动笔记也不会失效。

## 📅 今日 / 逾期 到期重练（spaced repetition）
```dataview
TABLE WITHOUT ID file.link AS 训练项, due AS 到期, layer AS 层, mastery AS 掌握度
FROM #aipm/drill
WHERE due AND due <= date(today)
SORT due ASC
```

## 🔴 未克服薄弱点（按复发排序）
```dataview
TABLE WITHOUT ID file.link AS 薄弱点, dimension AS 维度, layer AS 层, count AS 复发, status AS 状态
FROM #aipm/weak-spot
WHERE status != "✅"
SORT count DESC
```

## ❓ 待练题（掌握度 ❌ / 🔄）
```dataview
TABLE WITHOUT ID file.link AS 题, qtype AS 题型, mastery AS 掌握度, company AS 来源
FROM #aipm/question
WHERE mastery = "❌" OR mastery = "🔄"
SORT mastery ASC
```

## 🗓 最近复盘
```dataview
TABLE WITHOUT ID file.link AS 场次, company AS 公司, round AS 轮次, date AS 日期
FROM #aipm/session
SORT date DESC
LIMIT 10
```

## ✅ 已克服里程碑
```dataview
TABLE WITHOUT ID file.link AS 薄弱点, count AS 历经复发
FROM #aipm/weak-spot
WHERE status = "✅"
SORT file.mtime DESC
```
