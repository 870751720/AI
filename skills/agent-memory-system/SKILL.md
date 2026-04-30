---
name: agent-memory-system
description: Set up and maintain a persistent file-based memory system for AI Agents, inspired by Claude Code's layered context approach. Use when the user asks to (1) create, build, or initialize an AI agent memory system, (2) set up persistent memory or cross-session recall, (3) add memory capabilities to a project, (4) archive session summaries or record learnings and corrections, (5) update or optimize the existing memory mechanism. This skill provides transparent Markdown-based memory with index-driven loading, separation of human-written rules and AI-written experience, and automatic archiving.
---

# Agent Memory System

为 AI Agent 建立透明、分层的文件化记忆系统，支持跨会话持久化。

## 核心原则

- **透明优先**：所有记忆为纯文本 Markdown，用户可读、可改、可版本控制
- **人写 vs AI 写分离**：`rules/` 存放人写的稳定指令；`memory/` 存放 AI 写的经验与归档
- **索引驱动**：通过 `INDEX.md` 按需加载记忆，避免上下文膨胀
- **自动归档**：长任务结束后写会话摘要；被纠正时记录经验

## 文件结构

在 `.kimi/` 下建立：

```
memory/
├── INDEX.md              # 记忆总索引，会话开始时读取
├── learnings.md          # 纠正、踩坑、学到的模式
├── project-context.md    # 项目架构、技术栈、关键决策
└── sessions/             # 长任务会话摘要
```

## 工作流程

### 初始化（首次使用）

1. 检查 `.kimi/memory/` 是否存在，不存在则创建目录结构
2. 读取 `references/` 中的模板文件
3. 根据项目实际情况填充 `project-context.md`
4. 创建 `INDEX.md` 作为记忆导航

### 日常运作

| 时机 | 动作 |
|------|------|
| 会话开始 | 读取 `INDEX.md`，按索引加载必读记忆 |
| 被纠正时 | 追加到 `learnings.md`：错误表现 → 正确做法 → 场景 |
| 长任务结束（>20min） | 写 `sessions/YYYY-MM-DD-任务.md` 摘要 |
| learnings.md > 200 行 | 归档旧内容到 `sessions/`，生成摘要 |

### 加载规则

1. **优先级**：`rules/`（人写指令）> `memory/`（AI 写经验）
2. **冲突处理**：人写文件覆盖 AI 写文件；后加载的覆盖先加载的
3. **按需读取**：长记忆只读前 50 行，详细内容在需要时再加载

## 模板资源

- `references/index-template.md` — 记忆索引模板
- `references/project-context-template.md` — 项目上下文模板
- `references/learnings-template.md` — 经验记录模板
- `references/session-summary-template.md` — 会话摘要模板

## 维护规则

- 保持 `learnings.md` 在 200 行以内，超出则压缩归档
- `project-context.md` 的「重要变更记录」在架构变动时追加
- 用户可直接编辑任何 `.md` 文件，下次会话立即生效
- 旧记忆归档时保留核心决策，删除执行细节
