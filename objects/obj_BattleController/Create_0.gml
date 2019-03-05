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
	weight,	// The chance of encountering that monster
	
}
#endregion

// Set default battle parameters
encounterRate = 1/8;	// Chance of encountering a monster in the current area
scenery = sceneryType.jungle;	// Scenery used for the battle in the current area

encounterList[0, encounterParam.id] = enemyID.slime;
encounterList[0, encounterParam.weight] = 60/100;
encounterList[1, encounterParam.id] = enemyID.redSlime;
encounterList[1, encounterParam.weight] = 30/100;
encounterList[2, encounterParam.id] = enemyID.ghost;
encounterList[2, encounterParam.weight] = 10/100;

encounter = -1;			// Holds the id of what was encountered

// Set positions of battle HUD elements
sceneryX = 320;
sceneryY = 32;
enemyX = 512;
enemyY = 256;