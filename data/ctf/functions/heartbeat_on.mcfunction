scoreboard players set #hb_switch flag_heartbeat_switch 1
scoreboard players set #off_tick flag_off_tick 0
tellraw @a {"text":"【旗帜心跳开启】正版旗离线满60秒直接进攻胜利","color":"gold"}
title @a actionbar {"text":"旗帜心跳：已激活，不可长期藏容器固守","color":"yellow"}
