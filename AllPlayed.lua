-- AllPlayed.lua

--[[ ================================================================= ]]--
--[[                     Addon Initialisation                          ]]--
--[[ ================================================================= ]]--

-- Define static values for the addon
-- Ten days in second, needed to estimate the rested XP
local TEN_DAYS  = 60 * 60 * 24 * 10

-- Class colours
local CLASS_COLOURS = {}
CLASS_COLOURS['DRUID'] 	    =	"ff7d0a"
CLASS_COLOURS['HUNTER'] 	=	"abd473"
CLASS_COLOURS['MAGE'] 	    =	"69ccf0"
CLASS_COLOURS['PALADIN']    =	"f58cba"
CLASS_COLOURS['PRIEST'] 	=	"ffffff"
CLASS_COLOURS['ROGUE'] 	    =	"fff569"
CLASS_COLOURS['SHAMAN'] 	= 	"00dbba"
CLASS_COLOURS['WARLOCK']    =	"9482ca"
CLASS_COLOURS['WARRIOR']    =	"c79c6e"


-- Load external libraries 

-- L is for localisation (to allow translation of the addon)
local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")
-- A is for time and money formating functions
local A = AceLibrary("Abacus-2.0")
-- C is for colour management functions
local C = AceLibrary("Crayon-2.0")
-- metro is for the Metrognome timer librairy functions
local metro = AceLibrary("Metrognome-2.0")
-- tablet is for the tablet library functions
local tablet = AceLibrary("Tablet-2.0")
-- dewdrop is for the menu functions (only needed if FuBar is not there)
local dewdrop = AceLibrary("Dewdrop-2.0")

local tabletParent = "AllPlayedTabletParent"

-- Creation fo the main "object" with librairies (mixins) directly attach to the object (used self:functions)
-- If FuBar is present, we load the FuBarPlugin mixin
AllPlayed = {}
AllPlayed = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0", "AceEvent-2.0", "AceHook-2.1","FuBarPlugin-2.0")

if IsAddOnLoaded("Fubar") then
    AllPlayed.is_fubar_loaded = true
else
    AllPlayed.is_fubar_loaded = false
end

-- The data will be saved in WFT\{account name}\SaveVariables\AllPlayedDB.lua
AllPlayed:RegisterDB("AllPlayedDB")

-- Set the default for the save variables. Not very useful except to show the format
AllPlayed:RegisterDefaults('account', {
    -- Data for each PC
    data = {
        -- Faction
        ['*'] = {
            -- Realm
            ['*'] = {
                -- Name
                ['*'] = {
                    class                       = "",   -- English class name
                    class_loc                   = "",   -- Localized class name
                    level                       = 0, 
                    coin                        = 0, 
                    rested_xp                   = 0, 
                    max_rested_xp               = 0, 
                    last_update                 = 0, 
                    is_resting                  = false, 
                    is_ignored                  = false,
                    seconds_played              = 0,  
                    seconds_played_last_update  = 0,
                }
            }
        }
    }
})

-- The options that only change the display are done by profile
AllPlayed:RegisterDefaults('profile', {
    -- Global Options
    options = {
        all_factions    = true,
        all_realms      = true,
        show_seconds    = true,
        percent_rest    = "100",
        refresh_rate    = 1,
        show_class_name = false,
        colour_class    = false,
    },
})

-- Options for both FuBar and AceConsole
-- See AceOptions for the format
local command_options = {
    type = 'group',
    args = {
        display = {
            type = 'group', name = L["Display"], desc = L["Set the display options"], args = {
                all_factions = {
                    name    = L["All Factions"],
                    desc    = L["All factions will be displayed"],
                    type    = 'toggle',
                    get     = "GetAllFactions",
                    set     = "SetAllFactions",
                    order   = 1,
                },
                all_realms = {
                    name    = L["All Realms"],
                    desc    = L["All realms will de displayed"],
                    type    = 'toggle',
                    get     = "GetAllRealms",
                    set     = "SetAllRealms",
                    order   = 2,
                },
                show_seconds = {
                    name    = L["Show Seconds"],
                    desc    = L["Display the seconds in the time strings"],
                    type    = 'toggle',
                    get     = "GetShowSeconds",
                    set     = "SetShowSeconds",
                    order   = 3,
                },
                percent_rest = {
                    name        = L["Percent Rest"],
                    desc        = L["Set the base for % display of rested XP"],
                    type        = 'text',
                    get         = "GetPercentRest",
                    set         = "SetPercentRest",
                    validate    = { ["100"] = "100%", ["150"] = "150%" },
                    order       = 4,
                },
                show_class_name = {
                    name        = L["Show Class Name"],
                    desc        = L["Show the character class beside the level"],
                    type        = 'toggle',
                    get         = "GetShowClassName",
                    set         = "SetShowClassName",
                    order       = 5,
                },
                colorize_class = {
                    name        = L["Colorize Class"],
                    desc        = L["Colorize the character name based on class"],
                    type        = 'toggle',
                    get         = "GetColourClass",
                    set         = "SetColourClass",
                    order       = 6,
                },
            }, order = 1
        },
        ignore = {
            name    = L["Ignore"],
            desc    = L["Ignore the current PC"],
            type    = 'toggle',
            get     = "GetIsIgnored",
            set     = "SetIsIgnored",
            order   = 4
        },
    }
}


