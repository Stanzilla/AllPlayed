local AP_display_name, AP = ...

-- Config.lua
-- $Id$

if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.config	= ("$Revision$"):match("(%d+)")

-- Libraries
local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- Local functions
local GetVersionString
local ReturnConfigMenu
local DisplayConfigMenu
local InitConfig

-- Version iditification management
do
	local version_string = nil

	function GetVersionString()
		if not version_string then
			-- Find the curent revision number from all the files revisions
			local revision = 0
			if AllPlayed_revision then
				for _, rev in pairs(AllPlayed_revision) do
					local rev = tonumber(rev)
					if rev and rev > revision then revision = rev end
				end
			else
				assert(false,"No AllPlayed_revision")
			end

			-- Find the curent version
			local version = GetAddOnMetadata("AllPlayed", "Version"):match("([^ ]+)")

			version_string = string.format(L["Version %s (r%s)"], version, revision)
		end
		
		return version_string
	end
end -- do

-- Menu management
local function ReturnConfigMenu()
	-- This funciton is called only once. Otherwise, I would recycle the table
	local config_menu = {
		[1] = {
			text = L["AllPlayed Configuration"];
			isTitle = true;
		},
		[2] = {
			isTitle = true;
		},
		[3] = {
			text = " ";
			disabled = true;
		},
		[4] = {
			text = L["Display"],
			tooltipText = L["Set the display options"];
			hasArrow = true;
			menuList = {
				[1] = {
					text = L["All Factions"];
					tooltipText = L["All factions will be displayed"];
					checked = 'all_factions';
				},
				[2] = {
					text = L["All Realms"];
					tooltipText = L["All realms will de displayed"];
					checked = 'all_realms';
				},
				[3] = {
					text = L["Show Played Time"];
					tooltipText = L["Display the played time and the total time played"];
					checked = 'show_played_time';
				},
				[4] = {
					text = L["Show Seconds"];
					tooltipText = L["Display the seconds in the time strings"];
					checked = 'show_seconds';
				},
				[5] = {
					text = L["Show Gold"];
					tooltipText = L["Display the gold each character pocess"];
					checked = 'show_coins';
				},
				[6] = {
					text = L["Show XP Progress"];
					tooltipText = L["Display XP progress as a decimal value appended to the level"];
					checked = 'show_progress';
				},
				[7] = {
					text = L["Show XP total"];
					tooltipText = L["Show the total XP for all characters"];
					checked = 'show_xp_total';
				},
				[8] = {
					text = L["Show Location"];
					tooltipText = L["Show the character location"];
					hasArrow = true;
					menuList = {
						[1] = {
							text = L["Don't show location"];
							list = 'show_location';
							arg1 = "none";
						},
						[2] = {
							text = L["Show zone"];
							list = 'show_location';
							arg1 = "loc";
						},
						[3] = {
							text = L["Show subzone"];
							list = 'show_location';
							arg1 = "sub";
						},
						[4] = {
							text = L["Show zone/subzone"];
							list = 'show_location';
							arg1 = "loc/sub";
						},
					},
				},
				[9] = {
					text = L["Rested XP"];
					tooltipText = L["Set the rested XP options"];
					hasArrow = true;
					menuList = {
						[1] = {
							text = L["Rested XP Total"];
							tooltipText = L["Show the character rested XP"];
							checked = 'show_rested_xp';
						},
						[2] = {
							text = L["Percent Rest"];
							tooltipText = L["Set the base for % display of rested XP"];
							hasArrow = true;
							menuList = {
								[1] = {
									text = L["None"];
									list = 'percent_rest';
									arg1 = "0";
								},
								[2] = {
									text = L["100%"];
									list = 'percent_rest';
									arg1 = "100";
								},
								[3] = {
									text = L["150%"];
									list = 'percent_rest';
									arg1 = "150";
								},
							},
						},
						[3] = {
							text = L["Rested XP Countdown"];
							tooltipText = L["Show the time remaining before the character is 100% rested"];
							checked = 'show_rested_xp_countdown';
						},
					},
				},
				[10] = {
					text = L["PVP"];
					tooltipText = L["Set the PVP options"];
					hasArrow = true;
					menuList = {
						[1] = {
							text = L["Honor Kills"];
							tooltipText = L["Show the character honor kills"];
							checked = 'show_honor_kills';
						},
						[2] = {
							text = L["Honor Points"];
							tooltipText = L["Show the character honor points"];
							checked = 'show_honor_points';
						},
						[3] = {
							text = L["Arena Points"];
							tooltipText = L["Show the character arena points"];
							checked = 'show_arena_points';
						},
						[4] = {
							text = L["Show PVP Totals"];
							tooltipText = L["Show the honor related stats for all characters"];
							checked = 'show_pvp_totals';
						},
					},
				},
				[11] = {
					text = L["Show Class Name"];
					tooltipText = L["Show the character class beside the level"];
					checked = 'show_class_name';
				},
				[12] = {
					text = L["Colorize Class"];
					tooltipText = L["Colorize the character name based on class"];
					checked = 'colorize_class';
				},
				[13] = {
					text = L["Use Old Shaman Colour"];
					tooltipText = L["Use the pre-210 patch colour for the Shaman class"];
					checked = 'use_pre_210_shaman_colour';
				},
				[14] = {
					text = L["Use Icons"];
					tooltipText = L["Use graphics for coin and PvP currencies"];
					checked = 'use_icons';
				},
				[15] = {
					text = L["Scale"];
					tooltipText = L["Scale the tooltip (70% to 150%)"];
					disabled = true;
				},
				[16] = {
					text = L["Opacity"];
					tooltipText = L["% opacity of the tooltip background"];
					disabled = true;
				},
			},
		},
		[5] = {
			text = L["Sort"],
			tooltipText = L["Set the sort options"];
			hasArrow = true;
			menuList = {
				[1] = {
					text = L["Sort Type"],
					tooltipText = L["Select the sort type"];
					hasArrow = true;
					menuList = {
						[1] = {
							text = L["By name"];
							list = 'sort_type';
							arg1 = "alpha";
						},
						[2] = {
							text = L["By level"];
							list = 'sort_type';
							arg1 = "level";
						},
						[3] = {
							text = L["By experience"];
							list = 'sort_type';
							arg1 = "xp";
						},
						[4] = {
							text = L["By rested XP"];
							list = 'sort_type';
							arg1 = "rested_xp";
						},
						[5] = {
							text = L["By money"];
							list = 'sort_type';
							arg1 = "coin";
						},
						[6] = {
							text = L["By time played"];
							list = 'sort_type';
							arg1 = "time_played";
						},
					},
				},
				[2] = {
					text = L["Sort in reverse order"];
					tooltipText = L["Use the curent sort type in reverse order"];
					checked = 'reverse_sort';
				},
			},
		},
		[6] = {
			text = L["Ignore Characters"],
			tooltipText = L["Hide characters from display"];
			hasArrow = true;
			menuList = {
			},
		},
		[7] = {
			text = " ";
			disabled = true;
		},
		[8] = {
			text = L["Minimap Icon"];
			tooltipText = L["Show Minimap Icon"];
			checked = 'show_minimap_icon';
		},
	}	

	-- Set version for display
	config_menu[2].text = GetVersionString()
	
	-- All the checkbox option need to have their menu with the menu button
	-- and a pair of function to get and set the options
	local function AddCheckboxOption(menu)
	
		local foundCheck = false
		
		for i=1,#menu do
			if menu[i].checked then 
				menu[i].tooltipOnButton = 1 
				menu[i].keepShownOnClick = 1
				menu[i].value = menu[i].checked
				menu[i].checked = function() return AllPlayed:GetOption(menu[i].value) end
				menu[i].func = function(dropdownmenu, arg1, arg2, checked) 
					AllPlayed:SetOption(dropdownmenu.value, not AllPlayed:GetOption(dropdownmenu.value)) 
				end
				foundCheck = true
			end
			
			-- For options where you choose one choice from a list of set arguments
			-- arg1 contains the choice
			if menu[i].list then
				menu[i].tooltipOnButton = 1 
				menu[i].value = menu[i].list
				menu[i].checked = function() return AllPlayed:GetOption(menu[i].value) == menu[i].arg1 end
				menu[i].func = function(dropdownmenu, arg1, arg2, checked) 
					AllPlayed:SetOption(dropdownmenu.value, arg1) 
				end
				menu[i].list = nil
				foundCheck = true
			end
			
			-- Submenus
			if menu[i].menuList then AddCheckboxOption(menu[i].menuList) end
			
			-- Set notCheckable if no checkable items were found
		end
		
		if not foundCheck then
			for i=1,#menu do
				menu[i].notCheckable = 1
			end
		end
	end
	AddCheckboxOption(config_menu)
	
	-- Build the ignored list
	local i = 1
	for faction, faction_table in pairs(AP.db.account.data) do
		for realm, realm_table in pairs(faction_table) do
			for pc, _ in pairs(realm_table) do
				local pc_name = format(L["%s : %s"], realm, pc)
				config_menu[6].menuList[i] = {
					text = pc_name;
					tooltipText = string.format(L["Hide %s of %s from display"], pc, realm);
					tooltipOnButton = 1;
					keepShownOnClick = 1;
					checked = function() return AllPlayed:GetOption('is_ignored',realm, pc) end;
					func = function(dropdownmenu, arg1, arg2, checked) 
						AllPlayed:SetOption(
							'is_ignored', 
							not AllPlayed:GetOption('is_ignored',realm, pc), 
							realm, 
							pc
						)
					end;
				}
				i = i + 1
			end
		end
	end

	return config_menu
end

do
	local dropdownFrame = CreateFrame("Frame", "AllPlayedDropdownMenu", anchor, "UIDropDownMenuTemplate")

	function DisplayConfigMenu(anchorFrame)
		local anchor
		if anchorFrame then
			anchor = anchorFrame:GetName()
		else
			anchor = "cursor"
		end
		
		EasyMenu(AP.config_menu, dropdownFrame, anchor, nil, nil, "MENU")
	end
end -- do

-- Configuration initialization
local function InitConfig()
	-- Initialize config menu
	AP.config_menu = ReturnConfigMenu()
end

-- Functions used outside of Config.lua
AP.DisplayConfigMenu 		= DisplayConfigMenu
AP.GetVersionString 			= GetVersionString
AP.InitConfig					= InitConfig
