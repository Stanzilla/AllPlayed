-- AllPlayed.lua
-- $Id$

--[[ ================================================================= ]]--
--[[                     Addon Initialisation                          ]]--
--[[ ================================================================= ]]--

-- Define static values for the addon
-- Ten days in second, needed to estimate the rested XP
local TEN_DAYS  = 60 * 60 * 24 * 10

-- Class colours
local CLASS_COLOURS = {}
CLASS_COLOURS['DRUID']      = "ff7d0a"
CLASS_COLOURS['HUNTER']     = "abd473"
CLASS_COLOURS['MAGE']       = "69ccf0"
CLASS_COLOURS['PALADIN']    = "f58cba"
CLASS_COLOURS['PRIEST']     = "ffffff"
CLASS_COLOURS['ROGUE']      = "fff569"
CLASS_COLOURS['SHAMAN']     = "00dbba"
CLASS_COLOURS['WARLOCK']    = "9482ca"
CLASS_COLOURS['WARRIOR']    = "c79c6e"


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

-- Creation fo the main "object" with librairies (mixins) directly attach to the object (use self:functions)
AllPlayed = {}
AllPlayed = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0", "AceEvent-2.0", "AceHook-2.1","FuBarPlugin-2.0")

-- Keep track if FuBar is present
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
                    xp                          = -1,
                    max_rested_xp               = 0, 
                    last_update                 = 0, 
                    is_resting                  = false, 
                    is_ignored                  = false,
                    seconds_played              = 0,  
                    seconds_played_last_update  = 0,
                    zone_text                   = L["Unknown"],
                    subzone_text                = "",
                }
            }
        }
    }
})

