# 记忆索引（Memory Index）

> 本文件由 AI Agent 读取，用于在会话开始时定位并加载相关记忆。
> 所有记忆文件均为纯文本 Markdown，用户可随时直接编辑。

---

## 必读（每次会话加载）

| 文件 | 说明 |
|------|------|
| [user-profile](../rules/user-profile.md) | 用户行事风格与决策偏好 |
| [project-context](project-context.md) | 项目架构、技术栈、关键决策 |
| [agent-constraints](agent-constraints.md) | Agent 工作流约束与行为边界 |

## 技术参考（按需读取）

| 文件 | 说明 |
|------|------|
| [docs/tech/README.md](../../docs/tech/README.md) | 技术文档总索引，涵盖存档系统等核心模块设计 |

## 动态经验（按需读取头部 50 行）

| 文件 | 说明 |
|------|------|
| [learnings](learnings.md) | 历史纠正、踩坑记录、学到的模式 |

## 会话归档

- [sessions/](sessions/) — 长任务（>20 分钟）或重要变更的会话摘要

---

## 加载规则

1. **优先级**：`rules/`（人写指令）> `memory/`（AI 写经验）
2. **冲突处理**：人写文件覆盖 AI 写文件；后加载的覆盖先加载的
3. **膨胀控制**：`learnings.md` 超过 200 行时，旧内容自动归档到 `sessions/` 并生成摘要
4. **用户随时可改**：直接编辑任何 `.md` 文件，下次会话立即生效
