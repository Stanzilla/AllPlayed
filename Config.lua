local AP_display_name, AP = ...

-- Config.lua
-- $Id$

-- Localize some lua globals
local _G = getfenv(0)

local assert = _G.assert
local pairs = _G.pairs
local pairs = _G.pairs
local select = _G.select
local tonumber = _G.tonumber

local LibStub = _G.LibStub

if not _G.AllPlayed_revision then _G.AllPlayed_revision = {} end
_G.AllPlayed_revision.config	= ("$Revision$"):match("(%d+)")

local AllPlayed = _G.AllPlayed

-- Backward compatibility stuff
local IS_40 = (select(4, _G.GetBuildInfo()) >= 40000)

-- Localizations
local L = LibStub("AceLocale-3.0"):GetLocale("AllPlayed")

-- Local functions
local GetVersionString
local ReturnConfigMenu
local DisplayConfigMenu
local InitConfig

-- Icons
local valor_icon = "\124TInterface\\Icons\\pvecurrency-valor:0:0:2:0:64:64\124t"
local justice_icon = "\124TInterface\\Icons\\pvecurrency-justice:0:0:2:0:64:64\124t"
local honor_alliance_icon = '\124TInterface\\PVPFrame\\PVP-Currency-Alliance:0:0:2:0:32:32\124t'
local honor_horde_icon = '\124TInterface\\PVPFrame\\PVP-Currency-Horde:0:0:2:0:32:32\124t'
if IS_40 then
	honor_alliance_icon = '\124TInterface\\Icons\\PVPCurrency-Honor-Alliance:0:0:2:0:64:64\124t'
	honor_horde_icon = '\124TInterface\\Icons\\PVPCurrency-Honor-Horde:0:0:2:0:64:64\124t'
end
local conquest_alliance_icon = '\124TInterface\\Icons\\PVPCurrency-Conquest-Alliance:0:0:2:0:64:64\124t'
local conquest_horde_icon = '\124TInterface\\Icons\\PVPCurrency-Conquest-Horde:0:0:2:0:64:64\124t'
local arena_icon = '\124TInterface\\PVPFrame\\PVP-ArenaPoints-Icon:0:0:2:0:32:32\124t'
local kill_icon = '\124TInterface\\Icons\\Spell_Holy_BlessingOfStrength:0:0:2:0:64:64\124t'
local ap_icon = '\124TInterface\\Icons\\INV_Misc_PocketWatch_02:0:0\124t'

