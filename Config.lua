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
			if not foundCheck then
				for i=1,#menu do
					menu[i].notCheckable = 1
				end
			end
		end
	end
	AddCheckboxOption(config_menu)
	
	return config_menu
end

--[[
	[2] = {
		text = "Stack";
		tooltipText = "Compresses your inventory.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("stack") end;
	},
	[3] = {
		text = "Defrag";
		tooltipText = "Defragments your inventory.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("defrag") end;
	},
	[4] = {
		text = "Sort";
		tooltipText = "Sorts your inventory.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("sort") end;
	},
	[5] = {
		text = "Consolidate";
		tooltipText = "Consolidates your inventory.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("consolidate") end;
	},
	[6] = {
		text = "The Works";
		tooltipText = "Stacks, plows and sorts. All in one.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("theworks") end;
	},
	[7] = {
		text = " ";
		disabled = true;
	},
	[8] = {
		text = "Bank";
		hasArrow = true;
		disabled = not isGBankShown;
		menuList = {
			[1] = {
				text = "Bank Stack";
				tooltipText = "Compresses your bank.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("bankstack") end;
				disabled = not isBankShown;
			},
			[2] = {
				text = "Bank Defrag";
				tooltipText = "Defragments your bank.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("bankdefrag") end;
				disabled = not isBankShown;
			},
			[3] = {
				text = "Bank Sort";
				tooltipText = "Sorts your bank.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("banksort") end;
				disabled = not isBankShown;
			},
			[4] = {
				text = "Bank Consolidate";
				tooltipText = "Consolidate your bank.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("bankconsolidate") end;
				disabled = not isBankShown;
			},
			[5] = {
				text = "Bank The Works";
				tooltipText = "Stacks, plows and sorts your bank. All in one.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("banktheworks") end;
				disabled = not isBankShown;
			},
		};
	},
	[9] = {
		text = "Guild Bank";
		hasArrow = true;
		disabled = not isGBankShown;
		menuList = {
			[1] = {
				text = "Guild Bank Stack";
				tooltipText = "Compresses your guild bank.";
				tooltipOnButton = 1;
				func = function() MrPlow:DoStuff("gbankstack") end;
				tooltipOnButton = 1;
				disabled = not isGBankShown;
			},
			[2] = {
				text = "Guild Bank Defrag";
				tooltipText = "Defragments your guild bank.";
				func = function() MrPlow:DoStuff("gbankdefrag") end;
				tooltipOnButton = 1;
				disabled = not isGBankShown;
			},
			[3] = {
				text = "Guild Bank Sort";
				tooltipText = "Sorts your guild bank.";
				func = function() MrPlow:DoStuff("gbanksort") end;
				tooltipOnButton = 1;
				disabled = not isGBankShown;
			},
			[4] = {
				text = "Guild Bank The Works";
				tooltipText = "Stacks, plows and sorts your guild bank. All in one.";
				func = function() MrPlow:DoStuff("gbanktheworks") end;
				tooltipOnButton = 1;
				disabled = not isGBankShown;
			},
		};
	},
	[10] = {
		text = " ";
		disabled = true;
	},
	[11] = {
		text = "Stop";
		tooltipText = "Stops the current plow job.";
		tooltipOnButton = 1;
		func = function() MrPlow:DoStuff("stop") end;
	},
	[12] = {
		text = toggle_action .. " minimap button";
		tooltipText = toggle_action .. " the minimap button.";
		tooltipOnButton = 1;
		func = function() 
			if not db.hide then 
				db.hide = true
				icon:Hide("MrPlowLDB")
			else 
				db.hide = nil
				icon:Show("MrPlowLDB") 
			end 
		end;
	},
]]--

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
