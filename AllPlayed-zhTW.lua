-- AllPlayed-zhTW.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.zhTW	= ("$Revision$"):match("(%d+)")

local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("zhTW", function()
    return {
	-- Faction names 
--	["Alliance"]								= "聯盟",
--	["Horde"]								= "部落", 

	-- Tablet title
--	["All Played Breakdown"]						= true, 

        -- Menus
	["AllPlayed Configuration"]						= "AllPlayed 設置",
	["Display"]								= "AllPlayed 設置", 
	["Set the display options"]						= "顯示", 
	["All Factions"]							= "所有陣營", 
	["All factions will be displayed"]					= "顯示所有陣營", 
	["All Realms"]								= "所有服務器", 
	["All realms will de displayed"]					= "顯示所有服務器", 
	["Show Seconds"]							= "顯示秒數", 
	["Display the seconds in the time strings"]				= "在時間串中顯示秒數", 
	["Show Gold"]								= "顯示金錢",
	["Display the gold each character pocess"]     				= "顯示所有角色的金錢",
	["Show XP Progress"]							= "顯示經驗值",
	["Display XP progress as a decimal value appended to the level"]       		= "顯示升級所需經驗值",
	["Show XP total"]							= "顯示全部經驗值",
	["Show the total XP for all characters"]				= "顯示所有角色的全部經驗值",
	["Rested XP"]								= "雙倍經驗值",
	["Set the rested XP options"]						= "雙倍經驗值設置",
	["Rested XP Total"]							= "全部雙倍經驗值",
	["Show the character rested XP"]					= "顯示角色的雙倍經驗值",
	["Percent Rest"]							= "雙倍經驗值的百分比", 
	["Set the base for % display of rested XP"]				= "用百分比顯示雙倍經驗值", 
	["Rested XP Countdown"]							= "雙倍經驗值倒數計秒",
	["Show the time remaining before the character is 100% rested"]		= "顯示角色達到100%雙倍經驗值前所剩的時間",
	["Show Class Name"]                                     		= "顯示角色職業",
	["Show the character class beside the level"]           		= "在級別旁邊顯示角色職業",
	["Show Location"]							= "顯示位置",
	["Show the character location"]						= "顯示角色所處位置",
	["Don't show location"]							= "不顯示位置",
	["Show zone"]								= "顯示地區",
	["Show subzone"]							= "顯示子地區",
	["Show zone/subzone"]							= "顯示地區/子地區",
	["Colorize Class"]                                      		= "職業顏色",
	["Colorize the character name based on class"]          		= "使用職業顏色.",
	["Use Old Shaman Colour"]						= "薩滿使用舊的職業顏色",
	["Use the pre-210 patch colour for the Shaman class"]			= "不選則薩滿使用新的職業顏色",
	["Sort Type"]								= "排序",
	["Select the sort type"]						= "選擇排序依據",
	["By name"]								= "名字",
	["By level"]								= "級別",
	["By experience"]							= "經驗",
	["By rested XP"]							= "雙倍經驗",
	["By % rested"]								= "雙倍經驗百分比",
	["By money"]								= "金錢",
	["By time played"]							= "在線時間",
	["Sort in reverse order"]						= "反向排序",
	["Use the curent sort type in reverse order"]				= "按當前排序依據反向排序",
	["Font Size"]								= "字體大小",
	["Select the font size"]						= "選擇字體大小",
	["Opacity"]      							= "不透明度",
	["% opacity of the tooltip background"]					= "顯示信息背景不透明度",
	["Sort"]								= "排序",
	["Set the sort options"]						= "排序設置",
	["Ignore Characters"]                                      		= "忽略角色", 
	["Hide characters from display"]                           		= "隱藏角色顯示", 
	["Hide %s of %s from display"]						= "隱藏 %s of %s",
	["BC Installed?"]                                          		= "燃燒的遠征?", 
	["Is the Burning Crusade expansion installed?"]            		= "是否安裝了燃燒的遠征?", 
	["Close"]                                               		= "關閉", 
	["Close the tooltip"]                                   		= "關閉顯示信息", 
	["None"]                                                		= "無",

        -- Strings
--	["v%s - %s (Type /ap for help)"]                        		= true, 
	["%s characters "]                                      		= "%s 角色", 
	["%d rested XP"]							= "%d 雙倍經驗值", 
	["rested"]								= "精力充沛", 
	["Total %s Time Played: "]						= "%s 所有角色在線時間: ", 
	["Total %s Cash Value: "]						= "%s 所有角色金幣: ", 
	["Total Time Played: "]							= "所有在線時間: ", 
	["Total Cash Value: "]							= "所有金幣: ", 
	["Total XP: "]								= "所有經驗: ",
	["Unknown"]								= "未知目標",
	["%.1f M XP"]								= "%.1f 百萬經驗",
	["%.1f K XP"]								= "%.1f 千經驗",
	["%d XP"]								= "%d 經驗",

	-- Console commands
--	["/allplayed"]								= true, 
--	["/ap"]									= true, 
--	["/allplayedcl"]							= true, 
--	["/apcl"]								= true, 

    }
end)
