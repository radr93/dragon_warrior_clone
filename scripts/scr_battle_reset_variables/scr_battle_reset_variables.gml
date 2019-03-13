/*

scr_battle_reset_variables();

This script resets all variables for obj_BattleController so that the next time a battle is entered,
there is no information carried over from the previous battle.

Return (1) when complete

*/

// Initialize Variables
var bc = obj_BattleController;

// Reset Battle Controller
global.inBattle = false;				// No longer in battle
bc.state = battleState.beginEncounter;	// Next battle will start with begin encounter
bc.encounter = -1;						// No encounter set anymore
bc.encounterHP = -1;					// No encounter hp set anymore
bc.actionSelected = action.fight;		// Change default selection to fight
bc.enemyPreEmptive = false;				// Enemy pre-emptive not set
bc.playerPreEmptive = false;			// Player pre-emptive not set
bc.initiative = undefined;				// Initiative not selected
bc.damageCalculated = undefined;		// Damage not calculated
bc.playerDamage = -1;					// No player damage set
bc.enemyDamage = -1;					// No enemy damage set
bc.fleeSuccessful = undefined;			// Flee attempt unset


bc.victoryConfirm1 = false;				// 
bc.victoryConfirm2 = false;				// 
bc.victoryConfirm3 = false;				// 
bc.victoryConfirm4 = false;				// 

instance_destroy(obj_TextBox);			// Destroy

return(1)