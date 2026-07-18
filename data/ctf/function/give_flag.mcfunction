# 先把存储中的 id 更新为记分板的随机值
execute store result storage ctf:temp id int 1 run scoreboard players get #unique_id flag_unique_id

# 发放旗帜，$(id) 会被替换为实际随机数
$give @s minecraft:diamond[
    components={
        "minecraft:custom_data": {
            "ctf_flag": 1b,
            "flag_unique_uuid": $(id)
        },
        "minecraft:display": {"Name": "{\"text\":\"夺旗赛旗帜\",\"color\":\"gold\",\"bold\":true}"}
    }
]