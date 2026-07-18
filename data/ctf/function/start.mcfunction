function ctf:reset
scoreboard players set #game ctf_game 1
scoreboard players set #time ctf_time 300

# 生成本局唯一随机ID (Java版)
scoreboard players set #unique_id flag_unique_id 0
random value 1..99999
execute store result score #unique_id flag_unique_id run random value 1..99999

# 清空上局残留所有旗帜
clear @a minecraft:diamond[components={"minecraft:custom_data":{"ctf_flag":1b}}]
kill @e[type=item,item=minecraft:diamond,nbt={Item:{components:{"minecraft:custom_data":{ctf_flag:1b}}}}]
kill @e[type=item_frame,nbt={Item:{components:{"minecraft:custom_data":{ctf_flag:1b}}}}]

# ⭐ 关键改动：将 give 指令改为调用宏函数
execute as @a[team=ctf_defend,sort=random,limit=1] run function ctf:give_flag with storage ctf:temp {id:-1}

# 聊天栏广播 (保持不变)
tellraw @a {"text":"=====夺旗赛开始=====","color":"yellow"}
tellraw @a {"text":"进攻方夺取正版旗帜或使其销毁即可获胜","color":"red"}
tellraw @a {"text":"旗帜离线超时/存入私人末影箱也会直接判定进攻胜利","color":"gray"}

# 开局全屏Title (保持不变)
title @a times 20 80 20
title @a title {"text":"夺旗赛开战！","color":"gold","bold":true}
title @a subtitle {"text":"进攻夺取旗帜｜守方坚持到时限","color":"white"}