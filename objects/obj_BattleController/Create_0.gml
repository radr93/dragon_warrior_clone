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
	playerPreEmptive,
	enemyPreEmptive,
	selectAction,
	fight,
	spell,
	item,
	flee,
	dealDamage,
	takeDamage,
	death,
	victory,
	
	MAX
}
#endregion

// Set default battle parameters	( an area should change the following depending on how often what spawns there )
encounterRate = 1/8;				// How often you encounter a monster in the current area
scenery = sceneryType.jungle;		// What the battle scenery is in the current area
encounterList = -1;					// An array of all possible enemies (as an enemyID) and their probability of spawning

// Shared Battle State Variables
state = battleState.beginEncounter;	// Default battle state
encounter = -1;						// Enemy id of the enemy encountered
encounterHP = -1;					// How much HP the encounter has left

// Action Menu
actionSelected = action.fight;		// Which action the player has selected
playerSleep = false;				// Is the player sleep?
playerSilenced = false;				// Is the player silenced?
playerWeakened = false;				// Is the player weakened?
enemySleep = false;					// Is the enemy sleep?
enemySilenced = false;				// Is the enemy silenced?
enemyWeakened = false;				// Is the enemy weakened?

// Pre Emptive Battle State Variables
enemyPreEmptive = false;			// Did the enemy get a pre emptive strike? (boolean)
playerPreEmptive = false;			// Did the player get a pre emptive strike? (boolean)

// Fight Battle State Variables
initiative = undefined;				// Who attacks first, "player" or "enemy"?
damageCalculated = undefined;		// Becomes boolean when enemy attacks player
playerDamage = -1;					// The amount of damage the player did
enemyDamage = -1;					// The amount of damage the enemy did

// Select Spell Battle State Variables
spellCasted = false;				// Controls the text box popup after a spell has been casted
spellSelected = 0;					// Which spell is currently selected (if the list is open)
enoughMana = undefined;				// Did the player have enough mana to cast the spell?

// Select Item Battle State Variables
itemUsed = false;					// Controls the text box popup after an item has been used
itemSelected = 0;					// Which item is currently selected (if the list is open)

// Flee Attempt Battle State Variables
fleeSuccessful = undefined;			// Becomes boolean if/when player tries to flee

// Victory Battle State Variables
victoryConfirm1 = false;			// 
victoryConfirm2 = false;			// 
victoryConfirm3 = false;			// 
victoryConfirm4 = false;			// 


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
encounterList[0, encounterParam.chance] = 33/100;
encounterList[1, encounterParam.id] = enemyID.redSlime;
encounterList[1, encounterParam.chance] = 33/100;
encounterList[2, encounterParam.id] = enemyID.drakee;
encounterList[2, encounterParam.chance] = 24/100;
encounterList[3, encounterParam.id] = enemyID.ghost;
encounterList[3, encounterParam.chance] = 10/100;

#endregion
