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
        ["All Played Breakdown"]                                		= "All Played Liste", 

        -- Menus
	    ["AllPlayed Configuration"]										= "AllPlayed Configuration",
        ["Display"]                                             		= "Afficher", 
        ["Set the display options"]                             		= "Afficher les Options", 
        ["All Factions"]                                        		= "Toutes les Factions", 
        ["All factions will be displayed"]                      		= "Afficher Toutes les Factions", 
        ["All Realms"]                                          		= "Tous les Royaumes", 
        ["All realms will de displayed"]                        		= "Afficher Tous les Royaumes", 
        ["Show Seconds"]                                        		= "Voir secondes", 
        ["Display the seconds in the time strings"]             		= "Afficher les secondes dans ...", 
        ["Show Gold"]                                       			= "Voir son Or",
        ["Display the gold each character pocess"]     		    		= "Voir Total Or avec tous ses persos",
        ["Show XP Progress"]                                    		= "Voir progression de son XP",
        ["Display the level fraction based on curent XP"]       		= "Afficher le niveau actuel de son XP",
        ["Show XP total"]							 					= "Voir XP Total",
        ["Show the total XP for all characters"]						= "Voir XP Total de ts ses persos",
        ["Rested XP"]                                           		= "XP avant level",
        ["Set the rested XP options"]                               	= "Options pour XP avant level",
        ["Rested XP Total"]                                 			= "XP avant level ",
        ["Show the character rested XP"]                            	= "Voir XP avant level du personnage",
        ["Percent Rest"]                                            	= "Voir %XP avant level", 
        ["Set the base for % display of rested XP"]                 	= "Options pour %XP avant level", 
        ["Rested XP Countdown"]                                     	= "Compte a rebours XP avant level",
        ["Show the time remaining before the character is 100% rested"]	= "Afficher le temps restant avant 100% du personnage",
        ["Show Class Name"]                                     		= "Afficher le nom de la Classe",
        ["Show the character class beside the level"]           		= "Voir la classe du personnage a cote du niveau",
        ["Show Location"]												= "Afficher localisation",
        ["Show the character location"]			            			= "Afficher localisation du personnage",
        ["Don't show location"]											= "Ne pas afficher la localisation",
        ["Show zone"]													= "Afficher la Zone",
        ["Show subzone"]												= "Afficher la Sous-Zone",
        ["Show zone/subzone"]											= "Afficher Zone/Sous-Zone",
        ["Colorize Class"]                                      		= "Coloriez Classe",
        ["Colorize the character name based on class"]             		= "Colorier le Nom des personnage par classe",
        ["Use Old Shaman Colour"]										= "Utiliser ancienne couleur Chaman",
        ["Use the pre-210 patch colour for the Shaman class"]		  	= "Utilisez le Patch des couleur de la version 2.1 pour la classe chaman",
        ["Sort Type"]													= "Type de Tri",
        ["Select the sort type"]										= "	Selectionnez le type de tri",
        ["By name"]														= "Par Nom",
        ["By level"]													= "Par Level",
        ["By experience"]												= "Par XP",
	    ["By rested XP"]											= "Par Xp avant level",
	    ["By % rested"]												= "Par %Xp avant level",
        ["By money"]													= "Par Or",
        ["By time played"]												= "Par Temps de jeu",
        ["Sort in reverse order"]										= "Trier dans l'ordre inverse",
        ["Use the curent sort type in reverse order"]					= "Inverser l'ordre de tri",
        ["Font Size"]													= "Taille de la police d ecrtiure",
        ["Select the font size"]										= "Choisir la police d ecriture",
        ["Opacity"]      												= "Transparence",
        ["% opacity of the tooltip background"]							= "% de Transparence du fond",
        ["Sort"]														= "Trier par",
        ["Set the sort options"]										= "Options : Trier par",
        ["Ignore Characters"]                                      		= "Ignorer Personnages", 
        ["Hide characters from display"]                           		= "Versteckt Charaktere", 
        ["Hide %s of %s from display"]				            		= "Versteckt %s von %s",
        ["BC Installed?"]                                          		= "BC est Installer?", 
        ["Is the Burning Crusade expansion installed?"]            		= "	Est-ce que l'expansion Burning Crusade est installé?", 
        ["Close"]                                               		= "Fermer", 
        ["Close the tooltip"]                                   		= "Fermer le menu", 
        ["None"]                                                		= "Aucun",
		-- added By Orbital Digital For Translate French
		["Set the PVP options"]											= "Options PvP",
		["Honor Kills"]													= "Honneur Tuer",
		["Show the character honor kills"]								= "Voir les Honneur Tuer",
		["Honor Points"]												= "Points Honneur",
		["Show the character honor points"]								= "Voir les points Honneur",
		["Arena Points"]												= "Points Arene",
		["Show the character arena points"]								= "Voir les points Arene",
		["Badges of Justice"]											= "Insignes de Justice",
		["Show the character badges of Justice"]						= "Voir les Insignes de Justice",
		["AB Marks"]													= "Marque du Bassin",
		["Show the Arathi Basin Marks"]									= "Voir les marques du Bassin d Arathi",
		["AV Marks"]													= "Marque Alterac",
		["Show the Alterac Valley Marks"]								= "Voir les marques de la Vallee d Alterac",
		["WG Marks"]													= "Marque du Goulet",
		["Show the Warsong Gulch Marks"]								= "Voir les marques du Goulet des Chanteguerres",
		["EotS Marks"]													= "Marque du Cyclone",
		["Show the Eye of the Storm Marks"]								= "Voir les marques de l Oeil du Cyclone",
		["Show PVP Totals"]												= "Voir tous les points PVP",
		["Show the honor related stats for all characters"]				= "Voir les poitns d honneur de tous les personnages",
		

        -- Strings
        ["v%s - %s (Type /ap for help)"]                        		= "v%s - %s (Taper /ap pour afficher l aide)", 
        ["%s characters "]                                      		= "%s Personnages ", 
        ["%d rested XP"]                                     			= "%d XP avant level", 
        ["rested"]                                       		 	    = "Vous etes Reposer", 
        ["Total %s Time Played: "]                              		= "Total %s temps jouer: ", 
        ["Total %s Cash Value: "]                               		= "Total %s Or: ", 
        ["Total Time Played: "]                                 		= "Total temps jouer: ", 
        ["Total Cash Value: "]                                  		= "Total Or: ", 
        ["Total XP: "]							   					    = "Total XP",
        ["Unknown"]								 					    = "Unconnu",
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
