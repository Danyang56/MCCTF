# Java版 Minecraft 1.21 CTF 数据包参考文档

本 skill 汇总了维护这个 Java版 Minecraft 1.21 夺旗（CTF）数据包时必须查阅的权威文档与常见陷阱。后续任何开发者或 agent 在修改 `data/ctf/function` 下的 `.mcfunction` 文件前，请先阅读本文件。

## 1. 目标版本

- **Minecraft Java Edition 1.21**（具体适配 1.20.5+ 的组件化指令体系）。
- `pack_format` 当前为 **48**（对应 1.21）。
- 函数目录已按 1.21 规范改为单数 `data/ctf/function`，标签目录为 `data/ctf/tags/function`。

## 2. 权威参考文档（按查阅优先级）

### 2.1 指令与数据包核心

1. [Minecraft Wiki / Commands](https://minecraft.wiki/w/Commands) — 所有命令总览。
2. [Minecraft Wiki / Commands/execute](https://minecraft.wiki/w/Commands/execute) — `execute` 子命令全集，尤其关注：
   - `execute if items entity <source> <slots> <item_predicate>`
   - `execute store result score ... run data get entity ...`
   - Java 版没有 `||` / `&&` 逻辑运算符，需用多个 `if`/`unless` 或计分板组合。
3. [Minecraft Wiki / Data component format](https://minecraft.wiki/w/Data_component_format) — 1.20.5+ 物品组件（替代旧 NBT）的完整列表与示例。
4. [Minecraft Wiki / Function (Java Edition)](https://minecraft.wiki/w/Function_(Java_Edition)) — `.mcfunction` 文件格式、宏函数（`$` 开头）、返回值、长度限制。
5. [Minecraft Wiki / Data pack](https://minecraft.wiki/w/Data_pack) — `pack.mcmeta`、pack_format、目录结构。

### 2.2 常用组件速查

- 自定义数据：`minecraft:custom_data={ctf_flag:1b}`
- 物品名称（默认/不可铁砧修改）：`minecraft:item_name={text:"名称",color:"gold"}`
- 玩家自定义名称（可铁砧，默认斜体）：`minecraft:custom_name={text:"名称",italic:false}`
- 旧版 `display:{Name:'...'}` 在 1.20.5+ 已不用于物品，应改为 `minecraft:item_name` 或 `minecraft:custom_name`。

### 2.3 选择器、NBT 与计分板

- [Minecraft Wiki / Target selectors](https://minecraft.wiki/w/Target_selectors) — `@a`、`@p`、`@s`、`@e` 及其参数。
- [Minecraft Wiki / Scoreboard](https://minecraft.wiki/w/Scoreboard) — `scoreboard players add/remove/set/operation/get`。
- [Minecraft Wiki / Raw JSON text format](https://minecraft.wiki/w/Raw_JSON_text_format) — `tellraw`、`title` 的文本组件，包括 `score` 组件显示计分板数值。
- [Minecraft Wiki / NBT path](https://minecraft.wiki/w/NBT_path) — `data get entity @s Pos[0]` 等路径语法。

## 3. 本项目高频陷阱

### 3.1 不要混用 Bedrock 语法

Java版 Minecraft 1.21 **没有**以下 Bedrock 专有写法：

- ❌ `hasitem={item=...,components=...,location=slot.enderchest}`
  - ✅ 改为 `execute if items entity @s container.* <item_predicate>` 或 `enderchest.*`。
- ❌ 选择器参数 `item=minecraft:diamond`（仅用于 `@e[type=item]`）
  - ✅ 改为 `nbt={Item:{id:"minecraft:diamond",components:{...}}}`。
- ❌ `execute if score A matches 1 || score B matches 1`
  - ✅ 改为多条 `execute` 或用计分板合并状态。

### 3.2 计分板只接受整数

- ❌ `scoreboard players remove #time ctf_time 0.05`
  - ✅ 改为每刻减 1，另用一个计分板保存“秒数”显示值（除以 20）。

### 3.3 动态 UUID 与 custom_data 的部分匹配

本数据包每局生成一个随机 `flag_unique_uuid` 并写入旗帜的 `minecraft:custom_data`：

```mcfunction
execute store result storage ctf:temp id int 1 run scoreboard players get #unique_id flag_unique_id
execute as @a[team=ctf_defend,sort=random,limit=1] run function ctf:give_flag with storage ctf:temp
```

`give_flag` 是宏函数，把 `$(id)` 展开为实际数字写入物品：

```mcfunction
$give @s minecraft:diamond[custom_data={ctf_flag:1b,flag_unique_uuid:$(id)},item_name={...}]
```

**运行时判定**：在 `execute if items`、`clear`、`@e[nbt={...}]` 等检查中，我们使用 `custom_data={ctf_flag:1b}`。`custom_data` 组件在 predicates 与 NBT 匹配中采用**部分匹配**（只要物品的 custom_data 包含指定的键值即匹配），因此即使旗帜还带有 `flag_unique_uuid` 也能被正确识别。因为 `reset` 和每局开局都会清理所有 `ctf_flag:1b` 物品，旧局旗帜不会残留，无需在每次检查中展开 UID。

如果你确实需要按完整 UID 精确匹配，请把 UUID 写入 storage 后调用宏函数，让 `$(id)` 展开到 NBT 或组件中。

### 3.4 实体 NBT 标签名

- ❌ `tag:"ctf_flag_head_tag"`
  - ✅ `Tags:["ctf_flag_head_tag"]`。
- ❌ `execute store result #flagX flag_posX run entity @e[type=item,limit=1] X`
  - ✅ `execute store result score #flagX flag_posX run data get entity @e[type=item,limit=1] Pos[0] 1`。

### 3.5 在 title / tellraw 中显示计分板数值

- ❌ `{"text":"剩余时间：#time 秒"}`（`#time` 只是纯文本）
- ✅ 使用 `score` 组件：

```json
{"score":{"name":"#time","objective":"ctf_time"}}
```

## 4. 验证流程

修改任何 `.mcfunction` 后，建议按以下顺序验证：

1. **语法自检**：确认没有使用 Bedrock 专属参数（`hasitem`、`location=slot.*`、`||` 等）。
2. **游戏内测试**：在单人创造档中执行 `/reload`，然后运行 `/function ctf:init` 与 `/function ctf:start`。
3. **关键路径测试**：
   - 开局是否正确给防守方发放唯一 UID 的旗帜。
   - 进攻方拾取旗帜是否立即判定进攻胜利。
   - 倒计时是否以秒为单位正常减少。
   - 旗帜销毁/超时/放入末影箱是否分别触发对应胜负。
4. **查看日志**：服务端 `latest.log` 或单人游戏输出会报告无法解析的命令行号。

## 5. 推荐辅助工具

- [Misode 数据包生成器](https://misode.github.io/) — 生成 predicate、loot table、advancement 等。
- [Minecraft Wiki 命令生成器](https://minecraft.wiki/w/Commands) 页面内的示例可直接复制。
- 游戏内 `/data get storage ctf:temp` 与 `/data get entity @s Inventory` 用于调试 storage 和 NBT。

---

**维护原则**：最小改动、保持原逻辑不变，只把不符合 Java版 Minecraft 1.21 语法的部分修正为等价的 Java 版写法。如有新增机制，必须同步更新 `README.md` 的管理员指令清单。
