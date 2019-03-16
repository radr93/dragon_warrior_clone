/*	scr_enemy_id_to_IDstring(enemyID);
*
*	enemyID			The enemyID.xxx enum index of the enemy's id (e.g. enemyID.slime)
*
*	This script takes the enemyID.xxx enum index of the enemy's id and returns a IDstring
*	corresponding to that index (e.g. "Slime").
*
*	Returns (IDstring)																	*/

// Initialize Variables
var ID, IDstring;
ID = argument0;
IDstring = "Not found";

switch(ID){
	case enemyID.slime:
		IDstring = "Slime";
		break;
	case enemyID.redSlime:
		IDstring = "Red Slime";
		break;
	case enemyID.metalSlime:
		IDstring = "Metal Slime";
		break;
	case enemyID.drakee:
		IDstring = "Drakee";
		break;
	case enemyID.magidrakee:
		IDstring = "Magidrakee";
		break;
	case enemyID.drakeema:
		IDstring = "Drakeema";
		break;
	case enemyID.druin:
		IDstring = "Druin";
		break;
	case enemyID.druinlord:
		IDstring = "Druinlord";
		break;
	case enemyID.scorpion:
		IDstring = "Scorpion";
		break;
	case enemyID.metalScorpion:
		IDstring = "Metal Scorpion";
		break;
	case enemyID.rogueScorpion:
		IDstring = "Rogue Scorpion";
		break;
	case enemyID.magician:
		IDstring = "Magician";
		break;
	case enemyID.warlock:
		IDstring = "Warlock";
		break;
	case enemyID.wizard:
		IDstring = "Wizard";
		break;
	case enemyID.droll:
		IDstring = "Droll";
		break;
	case enemyID.drollmagi:
		IDstring = "Drollmagi";
		break;
	case enemyID.ghost:
		IDstring = "Ghost";
		break;
	case enemyID.poltergeist:
		IDstring = "Poltergeist";
		break;
	case enemyID.specter:
		IDstring = "Specter";
		break;
	case enemyID.wyvern:
		IDstring = "Wyvern";
		break;
	case enemyID.magiwyvern:
		IDstring = "Magiwyvern";
		break;
	case enemyID.starwyvern:
		IDstring = "Starwyvern";
		break;
	case enemyID.wolf:
		IDstring = "Wolf";
		break;
	case enemyID.wolflord:
		IDstring = "Wolflord";
		break;
	case enemyID.werewolf:
		IDstring = "Werewolf";
		break;
	case enemyID.knight:
		IDstring = "Knight";
		break;
	case enemyID.axeKnight:
		IDstring = "Axe Knight";
		break;
	case enemyID.armoredKnight:
		IDstring = "Armored Knight";
		break;
	case enemyID.skeleton:
		IDstring = "Skeleton";
		break;
	case enemyID.wraith:
		IDstring = "Wraith";
		break;
	case enemyID.wraithKnight:
		IDstring = "Wraith Knight";
		break;
	case enemyID.demonKnight:
		IDstring = "Demon Knight";
		break;
	case enemyID.goldman:
		IDstring = "Goldman";
		break;
	case enemyID.golem:
		IDstring = "Golem";
		break;
	case enemyID.stoneman:
		IDstring = "Stoneman";
		break;
	case enemyID.greenDragon:
		IDstring = "Green Dragon";
		break;
	case enemyID.blueDragon:
		IDstring = "Blue Dragon";
		break;
	case enemyID.redDragon:
		IDstring = "Red Dragon";
		break;
	case enemyID.dragonlord:
		IDstring = "The Dragonlord";
		break;
	case enemyID.dragonlord2:
		IDstring = "The Dragonlord (True Form)";
		break;
	default:
		IDstring = "Not Found";
		show_debug_message("[scr_enemy_id_to_IDstring]: IDstring not found for ID: "+string(ID));
}

return(IDstring);