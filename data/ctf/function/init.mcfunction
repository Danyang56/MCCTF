# 队伍创建（1.21 team指令无改动，书写规范不变）
team add ctf_defend "防守方"
team modify ctf_defend color green
team add ctf_attack "进攻方"
team modify ctf_attack color red

# 基础游戏状态记分板
scoreboard objectives add ctf_game dummy "游戏状态"
scoreboard objectives add ctf_time dummy "剩余时间"
scoreboard players set #game ctf_game 0

# 烫手山芋开关
scoreboard objectives add hotpotato_switch dummy "烫手山芋总开关"
scoreboard players set #switch hotpotato_switch 0
scoreboard objectives add flag_holder dummy "持旗玩家标记"

# 全域追踪开关 + 坐标缓存记分板
scoreboard objectives add flag_track_all_state dummy "全域追踪开关"
scoreboard players set #trackall flag_track_all_state 0
scoreboard objectives add flag_posX dummy "旗帜X坐标缓存"
scoreboard objectives add flag_posY dummy "旗帜Y坐标缓存"
scoreboard objectives add flag_posZ dummy "旗帜Z坐标缓存"
scoreboard players set #flagX flag_posX 0
scoreboard players set #flagY flag_posY 0
scoreboard players set #flagZ flag_posZ 0

# 旗帜心跳机制记分板（新增常量提前定义，规避除法读取空值报错）
scoreboard objectives add flag_heartbeat_switch dummy "心跳机制开关"
scoreboard players set #hb_switch flag_heartbeat_switch 0
scoreboard objectives add flag_off_tick dummy "旗帜离线计时刻数"
scoreboard players set #off_tick flag_off_tick 0
scoreboard objectives add hb_threshold dummy "心跳超时阈值(刻)"
scoreboard players set #hb_limit hb_threshold 1200
scoreboard objectives add hb_sec dummy "心跳剩余秒数缓存"
scoreboard objectives add hb_div dummy "刻转秒除数(20刻=1秒)"
scoreboard players set #hb_div hb_div 20

# 末影箱胜负规则开关
scoreboard objectives add enderchest_flag_rule dummy "末影箱存旗惩罚开关"
scoreboard players set #ec_rule enderchest_flag_rule 1

# 神仙打架模式总开关
scoreboard objectives add godmode_switch dummy "神仙模式总开关"
scoreboard players set #god godmode_switch 0
scoreboard objectives add god_disable_tracking dummy "神仙模式关闭自动追踪标记"
scoreboard players set #god_dis god_disable_tracking 0

# 本局旗帜唯一随机ID存储记分板
scoreboard objectives add flag_unique_id dummy "本局正版旗帜唯一UID"
scoreboard players set #unique_id flag_unique_id 0