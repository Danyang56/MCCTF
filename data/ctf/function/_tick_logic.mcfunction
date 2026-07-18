# 未开局直接跳过所有逻辑
execute unless score #game ctf_game matches 1 run return

# ========== 1. 全局倒计时扣除 ==========
# ctf_time 单位为刻，每刻减1；显示时转换为秒
scoreboard players remove #time ctf_time 1
scoreboard players operation #time_sec ctf_time_sec = #time ctf_time
scoreboard players operation #time_sec ctf_time_sec /= #hb_div hb_div
execute if score #time ctf_time matches ..0 run function ctf:end_win_defend
scoreboard objectives setdisplay list ctf_time_sec

# 最后30秒红色警告ActionBar
execute if score #time ctf_time matches 0..600 run title @a actionbar {"text":"⚠️ 比赛剩余时间：","color":"red","bold":true,"extra":[{"score":{"name":"#time_sec","objective":"ctf_time_sec"}},{"text":" 秒 ⚠️"}]}
execute if score #time ctf_time matches 601.. run title @a actionbar {"text":""}

# ========== 2. 进攻方持有正版旗直接胜利 ==========
execute as @a[team=ctf_attack] if items entity @s container.* minecraft:diamond[custom_data={ctf_flag:1b}] run function ctf:end_win_attack
execute as @a[team=ctf_attack] if items entity @s weapon.* minecraft:diamond[custom_data={ctf_flag:1b}] run function ctf:end_win_attack

# ========== 3. 正版旗帜全部消失则进攻胜利 ==========
scoreboard players set #found flag_holder 0
execute as @a if items entity @s container.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1
execute as @a if items entity @s weapon.* minecraft:diamond[custom_data={ctf_flag:1b}] run scoreboard players set #found flag_holder 1
execute if score #found flag_holder matches 0 unless entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] unless entity @e[type=minecraft:item_frame,nbt={Item:{id:"minecraft:diamond",components:{"minecraft:custom_data":{ctf_flag:1b}}}}] run function ctf:end_win_attack

# ========== 4. 正版旗存入私人末影箱（竞技模式）进攻胜利 ==========
execute if score #ec_rule enderchest_flag_rule matches 1 as @a if items entity @s enderchest.* minecraft:diamond[custom_data={ctf_flag:1b}] run function ctf:end_win_attack

# ========== 5. 旗帜心跳计时逻辑（神仙模式关闭则运行） ==========
execute unless score #god_dis god_disable_tracking matches 1 if score #hb_switch flag_heartbeat_switch matches 1 run function ctf:_heartbeat_logic

# ========== 6. 烫手/全域追踪逻辑（神仙模式关闭则运行） ==========
execute unless score #god_dis god_disable_tracking matches 1 if score #switch hotpotato_switch matches 1 run function ctf:_hot_potato_tick
execute unless score #god_dis god_disable_tracking matches 1 unless score #switch hotpotato_switch matches 1 if score #trackall flag_track_all_state matches 1 run function ctf:_hot_potato_tick
