/*	scr_battle_get_encounter(encounterID, weight, .., .., .., ..);
*
*	encounterID		The enemyID.xxx enum index of the enemy's id (e.g. enemyID.slime)
*	weight			The chance of encountering this monster. Should be x/100 and all arguments must total to 100
*	..				The script will then accept another enemyID on each even argument
*	..				and another weight for that enemyID on the odd arguments (again all x/100s must total to 100);
*
*	This script creates an obj_BattleController and then uses the arguments to set it's encounter by looping through
*	them
*
*	Returns 1 when complete
*
*/

var battle;
battle = instance_create_layer(x, y, "Controllers", obj_BattleController);
battle.state = battleState.beginEncounter;

#region Fabricate the encounterList (2d array with ID and weight for each index (option)

var encounterList;
for (var i = 0; i < argument_count/2; i++){		// Index (creates new entry in the encounterList)
	encounterList[i, encounterParam.id] = argument[(i*2)];			// Get the encounterID
	encounterList[i, encounterParam.chance] = argument[(i*2)+1];	// Get the weight of that encounter
	
	// Debug
	show_debug_message("encounterList["+string(i)+", 0] = "+scr_enemy_id_to_IDstring(encounterList[i, 0]));
	show_debug_message("encounterList["+string(i)+", 1] = "+string(encounterList[i, 1]));
}

#endregion

#region Find out what was encountered (select randomly from the encounterList)

var arrayHeight, roll, rangeChecking;
arrayHeight = array_height_2d(encounterList);	// Height of the encounterList
roll = random(1);								// Percentage rolled
rangeChecking = 0;								// Increments by weight for each iteration until you get an encounter
		
for (var e = 0; e < arrayHeight; e++){	// Loop through encounter list
	
	// Adds percentage of this encounter's weight to the current range to check
	rangeChecking += encounterList[e, encounterParam.chance];
			
	// If that percentage falls in range of the roll
	if (roll <= rangeChecking){
		
		// Set the encounter
		battle.encounter = encounterList[e, encounterParam.id];
		break;
	}
}
		
#endregion
		
#region Look up enemy ID's row index in enemy DB and set HP
		
// Look up enemy ID's row index in enemy DB and set encounter's HP
var enemyDB, index;
enemyDB = obj_EnemyDatabase.enemyDB;
index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, battle.encounter);
battle.encounterHP = enemyDB[# edb.hp, index];

#endregion
	
#region Create a textbox and/or hold the textbox instance ID as local variable
	
// If a textbox doesn't already exist, create one and store it's instance ID in a local variable
if (!instance_exists(obj_TextBox)){	var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);	}
	
// If a textbox does already exist, get the instance ID as a local variable
else{ var textbox = obj_TextBox; }
		
#endregion
		
#region Find out if using a, an or the
var a_an_the, name;
		
// A
a_an_the = "A ";		// Default "A "
// An
if (enemyDB[# edb.id, index] == enemyID.armoredKnight or enemyDB[# edb.id, index] == enemyID.axeKnight){
	a_an_the = "An "	// Use "An " for enemies with a vowel at the beginning of their name
}
// The
else if (enemyDB[# edb.id, index] == enemyID.dragonlord or enemyDB[# edb.id, index] == enemyID.dragonlord2){
	a_an_the = "The "	// "The " is used for unique enemies
}
#endregion
		
#region Draw the "A/An/The <monsterName> appeared" message in the textbox
		
// Draw the "A/An/The <monsterName> appeared" message in the textbox
name = enemyDB[# edb.name, index];
textbox.newText = a_an_the + name + " appeared!";
		
#endregion 