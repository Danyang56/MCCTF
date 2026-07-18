# 重置持旗标记、坐标缓存
scoreboard players set @a flag_holder 0
scoreboard players set #flagX flag_posX 0
scoreboard players set #flagY flag_posY 0
scoreboard players set #flagZ flag_posZ 0

# 标记持正版旗玩家
execute as @a if items entity @s container.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set @s flag_holder 1
execute as @a if items entity @s weapon.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set @s flag_holder 1

# 持旗发光，无粒子
effect give @a[scores={flag_holder=1}] minecraft:glow infinite 0 true
effect clear @a[scores={flag_holder=0}] minecraft:glow

# 刷新持旗头顶悬浮文字
kill @e[type=minecraft:text_display,tag=ctf_flag_head_tag]
execute as @a[scores={flag_holder=1}] at @s run summon minecraft:text_display ~ ~2.2 ~ {Tags:["ctf_flag_head_tag"],text:'{"text":"🏴 持旗者 🏴","color":"gold","bold":true}',background:0,see_through:1b,shadow:1b}

# 捕获地面正版旗坐标
execute store result score #flagX flag_posX run data get entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[0] 1
execute store result score #flagY flag_posY run data get entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[1] 1
execute store result score #flagZ flag_posZ run data get entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[2] 1

# 捕获展示框正版旗坐标
execute store result score #flagX flag_posX run data get entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[0] 1
execute store result score #flagY flag_posY run data get entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[1] 1
execute store result score #flagZ flag_posZ run data get entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},limit=1] Pos[2] 1

# 发放进攻方追踪指南针
clear @a minecraft:compass[custom_data={ctf_track_flag:1b}]
give @a minecraft:compass[custom_data={ctf_track_flag:1b},item_name={"text":"夺旗追踪指南针","color":"red","italic":false}]

# 刷新追踪marker，优先级：玩家持旗 > 地面掉落 > 展示框，自动选最近
kill @e[type=minecraft:marker,tag=flag_tracker]
summon minecraft:marker 0 64 0 {Tags:["flag_tracker"]}

execute if entity @a[scores={flag_holder=1},limit=1] run tp @e[type=minecraft:marker,tag=flag_tracker,limit=1] @a[scores={flag_holder=1},sort=nearest,limit=1]
execute unless entity @a[scores={flag_holder=1}] if entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] run tp @e[type=minecraft:marker,tag=flag_tracker,limit=1] @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},sort=nearest,limit=1]
execute unless entity @a[scores={flag_holder=1}] unless entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] if entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] run tp @e[type=minecraft:marker,tag=flag_tracker,limit=1] @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}},sort=nearest,limit=1]

# 无任何正版旗则删除marker
scoreboard players set #found flag_holder 0
execute as @a if items entity @s container.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1
execute as @a if items entity @s weapon.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1
execute if score #found flag_holder matches 0 unless entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] unless entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] run kill @e[type=minecraft:marker,tag=flag_tracker]
