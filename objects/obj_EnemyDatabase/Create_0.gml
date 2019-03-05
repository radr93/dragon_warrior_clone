/// @description Initialize Variables

// Enumerate Enemy IDs
#region Enumerate Enemy IDs
enum enemyID{
	slime,
	redSlime,
	metalSlime,
	drakee,
	magidrakee,
	drakeema,
	druin,
	druinlord,
	scorpion,
	metalScorpion,
	rogueScorpion,
	magician,
	warlock,
	wizard,
	droll,
	drollmagi,
	ghost,
	poltergeist,
	specter,
	wyvern,
	magiwyvern,
	starwyvern,
	wolf,
	wolflord,
	werewolf,
	knight,
	axeKnight,
	armoredKnight,
	skeleton,
	wraith,
	wraithKnight,
	demonKnight,
	goldman,
	golem,
	stoneman,
	greenDragon,
	blueDragon,
	redDragon,
	dragonlord,
	dragonlord2,
	
	MAX
}
#endregion

// Enumerate Enemy Stats
#region Enumerate Enemy Stats
enum enemyStat{
	id,
	name,
	sprite,
	level,
	hp,
	attackPower,
	defence,
	attackSpeed,
	xpPerKill,
	minGoldDrop,
	maxGoldDrop,
	
	MAX
}
#endregion

// Enumerate Enemy Database Columns
#region Enumerate Enemy Database Columns
enum edb{
	id,
	name,
	sprite,
	level,
	hp,
	attackPower,
	defence,
	attackSpeed,
	xpPerKill,
	minGoldDrop,
	maxGoldDrop,
	
	MAX
}


#endregion

// Load the database
enemyDB = load_csv("databases/enemyDB.csv");

// Convert all numbers from strings to real
enemyDB = ds_grid_number_strings_to_real(enemyDB);

// Convert all sprites from strings to sprite indices
var hh = ds_grid_height(enemyDB);
for (var r = 1; r < hh; r++){
	enemyDB[# edb.sprite, r] = asset_get_index(enemyDB[# edb.sprite, r]);
}