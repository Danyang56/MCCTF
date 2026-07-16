scoreboard players set #god godmode_switch 1
scoreboard players set #god_dis god_disable_tracking 1

# 关闭所有自动辅助
scoreboard players set #switch hotpotato_switch 0
scoreboard players set #trackall flag_track_all_state 0
scoreboard players set #hb_switch flag_heartbeat_switch 0

# 清除辅助效果实体
effect clear @a minecraft:glow
kill @e[type=text_display,tag=ctf_flag_head_tag]
kill @e[type=marker,tag=flag_tracker]
clear @a[team=ctf_attack] minecraft:compass{components:{"minecraft:custom_data":{"ctf_track_flag":1b}}}

# 全员OP
op @a

tellraw @a {"text":"==== 神仙打架模式已开启 ====","color":"purple","bold":true}
tellraw @a {"text":"1. 烫手、指南针、心跳、自动追踪全部失效","color":"white"}
tellraw @a {"text":"2. 全员获得OP权限，手动指令检索正版旗帜博弈","color":"light_purple"}
tellraw @a {"text":"3. 底层胜负、正版UID校验规则永久生效不可绕过","color":"red"}
title @a actionbar {"text":"神仙模式：无自动追踪，自行指令搜旗","color":"purple","bold":true}