-- The options that only change the display are done by profile
AllPlayed:RegisterDefaults('profile', {
    -- Global Options
    options = {
        all_factions                = true,
        all_realms                  = true,
        show_seconds                = true,
        show_progress               = true,
        show_rested_xp              = true,
        percent_rest                = "100",
        show_rested_xp_countdown    = false,
        refresh_rate                = 1,
        show_class_name             = false,
        colour_class                = false,
        show_location               = "none",
        show_xp_total               = false,
        bc_installed				= true,
        font_size					= 12,
        transparency				= nil,
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
                    name      = L["All Factions"],
                    desc      = L["All factions will be displayed"],
                    type      = 'toggle',
                    get       = "GetAllFactions",
                    set       = "SetAllFactions",
                    order     = 1,
                },
                all_realms = {
                    name      = L["All Realms"],
                    desc      = L["All realms will de displayed"],
                    type      = 'toggle',
                    get       = "GetAllRealms",
                    set       = "SetAllRealms",
                    order     = 2,
                },
                show_seconds = {
                    name      = L["Show Seconds"],
                    desc      = L["Display the seconds in the time strings"],
                    type      = 'toggle',
                    get       = "GetShowSeconds",
                    set       = "SetShowSeconds",
                    order     = 3,
                },

                show_progress = {
                    name      = L["Show XP Progress"],
                    desc      = L["Display the level fraction based on curent XP"],
                    type      = 'toggle',
                    get       = "GetShowProgress",
                    set       = "SetShowProgress",
                    order     = 4,
                },
                show_xp_total = {
                    name      = L["Show XP total"],
                    desc      = L["Show the total XP for all characters"],
                    type      = 'toggle',
                    get       = "GetShowXPTotal",
                    set       = "SetShowXPTotal",
                    order     = 5,
                },
                show_location = {
                    name      = L["Show Location"],
                    desc      = L["Show the character location"],
                    type      = 'text',
                    get       = "GetShowLocation",
                    set       = "SetShowLocation",
                    validate  = { ["none"]      = L["Don't show location"],
                                  ["loc"]       = L["Show zone"], 
                                  ["sub"]       = L["Show subzone"], 
                                  ["loc/sub"]   = L["Show zone/subzone"] 
                    },
                    order     = 6,
                },
                rested_xp = {
                    type = 'group', name = L["Rested XP"], desc = L["Set the rested XP options"], args = {
                         show_rested_xp = {
                            name        = L["Rested XP Total"],
                            desc        = L["Show the character rested XP"],
                            type        = 'toggle',
                            get         = "GetShowRestedXP",
                            set         = "SetShowRestedXP",
                            order = 1,
                         },
                         percent_rest = {
                            name        = L["Percent Rest"],
                            desc        = L["Set the base for % display of rested XP"],
                            type        = 'text',
                            get         = "GetPercentRest",
                            set         = "SetPercentRest",
                            validate    = { ["0"] = L["None"], ["100"] = "100%", ["150"] = "150%" },
                            order       = 2,
                        },
                         show_rested_xp_countdown = {
                            name        = L["Rested XP Countdown"],
                            desc        = L["Show the time remaining before the character is 100% rested"],
                            type        = 'toggle',
                            get         = "GetShowRestedXPCountdown",
                            set         = "SetShowRestedXPCountdown",
                            order = 3,
                         },
                    },
                    order     = 7,
                },
                show_class_name = {
                    name      = L["Show Class Name"],
                    desc      = L["Show the character class beside the level"],
                    type      = 'toggle',
                    get       = "GetShowClassName",
                    set       = "SetShowClassName",
                    order     = 8,
                },
                colorize_class = {
                    name      = L["Colorize Class"],
                    desc      = L["Colorize the character name based on class"],
                    type      = 'toggle',
                    get       = "GetColourClass",
                    set       = "SetColourClass",
                    order     = 9,
                },
                font_size = {
                    name      = L["Font Size"],
                    desc      = L["Select the font size"],
                    type      = 'range',
                    min		  = 8,
                    max       = 20,
                    step      = 1,
                    get       = "GetFontSize",
                    set       = "SetFontSize",
                    order     = 10,
                },
            }, order = 1
        },
        ignore = {
            name    = L["Ignore"],
            desc    = L["Ignore the current PC"],
            type    = 'toggle',
            get     = "GetIsIgnored",
            set     = "SetIsIgnored",
            order   = 2
        },
        bc_installed = {
            name    = L["BC Installed?"],
            desc    = L["Is the Burning Crusade expansion installed?"],
            type    = 'toggle',
            get     = "GetIsBCInstalled",
            set     = "SetIsBCInstalled",
            order   = 3
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
    self.total              = { time_played = 0, coin = 0, xp = 0 }
    
    self.sort_tables_done    = false
end

function AllPlayed:OnEnable()
    self.debugging = self:IsDebugging()

    self:Debug("AllPlayed:OnEnable()")

    -- code here, executed after everything is loaded.
    -- Note: AceDB-2.0 will also call this when standby is toggled.
    
    -- Register the events we need
    -- (event unregistering is done automagicaly by ACE)
    self:RegisterEvent("TIME_PLAYED_MSG",       "OnTimePlayedMsg")
    self:RegisterEvent("PLAYER_LEVEL_UP",       "EventHandler")
    self:RegisterEvent("PLAYER_XP_UPDATE",      "EventHandler")
    self:RegisterEvent("PLAYER_MONEY",          "EventHandler")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "EventHandler")
    self:RegisterEvent("ZONE_CHANGED",          "EventHandler")
    self:RegisterEvent("MINIMAP_ZONE_CHANGED",  "EventHandler")
    
    -- Hook the functions that need hooking
    -- (hook removal is done automagicaly by ACE)
    self:Hook("Logout", true)
    self:Hook("Quit",   true)
  
    -- Initialize values that don't change between reloads
    self.faction    = UnitFactionGroup("player")
    self.realm      = GetRealmName()
    self.pc         = UnitName("player")
    
    -- Initial update of values
    
    -- Is BC installed
    if(self.db.profile.options.bc_installed) then
    	self.max_pc_level = 70
    else
    	self.max_pc_level = 60
    end
    
    -- Get the values for the current character
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
    
    -- Start the Metrognome event to get an OnDataUpdate, OnUpdateText and OnUpdateTooltip every second
    -- or 20 seconds depending on the refresh_rate setting
	metro:RegisterMetro(self.name, self.Update, self.db.profile.options.refresh_rate, self)
	metro:StartMetro(self.name)
