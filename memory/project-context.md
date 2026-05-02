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

### 2026-05-02 — Markdown 配表 + 导表脚本体系建立

- **配表格式**：Markdown GFM 表格，固定三段式结构（表定义 / 字段定义 / 数据）
- **字段定义规范**：字段名、类型、必填、默认值、说明
- **命名约定**：Markdown 源文件字段用 `snake_case`，导出产物自动转 `camelCase`
- **导出产物**：TS Interface + 内联数据 → `src/data/{camelCase}.ts`（直接 import 使用）
- **导表命令**：`npm run export-data`
- **当前配表**：`item_table`（基础道具，8 条）、`character_look_table`（外观套装，2 条）、`outfit_part_table`（部件明细，20 条）、`asset_mapping_table`（资源映射，13 条）
- **脚本路径**：`scripts/export-tables.js`

### 2026-05-02 — 游戏品级体系确立

- **品级颜色**：白 → 蓝 → 紫 → 金 → 红
- **品级名称**：普通 → 精良 → 卓越 → 稀世 → 无双
- **适用范围**：装备、材料、技能、怪物、系统等所有可分级事物
- **设计定位**：统一的全局品级标准，颜色为UI标识，名称为世界观层称呼
- **详细文档**：见 `docs/mechanics/tiers.md`

### 2026-05-01 — 世界观核心设定确定

- **世界本质**：表面是DQ式奇幻世界，地下是系统持有者的隐秘世界
- **系统起源**：游戏开发者遗留的世界管理模块，流失到世界中
- **核心设定**：普通人没有"升级"概念，主角获得"战斗升级系统"后成为唯一能升级的人
- **系统稀有性**：像别墅一样贵，黑市流通，可丢弃重绑
- **主角起点**：废弃矿洞中被红狼丢弃的基础系统
- **关键角色**：红狼——传奇系统持有者，"追不上的人"，悲剧结局
- **详细文档**：见 `docs/story/world-building.md`
