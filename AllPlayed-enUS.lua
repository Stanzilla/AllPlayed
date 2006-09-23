-- AllPlayed-enUS.lua
local L = AceLibrary("AceLocale-2.0"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("enUS", function()
    return {
        -- Faction names
        ["Alliance"]                                            = "Alliance",
        ["Horde"]                                               = "Horde",
        
        -- Tablet title
        ["All Played Breakdown"]                                = "All Played Breakdown",
        
        -- Menus
        ["Display"]                                             = "Display",
        ["Set the display options"]                             = "Set the display options",
        ["All Factions"]                                        = "All Factions",
        ["All factions will be displayed"]                      = "All factions will be displayed",
        ["All Realms"]                                          = "All Realms",
        ["All realms will de displayed"]                        = "All realms will de displayed",
        ["Show Seconds"]                                        = "Show Seconds",
        ["Display the seconds in the time strings"]             = "Display the seconds in the time strings",
        ["Percent Rest"]                                        = "Percent Rest",
        ["Set the base for % display of rested XP"]             = "Set the base for % display of rested XP",
        ["Ignore"]                                              = "Ignore",
        ["Ignore the current PC"]                               = "Ignore the current PC",
        ["Report"]                                              = "Report",
        ["Print report"]                                        = "Print report",
        ["Close"]                                               = "Close",
        ["Close the tooltip"]                                   = "Close the tooltip",
        
        ["v%s - %s (Type /ap for help)"]                        = "v%s - %s (Type /ap for help)",
        ["%s characters "]                                      = "%s characters ",
        [": %d rested XP "]                                     = ": %d rested XP ",
        ["(%d%% rested)"]                                       = "(%d%% rested)",
        ["Total %s Time Played: "]                              = "Total %s Time Played: ",
        ["Total %s Cash Value: "]                               = "Total %s Cash Value: ",
        ["Total Time Played: "]                                 = "Total Time Played: ",
        ["Total Cash Value: "]                                  = "Total Cash Value: ",
        
        -- Console commands
        ["/allplayed"]                                          = "/allplayed",
        ["/ap"]                                                 = "/ap",
        
    }
end)
