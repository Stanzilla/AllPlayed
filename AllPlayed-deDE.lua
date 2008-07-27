-- AllPlayed-deDE.lua
-- $Id$
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.deDE	= ("$Revision$"):match("(%d+)")

local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("deDE", function()
    return {

        -- Faction names 
--        ["Alliance"]                                            		= "Allianz",
--        ["Horde"]                                               		= "Horde", 

        -- Tablet title
        ["All Played Breakdown"]                                		= "Auflistung der gesamten Spielzeit", 

        -- Menus
	 ["AllPlayed Configuration"]						= "AllPlayed Konfiguration",
        ["Display"]                                             		= "Anzeige", 
        ["Set the display options"]                             		= "Anezigeoptionen", 
        ["All Factions"]                                        		= "Alle Fraktionen", 
        ["All factions will be displayed"]                      		= "Alle Fraktionen werden angezeigt", 
        ["All Realms"]                                          		= "Alle Realms", 
        ["All realms will de displayed"]                        		= "Alle Realms werden angezeigt", 
        ["Show Seconds"]                                        		= "Zeige Sekunden", 
        ["Display the seconds in the time strings"]             		= "Zeige Sekunden in den Zeitstrings an", 
        ["Show Gold"]                                       			= "Zeige Gold",
        ["Display the gold each character pocess"]     		    	= "Zeigt das Gold an was jeder Charakter besitzt",
        ["Show XP Progress"]                                    		= "Zeige XP Verlauf",
        ["Display the level fraction based on curent XP"]       		= "Zeige Levelbruchteil basierend auf den aktuellen XP",
        ["Show XP total"]							 	= "Zeige Gesamt XP",
        ["Show the total XP for all characters"]				= "Zeige XP aller Charaktere insgesamt",
        ["Rested XP"]                                           		= "Erholt-XP",
        ["Set the rested XP options"]                               		= "Setzt die Erholt-XP Optionen",
        ["Rested XP Total"]                                 			= "Gesamt Erholt-XP",
        ["Show the character rested XP"]                            		= "Zeigt die Erholt-XP des Charakters",
        ["Percent Rest"]                                            		= "Zeige Erholt-XP in %", 
        ["Set the base for % display of rested XP"]                 		= "Setzt die Basis f\195\188r die Prozentanzeige der Erholt-XP", 
        ["Rested XP Countdown"]                                     		= "Erholt-XP Countdown",
        ["Show the time remaining before the character is 100% rested"]	= "Zeigt die Restezeit bis der Charakter 100% erholt ist",
        ["Show Class Name"]                                     		= "Zeige Klassennamen",
        ["Show the character class beside the level"]           		= "Zeigt die Charakterklasse neben dem Level",
        ["Show Location"]								= "Zeige Ort",
        ["Show the character location"]			            		= "Zeigt den Standort des Charakters",
        ["Don't show location"]							= "Zeige Ort nicht an",
        ["Show zone"]								= "Zeige Zone",
        ["Show subzone"]								= "Zeige Subzone",
        ["Show zone/subzone"]							= "Zeige Zone/Subzone",
        ["Colorize Class"]                                      		= "Klassen F\195\164rben",
        ["Colorize the character name based on class"]             		= "F\195\164rbe die Charakternamen nach Klasse",
        ["Use Old Shaman Colour"]							= "Alte Schmanenfarbe benutzen",
        ["Use the pre-210 patch colour for the Shaman class"]		  	= "Verwende die Farbe die vor dem 2.1 Patch f\195\188r Schmanen benutzt wurde",
        ["Sort Type"]								= "Sortiertyp",
        ["Select the sort type"]							= "W\195\164hlt den Sortiertyp aus",
        ["By name"]									= "Nach Namen",
        ["By level"]									= "Nach Farbe",
        ["By experience"]								= "Nach Erfahrung",
        ["By rested XP"]								= "Nach Erholt-XP",
        ["By % rested"]								= "Nach Erholt-%",
        ["By money"]									= "Nach Geld",
        ["By time played"]								= "Nach Spielzeit",
        ["Sort in reverse order"]							= "Sortiere in umgekehrter Reihenfolge",
        ["Use the curent sort type in reverse order"]				= "Sortiert nach ausgew\195\164hltem Sortiertyp in umgekehrter Reihenfolge",
        ["Font Size"]								= "Schriftgr\195\182\195\159e",
        ["Select the font size"]							= "W\195\164hlt die Schriftgr\195\182\195\159e aus",
        ["Opacity"]      								= "Transparenz",
        ["% opacity of the tooltip background"]					= "Transparenz in % des Tooltiphintergrundes",
        ["Sort"]									= "Sortieren",
        ["Set the sort options"]							= "Setzt die Sortieroptionen",
        ["Ignore Characters"]                                       		= "Ignoriere Charaktere", 
        ["Hide characters from display"]                           		= "Versteckt Charaktere", 
        ["Hide %s of %s from display"]				            	= "Versteckt %s von %s",
        ["BC Installed?"]                                          		= "BC Installiert", 
        ["Is the Burning Crusade expansion installed?"]            		= "Ist die Burning Crusade Erweiterung Installiert?", 
        ["Close"]                                               		= "Schlie\195\159en", 
        ["Close the tooltip"]                                   		= "Schlie\195\159t den Tooltip", 
        ["None"]                                                		= "Kein",

        -- Strings
        ["v%s - %s (Type /ap for help)"]                        		= "v%s - %s (Tippe /ap f\195\188r Hilfe)", 
        ["%s characters "]                                      		= "%s Charaktere ", 
        ["%d rested XP"]                                     			= "%d Erholt-XP", 
        ["rested"]                                       		       = "Erholt", 
        ["Total %s Time Played: "]                              		= "Gesamt %s Zeit gespielt: ", 
        ["Total %s Cash Value: "]                               		= "Gesamt %s Gold: ", 
        ["Total Time Played: "]                                 		= "Gesamt Zeit gespielt: ", 
        ["Total Cash Value: "]                                  		= "Gesamt Gold: ", 
        ["Total XP: "]							       = "Gesamt XP",
        ["Unknown"]								       = "Unbekannt",
        ["%.1f M XP"]							       = "%.1f M XP",
        ["%.1f K XP"]							       = "%.1f K XP",
        ["%d XP"]								       = "%d XP",

        -- Console commands
        ["/allplayed"]                                          		= "/allplayed", 
        ["/ap"]                                                 		= "/ap", 
        ["/allplayedcl"]                                         		= "/allplayedcl", 
        ["/apcl"]                                                		= "/apcl", 

    }
end)
