/*	scr_battle_set_scenery(scene);
*
*	scene	The scenery type enum index for the battle (e.g. sceneryType.jungle etc.)
*
*	This script sets the scenery of the current battle to change the picture drawn behind the enemy.
*
*	Returns 1 when complete
*
*/

// Initialize Variables
var battle, scene;
battle = obj_BattleController;
scene = argument0;

battle.scenery = scene;

return(1);