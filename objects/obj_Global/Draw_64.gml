/// @description Draw Debug Info

var battle = obj_BattleController
switch(battle.state){
	case battleState.beginEncounter:
		draw_text(32, 32, "battleState = beginEncounter");
		break;
	case battleState.selectAction:
		draw_text(32, 32, "battleState = selectAction");
		break;
	case battleState.fight:
		draw_text(32, 32, "battleState = fight");
		break;
	case battleState.spell:
		draw_text(32, 32, "battleState = selectSpell");
		break;
	case battleState.item:
		draw_text(32, 32, "battleState = selectItem");
		break;
	case battleState.flee:
		draw_text(32, 32, "battleState = fleeAttempt");
		break;
	case battleState.takeDamage:
		draw_text(32, 32, "battleState = takeDamage");
		break;
}
//if (instance_exists(obj_PauseMenu)){
	//draw_text(4, 232, "number of obj_TextBox == "+string(instance_number(obj_TextBox)));
//}