-- Register the chat commands
-- :RegisterChatCommand takes the slash commands and an AceOptions data table
AllPlayed:RegisterChatCommand({ L["/ap"], L["/allplayed"] }, command_options) 

-- This function is called by the ACE2 framework one time after the addon is loaded
function AllPlayed:OnInitialize()
    -- code here, executed only once.
    --self:SetDebugging(true) -- to have debugging through your whole app.
    
    
   
    -- Initial setup is done by OnEnable (not mush to do here)
    -- We set total variables to zero and create the tables that will never
    -- be deleted
    self.total_faction      = { [L["Horde"]]    = { time_played = 0, coin = 0 },
                                [L["Alliance"]] = { time_played = 0, coin = 0 },
    }
    self.total_realm        = { }
    self.total              = { time_played = 0, coin = 0 }
    
    self.sort_tables_done    = false
end

function AllPlayed:OnEnable()
    self.debugging = self:IsDebugging()

    self:Debug("AllPlayed:OnEnable()")

    -- code here, executed after everything is loaded.
    -- Note: AceDB-2.0 will also call this when standby is toggled.
    
    -- Register the events we need
    -- (event unregistering is done automagicaly by ACE)
    self:RegisterEvent("TIME_PLAYED_MSG",   "OnTimePlayedMsg")
    self:RegisterEvent("PLAYER_LEVEL_UP",   "EventHandler")
    self:RegisterEvent("PLAYER_XP_UPDATE",  "EventHandler")
    self:RegisterEvent("PLAYER_MONEY",      "EventHandler")
    
    -- Hook the functions that need hooking
    -- (hook removal is done automagicaly by ACE)
    self:SecureHook("Logout")
    self:SecureHook("Quit")
  
    -- Initialize values that don't change between reloads
    self.faction    = UnitFactionGroup("player")
    self.realm      = GetRealmName()
    self.pc         = UnitName("player")
    
    -- Initial update of values
    self:SaveVar()
    
    -- Build the sorting tables once in order not to generate memory garbage
    if not self.sort_tables_done then
        -- Static sort for the factions
        self.sort_faction = { L["Horde"], L["Alliance"] }
        
        self.sort_faction_realm = {}
        self.sort_realm_pc = {}
        for faction, faction_table in pairs(self.db.account.data) do
            -- Realms in each faction are alpha sorted
            self:Debug("ST : Faction = ",faction)
            self.sort_faction_realm[faction] =  buildSortedTable( faction_table )
        
            -- Other Realm sorts would go here
            
            self.sort_realm_pc[faction] = {}
            for realm, realm_table in pairs(faction_table) do
                -- PC in each realm are alpha sorted by name
                self:Debug("ST : Realm = ",realm)
                self.sort_realm_pc[faction][realm] = buildSortedTable( realm_table )
            end
        
            -- Other PC sorts would go here
        end
        
        self.sort_tables_done = true
    end

    -- Request the time played so we can populate seconds_played
    self:RequestTimePlayed()
    
    -- Start the Metrognome event to get an OnUpdateData, OnUpdateText and OnUpdateTooltip every second
    -- If FuBar is not loaded, we do not start Metrognome
    if self.is_fubar_loaded then
        metro:RegisterMetro(self.name, self.Update, self.db.profile.options.refresh_rate, self)
        metro:StartMetro(self.name)
    end
end

