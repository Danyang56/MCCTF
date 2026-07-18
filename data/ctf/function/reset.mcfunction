# 全局状态重置
scoreboard players set #game ctf_game 0
scoreboard players set #time ctf_time 0

# 清空上局残留所有旗帜
clear @a minecraft:diamond[custom_data={ctf_flag:1b}]
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]
kill @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}]

# 清空队伍
team empty ctf_defend
team empty ctf_attack

# 关闭全部机制开关
scoreboard players set #switch hotpotato_switch 0
scoreboard players set #trackall flag_track_all_state 0
scoreboard players set #hb_switch flag_heartbeat_switch 0
scoreboard players set #ec_rule enderchest_flag_rule 1
scoreboard players set #god godmode_switch 0
scoreboard players set #god_dis god_disable_tracking 0

# 清除追踪实体、发光、悬浮文字
effect clear @a minecraft:glow
clear @a minecraft:compass[custom_data={ctf_track_flag:1b}]
kill @e[type=minecraft:marker,tag=flag_tracker]
kill @e[type=minecraft:text_display,tag=ctf_flag_head_tag]

# 心跳、唯一ID重置
scoreboard players set #off_tick flag_off_tick 0
scoreboard players set #unique_id flag_unique_id 0

# 清空持旗标记
scoreboard players reset * flag_holder

tellraw @a {"text":"夺旗赛已全部重置，可重新开局","color":"aqua"}