-- AllPlayed-zhTW.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.zhTW	= ("$Revision$"):match("(%d+)")

local L = LibStub("AceLocale-3.0"):NewLocale("AllPlayed", "zhTW")
if not L then return end

-- Faction names 
--	L["Alliance"]								= "聯盟"
--	L["Horde"]								= "部落" 

-- Tablet title
--	L["All Played Breakdown"]						= true, 

-- Menus
L["AllPlayed Configuration"]						= "AllPlayed 設置"
L["Display"]								= "AllPlayed 設置" 
L["Set the display options"]						= "顯示" 
L["All Factions"]							= "所有陣營" 
L["All factions will be displayed"]					= "顯示所有陣營" 
L["All Realms"]								= "所有服務器" 
L["All realms will de displayed"]					= "顯示所有服務器" 
L["Show Seconds"]							= "顯示秒數" 
L["Display the seconds in the time strings"]				= "在時間串中顯示秒數" 
L["Show Gold"]								= "顯示金錢"
L["Display the gold each character pocess"]     				= "顯示所有角色的金錢"
L["Show XP Progress"]							= "顯示經驗值"
L["Display XP progress as a decimal value appended to the level"]       		= "顯示升級所需經驗值"
L["Show XP total"]							= "顯示全部經驗值"
L["Show the total XP for all characters"]				= "顯示所有角色的全部經驗值"
L["Rested XP"]								= "雙倍經驗值"
L["Set the rested XP options"]						= "雙倍經驗值設置"
L["Rested XP Total"]							= "全部雙倍經驗值"
L["Show the character rested XP"]					= "顯示角色的雙倍經驗值"
L["Percent Rest"]							= "雙倍經驗值的百分比" 
L["Set the base for % display of rested XP"]				= "用百分比顯示雙倍經驗值" 
L["Rested XP Countdown"]							= "雙倍經驗值倒數計秒"
L["Show the time remaining before the character is 100% rested"]		= "顯示角色達到100%雙倍經驗值前所剩的時間"
L["Show Class Name"]                                     		= "顯示角色職業"
L["Show the character class beside the level"]           		= "在級別旁邊顯示角色職業"
L["Show Location"]							= "顯示位置"
L["Show the character location"]						= "顯示角色所處位置"
L["Don't show location"]							= "不顯示位置"
L["Show zone"]								= "顯示地區"
L["Show subzone"]							= "顯示子地區"
L["Show zone/subzone"]							= "顯示地區/子地區"
L["Colorize Class"]                                      		= "職業顏色"
L["Colorize the character name based on class"]          		= "使用職業顏色."
L["Use Old Shaman Colour"]						= "薩滿使用舊的職業顏色"
L["Use the pre-210 patch colour for the Shaman class"]			= "不選則薩滿使用新的職業顏色"
L["Sort Type"]								= "排序"
L["Select the sort type"]						= "選擇排序依據"
L["By name"]								= "名字"
L["By level"]								= "級別"
L["By experience"]							= "經驗"
L["By rested XP"]							= "雙倍經驗"
L["By % rested"]								= "雙倍經驗百分比"
L["By money"]								= "金錢"
L["By time played"]							= "在線時間"
L["Sort in reverse order"]						= "反向排序"
L["Use the curent sort type in reverse order"]				= "按當前排序依據反向排序"
L["Font Size"]								= "字體大小"
L["Select the font size"]						= "選擇字體大小"
L["Opacity"]      							= "不透明度"
L["% opacity of the tooltip background"]					= "顯示信息背景不透明度"
L["Sort"]								= "排序"
L["Set the sort options"]						= "排序設置"
L["Ignore Characters"]                                      		= "忽略角色" 
L["Hide characters from display"]                           		= "隱藏角色顯示" 
L["Hide %s of %s from display"]						= "隱藏 %s of %s"
L["BC Installed?"]                                          		= "燃燒的遠征?" 
L["Is the Burning Crusade expansion installed?"]            		= "是否安裝了燃燒的遠征?" 
L["Close"]                                               		= "關閉" 
L["Close the tooltip"]                                   		= "關閉顯示信息" 
L["None"]                                                		= "無"

-- Strings
--	L["v%s - %s (Type /ap for help)"]                        		= true, 
L["%s characters "]                                      		= "%s 角色" 
L["%d rested XP"]							= "%d 雙倍經驗值" 
L["rested"]								= "精力充沛" 
L["Total %s Time Played: "]						= "%s 所有角色在線時間: " 
L["Total %s Cash Value: "]						= "%s 所有角色金幣: " 
L["Total Time Played: "]							= "所有在線時間: " 
L["Total Cash Value: "]							= "所有金幣: " 
L["Total XP: "]								= "所有經驗: "
L["Unknown"]								= "未知目標"
L["%.1f M XP"]								= "%.1f 百萬經驗"
L["%.1f K XP"]								= "%.1f 千經驗"
L["%d XP"]								= "%d 經驗"

-- Console commands
--	L["/allplayed"]								= true, 
--	L["/ap"]									= true, 
--	L["/allplayedcl"]							= true, 
--	L["/apcl"]								= true, 


