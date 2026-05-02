---
name: game-table-exporter
description: Manage and export game data tables from Markdown to JSON + TypeScript. Use when the user needs to (1) create, modify, or delete a game data table, (2) add or update table entries (rows), (3) add or modify table fields (columns), (4) run the table export pipeline, (5) understand the table format or naming conventions, or (6) troubleshoot export errors.
---

# Game Table Exporter

管理游戏配表体系：以 Markdown GFM 表格作为源文件，通过导表脚本一键生成 JSON（运行时数据）和 TypeScript Interface（类型定义）。

## 核心机制

| 环节 | 路径 | 说明 |
|------|------|------|
| 配表源文件 | `data/tables/*.md` | Markdown 三段式结构，人工维护 |
| 导表脚本 | `scripts/export-tables.js` | Node.js 脚本，扫描 → 解析 → 校验 → 导出 |
| 运行时数据 | `public/assets/data/*.json` | JSON 数组，游戏运行时加载 |
| 类型定义 | `src/data/*.ts` | TS Interface + const 占位符，供代码引用 |
| 导表命令 | `npm run export-data` | 调用 `node scripts/export-tables.js` |

## 配表文件格式（三段式）

每个 `.md` 文件必须包含以下三个二级标题区块：

### 1. `## 表定义`

元信息表格，固定 4 行：

| 属性 | 值 |
|:---|:---|
| 表ID | `xxx_table` |
| 描述 | 该表用途说明 |
| 主键 | `id`（或其他字段名） |
| 使用场景 | 哪些系统读取此表 |

### 2. `## 字段定义`

定义每一列的元数据：

| 字段名 | 类型 | 必填 | 默认值 | 说明 |
|:---|:---|:---:|:---|:---|
| id | string | ✅ | — | 程序侧唯一标识 |
| name | string | ✅ | — | 显示名称 |

**字段约束：**
- `字段名`：源文件中使用 `snake_case`，导出时自动转为 `camelCase`
- `类型`：仅支持 `string` / `number` / `boolean`
- `必填`：`✅` 表示必填，`❌` 表示可选
- `默认值`：空值时填充；写 `—` 表示无默认值
- `说明`：生成 TS 注释，帮助代码侧理解

### 3. `## 数据`

实际数据行，表头必须与「字段定义」中的 `字段名` 完全一致：

| id | name | ... |
|:---|:---|:---|
| hero_01 | 勇者 | ... |

**数据规则：**
- 空单元格或 `—` 视为空值，优先填充默认值
- 必填字段若为空且无默认值，导出报错
- `number` 类型字段若解析失败，回退为原始字符串

## 命名约定

| 对象 | 源文件命名 | 导出后命名 | 示例 |
|------|-----------|-----------|------|
| Markdown 源文件 | `snake_case.md` | — | `item_table.md` |
| JSON 数据文件 | — | `snake_case.json` | `item_table.json` |
| TS 类型文件 | — | `camelCase.ts` | `itemTable.ts` |
| TS Interface | — | `PascalCase` | `ItemTable` |
| TS 常量名 | — | `camelCase + Data` | `itemTableData` |
| 字段名（源文件） | `snake_case` | — | `tier_id` |
| 字段名（导出后） | — | `camelCase` | `tierId` |

## 工作流：新增/修改配表

### 新增一张表

1. **复制模板**：从 `references/table-template.md` 复制到 `data/tables/xxx_table.md`
2. **填写表定义**：设定表ID、描述、主键、使用场景
3. **填写字段定义**：按需求定义所有字段的元数据
4. **填写数据**：按字段定义添加数据行
5. **执行导表**：`npm run export-data`
6. **检查输出**：确认 JSON 和 TS 文件生成正确，无报错

### 修改现有表

- **加字段**：先在「字段定义」中添加新行，再在「数据」中添加对应列
- **改字段**：同步修改「字段定义」和「数据」的表头
- **删字段**：从「字段定义」和「数据」中同时移除
- **加/改/删数据行**：直接编辑「数据」区块
- **修改后必须重新执行** `npm run export-data`

### 修改后检查清单

- [ ] Markdown 语法正确（表格分隔行 `|:---|` 完整）
- [ ] 「数据」表头与「字段定义」中的 `字段名` 完全一致
- [ ] 必填字段无空值（或未填默认值）
- [ ] 执行 `npm run export-data` 无报错
- [ ] 生成的 JSON 和 TS 文件内容符合预期

## 校验与错误处理

导表脚本会执行以下校验：

| 校验项 | 行为 |
|--------|------|
| 缺少字段定义或数据 | 跳过该文件，控制台报错 |
| 数据行出现未定义字段 | 报错并跳过该行 |
| 必填字段为空且无默认值 | 报错，该文件跳过导出 |
| 类型转换失败（如 `abc` → number） | 回退为原始字符串，不阻断 |

**遇到报错时的排查步骤：**
1. 查看控制台错误信息，定位到具体文件和行号
2. 检查对应 Markdown 文件的「字段定义」和「数据」区块
3. 确认表头名称、必填项、默认值是否正确
4. 修复后重新运行 `npm run export-data`

## 示例：完整的配表文件

见 `references/table-example.md`
