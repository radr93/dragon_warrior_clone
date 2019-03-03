/// @description Initialize Variables

// Enumerate Item Information
#region Enumerate Item IDs
enum itemID{
	#region Weapons
	bambooPole,
	club,
	shortSword,
	handAxe,
	broadSword,
	flameSword,
	erdricksSword,
	#endregion
	#region Armor
	clothing,
	leatherArmor,
	chainMail,
	halfPlate,
	fullPlate,
	enchantedPlate,
	erdricksArmor,
	#endregion
	#region Shields
	buckler,
	kiteShield,
	gildedShield,
	#endregion
	#region Usable
	potion,
	magicDust,
	torch,
	#endregion
	#region Passive
	dragonScale,
	#endregion
	#region Key Items
	skeletonKey,
	#endregion
	
	MAX
}

#endregion
#region Enumerate Item Effects
enum itemEffect{
	none,
	augmentAttack,
	augmentDefence,
	heal,
	teleHome,
	illuminate,

	MAX
	
}
#endregion
#region Enumerate Item Properties
enum itemProp{
	id,
	name,
	sprite,
	description,
	usable,
	equippable,
	passive,
	key,
	effect,
	effectValue,
	effectRange,
	cost,
	
	MAX
	
}
#endregion
#region Enumerate Item Database Columns
enum idb{
	id,
	name,
	sprite,
	description,
	usable,
	equippable,
	passive,
	key,
	effect,
	effectValue,
	effectRange,
	cost,
	
	MAX
}
#endregion

// Load the database
itemDB = load_csv("databases/items/itemDB.csv");

// Convert all numbers from strings to real
itemDB = ds_grid_number_strings_to_real(itemDB);

// Convert all sprites from strings to sprite indices
var hh = ds_grid_height(itemDB);
for (var r = 0; r < hh; r++){
	itemDB[# idb.sprite, r] = asset_get_index(itemDB[# idb.sprite, r]);
}

// Convert all effects from string to enum value
for (var r = 0; r < hh; r++){
	switch (itemDB[# idb.effect, r]){
		case "none":			itemDB[# idb.effect, r] = itemEffect.none;
		case "augmentAttack":	itemDB[# idb.effect, r] = itemEffect.augmentAttack;
		case "augmentDefence":	itemDB[# idb.effect, r] = itemEffect.augmentDefence;
		case "heal":			itemDB[# idb.effect, r] = itemEffect.heal;
		case "teleHome":		itemDB[# idb.effect, r] = itemEffect.teleHome;
		case "illuminate":		itemDB[# idb.effect, r] = itemEffect.illuminate;
	}
}