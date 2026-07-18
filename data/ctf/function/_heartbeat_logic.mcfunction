# 有玩家持正版旗 → 重置离线计时
execute if entity @a[hasitem={item=minecraft:diamond,components={"minecraft:custom_data":{"ctf_flag":1b,"flag_unique_uuid:#unique_id}}}] run scoreboard players set #off_tick flag_off_tick 0
# 无持旗人，计时+1刻
execute unless entity @a[hasitem={item=minecraft:diamond,components={"minecraft:custom_data":{"ctf_flag":1b,"flag_unique_uuid:#unique_id}}}] run scoreboard players add #off_tick flag_off_tick 1

# 换算剩余秒数
scoreboard players operation #hb_sec flag_posX = #hb_limit hb_threshold - #off_tick flag_off_tick
scoreboard players operation #hb_sec flag_posX /= #hb_div flag_posY

# 心跳倒计时提示
execute if score #hb_sec flag_posX matches 10.. run title @a actionbar {"text":"🏴旗帜离线倒计时：#hb_sec 秒，请防守方取回旗帜","color":"yellow"}
execute if score #hb_sec flag_posX matches 0..9 run title @a actionbar {"text":"⚠️旗帜即将失活！仅剩#hb_sec 秒！","color":"orange","bold":true}

# 超时直接进攻胜利
execute if score #off_tick flag_off_tick >= #hb_limit hb_threshold run function ctf:end_win_attack