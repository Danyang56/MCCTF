# 队伍创建
team add ctf_defend "防守方"
team modify ctf_defend color green
team add ctf_attack "进攻方"
team modify ctf_attack color red

# 基础游戏状态记分板
scoreboard objectives add ctf_game dummy 游戏状态
scoreboard objectives add ctf_time dummy 剩余时间
scoreboard players set #game ctf_game 0

# 烫手山芋开关
scoreboard objectives add hotpotato_switch dummy
scoreboard players set #switch hotpotato_switch 0
scoreboard objectives add flag_holder dummy

# 全域追踪开关 + 坐标缓存
scoreboard objectives add flag_track_all_state dummy
scoreboard players set #trackall flag_track_all_state 0
scoreboard objectives add flag_posX dummy
scoreboard objectives add flag_posY dummy
scoreboard objectives add flag_posZ dummy
scoreboard players set #flagX flag_posX 0
scoreboard players set #flagY flag_posY 0
scoreboard players set #flagZ flag_posZ 0

# 旗帜心跳机制
scoreboard objectives add flag_heartbeat_switch dummy
scoreboard players set #hb_switch flag_heartbeat_switch 0
scoreboard objectives add flag_off_tick dummy
scoreboard players set #off_tick flag_off_tick 0
scoreboard objectives add hb_threshold dummy
scoreboard players set #hb_limit hb_threshold 1200
scoreboard objectives add hb_sec dummy
scoreboard objectives add hb_div dummy
scoreboard players set #hb_div flag_posY 20

# 末影箱规则
scoreboard objectives add enderchest_flag_rule dummy
scoreboard players set #ec_rule enderchest_flag_rule 1

# 神仙模式开关
scoreboard objectives add godmode_switch dummy
scoreboard players set #god godmode_switch 0
scoreboard objectives add god_disable_tracking dummy
scoreboard players set #god_dis god_disable_tracking 0

# 旗帜唯一ID防复制
scoreboard objectives add flag_unique_id dummy
scoreboard players set #unique_id flag_unique_id 0