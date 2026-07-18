scoreboard players set #game ctf_game 0

# 区分失败原因提示
execute as @a if items entity @s enderchest.* minecraft:diamond[custom_data={ctf_flag:1b}] run tellraw @a {"text":"判定原因：防守方将正版旗帜存入私人末影箱，无法被进攻获取！","color":"orange"}

tellraw @a {"text":"【比赛结束】进攻方成功夺得/销毁正版旗帜，获胜！","color":"red","bold":true}

# 胜利Title与音效
title @a times 20 120 30
title @a title {"text":"进攻方胜利！","color":"red","bold":true}
title @a subtitle {"text":"旗帜已被夺取或销毁","color":"red"}
playsound minecraft:entity.ender_dragon.death master @a ~ ~ ~ 1 1

# 清理全部旗帜
clear @a minecraft:diamond[custom_data={ctf_flag:1b}]
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]
kill @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]