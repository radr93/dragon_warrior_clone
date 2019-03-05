/// @description Initialize Variables

#region Enumerate Level Database Columns
enum ldb{
	level,
	experience,
	totalXP,
	strength,
	agility,
	hpMax,
	mpMax,
	newSpell,
	
	MAX
}
#endregion

// Load the database
levelDB = load_csv("databases/levelDB.csv");

// Convert all numbers from strings to real
levelDB = ds_grid_number_strings_to_real(levelDB);

// Convert all spells from string to enum (spellID)
for (var l = 1; l < ds_grid_height(levelDB)-1; l++){
	if (levelDB[# ldb.newSpell, l] != -1){
		
		switch (levelDB[# ldb.newSpell, l]){
			case "alleviate":	levelDB[# ldb.newSpell, l] = spellID.alleviate;		break;
			case "afflict":		levelDB[# ldb.newSpell, l] = spellID.afflict;		break;
			case "entrance":	levelDB[# ldb.newSpell, l] = spellID.entrance;		break;
			case "illuminate":	levelDB[# ldb.newSpell, l] = spellID.illuminate;	break;
			case "silence":		levelDB[# ldb.newSpell, l] = spellID.silence;		break;
			case "weaken":		levelDB[# ldb.newSpell, l] = spellID.weaken;		break;
			case "teleout":		levelDB[# ldb.newSpell, l] = spellID.teleOut;		break;
			case "telehome":	levelDB[# ldb.newSpell, l] = spellID.teleHome;		break;
			case "intimidate":	levelDB[# ldb.newSpell, l] = spellID.intimidate;	break;
			case "revivify":	levelDB[# ldb.newSpell, l] = spellID.revivify;		break;
			case "destroy":		levelDB[# ldb.newSpell, l] = spellID.destroy;		break;
		}
		
	}
}