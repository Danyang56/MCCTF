scoreboard players set #game ctf_game 0
tellraw @a {"text":"【比赛结束】时间耗尽，防守方守住正版旗帜，获胜！","color":"green","bold":true}

# 胜利Title与音效
title @a times 20 120 30
title @a title {"text":"防守方胜利！","color":"green","bold":true}
title @a subtitle {"text":"旗帜完整保存至时限结束","color":"lime"}
playsound entity.ender_dragon.death master @a ~ ~ ~ 1 1

# 清理全部旗帜
clear @a minecraft:diamond[custom_data={ctf_flag:1b}]
kill @e[type=item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{"ctf_flag":1b}}}}]
kill @e[type=item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{"ctf_flag":1b}}}}]
