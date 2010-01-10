-- AllPlayed-zhCN.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.zhCN	= ("$Revision$"):match("(%d+)")

local L = LibStub("AceLocale-3.0"):NewLocale("AllPlayed", "zhCN")
if not L then return end

-- This is only a place-holder for future possible localisation files

-- Faction names 
--        L["Alliance"]                                            	= "联盟"
--        L["Horde"]                                               	= "部落" 

-- Tablet title
--        L["All Played Breakdown"]                                	= true, 

-- Menus
--    	L["AllPlayed Configuration"]					= true,
L["Display"]                                             	= "AllPlayed 设置" 
L["Set the display options"]                             	= "显示" 
L["All Factions"]                                        	= "所有阵营" 
L["All factions will be displayed"]                      	= "显示所有阵营" 
L["All Realms"]                                          	= "所有服务器" 
L["All realms will de displayed"]                        	= "显示所有服务器" 
L["Show Seconds"]                                        	= "显示秒数" 
L["Display the seconds in the time strings"]             	= "在时间串中显示秒数" 
L["Show Gold"]                                    		= "显示金钱"
L["Display the gold each character pocess"]     			= "显示所有角色的金钱"
L["Show XP Progress"]                                    	= "显示经验值"
L["Display XP progress as a decimal value appended to the level"]       	= "显示升级所需经验值"
L["Show XP total"]						= "显示全部经验值"
L["Show the total XP for all characters"]			= "显示所有角色的全部经验值"
L["Rested XP"]                                           	= "双倍经验值"
L["Set the rested XP options"]                                   = "双倍经验值设置"
L["Rested XP Total"]                                             = "全部双倍经验值"
L["Show the character rested XP"]                                = "显示角色的双倍经验值"
L["Percent Rest"]                                                = "双倍经验值的百分比" 
L["Set the base for % display of rested XP"]                     = "用百分比显示双倍经验值" 
L["Rested XP Countdown"]                                         = "双倍经验值倒数计秒"
L["Show the time remaining before the character is 100% rested"] = "显示角色达到100%双倍经验值前所剩的时间"
L["Show Class Name"]                                     	= "显示角色职业"
L["Show the character class beside the level"]           	= "在级别旁边显示角色职业"
L["Show Location"]						= "显示位置"
L["Show the character location"]					= "显示角色所处位置"
L["Don't show location"]						= "不显示位置"
L["Show zone"]							= "显示地区"
L["Show subzone"]						= "显示子地区"
L["Show zone/subzone"]						= "显示地区/子地区"
L["Colorize Class"]                                      	= "职业颜色"
L["Colorize the character name based on class"]          	= "使用职业颜色"
L["Use Old Shaman Colour"]					= "萨满祭司使用老的职业颜色"
L["Use the pre-210 patch colour for the Shaman class"]		= "不选则萨满祭司使用新的职业颜色"
L["Sort Type"]							= "排序"
L["Select the sort type"]					= "选择排序依据"
L["By name"]							= "名字"
L["By level"]							= "级别"
L["By experience"]						= "经验"
L["By rested XP"]						= "双倍经验"
L["By % rested"]							= "双倍经验百分比"
L["By money"]							= "金钱"
L["By time played"]						= "在线时间"
L["Sort in reverse order"]					= "反向排序"
L["Use the curent sort type in reverse order"]			= "按当前排序依据反向排序"
L["Font Size"]							= "字体大小"
L["Select the font size"]					= "选择字体大小"
L["Opacity"]      						= "不透明度"
L["% opacity of the tooltip background"]				= "显示信息背景不透明度"
L["Sort"]							= "排序"
L["Set the sort options"]					= "排序设置"
L["Ignore Characters"]                                      	= "忽略角色" 
L["Hide characters from display"]                           	= "隐藏角色显示" 
L["Hide %s of %s from display"]					= "隐藏 %s of %s"
L["BC Installed?"]                                          	= "燃烧的远征" 
L["Is the Burning Crusade expansion installed?"]            	= "是否安装了燃烧的远征？" 
L["Close"]                                               	= "关闭" 
L["Close the tooltip"]                                   	= "关闭显示信息" 
L["None"]                                                	= "无"

-- Strings
--        L["v%s - %s (Type /ap for help)"]                        	= true, 
L["%s characters "]                                      	= "%s 角色" 
L["%d rested XP"]                                     		= "%d 双倍经验值" 
L["rested"]                                       		= "精力充沛" 
L["Total %s Time Played: "]                              	= "%s 所有角色在线时间" 
L["Total %s Cash Value: "]                               	= "%s 所有角色金币" 
L["Total Time Played: "]                                 	= "所有在线时间" 
L["Total Cash Value: "]                                  	= "所有金币" 
L["Total XP: "]							= "所有经验"
L["Unknown"]							= "未知目标"
L["%.1f M XP"]							= "%.1f 百万经验"
L["%.1f K XP"]							= "%.1f 千经验"
L["%d XP"]							= "%d 经验"

-- Console commands
--        L["/allplayed"]                                          	= true, 
--        L["/ap"]                                                 	= true, 
--        L["/allplayedcl"]                                          	= true, 
--        L["/apcl"]                                                 	= true, 

