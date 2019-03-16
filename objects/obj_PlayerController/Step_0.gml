/// @description Update Player Stats

#region Level Up

// If your xp meets or exceeds requirement for next level
while (stats[playerStat.xpCurrent] >= stats[playerStat.xpMax]){
	
	// Increase Level
	stats[playerStat.level]++;
	
	// Update required experience and stats
	var levelDB, index, xpGain, hpGain, mpGain, strGain, agiGain;
	levelDB = obj_LevelDatabase.levelDB;
	index = ds_grid_value_y(levelDB, 0, 1, 0, ds_grid_height(levelDB)-1, stats[playerStat.level]);
	xpGain = levelDB[# ldb.experience, index];
	hpGain = levelDB[# ldb.hpMax, index];
	mpGain = levelDB[# ldb.mpMax, index];
	strGain = levelDB[# ldb.strength, index];
	agiGain = levelDB[# ldb.agility, index];
	
	stats[playerStat.xpMax] += xpGain;
	stats[playerStat.hpMax] = hpGain;
	stats[playerStat.mpMax] = mpGain;
	stats[playerStat.strength] = strGain;
	stats[playerStat.agility] = agiGain;
	stats[playerStat.critChance] = stats[playerStat.agility]/400;
	
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
	stats[playerStat.xpCurrent] += 137;
}

// Increase MP
if (keyboard_check_pressed(vk_pageup)){
	stats[playerStat.mpCurrent] = stats[playerStat.mpMax];
}

// Leave battle
if (keyboard_check_pressed(ord("B"))){
	global.inBattle = false;
}