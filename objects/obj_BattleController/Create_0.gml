/// @description Initialize Variables

// Enumerate Battle Options
#region Scenery Types (jungle, mountain etc.)
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
#region Encounter List parameters (id, chance of spawning)
enum encounterParam{
	id,		// The id of the monster to encounter
	chance,	// The chance of encountering that monster
	MAX
}
#endregion
#region Action List Options (fight, spell, item, run)
enum action{
	fight,
	spell,
	item,
	flee,
	MAX
}

#endregion
#region Enumerate Battle State Machine
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

// Initialize Variables
scenery = sceneryType.jungle;		// What the battle scenery is in the current area
state = battleState.beginEncounter;	// Default battle state
encounter = -1;						// Enemy id of the enemy encountered
encounterHP = -1;					// How much HP the encounter has left

// Pre Emptive Battle State Variables
enemyPreEmptive = false;			// Did the enemy get a pre emptive strike? (boolean)
playerPreEmptive = false;			// Did the player get a pre emptive strike? (boolean)

// Action Menu
actionSelected = action.fight;		// Which action the player has selected

// Status Conditions
sleepCheck = false;
playerSleep = false;				// Is the player sleep?
playerSilenced = false;				// Is the player silenced?
playerWeakened = false;				// Is the player weakened?
enemySleep = false;					// Is the enemy sleep?
enemySilenced = false;				// Is the enemy silenced?
enemyWeakened = false;				// Is the enemy weakened?

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