end

function AllPlayed:OnDisable()
    -- Stop the Metrognome event
--    if self.is_fubar_loaded then
        metro:UnregisterMetro(self.name)
--    else
    if not self.is_fubar_loaded then
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
-- check self.is_fubar_loaded
AllPlayed.OnMenuRequest = command_options
AllPlayed.hasIcon = "Interface\\Icons\\INV_Misc_PocketWatch_02.blp"
AllPlayed.defaultPosition = "LEFT"
AllPlayed.defaultMinimapPosition = 200
AllPlayed.cannotDetachTooltip = false
AllPlayed.hideWithoutStandby = true
AllPlayed.clickableTooltip = false 

function AllPlayed:OnDataUpdate()
    self:Debug("AllPlayed:OnDataUpdate()")
    
    -- Update the data that may have changed but are not tracked by an event
    self.db.account.data[self.faction][self.realm][self.pc].is_resting = IsResting()
    
    -- Recompute the totals
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
    self.total_faction[L["Horde"]].xp               = 0 
    self.total_faction[L["Alliance"]].time_played   = 0
    self.total_faction[L["Alliance"]].coin          = 0 
    self.total_faction[L["Alliance"]].xp            = 0 
    self.total.time_played                          = 0
    self.total.coin                                 = 0 
    self.total.xp                                   = 0
    
    -- Let all the factions, realms and PC be counted
    for faction, faction_table in pairs(self.db.account.data) do
        for realm, realm_table in pairs(faction_table) do
            self:Debug("faction: %s realm: %s", faction, realm)
            
            if not self.total_realm[faction] then self.total_realm[faction] = {} end
            if not self.total_realm[faction][realm] then self.total_realm[faction][realm] = {} end
            self.total_realm[faction][realm].time_played = 0
            self.total_realm[faction][realm].coin = 0
            self.total_realm[faction][realm].xp = 0
            for pc, pc_table in pairs(realm_table) do
                if not pc_table.is_ignored then
					-- Need to get the current seconds_played for the PC
					local seconds_played = self:EstimateTimePlayed(pc, 
																   realm, 
																   pc_table.seconds_played,
																   pc_table.seconds_played_last_update
										   )

					local pc_xp = pc_table.xp
					if (pc_xp ==-1) then pc_xp = 0 end

					pc_xp = pc_xp + XPToLevel(pc_table.level)

					self.total_faction[faction].time_played         = self.total_faction[faction].time_played       + seconds_played
					self.total_faction[faction].coin                = self.total_faction[faction].coin              + pc_table.coin
					self.total_faction[faction].xp                  = self.total_faction[faction].xp                + pc_xp
					self.total_realm[faction][realm].time_played    = self.total_realm[faction][realm].time_played  + seconds_played
					self.total_realm[faction][realm].coin           = self.total_realm[faction][realm].coin         + pc_table.coin
					self.total_realm[faction][realm].xp             = self.total_realm[faction][realm].xp           + pc_xp
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
            self.total.xp
                =   self.total_faction[L["Horde"]].xp
                  + self.total_faction[L["Alliance"]].xp
        else
            -- Only the current faction count
            self.total.time_played = self.total_faction[self.faction].time_played
            self.total.coin        = self.total_faction[self.faction].coin
            self.total.xp          = self.total_faction[self.faction].xp
        end
    else
        -- Only the current realm count (all_factions is ignore)
        self.total.time_played = self.total_realm[self.faction][self.realm].time_played
        self.total.coin        = self.total_realm[self.faction][self.realm].coin
        self.total.xp          = self.total_realm[self.faction][self.realm].xp
    end
end

-- Fill the tablet with the All Played information
function AllPlayed:FillTablet()
    self:Debug("AllPlayed:FillTablet()")
    self:Debug("=>self.total.time_played: ", self.total.time_played)
    
