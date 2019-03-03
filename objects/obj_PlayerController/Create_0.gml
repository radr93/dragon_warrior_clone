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

// Initialize Player Stats
#region Initialize Player Stats
for (var s = 0; s < playerStat.MAX; s++){
	stats[s] = 0;
}

stats[playerStat.name] = "RADR";
stats[playerStat.level] = 1;
stats[playerStat.xpMax] = 7;
stats[playerStat.hpMax] = irandom_range(9, 12);
stats[playerStat.hpCurrent] = stats[playerStat.hpMax];
stats[playerStat.mpMax] = irandom_range(5, 7);
stats[playerStat.mpCurrent] = stats[playerStat.mpMax];
stats[playerStat.strength] = irandom_range(5,8);
stats[playerStat.agility] = irandom_range(4,7);
stats[playerStat.attackPower] = stats[playerStat.strength];
stats[playerStat.defence] = stats[playerStat.agility];
#endregion

// Initialize Player Inventory
for (var i = 0; i < itemID.MAX; i++){
	items[i] = 1;
}