-- Version iditification management
do
	local version_string = nil

	function GetVersionString()
		if not version_string then
			-- Find the curent revision number from all the files revisions
			local revision = 0
			if _G.AllPlayed_revision then
				for _, rev in pairs(_G.AllPlayed_revision) do
					local rev = tonumber(rev)
					if rev and rev > revision then revision = rev end
				end
			else
				assert(false,"No AllPlayed_revision")
			end

			-- Find the curent version
			local version = _G.GetAddOnMetadata("AllPlayed", "Version"):match("([^ ]+)")

			version_string = (L["Version %s (r%s)"]):format(version, revision)
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
					text = (L["%s (%s)"]):format(L["Valor Points"],valor_icon);
					hasArrow = true;
					menuList = {
						[1] = {
							text = (L["Show %s"]):format(L["Valor Points"]);
							tooltipText = (L["Display the %s each character pocess"]):format(L["Valor Points"]);
							checked = 'show_valor_points';
						},
						[2] = {
							text = (L["Show %s total"]):format(L["Valor Points"]);
							tooltipText = (L["Show the total %s for all characters"]):format(L["Valor Points"]);
							checked = 'show_valor_total';
						},
					},
				},
				[10] = {
					text = (L["%s (%s)"]):format(L["Justice Points"],justice_icon);
					hasArrow = true;
					menuList = {
						[1] = {
							text = (L["Show %s"]):format(L["Justice Points"]);
							tooltipText = (L["Display the %s each character pocess"]):format(L["Justice Points"]);
							checked = 'show_justice_points';
						},
						[2] = {
							text = (L["Show %s total"]):format(L["Justice Points"]);
							tooltipText = (L["Show the total %s for all characters"]):format(L["Justice Points"]);
							checked = 'show_justice_total';
						},
					},
				},
				[11] = {
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
				[12] = {
					text = L["PVP"];
					tooltipText = L["Set the PVP options"];
					hasArrow = true;
					menuList = {
						[1] = {
							text = (L["%s (%s)"]):format(L["Honor Kills"], kill_icon);
							tooltipText = L["Show the character honor kills"];
							checked = 'show_honor_kills';
						},
						[2] = {
							text = (L["%s (%s or %s)"]):format(L["Honor Points"], honor_alliance_icon, honor_horde_icon);
							tooltipText = (L['Display the %s each character pocess']):format(L["Honor Points"]);
							checked = 'show_honor_points';
						},
						[3] = {
							text = (L["%s (%s)"]):format(L["Arena Points"], arena_icon);
							tooltipText = (L['Display the %s each character pocess']):format(L["Arena Points"]);
							checked = 'show_arena_points';
						},
						[4] = {
							text = L["Show PVP Totals"];
							tooltipText = L["Show the honor related stats for all characters"];
							checked = 'show_pvp_totals';
						},
					},
				},
				[13] = {
					text = L["Show Class Name"];
					tooltipText = L["Show the character class beside the level"];
					checked = 'show_class_name';
				},
				[14] = {
					text = L["Colorize Class"];
					tooltipText = L["Colorize the character name based on class"];
					checked = 'colorize_class';
				},
				[15] = {
					text = L["Use Old Shaman Colour"];
					tooltipText = L["Use the pre-210 patch colour for the Shaman class"];
					checked = 'use_pre_210_shaman_colour';
				},
				[16] = {
					text = L["Show Item Level"];
					tooltipText = L["Show the character item level (iLevel)"];
					checked = 'show_ilevel';
				},
				[17] = {
					text = L["Use Icons"];
					tooltipText = L["Use graphics for coin and PvP currencies"];
					checked = 'use_icons';
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
							text = L["By item level"];
							list = 'sort_type';
							arg1 = "ilevel";
						},
						[4] = {
							text = L["By experience"];
							list = 'sort_type';
							arg1 = "xp";
						},
						[5] = {
							text = L["By rested XP"];
							list = 'sort_type';
							arg1 = "rested_xp";
						},
						[6] = {
							text = L["By money"];
							list = 'sort_type';
							arg1 = "coin";
						},
						[7] = {
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
		[9] = {
			text = L["Configuration"];
			tooltipText = L["Open configuration dialog"];
			tooltipOnButton = 1;
			func = function() _G.InterfaceOptionsFrame_OpenToCategory(AP_display_name) end;
		},
	}

	-- No area points in Cataclysm, conquest point instead
	if IS_40 then
		config_menu[4].menuList[11].menuList[3].text = (L['Display the %s each character pocess']):format(
																			   L["Conquest Points"],
																			   conquest_alliance_icon,
																			   conquest_horde_icon)
		config_menu[4].menuList[11].menuList[3].tooltipText = (L['Display the %s each character pocess']):format(L["Conquest Points"])
		config_menu[4].menuList[11].menuList[3].checked = 'show_conquest_points'
	end

	-- No Valor or Justice points before Cataclysm
	if not IS_40 then
		for i=9,14 do
			config_menu[4].menuList[i] = config_menu[4].menuList[i+2]
		end
		config_menu[4].menuList[15] = nil
		config_menu[4].menuList[16] = nil
	end

	-- Set version for display
	config_menu[2].text = GetVersionString()

	-- All the checkbox options need to have their menu with the menu button
	-- and a pair of function to get and set the options
	local function AddCheckboxOption(menu)

		local foundCheck = false

		for i=1,#menu do
			-- For Cataclysm only
			if IS_40 then
				menu[i].isNotRadio = true
				if not menu[i].checked and not menu[i].list then
					menu[i].notCheckable = true
					menu[i].text = "|TInterface\Common\UI-SliderBar-Background:0:1.5:0:0:8:8|t" .. menu[i].text
				end
			end

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
				if IS_40 then
					menu[i].isNotRadio = nil
				end
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

		end

		-- Set notCheckable if no checkable items were found
		if not foundCheck then
			for i=1,#menu do
				menu[i].notCheckable = 1
			end
		end
	end
	AddCheckboxOption(config_menu)

	-- Build the ignored list
	local i = 1
	for faction, faction_table in pairs(AP.db.global.data) do
		for realm, realm_table in pairs(faction_table) do
			for pc, _ in pairs(realm_table) do
				local pc_name = (L["%s : %s"]):format(realm, pc)
				config_menu[6].menuList[i] = {
					text = pc_name;
					tooltipText = (L["Hide %s of %s from display"]):format(pc, realm);
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
				-- Specify no radial button for Cataclysm
				if IS_40 then config_menu[6].menuList[i].isNotRadio = true end

				i = i + 1
			end
		end
	end

	return config_menu
end

do
	local dropdownFrame = _G.CreateFrame("Frame", "AllPlayedDropdownMenu", nil, "UIDropDownMenuTemplate")

	function DisplayConfigMenu(anchorFrame)
		local anchor
		if anchorFrame then
			anchor = anchorFrame:GetName()
		else
			anchor = "cursor"
		end

		_G.EasyMenu(AP.config_menu, dropdownFrame, anchor, nil, nil, "MENU")
	end
end -- do

-- Option management
local function GetOptions()
	local options = {
		name = ap_icon .. " " .. AP_display_name,
		childGroups = "tab",
		type = "group",
		order = 1,
		args = {
			display = {
				type = 'group', name = L["Display"], desc = L["Specify what to display"], args = {
					main = {
						type = 'header',
						name = L["Main Settings"],
						order     = 1,
					},
					show_coins = {
						name      = L["Show Gold"],
						desc      = L["Display the gold each character pocess"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_coins') end,
						set       = function(info, v) AllPlayed:SetOption('show_coins',v) end,
						order     = 1.1,
					},
					use_icons = {
						name      = L["Use Icons"],
						desc      = L["Use graphics for coin and PvP currencies"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('use_icons') end,
						set       = function(info, v) AllPlayed:SetOption('use_icons',v) end,
						order     = 1.2,
					},
					show_class_name = {
						name      = L["Show Class Name"],
						desc      = L["Show the character class beside the level"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_class_name') end,
						set       = function(info, v) AllPlayed:SetOption('show_class_name',v) end,
						order     = 1.3,
					},
					colorize_class = {
						name      = L["Colorize Class"],
						desc      = L["Colorize the character name based on class"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('colorize_class') end,
						set       = function(info, v) AllPlayed:SetOption('colorize_class',v) end,
						order     = 1.4,
					},
					use_pre_210_shaman_colour = {
						name      = L["Use Old Shaman Colour"],
						desc      = L["Use the pre-210 patch colour for the Shaman class"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('use_pre_210_shaman_colour') end,
						set       = function(info, v) AllPlayed:SetOption('use_pre_210_shaman_colour',v) end,
						order     = 1.5,
					},
					show_ilevel = {
						name      = L["Show Item Level"],
						desc      = L["Show the character item level (iLevel)"],
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_ilevel') end,
						set       = function(info, v) AllPlayed:SetOption('show_ilevel',v) end,
						order     = 1.6,
					},
					show_location = {
						name      = L["Show Location"],
						desc      = L["Show the character location"],
						width		 = "full",
						type      = 'select',
						get       = function() return AllPlayed:GetOption('show_location') end,
						set       = function(info, v) AllPlayed:SetOption('show_location',v) end,
						values    = { ["none"]      = L["Don't show location"],
										 ["loc"]       = L["Show zone"],
										 ["sub"]       = L["Show subzone"],
										 ["loc/sub"]   = L["Show zone/subzone"]
						},
						order     = 1.7,
					},
					valor = {
						type = 'header',
						name = (L["%s (%s)"]):format(L["Valor Points"],valor_icon),
						order     = 1.8,
					},
					show_valor_points = {
						name      = (L["Show %s"]):format(L["Valor Points"]),
						desc      = (L["Display the %s each character pocess"]):format(L["Valor Points"]),
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_valor_points') end,
						set       = function(info, v) AllPlayed:SetOption('show_valor_points',v) end,
						order     = 1.81,
					},
					show_valor_total = {
						name      = (L["Show %s total"]):format(L["Valor Points"]),
						desc      = (L["Show the total %s for all characters"]):format(L["Valor Points"]),
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_valor_total') end,
						set       = function(info, v) AllPlayed:SetOption('show_valor_total',v) end,
						order     = 1.82,
					},
					justice = {
						type = 'header',
						name = (L["%s (%s)"]):format(L["Justice Points"],justice_icon),
						order     = 1.9,
					},
					show_justice_points = {
						name      = (L["Show %s"]):format(L["Justice Points"]),
						desc      = (L["Display the %s each character pocess"]):format(L["Justice Points"]),
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_justice_points') end,
						set       = function(info, v) AllPlayed:SetOption('show_justice_points',v) end,
						order     = 1.91,
					},
					show_justice_total = {
						name      = (L["Show %s total"]):format(L["Justice Points"]),
						desc      = (L["Show the total %s for all characters"]):format(L["Justice Points"]),
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_justice_total') end,
						set       = function(info, v) AllPlayed:SetOption('show_justice_total',v) end,
						order     = 1.92,
					},
					faction_and_realms = {
						type = 'header',
						name = L["Factions and Realms"],
						order     = 2,
					},
					 all_factions = {
						  name      = L["All Factions"],
						  desc      = L["All factions will be displayed"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('all_factions') end,
						  set       = function(info, v) AllPlayed:SetOption('all_factions',v) end,
						  order     = 2.1,
					 },
					 all_realms = {
						  name      = L["All Realms"],
						  desc      = L["All realms will de displayed"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('all_realms') end,
						  set       = function(info, v) AllPlayed:SetOption('all_realms',v) end,
						  order     = 2.2,
					 },
					time = {
						type = 'header',
						name = L["Time Played"],
						order     = 3,
					},
					 show_played_time = {
						  name      = L["Show Played Time"],
						  desc      = L["Display the played time and the total time played"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('show_played_time') end,
						  set       = function(info, v) AllPlayed:SetOption('show_played_time',v) end,
						  order     = 3.1,
					 },
					 show_seconds = {
						  name      = L["Show Seconds"],
						  desc      = L["Display the seconds in the time strings"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('show_seconds') end,
						  set       = function(info, v) AllPlayed:SetOption('show_seconds',v) end,
						  order     = 3.2,
					 },
					xp = {
						type = 'header',
						name = L["Experience Points"],
						order     = 5,
					},
					 show_progress = {
						  name      = L["Show XP Progress"],
						  desc      = L["Display XP progress as a decimal value appended to the level"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('show_progress') end,
						  set       = function(info, v) AllPlayed:SetOption('show_progress',v) end,
						  order     = 5.1,
					 },
					 show_xp_total = {
						  name      = L["Show XP total"],
						  desc      = L["Show the total XP for all characters"],
						  type      = 'toggle',
						  get       = function() return AllPlayed:GetOption('show_xp_total') end,
						  set       = function(info, v) AllPlayed:SetOption('show_xp_total',v) end,
						  order     = 5.2,
					 },
					 show_rested_xp = {
						 name        = L["Rested XP Total"],
						 desc        = L["Show the character rested XP"],
						 type        = 'toggle',
						 get       	 = function() return AllPlayed:GetOption('show_rested_xp') end,
						 set       	 = function(info, v) AllPlayed:SetOption('show_rested_xp',v) end,
						 order 		 = 5.3,
					 },
					 show_rested_xp_countdown = {
						 name        = L["Rested XP Countdown"],
						 desc        = L["Show the time remaining before the character is 100% rested"],
						 type        = 'toggle',
						 get       	 = function() return AllPlayed:GetOption('show_rested_xp_countdown') end,
						 set       	 = function(info, v) AllPlayed:SetOption('show_rested_xp_countdown',v) end,
						 order 		 = 5.4,
					},
					 percent_rest = {
						 name        = L["Percent Rest"],
						 desc        = L["Set the base for % display of rested XP"],
						 type        = 'select',
						 get       	 = function() return AllPlayed:GetOption('percent_rest') end,
						 set       	 = function(info, v) AllPlayed:SetOption('percent_rest',v) end,
						 values    	 = { ["0"] = L["Do not show Percent Rest"], ["100"] = L["100%"], ["150"] = L["150%"] },
						 order       = 5.5,
					},
					sort = {
						type = 'header',
						name = L["Sort Order"],
						order = 9,
					},
					sort_type = {
						name      = L["Sort Type"],
						desc      = L["Select the sort type"],
						type      = 'select',
						get       = function() return AllPlayed:GetOption('sort_type') end,
						set       = function(info, v) AllPlayed:SetOption('sort_type',v) end,
						values  = {
									  ["alpha"] 			= L["By name"],
									  ["level"] 			= L["By level"],
									  ["ilevel"] 			= L["By item level"],
									  ["xp"]					= L["By experience"],
									  ["rested_xp"]		= L["By rested XP"],
									  ["percent_rest"]	= L["By % rested"],
									  ["coin"]				= L["By money"],
									  ["time_played"]		= L["By time played"],
						},
						order     = 9.1,
					},
					reverse_sort = {
					  name      = L["Sort in reverse order"],
					  desc      = L["Use the curent sort type in reverse order"],
					  type      = 'toggle',
					  get       = function() return AllPlayed:GetOption('reverse_sort') end,
					  set       = function(info, v) AllPlayed:SetOption('reverse_sort',v) end,
					  order     = 9.2,
					},
					pvp = {
						type = 'header',
						name = L["PVP"],
						desc = L["Set the PVP options"],
						order     = 11,
					},
					show_honor_kills= {
						name        = L["Honor Kills"],
						name        = (L["%s (%s)"]):format(L["Honor Kills"], kill_icon),
						desc        = L["Show the character honor kills"],
						type        = 'toggle',
						get       	= function() return AllPlayed:GetOption('show_honor_kills') end,
						set       	= function(info, v) AllPlayed:SetOption('show_honor_kills',v) end,
						order = 11.1,
					},
					show_honor_points = {
						name        = (L["%s (%s or %s)"]):format(L["Honor Points"], honor_alliance_icon, honor_horde_icon),
						desc        = (L['Display the %s each character pocess']):format(L["Honor Points"]),
						type        = 'toggle',
						get       	= function() return AllPlayed:GetOption('show_honor_points') end,
						set       	= function(info, v) AllPlayed:SetOption('show_honor_points',v) end,
						order = 11.2,
					},
					show_arena_points	= {
						name        = (L["%s (%s)"]):format(L["Arena Points"], arena_icon),
						desc        = (L['Display the %s each character pocess']):format(L["Arena Points"]),
						type        = 'toggle',
						get       	= function() return AllPlayed:GetOption('show_arena_points') end,
						set       	= function(info, v) AllPlayed:SetOption('show_arena_points',v) end,
						order = 11.3,
					},
					show_pvp_totals = {
						name        = L["Show PVP Totals"],
						desc        = L["Show the honor related stats for all characters"],
						type        = 'toggle',
						get         = function() return AllPlayed:GetOption('show_pvp_totals') end,
						set         = function(info, v) AllPlayed:SetOption('show_pvp_totals',v) end,
						order = 11.4,
					},
				}, order = 10,
			},
			ignore = {
				name    = L["Ignore Characters"],
				desc    = L["Hide characters from display"],
				type    = 'group',
				args    = {
					ignore_desc = {
						name = L["Hide characters from display"],
						type = 'description',
						order = .5,
					},
					ignore_desc2 = {
						name = " ",
						type = 'description',
						order = .7,
					},
				},
				order   = 20
			},
			ui = {
				type = 'group', name = L["UI"], desc = L["Set UI options"], args = {
					show_minimap_icon = {
						name      = L["Minimap Icon"],
						desc      = L["Show Minimap Icon"],
						width		= "full",
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('show_minimap_icon') end,
						set       = function(info, v) AllPlayed:SetOption('show_minimap_icon',v) end,
						order     = .5,
					},
					tooltip_scale = {
						name      = L["Scale"],
						desc      = L["Scale the tooltip (70% to 150%)"],
						width		= "full",
						type      = 'range',
						min		  = .7,
						max       = 1.5,
						step      = .05,
						isPercent = true,
						get       = function() return AllPlayed:GetOption('tooltip_scale') end,
						set       = function(info, v) AllPlayed:SetOption('tooltip_scale',v) end,
						order     = .6,
					},
					opacity = {
						name      = L["Opacity"],
						desc      = L["% opacity of the tooltip background"],
						width		= "full",
						type      = 'range',
						min		  = 0,
						max       = 1,
						step      = .05,
						isPercent = true,
						get       = function() return AllPlayed:GetOption('opacity') end,
						set       = function(info, v) AllPlayed:SetOption('opacity',v) end,
						order     = .7,
					},
					tooltip_delay = {
						name      = L["Display Delay"],
						desc      = L["How long should the tooltip be displayed after the mouse is moved out."],
						width		= "full",
						type      = 'range',
						min		  = 0,
						max       = 1.5,
						step      = .05,
						isPercent = false,
						get       = function() return AllPlayed:GetOption('tooltip_delay') end,
						set       = function(info, v) AllPlayed:SetOption('tooltip_delay',v) end,
						order     = .8,
					},
					tooltip_keep_on_mouseover = {
						name      = L["Sticky Tooltip"],
						desc      = L["Keep displaying the tooltip when the mouse is over it. If uncheck, the tooltip is displayed only when mousing over the icon."],
						width		= "full",
						type      = 'toggle',
						get       = function() return AllPlayed:GetOption('tooltip_keep_on_mouseover') end,
						set       = function(info, v) AllPlayed:SetOption('tooltip_keep_on_mouseover',v) end,
						order     = .9,
					},
				}, order = 30,
			},
		},
	}

	-- Arena points do not exists in Cataclysm but Conquest points do
	if IS_40 then
		options.args.display.args.show_arena_points = nil
		options.args.display.args.show_conquest_points = {
						name        = (L["%s (%s or %s)"]):format(L["Conquest Pts"], conquest_alliance_icon, conquest_horde_icon),
						desc        = (L['Display the %s each character pocess']):format(L["Conquest Points"]),
						type        = 'toggle',
						get       	= function() return AllPlayed:GetOption('show_conquest_points') end,
						set       	= function(info, v) AllPlayed:SetOption('show_conquest_points',v) end,
						order = 11.3,
		}
	end

	-- Justice Points shouuld not be displayed before Cataclysm
	if not IS_40 then
		options.args.display.args.justice = nil
		options.args.display.args.show_valor_points = nil
		options.args.display.args.show_justice_points = nil
		options.args.display.args.show_justice_total = nil
	end

	-- Ignore section
	local faction_order = 1
	for faction, faction_table in pairs(AP.db.global.data) do
		local faction_id = "faction" .. faction_order
		options.args.ignore.args[faction_id] = {
				type 	= 'group',
				name 	= faction,
				args	= {},
		}
		faction_order = faction_order + 1

		local realm_order = 1
		for realm, realm_table in pairs(faction_table) do
			local realm_id = "realm" .. realm_order
			options.args.ignore.args[faction_id].args[realm_id] = {
				type 	= 'group',
				name 	= realm,
				args	= {},
			}

			local pc_order = 1
			for pc, _ in pairs(realm_table) do
				local pc_id = "pc" .. pc_order
				options.args.ignore.args[faction_id].args[realm_id].args[pc_id] = {
					name = pc,
					desc = (L["Hide %s of %s from display"]):format(pc, realm),
					type = 'toggle',
					get  = function() return AllPlayed:GetOption('is_ignored',realm, pc) end,
					set  = function(info, value) AllPlayed:SetOption('is_ignored', value, realm, pc) end
				}

				pc_order = pc_order + 1
			end

			realm_order = realm_order + 1
	  	end
	end

	-- Profile section
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(AP.db)

	return options

end

-- Configuration initialization
local function InitConfig()
	-- Get the AllPlayed global
	AllPlayed = _G.AllPlayed

	-- Initialize config menu
	AP.config_menu = ReturnConfigMenu()

	-- Initialized options panel
	LibStub("AceConfig-3.0"):RegisterOptionsTable(AP_display_name, GetOptions())
	AP.options_frame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(AP_display_name)

	-- About section
	if LibStub:GetLibrary("LibAboutPanel", true) then
		LibStub:GetLibrary("LibAboutPanel").new(AP_display_name, AP_display_name)
	end
end

-- Functions used outside of Config.lua
AP.DisplayConfigMenu 		= DisplayConfigMenu
AP.GetVersionString 			= GetVersionString
AP.InitConfig					= InitConfig
