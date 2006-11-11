-- AllPlayed-enUS.lua
local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("enUS", function()
    return {
        -- Faction names 
        ["Alliance"]                                            = true,
        ["Horde"]                                               = true, 
        
        -- Tablet title
        ["All Played Breakdown"]                                = true, 
        
        -- Menus
        ["Display"]                                             = true, 
        ["Set the display options"]                             = true, 
        ["All Factions"]                                        = true, 
        ["All factions will be displayed"]                      = true, 
        ["All Realms"]                                          = true, 
        ["All realms will de displayed"]                        = true, 
        ["Show Seconds"]                                        = true, 
        ["Display the seconds in the time strings"]             = true, 
        ["Percent Rest"]                                        = true, 
        ["Set the base for % display of rested XP"]             = true, 
        ["Ignore"]                                              = true, 
        ["Ignore the current PC"]                               = true, 
        ["Report"]                                              = true, 
        ["Print report"]                                        = true, 
        ["Close"]                                               = true, 
        ["Close the tooltip"]                                   = true, 
        
        -- Strings
        ["v%s - %s (Type /ap for help)"]                        = true, 
        ["%s characters "]                                      = true, 
        [": %d rested XP "]                                     = true, 
        ["(%d%% rested)"]                                       = true, 
        ["Total %s Time Played: "]                              = true, 
        ["Total %s Cash Value: "]                               = true, 
        ["Total Time Played: "]                                 = true, 
        ["Total Cash Value: "]                                  = true, 
        
        -- Console commands
        ["/allplayed"]                                          = true, 
        ["/ap"]                                                 = true, 
        
    }
end)
