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

## 游戏配置（gameConfig.ts）

- 分辨率：1280 × 720
- 缩放模式：`Phaser.Scale.RESIZE`
- 自动居中：`NO_CENTER`
- 背景色：`#2d2d2d`
- 物理引擎：Arcade（默认），重力 `{ x: 0, y: 300 }`，`debug: false`

## 目录结构

```
src/
├── main.ts              # 入口：创建 Phaser.Game 实例
├── gameConfig.ts        # 全局配置 + 场景注册
└── scenes/
    └── BootScene.ts     # 当前唯一场景

public/assets/           # 游戏资源（图片、音频、字体）
dist/                    # 构建产物
```

## 场景管理约定

1. 新场景放在 `src/scenes/`
2. 在 `src/gameConfig.ts` 的 `scene` 数组中注册
3. 场景切换用 `this.scene.start('SceneKey')`

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

## 已知限制

- 当前未引入测试框架
- `.kimi/` 为子模块（SSH 拉取），通用 AI Skill / Rule 应放此处；游戏业务代码留在主仓库

---

## 重要变更记录

<!-- 每次架构变动或重大决策时追加 -->
