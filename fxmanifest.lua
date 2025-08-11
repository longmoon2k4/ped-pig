fx_version 'cerulean'
game 'gta5'

author 'longmoon2k4'
description 'Resource thêm ped con heo (a_c_pig) cho FiveM.'
version '1.0.0'

files {
    'peds.meta',
    'stream/a_c_pig.ydd',
    'stream/a_c_pig.yft',
    'stream/a_c_pig.ymt',
    'stream/a_c_pig.ytd'
}

data_file 'PED_METADATA_FILE' 'peds.meta'

replace_ped 'a_c_pig'

client_script 'client.lua'