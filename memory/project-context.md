# Project Context — 项目上下文

> 记录项目架构、技术决策和关键约定。由 AI Agent 在会话开始时读取。

---

## 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 游戏引擎 | Phaser | ^4.0.0 |
| 语言 | TypeScript | ^6.0.3 |
| 构建工具 | Vite | ^8.0.10 |
| 包管理器 | npm | — |

## 开发规范

- 文档语言：**中文**（注释、README、提交信息）
- 提交风格：Conventional Commits，例：`feat: 添加玩家移动逻辑`
- 代码风格：TypeScript 严格模式；场景类继承 `Phaser.Scene`

## 常用命令

```bash
npm run dev      # 开发服务器（热重载）
npm run build    # 生产构建
npm run preview  # 预览生产构建
```

## 项目结构

```
src/
├── main.ts              # 入口
├── gameConfig.ts        # Phaser 全局配置
├── constants/           # 常量定义（SceneKeys、AssetKeys 等）
├── managers/            # 单例管理器（AudioManager、StateManager 等）
├── objects/             # 可复用游戏实体
│   └── platforms/
├── scenes/              # 场景
├── types/               # 全局类型定义
└── utils/               # 工具函数

public/assets/           # 静态资源（Vite 原样复制）
├── images/
├── audio/
├── fonts/
└── data/
```

> `.gitkeep` 占位说明：当前 `constants/`、`managers/`、`objects/`、`types/`、`utils/` 及 `public/assets/*` 均为空目录，内放 `.gitkeep` 占位。**后续任一目录首次创建真实文件时，须同步删除该目录的 `.gitkeep`**。

## 重要变更记录

<!-- 每次架构变动或重大决策时追加 -->
