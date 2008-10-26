-- AllPlayed-zhCN.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.zhCN	= ("$Revision$"):match("(%d+)")

local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("zhCN", function()
    return {

        -- Faction names 
--        ["Alliance"]                                            	= "联盟",
--        ["Horde"]                                               	= "部落", 

        -- Tablet title
--        ["All Played Breakdown"]                                	= true, 

        -- Menus
--    	["AllPlayed Configuration"]					= true,
        ["Display"]                                             	= "AllPlayed 设置", 
        ["Set the display options"]                             	= "显示", 
        ["All Factions"]                                        	= "所有阵营", 
        ["All factions will be displayed"]                      	= "显示所有阵营", 
        ["All Realms"]                                          	= "所有服务器", 
        ["All realms will de displayed"]                        	= "显示所有服务器", 
        ["Show Seconds"]                                        	= "显示秒数", 
        ["Display the seconds in the time strings"]             	= "在时间串中显示秒数", 
        ["Show Gold"]                                    		= "显示金钱",
        ["Display the gold each character pocess"]     			= "显示所有角色的金钱",
        ["Show XP Progress"]                                    	= "显示经验值",
        ["Display the level fraction based on current XP"]       	= "显示升级所需经验值",
        ["Show XP total"]						= "显示全部经验值",
        ["Show the total XP for all characters"]			= "显示所有角色的全部经验值",
        ["Rested XP"]                                           	= "双倍经验值",
        ["Set the rested XP options"]                                   = "双倍经验值设置",
        ["Rested XP Total"]                                             = "全部双倍经验值",
        ["Show the character rested XP"]                                = "显示角色的双倍经验值",
        ["Percent Rest"]                                                = "双倍经验值的百分比", 
        ["Set the base for % display of rested XP"]                     = "用百分比显示双倍经验值", 
        ["Rested XP Countdown"]                                         = "双倍经验值倒数计秒",
        ["Show the time remaining before the character is 100% rested"] = "显示角色达到100%双倍经验值前所剩的时间",
        ["Show Class Name"]                                     	= "显示角色职业",
        ["Show the character class beside the level"]           	= "在级别旁边显示角色职业",
        ["Show Location"]						= "显示位置",
        ["Show the character location"]					= "显示角色所处位置",
        ["Don't show location"]						= "不显示位置",
        ["Show zone"]							= "显示地区",
        ["Show subzone"]						= "显示子地区",
        ["Show zone/subzone"]						= "显示地区/子地区",
        ["Colorize Class"]                                      	= "职业颜色",
        ["Colorize the character name based on class"]          	= "使用职业颜色",
        ["Use Old Shaman Colour"]					= "萨满祭司使用老的职业颜色",
        ["Use the pre-210 patch colour for the Shaman class"]		= "不选则萨满祭司使用新的职业颜色",
        ["Sort Type"]							= "排序",
        ["Select the sort type"]					= "选择排序依据",
        ["By name"]							= "名字",
        ["By level"]							= "级别",
        ["By experience"]						= "经验",
        ["By rested XP"]						= "双倍经验",
        ["By % rested"]							= "双倍经验百分比",
        ["By money"]							= "金钱",
        ["By time played"]						= "在线时间",
        ["Sort in reverse order"]					= "反向排序",
        ["Use the curent sort type in reverse order"]			= "按当前排序依据反向排序",
        ["Font Size"]							= "字体大小",
        ["Select the font size"]					= "选择字体大小",
        ["Opacity"]      						= "不透明度",
        ["% opacity of the tooltip background"]				= "显示信息背景不透明度",
        ["Sort"]							= "排序",
        ["Set the sort options"]					= "排序设置",
        ["Ignore Characters"]                                      	= "忽略角色", 
        ["Hide characters from display"]                           	= "隐藏角色显示", 
        ["Hide %s of %s from display"]					= "隐藏 %s of %s",
        ["BC Installed?"]                                          	= "燃烧的远征", 
        ["Is the Burning Crusade expansion installed?"]            	= "是否安装了燃烧的远征？", 
        ["Close"]                                               	= "关闭", 
        ["Close the tooltip"]                                   	= "关闭显示信息", 
        ["None"]                                                	= "无",

        -- Strings
--        ["v%s - %s (Type /ap for help)"]                        	= true, 
        ["%s characters "]                                      	= "%s 角色", 
        ["%d rested XP"]                                     		= "%d 双倍经验值", 
        ["rested"]                                       		= "精力充沛", 
        ["Total %s Time Played: "]                              	= "%s 所有角色在线时间", 
        ["Total %s Cash Value: "]                               	= "%s 所有角色金币", 
        ["Total Time Played: "]                                 	= "所有在线时间", 
        ["Total Cash Value: "]                                  	= "所有金币", 
        ["Total XP: "]							= "所有经验",
        ["Unknown"]							= "未知目标",
        ["%.1f M XP"]							= "%.1f 百万经验",
        ["%.1f K XP"]							= "%.1f 千经验",
        ["%d XP"]							= "%d 经验",

        -- Console commands
--        ["/allplayed"]                                          	= true, 
--        ["/ap"]                                                 	= true, 
--        ["/allplayedcl"]                                          	= true, 
--        ["/apcl"]                                                 	= true, 

    }
end)