function AllPlayed:OnDisable()
    -- Stop the Metrognome event
    if self.is_fubar_loaded then
        metro:UnregisterMetro(self.name)
    else
        tablet:Close(tabletParent)
    end
end

function AllPlayed:IsDebugging() return self.db.profile.debugging end
function AllPlayed:SetDebugging(debugging) self.db.profile.debugging = debugging; self.debugging = debugging; end


--[[ ================================================================= ]]--
--[[                          Fubar part                               ]]--
--[[ ================================================================= ]]--

-- FuBar configuration
-- Defining there even if FuBar is not present doesn't cause any problem se I don't
-- check self.is_fubar_loaded where
AllPlayed.OnMenuRequest = command_options
AllPlayed.hasIcon = "Interface\\Icons\\INV_Misc_PocketWatch_02.blp"
AllPlayed.defaultPosition = "LEFT"
AllPlayed.defaultMinimapPosition = 200
AllPlayed.cannotDetachTooltip = false
AllPlayed.hideWithoutStandby = true
AllPlayed.clickableTooltip = false 

function AllPlayed:OnDataUpdate()
    self:Debug("AllPlayed:OnDataUpdate()")
    
    self:ComputeTotal()
end

function AllPlayed:OnTextUpdate()
    self:Debug("AllPlayed:OnTextUpdate()")
    
    self:SetText( self:FormatTime(self.total.time_played) )
end

function AllPlayed:OnTooltipUpdate()
    self:Debug("OnTooltipUpdate()")
    self:Debug("=>self.total.time_played: ", self.total.time_played)
    
    self:FillTablet()
    
    --tablet:SetHint("Click to do something")
    -- as a rule, if you have an OnClick or OnDoubleClick or OnMouseUp or OnMouseDown, you should set a hint.
end

function AllPlayed:OnClick()
    -- do something
    --self:Update()
end



--[[ ================================================================= ]]--
--[[              Functions specific to the addon                      ]]--
--[[ ================================================================= ]]--

-- Get the totals per faction and realm
function AllPlayed:ComputeTotal()
    self:Debug("AllPlayed:ComputeTotal()")
    
    -- Let's start from scratch
    self.total_faction[L["Horde"]].time_played      = 0
    self.total_faction[L["Horde"]].coin             = 0 
    self.total_faction[L["Alliance"]].time_played   = 0
    self.total_faction[L["Alliance"]].coin          = 0 
    self.total.time_played                          = 0
    self.total.coin                                 = 0 
    
    -- Let all the factions, realms and PC be counted
    for faction, faction_table in pairs(self.db.account.data) do
        for realm, realm_table in pairs(faction_table) do
            self:Debug("faction: %s realm: %s", faction, realm)
            
            if not self.total_realm[faction] then self.total_realm[faction] = {} end
            if not self.total_realm[faction][realm] then self.total_realm[faction][realm] = {} end
            self.total_realm[faction][realm].time_played = 0
            self.total_realm[faction][realm].coin = 0
            for pc, pc_table in pairs(realm_table) do
                if not pc_table.is_ignored then
                    -- Need to get the current seconds_played for the PC
                    local seconds_played = self:EstimateTimePlayed(pc, 
                                                                   realm, 
                                                                   pc_table.seconds_played,
                                                                   pc_table.seconds_played_last_update
                                           )
                    self.total_faction[faction].time_played         = self.total_faction[faction].time_played       + seconds_played
                    self.total_faction[faction].coin                = self.total_faction[faction].coin              + pc_table.coin
                    self.total_realm[faction][realm].time_played    = self.total_realm[faction][realm].time_played  + seconds_played
                    self.total_realm[faction][realm].coin           = self.total_realm[faction][realm].coin         + pc_table.coin
                end
            end
        end
    end
    
    -- The Grand Total varies according to the options
    if self.db.profile.options.all_realms then
        if self.db.profile.options.all_factions then
            -- Everything count
            self.total.time_played 
                =   self.total_faction[L["Horde"]].time_played 
                  + self.total_faction[L["Alliance"]].time_played
            self.total.coin
                =   self.total_faction[L["Horde"]].coin
                  + self.total_faction[L["Alliance"]].coin
        else
            -- Only the current faction count
            self.total.time_played = self.total_faction[self.faction].time_played
            self.total.coin        = self.total_faction[self.faction].coin
        end
    else
        -- Only the current realm count (all_factions is ignore)
        self.total.time_played = self.total_realm[self.faction][self.realm].time_played
        self.total.coin        = self.total_realm[self.faction][self.realm].coin
    end
