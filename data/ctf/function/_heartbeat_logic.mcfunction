# 检查是否有玩家持正版旗
scoreboard players set #found flag_holder 0
execute as @a if items entity @s container.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1
execute as @a if items entity @s weapon.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1

# 有玩家持正版旗 → 重置离线计时；无持旗人，计时+1刻
execute if score #found flag_holder matches 1 run scoreboard players set #off_tick flag_off_tick 0
execute unless score #found flag_holder matches 1 run scoreboard players add #off_tick flag_off_tick 1

# 换算剩余秒数
scoreboard players operation #hb_sec hb_sec = #hb_limit hb_threshold
scoreboard players operation #hb_sec hb_sec -= #off_tick flag_off_tick
scoreboard players operation #hb_sec hb_sec /= #hb_div hb_div

# 心跳倒计时提示
execute if score #hb_sec hb_sec matches 10.. run title @a actionbar {"text":"🏴旗帜离线倒计时：","color":"yellow","extra":[{"score":{"name":"#hb_sec","objective":"hb_sec"}},{"text":" 秒，请防守方取回旗帜"}]}
execute if score #hb_sec hb_sec matches 0..9 run title @a actionbar {"text":"⚠️旗帜即将失活！仅剩","color":"orange","bold":true,"extra":[{"score":{"name":"#hb_sec","objective":"hb_sec"}},{"text":" 秒！"}]}

# 超时直接进攻胜利
execute if score #off_tick flag_off_tick >= #hb_limit hb_threshold run function ctf:end_win_attack
