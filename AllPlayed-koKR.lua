-- AllPlayed-koKR.lua
-- $Id: AllPlayed-koKR.lua 29449 2007-03-03 16:18:41Z next96 $
local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("koKR", function()
    return {
        -- Faction names 
--      ["Alliance"]                                            		= "얼라이언스",
--      ["Horde"]                                               		= "호드", 

        -- Tablet title
--      ["All Played Breakdown"]                                		= true, 

        -- Menus
        ["Display"]                                             		= "보기 설정", 
        ["Set the display options"]                             		= "보기 설정", 
        ["All Factions"]                                        		= "모든 평판", 
        ["All factions will be displayed"]                      		= "모든 평판을 표시합니다.", 
        ["All Realms"]                                          		= "모든 서버", 
        ["All realms will de displayed"]                        		= "모든 서버를 표시합니다.", 
        ["Show Seconds"]                                        		= "초단위 보기", 
        ["Display the seconds in the time strings"]             		= "시간을 초단위까지 표시합니다.", 
        ["Show Gold"]                                    			= "금액 보기",
        ["Display the gold each character pocess"]     				= "각 캐릭터의 소지 금액을 표시합니다.",
        ["Show XP Progress"]                                    		= "현재 레벨 경험치 보기",
        ["Display the level fraction based on curent XP"]       		= "현재 레벨에서의 경험치를 표시합니다.",
        ["Show XP total"]							= "총 경험치 보기",
        ["Show the total XP for all characters"]				= "모든 캐릭터의 총 경험치를 표시합니다.",
        ["Rested XP"]                                           		= "휴식 경험치",
        ["Set the rested XP options"]						= "휴식 경험치 설정",
        ["Rested XP Total"]							= "총 휴식 경험치",
        ["Show the character rested XP"]					= "총 휴식 경험치를 표시합니다.",
        ["Percent Rest"]							= "휴식 경험치 기준", 
        ["Set the base for % display of rested XP"]				= "휴식 경험치 표시의 기준을 선택합니다.", 
        ["Rested XP Countdown"]							= "휴식 경험치 알림",
        ["Show the time remaining before the character is 100% rested"]		= "캐릭터의 휴식 경험치가 100%가 되기전에 알림메시지를 표시합니다.",
        ["Show Class Name"]                                     		= "직업 보기",
        ["Show the character class beside the level"]           		= "레벨 옆에 캐릭터의 직업을 표시합니다.",
        ["Show Location"]							= "지역 보기",
        ["Show the character location"]						= "캐릭터의 현재 위치를 표시합니다.",
        ["Don't show location"]							= "지역 표시 안함",
        ["Show zone"]								= "지역 표시",
        ["Show subzone"]							= "세부지역 표시",
        ["Show zone/subzone"]							= "지역/세부지역 표시",
        ["Colorize Class"]                                      		= "직업 색상 표시",
        ["Colorize the character name based on class"]          		= "직업의 색상에 따라 캐릭터 이름의 색상을 변경합니다.",
        ["Sort Type"]								= "정렬 렬식",
        ["Select the sort type"]						= "정렬 방식을 선택합니다.",
        ["By name"]								= "이름순으로",
        ["By level"]								= "레벨순으로",
        ["By experience"]							= "경험치순으로",
        ["By rested XP"]							= "휴식 경험치순으로",
        ["By % rested"]								= "휴식 경험치 백분율순으로",
        ["By money"]								= "금액순으로",
        ["By time played"]							= "플레이 시간순으로",
        ["Sort in reverse order"]						= "역순으로 정렬",
        ["Use the curent sort type in reverse order"]				= "정렬 방식의 역순으로 정렬합니다.",
        ["Font Size"]								= "글자 크기",
        ["Select the font size"]						= "글자 크기를 변경합니다.",
        ["Opacity"]      							= "투명도",
        ["% opacity of the tooltip background"]					= "툴팁 배경의 투명도를 변경합니다.",
        ["Sort"]								= "정렬",
        ["Set the sort options"]						= "정렬 방법",

        ["Ignore"]                                              		= "현재캐릭터 숨김", 
        ["Ignore the current PC"]                               		= "현재 접속하고 있는 캐릭터는 숨깁니다.", 
        ["BC Installed?"]                                          		= "확장팩 설치?", 
        ["Is the Burning Crusade expansion installed?"]            		= "확장팩이 설치되어 있나요?", 
        ["Close"]                                               		= "닫기", 
        ["Close the tooltip"]                                   		= "툴팁을 닫습니다.", 
        ["None"]                                                		= "없음",

        -- Strings
--      ["v%s - %s (Type /ap for help)"]                        		= true, 
        ["%s characters "]                                      		= "%s 캐릭터", 
        ["%d rested XP"]                                     			= "%d 휴식 경험치", 
        ["rested"]                                       		        = "휴식", 
        ["Total %s Time Played: "]                              		= "%s 총 플레이 시간: ", 
        ["Total %s Cash Value: "]                               		= "%s 총 금액: ", 
        ["Total Time Played: "]                                 		= "총 플레이 시간: ", 
        ["Total Cash Value: "]                                  		= "총 금액: ", 
        ["Total XP: "]								= "총 경험치: ",
        ["Unknown"]								= "알 수 없음",

        -- Console commands
--      ["/allplayed"]                                          		= true, 
--      ["/ap"]                                                 		= true, 

    }
end)