end

-- Fill the tablet with the All Played information
function AllPlayed:FillTablet()
    self:Debug("AllPlayed:FillTablet()")
    self:Debug("=>self.total.time_played: ", self.total.time_played)
    
    local estimated_rested_xp = 0

    -- Set the title for the table (just when using FuBar
    tablet:SetTitle(C:White(L["All Played Breakdown"]))
    
  
    -- We group by factions, then by realm, then by PC
    for _, faction in ipairs (self.sort_faction) do
        -- We do not print the faction if no option to select it is on
        -- and if the time played for the faction = 0 since this means
        -- all PC in the faction are ingored.
        if ((self.db.profile.options.all_factions or self.faction == faction)
            and self.total.time_played ~= 0
            and self.sort_faction_realm[faction]
        ) then
            for _, realm in ipairs(self.sort_faction_realm[faction]) do
                -- We do not print the repl if no option to select it is on
                -- and if the time played for the relm = 0 since this means
                -- all PC in the relm are ingored.
                if ((self.db.profile.options.all_realms or self.realm == realm)
                    and self.total_realm[faction][realm].time_played ~= 0
                ) then
                    --self:Debug("self.total_realm[faction][realm].time_played: ",self.total_realm[faction][realm].time_played)
                    local cat = tablet:AddCategory(
                        'columns', 2,
                        'child_indentation', 10
                    )
                    cat:AddLine(
                       'columns', 1,
                       'indentation', 0,
                       'text', string.format( C:Yellow(L["%s characters "]) .. C:Green("[%s: ") .. "%s" .. C:Green("]"),
                                              realm,
                                              self:FormatTime(self.total_realm[faction][realm].time_played),
                                              FormatMoney(self.total_realm[faction][realm].coin)
                               )
                    )
                
                    for _, pc in ipairs(self.sort_realm_pc[faction][realm]) do
                        if (not self.db.account.data[faction][realm][pc].is_ignored) then
                            -- Seconds played are still going up for the current PC
                            local seconds_played = self:EstimateTimePlayed(
                                                        pc, 
                                                        realm, 
                                                        self.db.account.data[faction][realm][pc].seconds_played,
                                                        self.db.account.data[faction][realm][pc].seconds_played_last_update
                                                   )
                            if (self.db.account.data[faction][realm][pc].level == 60) then
                                cat:AddLine(
                                    'text',  FormatCharacterName( pc, 
                                                                  self.db.account.data[faction][realm][pc].level, 
                                                                  seconds_played, 
                                                                  self.db.account.data[faction][realm][pc].class, 
                                                                  self.db.account.data[faction][realm][pc].class_loc, 
                                                                  faction 
                                             ),
                                    'text2', FormatMoney(self.db.account.data[faction][realm][pc].coin)
                                )
                            else
                                estimated_rested_xp = self:EstimateRestedXP( 
                                                            pc, 
                                                            realm, 
                                                            self.db.account.data[faction][realm][pc].level, 
                                                            self.db.account.data[faction][realm][pc].rested_xp, 
                                                            self.db.account.data[faction][realm][pc].max_rested_xp, 
                                                            self.db.account.data[faction][realm][pc].last_update, 
                                                            self.db.account.data[faction][realm][pc].is_resting 
                                                      )
                                cat:AddLine(
                                    'text',  FormatCharacterName( pc, 
                                                                  self.db.account.data[faction][realm][pc].level, 
                                                                  seconds_played, 
                                                                  self.db.account.data[faction][realm][pc].class, 
                                                                  self.db.account.data[faction][realm][pc].class_loc, 
                                                                  faction ),
                                    'text2', string.format( FormatMoney(self.db.account.data[faction][realm][pc].coin)
                                                            .. FactionColour( faction, L[": %d rested XP "] )
                                                            .. PercentColour( (estimated_rested_xp/self.db.account.data[faction][realm][pc].max_rested_xp), 
                                                                              L["(%d%% rested)"] 
                                                            ),
                                                            estimated_rested_xp,
                                                            -- The % rested XP is displayed on a 150% base since
                                                            -- this is the maximum rested XP possible for a PC in
                                                            -- respect of his level
                                                            (self.db.profile.options.percent_rest * 
                                                             estimated_rested_xp / 
                                                             self.db.account.data[faction][realm][pc].max_rested_xp)
                                             )
                                )
                            end
                        end
                    end
                end
            end
        end
    end

    -- Print the totals
    local cat = tablet:AddCategory(
        'columns', 2
    )
    cat:AddLine(
        'text',  C:Orange( L["Total Time Played: "] ),
        'text2', C:Yellow( self:FormatTime(self.total.time_played) )
    )
    cat:AddLine(
        'text',  C:Orange( L["Total Cash Value: "] ),
        'text2', FormatMoney(self.total.coin)
    )
    
    --tablet:SetHint("Click to do something")
    -- as a rule, if you have an OnClick or OnDoubleClick or OnMouseUp or OnMouseDown, you should set a hint.
end


-- Function trigered when the TIME_PLAYED_MSG event is fired
function AllPlayed:OnTimePlayedMsg(seconds_played)
    self:Debug("OnTimePlayedMsg(): ",seconds_played)
    
    -- We save the normal variables and the seconds played
    self:SetSecondsPlayed(seconds_played)
    self:SaveVar()

    -- Compute the totals
    self:ComputeTotal()
end

-- Event handler for the other events registered
function AllPlayed:EventHandler()
    self:Debug("EventHandler(): [arg1: %s] [arg2: %s] [arg3: %s]", arg1, arg2, arg3)
    
    -- We save a new copy of the vars
    self:SaveVar()
    
    -- Compute totals
    self:ComputeTotal()
end

-- Function called from Metrognome when FuBar is not loaded
function AllPlayed:TimerUpdate()
    self:ComputeTotal()
    --self:FillTablet()

    -- We have to register the tabler for every update!!!!
    tablet:Register(tabletParent, 
        'menu', function()
             dewdrop:FeedAceOptionsTable(command_options)
        end,
        'cantAttach', true,
        'detachedData', self.db.profile.tabletData,
        'children', function() 
            AllPlayed:FillTablet() 
        end,
        'showTitleWhenDetached', true
    )

    tablet:Refresh(tabletParent)

end

--[[ ================================================================= ]]--
--[[                  Store and retreive methods                       ]]--
--[[ ================================================================= ]]--

-- This function should be called everytime it is useful to refresh the save data
-- I know that some data never change until the user log out but since the function
-- is not called very often, I don't see the needs to do more special cases
function AllPlayed:SaveVar()
    self:Debug("AllPlayed:SaveVar()")

    -- Fill some of the SaveVariables with values that do not change between 
    self.db.account.data[self.faction][self.realm][self.pc].class_loc, 
        self.db.account.data[self.faction][self.realm][self.pc].class        = UnitClass("player")
    self.db.account.data[self.faction][self.realm][self.pc].level           = UnitLevel("player")
    self.db.account.data[self.faction][self.realm][self.pc].max_rested_xp   = UnitXPMax("player") * 1.5
    self.db.account.data[self.faction][self.realm][self.pc].last_update     = time()
    self.db.account.data[self.faction][self.realm][self.pc].is_resting      = IsResting()
    
    -- Make sure that coin is not nil
    if GetMoney() == nil then
        self.db.account.data[self.faction][self.realm][self.pc].coin        = 0
    else
        self.db.account.data[self.faction][self.realm][self.pc].coin        = GetMoney()
    end
    
    -- Make sure that rested_xp is not nil
    if GetXPExhaustion() == nil then
        self.db.account.data[self.faction][self.realm][self.pc].rested_xp   = 0
    else
        self.db.account.data[self.faction][self.realm][self.pc].rested_xp   = GetXPExhaustion()
    end
    
end

-- Set the value seconds_played that will be saved in the save variables
function AllPlayed:SetSecondsPlayed(seconds_played)
    self:Debug("SetSecondsPlayed(): ",seconds_played)

    self.db.account.data[self.faction][self.realm][self.pc].seconds_played              = seconds_played
    self.db.account.data[self.faction][self.realm][self.pc].seconds_played_last_update  = time()
end

-- Get the current is_ignored value
function AllPlayed:GetIsIgnored()
    self:Debug("AllPlayed:getIsIgnored: ",
               self.db.account.data[self.faction][self.realm][self.pc].is_ignored
    )

    return self.db.account.data[self.faction][self.realm][self.pc].is_ignored
end

-- Set the value for is_ignored
function AllPlayed:SetIsIgnored(value)
    self:Debug("AllPlayed:SetIsIgnored: ",value)
    
    self.db.account.data[self.faction][self.realm][self.pc].is_ignored = value
    
    -- Compute the totals
    self:ComputeTotal()
end

-- Get the current all_factions value
function AllPlayed:GetAllFactions()
    self:Debug("AllPlayed:GetAllFactions: ", self.db.profile.options.all_factions)
    
    return self.db.profile.options.all_factions
end

-- Set the value for all_factions
function AllPlayed:SetAllFactions( value )
    self:Debug("AllPlayed:SetAllFactions: old %s, new %s", self.db.profile.options.all_factions, value )
    
    self.db.profile.options.all_factions = value
    
    -- Compute the totals
    self:ComputeTotal()
end

-- Get the current all_realms value
function AllPlayed:GetAllRealms()
    self:Debug("AllPlayed:GetAllRealms: ", self.db.profile.options.all_realms)
    
    return self.db.profile.options.all_realms
end

-- Set the value for all_realms
function AllPlayed:SetAllRealms( value )
    self:Debug("AllPlayed:SetAllRealms: old %s, new %s", self.db.profile.options.all_realms, value )
    
    self.db.profile.options.all_realms = value
    
    -- Compute the totals
    self:ComputeTotal()
end

-- Get the value for show_seconds
function AllPlayed:GetShowSeconds()
    self:Debug("AllPlayed:GetShowSeconds: ", self.db.profile.options.show_seconds)

    return self.db.profile.options.show_seconds
end

-- Set the value of show_seconds
-- Also set the refresh rate use by Metrognome
function AllPlayed:SetShowSeconds( value )
    self:Debug( "AllPlayed:SetShowSeconds: old %s, new %s", self.db.profile.options.show_seconds, value)
    
    self.db.profile.options.show_seconds = value
    
    if value then
        -- If the seconds are displayed, we need to refresh every seconds
        self.db.profile.options.refresh_rate = 1
    else
        -- If only the minutes are shown, 3 refreshs a minute will do nicely
        self.db.profile.options.refresh_rate = 20
    end
    self:Debug("=> refresh rate:", self.db.profile.options.refresh_rate) 
    
    -- If there is a timer active, we change the rate
    if metro:MetroStatus(self.name) then
        metro:ChangeMetroRate( self.name, self.db.profile.options.refresh_rate )
        if self.is_fubar_loaded then
            self:Update()
        else
            self:TimerUpdate()
        end
    end
end

-- Get the value of percent_rest
function AllPlayed:GetPercentRest()
    self:Debug("AllPlayed:GetAllRealms: ", self.db.profile.options.percent_rest)
    
    return self.db.profile.options.percent_rest
end

-- Set the value of percent_rest
function AllPlayed:SetPercentRest( value )
    self:Debug("AllPlayed:SetPercentRest: old %s, new %s", self.db.profile.options.percent_rest, value )
    
    self.db.profile.options.percent_rest = value
end

-- Get the value of show_class_name
function AllPlayed:GetShowClassName()
    self:Debug("AllPlayed:GetShowClassName: ", self.db.profile.options.show_class_name)
    
    return self.db.profile.options.show_class_name
end

-- Set the value of show_class_name
function AllPlayed:SetShowClassName( value )
    self:Debug("AllPlayed:SetPercentRest: old %s, new %s", self.db.profile.options.show_class_name, value )
    
    self.db.profile.options.show_class_name = value
end

-- Get the value of colour_class
function AllPlayed:GetColourClass()
    self:Debug("AllPlayed:GetColourClass: ", self.db.profile.options.colour_class)
    
    return self.db.profile.options.colour_class
end

-- Set the value of colour_class
function AllPlayed:SetColourClass( value )
    self:Debug("AllPlayed:SetPercentRest: old %s, new %s", self.db.profile.options.colour_class, value )
    
    self.db.profile.options.colour_class = value
end



--[[ ================================================================= ]]--
--[[                         Hook function                             ]]--
--[[ ================================================================= ]]--

-- Those are used to get a last update on the time played before going away
function AllPlayed:Logout()
    self:Debug("Logout()")

    self:RequestTimePlayed()
    return self.hooks.Logout()
end

function AllPlayed:Quit()
    self:Debug("Quit()")

    RequestTimePlayed()
    return self.hooks.Quit()
end

--[[ ================================================================= ]]--
--[[                       Utility Functions                           ]]--
--[[ ================================================================= ]]--

-- This function estimate (calculate) the real time played
-- Only the current player is still playing.
function AllPlayed:EstimateTimePlayed( pc, realm, time_played, last_update )
    if pc == self.pc and realm == self.realm then
        return time_played + time() - last_update
    else
        return time_played
    end
end

-- This function tries to estimate the total rested XP for a character based
-- on the last time the data were updated and whether or not the character
-- was in an Inn
function AllPlayed:EstimateRestedXP( pc, realm, level, rested_xp, max_rested_xp, last_update, is_resting )
    self:Debug("AllPlayed:EstimateRestedXP: %s, %s, %s, %s, %s, %s, %s",pc, realm, level, rested_xp, max_rested_xp, last_update, is_resting)
    -- I'm putting level as a parameter even though I don't use it for now. I need to find 
    -- out at what level do a character start to gain rested XP
    
    -- If the character is the current player and he is not in an Inn, he gain no rest
    if pc == AllPlayed.pc and realm == self.realm and not is_resting then
        return rested_xp
    end
    
    -- It takes 10 days to for a character to be fully rested if he is in an Inn,
    -- otherwise it takes 40 days.
    if is_resting then
        return math.min( rested_xp + math.floor( ( time()-last_update ) * ( max_rested_xp/TEN_DAYS ) ), max_rested_xp )
    else
        return math.min( rested_xp + math.floor( ( time()-last_update ) * ( max_rested_xp/(4 * TEN_DAYS) ) ), max_rested_xp )
    end
end

-- Function that Send a request to the server to get an update of the time played.
function AllPlayed:RequestTimePlayed()
    -- We only send the event if the message has not been seen for 10 seconds
    if time() - self.db.account.data[self.faction][self.realm][self.pc].seconds_played_last_update > 10 then
        RequestTimePlayed()
    end
    
end

function AllPlayed:FormatTime(seconds)
    return A:FormatDurationFull( seconds, false, not self.db.profile.options.show_seconds )
end

function FormatMoney(coin)
    return A:FormatMoneyFull( coin, true, false )
end


-- This function colorize the text based on the faction
function FactionColour( faction, string )
    if faction == L["Horde"] then
        return C:Red(string)
    else
        -- Blue
        return C:Colorize( "007fff", string )
    end
end

-- This function colorize the text based on the percent value
-- percent must be a value in the range 0-1, not 0-100
function PercentColour( percent, string )
    return C:Colorize( C:GetThresholdHexColor( percent ), string )
end

-- This function colorize the text based on the class
-- If no class is defined, the text is colorized by faction
function ClassColour( class, faction, string )
    if class == "" or not AllPlayed:GetColourClass() then
        return FactionColour( faction, string )
    else
        return C:Colorize( CLASS_COLOURS[class], string )
    end
end

-- This function format and colorize the Character name and level 
-- based on the options selected by the user
function FormatCharacterName( pc, level, seconds_played, class, class_loc, faction )
    local level_string      = ""
    
    -- Created use the all cap english name if the localized name is not present
    -- This should never happen but I like to code defensively
    local class_display = class_loc 
    if class_display == "" then class_display = class end
    
    if class == "" or not AllPlayed:GetShowClassName() then
        level_string = string.format( "%d", level )
    else
        level_string = string.format( "%s %d", class_display, level )
    end
    
    return string.format( ClassColour( class, faction, "%s (%s)" ) .. FactionColour( faction, ": %s" ),
                          pc,
                          level_string,
                          AllPlayed:FormatTime(seconds_played)
           )
end


-- This build an iterator that sort by keys
-- See <http://www.lua.org/pil/19.3.html> for full explanation
-- I don't use it anymore as it seams it was creating too mush garbage
function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

-- This function build a table of sorted keys that will latter
-- be used with ipairs in order to get the value of a hash in order
-- By doing it this way, the temporary tables are droped only once so
-- it reduce the LUA garbage collection.
function buildSortedTable( unsorted_table, sort_function )
    AllPlayed:Debug("buildSortedTable:")
    
    local sorted_key_table = {}
    
    for key in pairs(unsorted_table) do table.insert(sorted_key_table, key) end
    table.sort(sorted_key_table, sort_function)
    
    return sorted_key_table
end

