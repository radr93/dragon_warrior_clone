/*

player_get_defence();

This script calculates the player's defence stat.

Returns defence [real]

*/

// Initialize Variables
var player, stats, equip, items, itemDB, defence;

player = obj_PlayerController;
stats = player.stats;
equip = player.equip;
items = player.items;
itemDB = obj_ItemDatabase.itemDB;

// Defence always at least 1/2 of agility
defence = floor(stats[playerStat.agility]/2);

// If armor is equipped
if (equip[equipSlot.armor] != -1){
	var index = ds_grid_value_y(itemDB, 0, 1, 0, ds_grid_height(itemDB)-1, equip[equipSlot.armor]);
	defence += itemDB[# idb.effectValue, index];
}

// If a shield is equipped
if (equip[equipSlot.shield] != -1){
	var index = ds_grid_value_y(itemDB, 0, 1, 0, ds_grid_height(itemDB)-1, equip[equipSlot.shield]);
	defence += itemDB[# idb.effectValue, index];
}

// Loop through items for passive bonuses
for (var i = 0; i < itemID.MAX; i++){
	
	// Augment Defence
	if (items[i] > 0){
		var index = ds_grid_value_y(itemDB, 0, 1, 0, ds_grid_height(itemDB)-1, i);
		
		if (itemDB[# itemProp.effect, index] == itemEffect.augmentDefence){
			
			defence += itemDB[# idb.effectValue, index];
		}
	}
}

return(defence);