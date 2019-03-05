/// @description Update Player Stats

#region Level Up

// If your xp meets or exceeds requirement for next level
while (stats[playerStat.xpCurrent] >= stats[playerStat.xpMax]){
	
	// Increase Level
	stats[playerStat.level]++;
	
	// Update required experience and stats
	var levelDB = obj_LevelDatabase.levelDB;
	var index = ds_grid_value_y(levelDB, 0, 1, 0, ds_grid_height(levelDB)-1, stats[playerStat.level]);
	
	stats[playerStat.xpMax] += levelDB[# ldb.experience, index];
	stats[playerStat.hpMax] = levelDB[# ldb.hpMax, index];
	stats[playerStat.mpMax] = levelDB[# ldb.mpMax, index];
	stats[playerStat.strength] = levelDB[# ldb.strength, index];
	stats[playerStat.agility] = levelDB[# ldb.agility, index];
	
	// See if any new spells can be learned
	if (levelDB[# ldb.newSpell, index] != -1){
		spells[levelDB[# ldb.newSpell, index]] = 1;
	}
}
#endregion

// Calculate Attack Power
stats[playerStat.attackPower] = player_get_attackpower();

// Calculate Defence
stats[playerStat.defence] = player_get_defence();

// Break the game
// Increase XP
if (keyboard_check_pressed(vk_insert)){
	stats[playerStat.xpCurrent] += 100;
}

// Increase MP
if (keyboard_check_pressed(vk_pageup)){
	stats[playerStat.mpCurrent] = stats[playerStat.mpMax];
}

// Leave battle
if (keyboard_check_pressed(ord("B"))){
	global.inBattle = false;
}