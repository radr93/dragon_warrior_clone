/// @description Initialize Variables

// Enumerate Battle Functions
#region Enumerate Scenery Types
enum sceneryType{
	field,
	jungle,
	swamp,
	mountain,
	cave,
	dungeon,
	
	MAX
}
#endregion
#region Enumerate Encounter List Parameters
enum encounterParam{
	id,		// The id of the monster to encounter
	chance,	// The chance of encountering that monster
	MAX
}
#endregion
#region Enumerate Action Options
enum action{
	fight,
	spell,
	item,
	flee,
	MAX
}

#endregion
#region Enumerate Battle States
enum battleState{
	beginEncounter,
	enemyPreEmptive,
	selectAction,
	fight,
	spell,
	item,
	flee,
	takeDamage,
	death,
	victory,
	
	MAX
}
#endregion
state = battleState.beginEncounter;	// Default battle state

// Set default battle parameters	( an area should change the following depending on how often what spawns there )
encounterRate = 1/8;				// How often you encounter a monster in the current area
scenery = sceneryType.jungle;		// What the battle scenery is in the current area
encounterList = -1;					// An array of all possible enemies (as an enemyID) and their probability of spawning

// Shared Battle State Variables
encounter = -1;						// Enemy id of the enemy encountered
actionSelected = action.fight;		// Which action the player has selected

// Fight Battle State Variables
initiative = undefined;				// Who attacks first, "player" or "enemy"?
playerDamage = 0;

// Select Spell Battle State Variables


// Select Item Battle State Variables


// Flee Attempt Battle State Variables
fleeSuccessful = undefined;			// Becomes boolean if/when player tries to flee

// Take Damage Battle State Variables
damageCalculated = undefined;		// Becomes boolean when enemy attacks player
enemyDamage = 0;




#region Set positions of battle HUD elements

// Scenery backdrop position
sceneryX = 320;
sceneryY = 32;

// Enemy position
enemyX = 512;
enemyY = 256;

// Action List text position
actionTextX = 160;
actionTextY = 136;

// Player Stats text position
statsTextX = 824;
statsTextY = 104;

// Monster name and level position
enemyNameX = 512;
enemyNameY = 352;
#endregion




#region This can be safely deleted when areas begin providing the battle controller with their own encounter ids and weights
encounterList[0, encounterParam.id] = enemyID.slime;
encounterList[0, encounterParam.chance] = 60/100;
encounterList[1, encounterParam.id] = enemyID.redSlime;
encounterList[1, encounterParam.chance] = 30/100;
encounterList[2, encounterParam.id] = enemyID.ghost;
encounterList[2, encounterParam.chance] = 9/100;
encounterList[3, encounterParam.id] = enemyID.axeKnight;
encounterList[3, encounterParam.chance] = 1/100;

#endregion
