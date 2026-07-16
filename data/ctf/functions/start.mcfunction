function ctf:reset
scoreboard players set #game ctf_game 1
scoreboard players set #time ctf_time 300

# 生成本局唯一随机ID
scoreboard players set #unique_id flag_unique_id 0
scoreboard players random #unique_id flag_unique_id 1 99999

# 清空上局残留所有旗帜
clear @a minecraft:diamond[custom_data={ctf_flag:1b}]
kill @e[type=item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{"ctf_flag":1b}}}}]
kill @e[type=item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{"ctf_flag":1b}}}}]

# 随机给一名防守玩家发放正版旗帜
execute @a[team=ctf_defend,sort=random,limit=1] run give @s minecraft:diamond[custom_data={ctf_flag:1b,flag_unique_uuid:#unique_id},display={Name:'{"text":"夺旗赛旗帜","color":"gold","bold":true}'}]

# 聊天栏广播
tellraw @a {"text":"=====夺旗赛开始=====","color":"yellow"}
tellraw @a {"text":"进攻方夺取正版旗帜或使其销毁即可获胜","color":"red"}
tellraw @a {"text":"旗帜离线超时/存入私人末影箱也会直接判定进攻胜利","color":"gray"}

# 开局全屏Title
title @a times 20 80 20
title @a title {"text":"夺旗赛开战！","color":"gold","bold":true}
title @a subtitle {"text":"进攻夺取旗帜｜守方坚持到时限","color":"white"}
