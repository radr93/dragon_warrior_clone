/*

player_get_attackpower();

This script calculates the player's attack power stat.

Returns attack power [real]

*/

// Initialize Variables
var player, stats, equip, items, itemDB, attackPower;

player = obj_PlayerController;
stats = player.stats;
equip = player.equip;
items = player.items;
itemDB = obj_ItemDatabase.itemDB;

// Attack power always at least equal to strength
attackPower = stats[playerStat.strength];

// If a weapon is equipped, add weapon's power to attack power
if (equip[equipSlot.weapon] != -1){
	var index = ds_grid_value_y(itemDB, 0, 1, 0, ds_grid_height(itemDB)-1, equip[equipSlot.weapon]);
	attackPower += itemDB[# idb.effectValue, index];
}

return(attackPower);