/// @description Initialize Variables

// Enumerate Spell Information
#region Enumerate Spell IDs
enum spellID{
	alleviate,
	afflict,
	entrance,
	illuminate,
	silence,
	weaken,
	teleOut,
	teleHome,
	intimidate,
	revivify,
	destroy,
	
	MAX
}

#endregion
#region Enumerate Spell Effects
enum spellEffect{
	heal,
	damage,
	sleep,
	illuminate,
	silence,
	debuff,
	teleOut,
	teleHome,
	repel,
	
	MAX
}

#endregion
#region Enumerate Spell Properties
enum spellProp{
	id,
	name,
	sprite,
	description,
	reqLevel,
	spellCost,
	usableInBattle,
	usableOutOfBattle,
	spellEffect,
	effectMin,
	effectMax,
	MAX
}
#endregion
#region Enumerate Spell Database Columns
enum sdb{
	id,
	name,
	sprite,
	description,
	reqLevel,
	spellCost,
	usableInBattle,
	usableOutOfBattle,
	spellEffect,
	effectMin,
	effectMax,
	
	MAX	
}
#endregion

// Load the database
spellDB = load_csv("databases/spellDB.csv");

// Convert all numbers from strings to real
spellDB = ds_grid_number_strings_to_real(spellDB);

// Convert all sprites from strings to sprite indices and booleans from string to boolean
var hh = ds_grid_height(spellDB);
for (var r = 0; r < hh; r++){
	
	// Sprite from string to asset index
	spellDB[# sdb.sprite, r] = asset_get_index(spellDB[# idb.sprite, r]);
	
	// Usable in battle booleans
	if (spellDB[# sdb.usableInBattle, r] == "true"){	spellDB[# sdb.usableInBattle, r] = true;	}
	else	{	spellDB[# sdb.usableInBattle, r] = false;	}
	
	// Usable out of battle booleans
	if (spellDB[# sdb.usableOutOfBattle, r] == "true"){	spellDB[# sdb.usableOutOfBattle, r] = true;	}
	else	{	spellDB[# sdb.usableOutOfBattle, r] = false;	}
	
	// Spell effects string to enum
	switch (spellDB[# sdb.spellEffect, r]){
	
		case "heal":		spellDB[# sdb.spellEffect, r] = spellEffect.heal;			break;
		case "damage":		spellDB[# sdb.spellEffect, r] = spellEffect.damage;			break;
		case "sleep":		spellDB[# sdb.spellEffect, r] = spellEffect.sleep;			break;
		case "illuminate":	spellDB[# sdb.spellEffect, r] = spellEffect.illuminate;		break;
		case "silence":		spellDB[# sdb.spellEffect, r] = spellEffect.silence;		break;
		case "debuff":		spellDB[# sdb.spellEffect, r] = spellEffect.debuff;			break;
		case "teleOut":		spellDB[# sdb.spellEffect, r] = spellEffect.teleOut;		break;
		case "teleHome":	spellDB[# sdb.spellEffect, r] = spellEffect.teleHome;		break;
		case "repel":		spellDB[# sdb.spellEffect, r] = spellEffect.repel;			break;
	}
}