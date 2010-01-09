﻿-- AllPlayed-enUS.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.enUS	= ("$Revision$"):match("(%d+)")


local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("enUS", function()
	return {

		-- Faction names
		["Alliance"]                                            				= true,
		["Horde"]                                               				= true,

		-- Tablet title
		["All Played Breakdown"]                                				= true,

		-- Menus
		["AllPlayed Configuration"]													= true,
		["Version %s (r%s)"]																= true,
		["Display"]                                             				= true,
		["Set the display options"]                             				= true,
		["All Factions"]                                        				= true,
		["All factions will be displayed"]                      				= true,
		["All Realms"]                                          				= true,
		["All realms will de displayed"]                        				= true,
		["Show Played Time"]																= true,
		["Display the played time and the total time played"]					= true,
		["Show Seconds"]                                        				= true,
		["Display the seconds in the time strings"]             				= true,
		["Show Gold"]                                    						= true,
		["Display the gold each character pocess"]     							= true,
		["Show XP Progress"]                                    				= true,
		["Display XP progress as a decimal value appended to the level"]	= true,
		["Show XP total"]																	= true,
		["Show the total XP for all characters"]									= true,
		["Rested XP"]                                           				= true,
		["Set the rested XP options"]                                   	= true,
		["Rested XP Total"]                                             	= true,
		["Show the character rested XP"]                                	= true,
		["Percent Rest"]                                                	= true,
		["Set the base for % display of rested XP"]                     	= true,
		["Rested XP Countdown"]                                         	= true,
		["Show the time remaining before the character is 100% rested"]	= true,
		["PVP"]																				= true,
		["Set the PVP options"]															= true,
		["Arena Points"]																	= true,
		["Show the character arena points"]											= true,
		["Honor Points"]																	= true,
		["Show the character honor points"]											= true,
		["Honor Kills"]																	= true,
		["Show the character honor kills"]											= true,
		["Show PVP Totals"]																= true,
		["Badges of Justice"]															= true,
		["Show the character badges of Justice"]									= true,
		["WG Marks"]																		= true,
		["Show the Warsong Gulch Marks"]												= true,
		["AB Marks"]																		= true,
		["Show the Arathi Basin Marks"]												= true,
		["AV Marks"]																		= true,
		["Show the Alterac Valley Marks"]											= true,
		["EotS Marks"]																		= true,
		["Show the Eye of the Storm Marks"]											= true,
		["Show the honor related stats for all characters"]					= true,
		["Show Class Name"]                                     				= true,
		["Show the character class beside the level"]           				= true,
		["Show Location"]																	= true,
		["Show the character location"]												= true,
		["Don't show location"]															= true,
		["Show zone"]																		= true,
		["Show subzone"]																	= true,
		["Show zone/subzone"]															= true,
		["Colorize Class"]                                  	    			= true,
		["Colorize the character name based on class"]      	    			= true,
		["Use Old Shaman Colour"]														= true,
		["Use the pre-210 patch colour for the Shaman class"]					= true,
		["Sort Type"]																		= true,
		["Select the sort type"]														= true,
		["By name"]																			= true,
		["By level"]																		= true,
		["By experience"]																	= true,
		["By rested XP"]																	= true,
		["By % rested"]																	= true,
		["By money"]																		= true,
		["By time played"]																= true,
		["Sort in reverse order"]														= true,
		["Use the curent sort type in reverse order"]							= true,
		["Use Icons"]																		= true,
		["Use graphics for coin and PvP currencies"]								= true,
		["Minimap Icon"]																	= true,
		["Show Minimap Icon"]															= true,
		["Scale"]																			= true,
		["Scale the tooltip (70% to 150%)"]											= true,
		["Opacity"]      																	= true,
		["% opacity of the tooltip background"]									= true,
		["Sort"]																				= true,
		["Set the sort options"]														= true,
		["Ignore Characters"]                                      			= true,
		["Hide characters from display"]                           			= true,
		["%s : %s"]																			= true,
		["Hide %s of %s from display"]												= true,
		["BC Installed?"]                                          			= true,
		["Is the Burning Crusade expansion installed?"]            			= true,
		["Close"]                                        	       			= true,
		["Close the tooltip"]                            	       			= true,
		["None"]                                         	       			= true,
		["100%"]																				= true,
		["150%"]																				= true,

		["Filter"]																			= true,
		["Specify what to display"]													= true,
		["Configuration"]																	= true,
		["Open configuration dialog"]													= true,
		["Factions and Realms"]															= true,
		["Time Played"]																	= true,
		["About"]																			= true,
		["UI Settings"]																	= true,
		["Set UI options"]																= true,
		["Experience Points"]															= true,
		["Sort Order"]																		= true,
		["Main Settings"]																	= true,
		["Do not show Percent Rest"]													= true,

		-- Strings
		["v%s - %s (Type /ap for help)"]                 	       			= true,
		["%s characters "]                               	       			= true,
		["%d rested XP"]                                 	    				= true,
		["rested"]                                       		        		= true,
		["Total %s Time Played: "]                              				= true,
		["Total %s Cash Value: "]                               				= true,
		["Total Time Played: "]                                 				= true,
		["Total Cash Value: "]                                  				= true,
		["Total PvP: "]																	= true,
		["Total XP: "]																		= true,
		["Unknown"]																			= true,
		["%.1f M XP"]																		= true,
		["%.1f K XP"]																		= true,
		["%d XP"]																			= true,
		['%s HK']																			= true,
		['%s HP']																			= true,
		['%s AP']																			= true,
		['%s BoJ']																			= true,
		['%s AB']																			= true,
		['%s AV']																			= true,
		['%s WG']																			= true,
		['%s EotS']																			= true,

		-- Console commands
		["/allplayed"]                                   	       			= true,
		["/ap"]                                          	       			= true,
		["/allplayedcl"]                                          			= true,
		["/apcl"]                                                 			= true,

	}
end)