--    local estimated_rested_xp 	= 0
    local first_category 		= true
    local nb_columns = 2
    
    if self:GetShowLocation() ~= "none" then
        nb_columns = 3
    end

    -- Set the title for the table (just when using FuBar
    tablet:SetTitle(C:White(L["All Played Breakdown"]))
    
	local cat = tablet:AddCategory(
		'id', 'Normal Line',
		'columns', nb_columns,
		'child_indentation', 10,
		'hideBlankLine', false,
		'wrap', true,
		'child_size',  self:GetFontSize(),
		'child_size2', self:GetFontSize(),
		'child_size3', self:GetFontSize()

	)
	
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
                -- We do not print the realm if no option to select it is on
                -- and if the time played for the realm = 0 since this means
                -- all PC in the realm are ingored.
                if ((self.db.profile.options.all_realms or self.realm == realm)
                    and self.total_realm[faction][realm].time_played ~= 0
                ) then
                    --self:Debug("self.total_realm[faction][realm].time_played: ",self.total_realm[faction][realm].time_played)
                    
                    -- Build the Realm aggregated line
                    local text_realm = string.format( C:Yellow(L["%s characters "]) .. C:Green("[%s : ") .. "%s" ,
                                                      realm,
                                                      self:FormatTime(self.total_realm[faction][realm].time_played),
                                                      FormatMoney(self.total_realm[faction][realm].coin)
                                      )
                    if self.db.profile.options.show_xp_total then
                        text_realm = string.format( "%s " .. C:Green(": %s"),
                                                    text_realm,
                                                    FormatXP(self.total_realm[faction][realm].xp)
                                     )
                    end
                    
                    text_realm = text_realm .. C:Green("]")
                    
                    if first_category then
                    	first_category = false
                    else
						cat:AddLine(
						   'columns', 1,
						   'indentation', 0,
						   'text', " "
						)
                    end
                    
                    cat:AddLine(
                       'columns', 1,
                       'indentation', 0,
                       'text', text_realm
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
                            
                            local text_pc = FormatCharacterName( pc, 
                                                                 self.db.account.data[faction][realm][pc].level, 
                                                                 self.db.account.data[faction][realm][pc].xp,
                                                                 seconds_played, 
                                                                 self.db.account.data[faction][realm][pc].class, 
                                                                 self.db.account.data[faction][realm][pc].class_loc, 
                                                                 faction 
                                            )
                                            
							local text_location = ""
							if self:GetShowLocation() ~= "none" then
								 if self:GetShowLocation() == "loc"
                                    or 
                                    self.db.account.data[faction][realm][pc].zone_text == L["Unknown"]
                                    or 
                                    (self:GetShowLocation() == "loc/sub" and 
                                     self.db.account.data[faction][realm][pc].subzone_text == "")
                                 then
								 	text_location = FactionColour(
								 						faction,
								 						self.db.account.data[faction][realm][pc].zone_text
								 					)
								 elseif self:GetShowLocation() == "sub" then
								 	text_location = FactionColour(
								 						faction,
								 						self.db.account.data[faction][realm][pc].subzone_text
								 					)
								 else
								 	text_location = FactionColour(
								 						faction,
								 						self.db.account.data[faction][realm][pc].zone_text 
								 						.. '/' .. self.db.account.data[faction][realm][pc].subzone_text
								 					)							 
								 end
							end
							
                            
                            local text_coin = FormatMoney(self.db.account.data[faction][realm][pc].coin)
                            
                            if self.db.account.data[faction][realm][pc].level < self.max_pc_level and 
                               (self.db.account.data[faction][realm][pc].level > 1 or
                                self.db.account.data[faction][realm][pc].xp > 0)
                            then
                                -- How must rested XP do we have?
                                local estimated_rested_xp = self:EstimateRestedXP( 
                                                            pc, 
                                                            realm, 
                                                            self.db.account.data[faction][realm][pc].level, 
                                                            self.db.account.data[faction][realm][pc].rested_xp, 
                                                            self.db.account.data[faction][realm][pc].max_rested_xp, 
                                                            self.db.account.data[faction][realm][pc].last_update, 
                                                            self.db.account.data[faction][realm][pc].is_resting 
                                                      )
                            
                                -- Do we need to show the rested XP for the character?
                                if self:GetShowRestedXP() then
                                    text_coin = text_coin .. string.format( FactionColour( faction, L[" : %d rested XP"] ),
                                                                            estimated_rested_xp
                                                             )
                                end
                                
                                local percent_for_colour = estimated_rested_xp/self.db.account.data[faction][realm][pc].max_rested_xp
                                local countdown_seconds  = floor( TEN_DAYS * (1 - percent_for_colour) )
                                
                                -- The time to rest is way more if not in an inn or a major city
                                if not self.db.account.data[faction][realm][pc].is_resting then
                                    countdown_seconds = countdown_seconds * 4
                                end
                                
                                local text_countdown = ""
                                if percent_for_colour < 1 and ( self.db.account.data[faction][realm][pc].is_resting or
                                                                pc ~= self.pc or realm ~= self.realm
                                                              )
                                then
                                    text_countdown = self:FormatTime(countdown_seconds)
                                end
                                
                                -- Do we show the percent XP rested and/or the countdown until 100% rested?
                                if self:GetPercentRest() ~= "0" and self:GetShowRestedXPCountdown() and text_countdown ~= "" then
                                    text_coin = text_coin .. string.format( PercentColour(percent_for_colour, " (%d%% %s, -%s)"),
                                                                            self:GetPercentRest() * percent_for_colour,
                                                                            L["rested"],
                                                                            text_countdown
                                                             )
                                elseif self:GetPercentRest() ~= "0" then
                                    text_coin = text_coin .. string.format( PercentColour(percent_for_colour, " (%d%% %s)"),
                                                                            self:GetPercentRest() * percent_for_colour,
                                                                            L["rested"]
                                                             )
                                elseif self:GetShowRestedXPCountdown() and text_countdown ~= "" then
                                    text_coin = text_coin .. PercentColour( percent_for_colour, " (-" .. text_countdown .. ")" )
                                end
                            end
                            
                            if text_location ~= "" then
                            	cat:AddLine( 'text',  text_pc,
                            				 'text2', text_location,
                            				 'text3', text_coin
                        		)
                            else
                            	cat:AddLine( 'text',  text_pc,
                            	             'text2', text_coin
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
        'columns',     2,
		'child_size',  self:GetFontSize(),
		'child_size2', self:GetFontSize()
    )
    cat:AddLine(
        'text',  C:Orange( L["Total Time Played: "] ),
        'text2', C:Yellow( self:FormatTime(self.total.time_played) )
    )
    cat:AddLine(
        'text',  C:Orange( L["Total Cash Value: "] ),
        'text2', FormatMoney(self.total.coin)
    )
    
    if self.db.profile.options.show_xp_total then
       cat:AddLine(
           'text',  C:Orange( L["Total XP: "] ),
           'text2', C:Yellow( FormatXP(self.total.xp) )
       )
    end
    
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
        self.db.account.data[self.faction][self.realm][self.pc].class       = UnitClass("player")
    self.db.account.data[self.faction][self.realm][self.pc].level           = UnitLevel("player")
    self.db.account.data[self.faction][self.realm][self.pc].xp              = UnitXP("player")
    self.db.account.data[self.faction][self.realm][self.pc].max_rested_xp   = UnitXPMax("player") * 1.5
    self.db.account.data[self.faction][self.realm][self.pc].last_update     = time()
    self.db.account.data[self.faction][self.realm][self.pc].is_resting      = IsResting()
    self.db.account.data[self.faction][self.realm][self.pc].zone_text       = GetZoneText()
    self.db.account.data[self.faction][self.realm][self.pc].subzone_text    = GetSubZoneText()
    
    --self:Print("AllPlayed:SaveVar() Zone: ->%s<- ->%s<-", GetZoneText(), self.db.account.data[self.faction][self.realm][self.pc].zone_text)
    
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

--[[ Methods used for the option menu ]]--

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

    -- Refesh
    self:Update()
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
    
    -- Refesh
    self:Update()
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

    -- Refesh
    self:Update()
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
--        if self.is_fubar_loaded then
--            self:Update()
--        else
--            self:TimerUpdate()
--        end
    end
    
    -- Refesh
    self:Update()
   
end

-- Get the value of show_progress
function AllPlayed:GetShowProgress()
    self:Debug("AllPlayed:GetShowProgress: ", self.db.profile.options.show_progress)
    
    return self.db.profile.options.show_progress
end

-- Set the value of show_progress
function AllPlayed:SetShowProgress( value )
    self:Debug("AllPlayed:SetShowProgress: old %s, new %s", self.db.profile.options.show_progress, value )
    
    self.db.profile.options.show_progress = value

    -- Refesh
    self:Update()
end

-- Get the value of show_rested_xp
function AllPlayed:GetShowRestedXP()
    self:Debug("AllPlayed:GetShowRestedXP: ", self.db.profile.options.show_rested_xp)
    
    return self.db.profile.options.show_rested_xp
end

-- Set the value of show_rested_xp
function AllPlayed:SetShowRestedXP( value )
    self:Debug("AllPlayed:SetShowRestedXP: old %s, new %s", self.db.profile.options.show_rested_xp, value )
    
    self.db.profile.options.show_rested_xp = value

    -- Refesh
    self:Update()
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

    -- Refesh
    self:Update()
end

-- Get the value of show_rested_xp_countdown
function AllPlayed:GetShowRestedXPCountdown()
    self:Debug("AllPlayed:GetShowRestedXPCountdown: ", self.db.profile.options.show_rested_xp_countdown)
    
    return self.db.profile.options.show_rested_xp_countdown
end

-- Set the value of show_rested_xp_countdown
function AllPlayed:SetShowRestedXPCountdown( value )
    self:Debug("AllPlayed:SetShowRestedXPCountdown: old %s, new %s", self.db.profile.options.show_rested_xp_countdown, value )
    
    self.db.profile.options.show_rested_xp_countdown = value

    -- Refesh
    self:Update()
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

    -- Refesh
    self:Update()
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

    -- Refesh
    self:Update()
end

-- Get the value of show_xp_total
function AllPlayed:GetShowXPTotal()
    self:Debug("AllPlayed:GetShowXPTotal: ", self.db.profile.options.show_xp_total)
    
    return self.db.profile.options.show_xp_total
end

-- Set the value of show_xp_total
function AllPlayed:SetShowXPTotal( value )
    self:Debug("AllPlayed:SetShowXPTotal: old %s, new %s", self.db.profile.options.show_xp_total, value )
    
    self.db.profile.options.show_xp_total = value

    -- Refesh
    self:Update()
end

-- Get the value of show_location
function AllPlayed:GetShowLocation()
    self:Debug("AllPlayed:GetShowLocation: ", self.db.profile.options.show_location)
    
    return self.db.profile.options.show_location
end

-- Set the value of show_location
function AllPlayed:SetShowLocation( value )
    self:Debug("AllPlayed:SetShowLocation: old %s, new %s", self.db.profile.options.show_location, value )
    
    self.db.profile.options.show_location = value

    -- Refesh
    self:Update()
end

-- Get the current bc_installed value
function AllPlayed:GetIsBCInstalled()
    self:Debug("AllPlayed:GetIsBCInstalled: ",
               self.db.profile.options.bc_installed
    )

    return self.db.profile.options.bc_installed
end

-- Set the value for bc_installed
function AllPlayed:SetIsBCInstalled(value)
    self:Debug("AllPlayed:SetIsBCInstalled: ",value)
    
    self.db.profile.options.bc_installed = value

	-- The only difference is the maximum level that a PC can get to    
	if(value) then
		self.max_pc_level = 70
	else
		self.max_pc_level = 60
	end
    
    -- Compute the totals
    self:ComputeTotal()

    -- Refesh
    self:Update()
end

-- Get the value of font_size
function AllPlayed:GetFontSize()
    self:Debug("AllPlayed:GetFontSize: ", self.db.profile.options.font_size)
    
    return self.db.profile.options.font_size
end

-- Set the value of font_size
function AllPlayed:SetFontSize( value )
    self:Debug("AllPlayed:SetFontSize: old %s, new %s", self.db.profile.options.font_size, value )
    
    self.db.profile.options.font_size = value

    -- Refesh
    self:Update()
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
    return A:FormatDurationFull( seconds, false, not self:GetShowSeconds() )
end

function FormatXP(xp)
   local display_xp = ""
   
   if xp > 1000000 then
      -- Millions of XP
      display_xp = string.format( "%.1f M XP", xp / 1000000 )
   elseif xp > 1000 then
      -- Thousands of XP
      display_xp = string.format( "%.1f K XP", xp / 1000 )
   else
      -- Very few XP
      display_xp = string.format( "%d XP" , xp )
   end
   
   return display_xp
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
    return C:Colorize( C:GetThresholdHexColor( percent, 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1 ), string )
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
function FormatCharacterName( pc, level, xp, seconds_played, class, class_loc, faction )
    AllPlayed:Debug("FormatCharacterName: %s, %s, %s, %s, %s, %s, %s",pc, level, xp, seconds_played, class, class_loc, faction)
    
    if xp == nil then
        AllPlayed:Print("FormatCharacterName: %s, %s, %s, %s, %s, %s, %s",pc, level, xp, seconds_played, class, class_loc, faction)
    end

    local result_string     = ""
    local level_string      = ""
    
    -- Format the level string according to the show_progress option
    if AllPlayed:GetShowProgress() and xp ~= -1 then
        local progress = min( xp / XPToNextLevel(level), .99 )
        level_string = string.format( "%.2f" , level + progress )
    else
        level_string = string.format( "%d" , level )
   end
    
    -- Created use the all cap english name if the localized name is not present
    -- This should never happen but I like to code defensively
    local class_display = class_loc 
    if class_display == "" then class_display = class end
    
    if class_display ~= "" and AllPlayed:GetShowClassName() then
        level_string = string.format( "%s %s", class_display, level_string )
    end
    
    result_string =  string.format( ClassColour( class, faction, "%s (%s)" ) .. FactionColour( faction, " : %s" ),
                          pc,
                          level_string,
                          AllPlayed:FormatTime(seconds_played)
                    )
                    
    -- Do we need to show the total XP
    if AllPlayed:GetShowXPTotal() and xp ~= -1 then
        local pc_xp = xp + XPToLevel(level)
        result_string = result_string .. FactionColour( faction, " : " .. FormatXP(pc_xp) )
    end
    
    return result_string
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

-- This function caculate the number of XP to reach a particular level.
local XPToLevelCache  = {}
XPToLevelCache[0]     = 0
XPToLevelCache[1]     = 0
function XPToLevel( level )
    if XPToLevelCache[level] == nil then
        XPToLevelCache[level] = XPToNextLevel( level - 1 ) + XPToLevel( level - 1 )
--        if level > 1 then
--            XPToLevelCache[level] = XPToLevelCache[level] + XPToLevel( level - 1 )
--        end
    end

    return XPToLevelCache[level]
end

-- This function caculate the number of XP that you need at a particular level to reach
-- next level. Will need to review this when BC becomes live.
local XPToNextLevelCache = {}
-- Until there is a new formula for BC, I use the published XP values
XPToNextLevelCache[60]    = 494000
XPToNextLevelCache[61]    = 574700  
XPToNextLevelCache[62]    = 614400   
XPToNextLevelCache[63]    = 650300   
XPToNextLevelCache[64]    = 682300   
XPToNextLevelCache[65]    = 710200   
XPToNextLevelCache[66]    = 734100   
XPToNextLevelCache[67]    = 753700   
XPToNextLevelCache[68]    = 768900   
XPToNextLevelCache[69]    = 779700   
function XPToNextLevel( level )
    if XPToNextLevelCache[level] == nil then
        XPToNextLevelCache[level] = 40 * level^2 + (5 * level + 45) * XPDiff(level) + 360 * level
    end
    
    return XPToNextLevelCache[level]
end


-- This is a special function that is used to had difficulty (more XP) requirement after
-- level 28
function XPDiff( level )
   local x = max( level - 28, 0 )
   
   if ( x < 4 ) then
      return ( x * (x + 1) ) / 2
   else
      return 5 * (x - 2)
   end
end
