/// @description Initialize Variables

// Enumerate Player Stats
#region Enumerate Player Stats
enum playerStat{
	name,
	
	level,
	xpMax,
	xpCurrent,
	xpPrevMax,
	
	hpMax,
	hpCurrent,
	mpMax,
	mpCurrent,
	
	strength,
	agility,
	attackPower,
	defence,
	
	goldCount,
	
	MAX
}
#endregion

// Enumerate Player Equip Slots
#region Enumerate Player Equip Slots
enum equipSlot{
	weapon,
	armor,
	shield,
	
	MAX
}
#endregion


// Initialize Player Data
#region Initialize Player Stats
for (var s = 0; s < playerStat.MAX; s++){
	stats[s] = 0;
}

var levelDB = obj_LevelDatabase.levelDB;

stats[playerStat.name] = "RADR";
stats[playerStat.level] = 1;
stats[playerStat.xpMax] = 7;
stats[playerStat.hpMax] = 15;
stats[playerStat.hpCurrent] = stats[playerStat.hpMax];
stats[playerStat.mpMax] = 0;
stats[playerStat.mpCurrent] = stats[playerStat.mpMax];
stats[playerStat.strength] = 4;
stats[playerStat.agility] = 4;
stats[playerStat.attackPower] = stats[playerStat.strength];
stats[playerStat.defence] = stats[playerStat.agility]/2;
#endregion

#region Initialize Player Inventory
for (var i = 0; i < itemID.MAX; i++){
	items[i] = 0;
}

items[itemID.potion] +=6;
#endregion

#region Initialize Player Spells
for (var s = 0; s < spellID.MAX; s++){
	spells[s] = 0;	
}
#endregion

#region Inititalize Player Equip Slots
for (var e = 0; e < equipSlot.MAX; e++){
	equip[e] = -1;
}
#endregion