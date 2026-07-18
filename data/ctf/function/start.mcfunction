function ctf:reset
scoreboard players set #game ctf_game 1
# 300秒 = 6000刻
scoreboard players set #time ctf_time 6000

# 生成本局唯一随机ID (Java版)
execute store result score #unique_id flag_unique_id run random value 1..99999

# 把随机ID写入 storage，供宏函数使用
execute store result storage ctf:temp id int 1 run scoreboard players get #unique_id flag_unique_id

# 清空上局残留所有旗帜
clear @a minecraft:diamond[custom_data={ctf_flag:1b}]
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]
kill @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]

# 调用宏函数给随机防守玩家发正版旗
execute as @a[team=ctf_defend,sort=random,limit=1] run function ctf:give_flag with storage ctf:temp

# 聊天栏广播 (保持不变)
tellraw @a {"text":"=====夺旗赛开始=====","color":"yellow"}
tellraw @a {"text":"进攻方夺取正版旗帜或使其销毁即可获胜","color":"red"}
tellraw @a {"text":"旗帜离线超时/存入私人末影箱也会直接判定进攻胜利","color":"gray"}

# 开局全屏Title (保持不变)
title @a times 20 80 20
title @a title {"text":"夺旗赛开战！","color":"gold","bold":true}
title @a subtitle {"text":"进攻夺取旗帜｜守方坚持到时限","color":"white"}