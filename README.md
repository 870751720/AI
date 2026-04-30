# AI Toolkit

本仓库是中央 AI 配置库，存放通用的 AI Skill、Rule、Prompt 等资产，供多个项目复用。

## 目录结构

```
AI/
├── skills/          # AI Skill（Kimi / Cursor / Claude Code 等）
│   ├── game-dev/    # 游戏开发专用 Skill
│   ├── code-review/ # 代码审查 Skill
│   └── doc-writing/ # 文档编写 Skill
├── rules/           # AI 行为规则 / .cursorrules / .kimi-rules
├── prompts/         # 可复用的 Prompt 模板
├── mcp/             # MCP (Model Context Protocol) 配置
├── docs/            # AI 设计理念、最佳实践
└── agents/          # Agent 配置
```

## 使用方式

在其他项目（如 Game）中通过 Git Submodule 引用：

```bash
git submodule add git@github.com:870751720/AI.git ai-toolkit
```

## 原则

- **通用配置**放在本仓库。
- **项目专属**配置放在各项目自己的仓库中。
