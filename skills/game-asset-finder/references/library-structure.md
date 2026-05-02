# 美术库结构参考

> 路径：`C:\Users\Gavin\Desktop\美术库`
> 用途：供 scan-assets.ps1 扫描和 SKILL.md 引用，了解各分类下的资源详情。

---

## 顶层分类

| 目录 | 内容 | 可搬运格式 |
|------|------|-----------|
| `character/` | 3套 Barbarian 角色动画 | PNG 序列、拆分部件 |
| `environment/` | 建筑、环境装饰、地面瓦片 | PNG |
| `font/` | 字体文件 | TTF |
| `icon/` | UI 背景图 | PNG |
| `Unity2DRPG_Farm_Assets-main/` | Unity 农场 RPG 完整素材包 | PNG、WAV、OGG |
| `素材/` | 杂项素材：Icons 2D、NPC 等 | PNG、GIF |
| `音效库/` | 海量分类音效 | WAV、MP3 |

---

## character — 角色动画

**3套 Barbarian（01/02/03）**

每套含完整 PNG 序列动画：
- `Attacking/` — 12 帧攻击
- `Dying/` — 14~15 帧死亡
- `Hurt/` — 12 帧受击
- `Idle/` — 12 帧待机
- `Idle Blink/` — 12 帧眨眼待机
- `Jump Loop/` — 6 帧跳跃循环
- `Jump Start/` — 6 帧跳跃起跳
- `Taunt/` — 18 帧嘲讽
- `Walking/` — 18 帧行走

另有 `Vector Parts/` 拆分部件（Body、Head、Arms、Legs、Shield、Weapon），可自由组合。

**搬运映射**：`character/PNG/Barbarian XX/PNG Sequences/` → `public/assets/images/characters/`

---

## environment — 场景环境

- `Buildings/` — 11 张建筑
- `Environment/` — 25 张环境装饰
- `Ground Tiles/` — 56 张地面瓦片（适合做 Tilemap）

**搬运映射**：`environment/PNG/**` → `public/assets/images/environment/`

---

## icon — UI 背景

- `Background/` — 241 张背景/UI 底图

**搬运映射**：`icon/Background/**` → `public/assets/images/ui/backgrounds/`

---

## Unity2DRPG_Farm_Assets-main — 农场 RPG 素材包

### Sprites
- `Sprite Textures/Buildings/` — 建筑
- `Sprite Textures/Character/Farmer/` — 农夫角色
- `Sprite Textures/Crops/` — 作物
- `Sprite Textures/Effects/` — 特效
- `Sprite Textures/NPCs/` — NPC（Butch、Cora）
- `Sprite Textures/Objects/` — 物件
- `Sprite Textures/Scenary/` — 场景
- `Sprite Textures/Tile Sprites/` — 瓦片
- `Sprite Textures/Tools/` — 工具
- `Sprite Textures/Trees/` — 树木
- `Sprite Textures/UI/` — UI 元素
- `Output Textures/` — 打包大图

### Sounds
- `AmbientSounds/` — 环境音
- `Effects/Crops/` — 作物音效
- `Effects/Footstep/` — 脚步声
- `Effects/Pickup/` — 拾取音
- `Effects/Tools/` — 工具音
- `Music/` — 2 首 BGM（.ogg）

**搬运映射**：Sprites → `public/assets/images/`；Sounds → `public/assets/audio/`

---

## 素材 — 杂项

- `Icons 2D/` — 431 张 2D 图标（道具、技能等）
- `NPC/` — NPC 素材（GIF + PNG）
- 其余子目录含各种特效/动画素材

**搬运映射**：`素材/Icons 2D/**` → `public/assets/images/icons/`

---

## 音效库 — 分类音效

### 界面音效 (`I 界面/`)
- PickUp、提示音、用户确认、菜单滚动等

### J~N 类音效 (`J~N类音效/`)
- 按材质/类型细分：鞭、木、水、火、岩石、冰、闪电、风、爆炸等
- 各类型下按动作细分：施法、打击、挥动等

### 环境音 (`环境/`)
- `01移动状态/` — 硬地、雪地、积水、沙石、泥地、树叶
- `02普通环境声/`、`03特殊环境声/`
- 森林、沙漠、洞穴、海洋等

### 动物音效 (`动物/`)
- `01小型动物/` — 蝙蝠、蜘蛛、鸟类、昆虫等
- `02中型动物/` — 狼、熊、野猪、鹿等
- `03大型动物/` — 大象、犀牛等
- `04巨型动物/` — 巨龙等

### 怪物音效 (`怪物/`)
- `01小型怪物/` — 哥布林、骷髅等
- `02中型怪物/` — 食人魔、僵尸等
- `03大型怪物/` — 巨人、石头怪等
- `04巨型怪物/` — 泰坦等

### 人物对话/配音 (`04人物配音/`)
- 大量魔兽3风格语音（多语种、多角色）

**搬运映射**：`音效库/**` → `public/assets/audio/sfx/`

---

## 项目资源目录规范

搬运目标路径：

```
public/assets/
├── images/
│   ├── characters/      # 角色动画帧
│   ├── environment/     # 场景、建筑、瓦片
│   ├── icons/           # 道具/技能图标
│   ├── ui/              # UI 背景、元素
│   └── farm/            # 农场RPG素材
├── audio/
│   ├── bgm/             # 背景音乐
│   └── sfx/             # 音效
└── fonts/               # 字体
```
