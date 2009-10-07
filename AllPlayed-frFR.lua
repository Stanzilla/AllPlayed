-- AllPlayed-frFR.lua
-- $Id: AllPlayed-frFR.lua 007 2008-10-22 11:48:03Z laotseu $
if not AllPlayed_revision then AllPlayed_revision = {} end
AllPlayed_revision.frFR	= ("$Revision$"):match("(%d+)")


local L = AceLibrary("AceLocale-2.2"):new("AllPlayed")

-- This is only a place-holder for future possible localisation files
L:RegisterTranslations("frFR", function()
    return {

        -- Faction names 
--        ["Alliance"]                                            		= "Alliance",
--        ["Horde"]                                               		= "Horde", 

        -- Tablet title
        ["All Played Breakdown"]                                		= "All Played",

        -- Menus
	    ["AllPlayed Configuration"]										= "Configuration AllPlayed",
        ["Display"]                                             		= "Afficher", 
        ["Set the display options"]                             		= "Afficher les options",
        ["All Factions"]                                        		= "Toutes les factions",
        ["All factions will be displayed"]                      		= "Afficher toutes les factions",
        ["All Realms"]                                          		= "Tous les royaumes",
        ["All realms will de displayed"]                        		= "Afficher tous les royaumes",
        ["Show Seconds"]                                        		= "Voir secondes", 
        ["Display the seconds in the time strings"]             		= "Afficher les secondes dans ...", 
        ["Show Gold"]                                       			= "Voir son Or",
        ["Display the gold each character pocess"]     		    		= "Voir total Or avec tous ses persos",
        ["Show XP Progress"]                                    		= "Voir progression de son XP",
        ["Display XP progress as a decimal value appended to the level"]       		= "Afficher le niveau actuel de son XP",
        ["Show XP total"]							 					= "Voir XP totale",
        ["Show the total XP for all characters"]						= "Voir XP totale de tous ses persos",
        ["Rested XP"]                                           		= "XP avant level",
        ["Set the rested XP options"]                               	= "Options pour XP avant level",
        ["Rested XP Total"]                                 			= "XP avant level ",
        ["Show the character rested XP"]                            	= "Voir XP avant level du personnage",
        ["Percent Rest"]                                            	= "Voir %XP avant level", 
        ["Set the base for % display of rested XP"]                 	= "Options pour %XP avant level", 
        ["Rested XP Countdown"]                                     	= "Compte à rebours XP avant level",
        ["Show the time remaining before the character is 100% rested"]	= "Afficher le temps restant avant que le personnage soit reposé à 100%",
        ["Show Class Name"]                                     		= "Afficher le nom de la classe",
        ["Show the character class beside the level"]           		= "Voir la classe du personnage à côté du niveau",
        ["Show Location"]												= "Afficher lieu",
        ["Show the character location"]			            			= "Afficher le lieu du personnage",
        ["Don't show location"]											= "Ne pas afficher le lieu",
        ["Show zone"]													= "Afficher la zone",
        ["Show subzone"]												= "Afficher la sous-zone",
        ["Show zone/subzone"]											= "Afficher zone/sous-zone",
        ["Colorize Class"]												= "Colorer classe",
        ["Colorize the character name based on class"]					= "Colorer le nom des personnages par classe",
        ["Use Old Shaman Colour"]										= "Utiliser ancienne couleur Chaman",
        ["Use the pre-210 patch colour for the Shaman class"]			= "Utilisez l'ancienne couleur pour la classe Chaman (patch 2.1)",
        ["Sort Type"]													= "Type de tri",
        ["Select the sort type"]										= "	Sélectionnez le type de tri",
        ["By name"]														= "Par nom",
        ["By level"]													= "Par niveau",
        ["By experience"]												= "Par XP",
	    ["By rested XP"]												= "Par XP avant niveau",
	    ["By % rested"]													= "Par %XP avant niveau",
        ["By money"]													= "Par Or",
        ["By time played"]												= "Par temps de jeu",
        ["Sort in reverse order"]										= "Trier dans l'ordre inverse",
        ["Use the curent sort type in reverse order"]					= "Inverser l'ordre de tri",
        ["Font Size"]													= "Taille de la police d'écriture",
        ["Select the font size"]										= "Choisir la police d'écriture",
        ["Opacity"]      												= "Transparence",
        ["% opacity of the tooltip background"]							= "% de transparence du fond",
        ["Sort"]														= "Trier par",
        ["Set the sort options"]										= "Options : trier par",
        ["Ignore Characters"]											= "Ignorer personnages",
        ["Hide characters from display"]                           		= "Cacher des personnages de l'affichage",
        ["Hide %s of %s from display"]				            		= "Cacher %s de %s de l'affichage",
        ["BC Installed?"]                                          		= "BC est installé?",
        ["Is the Burning Crusade expansion installed?"]            		= "Est-ce que l'extension Burning Crusade est installée ?",
        ["Close"]                                               		= "Fermer", 
        ["Close the tooltip"]                                   		= "Fermer le menu", 
        ["None"]                                                		= "Aucun",
		-- added By Orbital Digital For Translate French
		["Set the PVP options"]											= "Options PvP",
		["Honor Kills"]													= "Victoires honorables",
		["Show the character honor kills"]								= "Voir les victoires honorables",
		["Honor Points"]												= "Points d'honneur",
		["Show the character honor points"]								= "Voir les points d'honneur",
		["Arena Points"]												= "Points d'arène",
		["Show the character arena points"]								= "Voir les points d'arène",
		["Badges of Justice"]											= "Insignes de justice",
		["Show the character badges of Justice"]						= "Voir les insignes de justice",
		["AB Marks"]													= "Marque du Bassin",
		["Show the Arathi Basin Marks"]									= "Voir les marques du Bassin d'Arathi",
		["AV Marks"]													= "Marque Altérac",
		["Show the Alterac Valley Marks"]								= "Voir les marques de la Vallee d'Altérac",
		["WG Marks"]													= "Marque du Goulet",
		["Show the Warsong Gulch Marks"]								= "Voir les marques du Goulet des Chanteguerres",
		["EotS Marks"]													= "Marque du Cyclone",
		["Show the Eye of the Storm Marks"]								= "Voir les marques de l'Oeil du Cyclone",
		["Show PVP Totals"]												= "Afficher le total PVP",
		["Show the honor related stats for all characters"]				= "Voir le total des points de tous les personnages",
		

        -- Strings
        ["v%s - %s (Type /ap for help)"]                        		= "v%s - %s (Taper /ap pour afficher l'aide)",
        ["%s characters "]                                      		= "Personnages sur %s",
        ["%d rested XP"]                                     			= "%d XP avant level", 
        ["rested"]                                       		 	    = "reposé",
        ["Total %s Time Played: "]                              		= "Total %s temps joué : ",
        ["Total %s Cash Value: "]                               		= "Total %s Or: ", 
        ["Total Time Played: "]                                 		= "Total temps joué : ",
        ["Total Cash Value: "]                                  		= "Total Or: ", 
        ["Total XP: "]							   					    = "Total XP",
        ["Unknown"]								 					    = "Inconnu",
        ["%.1f M XP"]											        = "%.1f M XP",
        ["%.1f K XP"]							 				        = "%.1f K XP",
        ["%d XP"]												        = "%d XP",

        -- Console commands
        ["/allplayed"]                                          		= "/allplayed", 
        ["/ap"]                                                 		= "/ap", 
        ["/allplayedcl"]                                         		= "/allplayedcl", 
        ["/apcl"]                                                		= "/apcl", 

    }
end)
