[b]Current Version: 1.0.alpha.$Revision$[/b] 
 
[SIZE=3][b]AllPlayed[/b][/SIZE]

[b]Description:[/b]
AllPlayed display the total time played, rested XP and money for each of your WoW characters. It's just a snapshot of the current
state, no history, no stats. You can look at the total time you have played WoW and be proud (or afraid ;-). My personal time is 
a bit over 60 days. I'm sure some people out there have way bigger totals. It would be fun to ear about it.

AllPlayed is a re-write in Ace2 of an addon created by Riboflavin and latter updated to Titan AllPlayed. I didn't use any of the code
from the original addons but I tried to emulate the output of them as mush as I could. I really missed Titan AllPlayed after
I start using FuBar and since the originals appear to no longer be supported, I rolled up my sleeves and did something about it.

This is my first addon. I hold no responsibility if something breaks, smokes start coming off you computer or if there
is a flood in your village. I'm also not responsible if your brain turn into oatmeal after looking at my code but
comments are welcome.

[b]Features:[/b][list]
[*]Show the time played, rested XP and money for each of your characters
[*]Show the total time played and money per realm, per faction or for all your characters
[*]FuBar support
[/list]

[b]Initial Setup:[/b][list]
[*]Install the addon in you Word of Warcraft\Interface\Addons\ directory. There are no dependencies (well, except 
FuBar for now, see the To Do list).
[*]Logon with each of your characters to populate the AllPlayed data.
[/list]

[b]To Do (before official release):[/b][list]
[*]Make FuBar an optional dependency to allow AllPlayed to run without it installed. This is useful when migrating from
Titan to FuBar and haven't yet done it for all your PC.
[*]Remove/comment out all the AceDebug and the debug code
[/list]

[b]To Do (eventually):[/b][list]
[*]Stop metrognome when nothing displayed needs the update i.e. when Show Text is off and the main frame is not displayed.
[*]Options to sort per level, per money or per rested XP
[*]Options to display the characters without grouping them per Realm
[*]A way to ignore characters without having to log with them
[*]Option to ignore whole realm
[/list]


[b]Command List:[/b]
[i]All of these commands are available from both the command line and dropdown config menu.[/i]
[list][*][i]/ap[/i] - Main chat command
[list]
[*][i]display[/i] - Set the display options 
[list]
[*][i]all_factions[/i] - All factions will be displayed if on. Only the current faction
will be displayed if off.
[*][i]all_realms[/i] - All realms will de displayed if on. Only the current realm will
be displayed if off. Note: if all_realms is off, all_factions is ignored.
[*][i]show_seconds[/i] - Display the seconds in the time strings. 
[*][i]percent_rest[/i] - Set the base for % display of rested XP. This can be 100% or 150%.
[list]
[*][i]ignore[/i] - Ignore the current PC. It won't be displayed and won't affect the totals. Currently, this only to
ignore a PC is to logon with it and select ignore. I plan to change that.
[*][i]report[/i] - Print the report in the default chat window.
[/list]

[b]Note:[/b][list]
[*]When the FuBar part of the addon is active, AllPlayed will recompute the data based on the [i]show_sconds[/i]
option. If [i]show_seconds[/i] is on, the data will be compute every second. If [i]show_seconds[/i] is off, the will compute every 20 seconds.
If you fear that the addon will take mush resource, do not display the seconds. If the addon is disable in FuBar, the automatic refresh is 
also disable but the console part will still work.
[/list]