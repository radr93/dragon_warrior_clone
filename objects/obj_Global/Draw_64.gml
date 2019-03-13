/// @description Draw Debug Info

if (showDebug){
	draw_set_color(c_white);
	draw_set_font(Calibri_8);

	var battle = obj_BattleController;

	var xx, yy, lineCount;
	xx = 32;
	yy = 32;
	lineCount = 24;

	scr_draw_ui_box(0,0,xx+(32*9),yy+(16*lineCount),c_black,c_white,0.8)

	switch(battle.state){
		case battleState.beginEncounter:
			draw_text(xx, yy, "battleState = beginEncounter");
			break;
		case battleState.playerPreEmptive:
			draw_text(xx, yy, "battleState = playerPreEmptive");
			break;
		case battleState.enemyPreEmptive:
			draw_text(xx, yy, "battleState = enemyPreEmptive");
			break;
		case battleState.selectAction:
			draw_text(xx, yy, "battleState = selectAction");
			break;
		case battleState.fight:
			draw_text(xx, yy, "battleState = fight");
			break;
		case battleState.spell:
			draw_text(xx, yy, "battleState = selectSpell");
			break;
		case battleState.item:
			draw_text(xx, yy, "battleState = selectItem");
			break;
		case battleState.flee:
			draw_text(xx, yy, "battleState = fleeAttempt");
			break;
		case battleState.dealDamage:
			draw_text(xx, yy, "battleState = dealDamage");
			break;
		case battleState.takeDamage:
			draw_text(xx, yy, "battleState = takeDamage");
			break;
		case battleState.death:
			draw_text(xx, yy, "battleState = death");
			break;
		case battleState.victory:
			draw_text(xx, yy, "battleState = victory");
			break;
	}
	yy += 16;

	if (instance_exists(obj_BattleController)){
		var enemyDB = obj_EnemyDatabase.enemyDB;
		var index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB), battle.encounter);
		var encounterMaxHp = string(enemyDB[# edb.hp, index]);
	
		draw_text(xx, yy, "encounter = "+string(obj_BattleController.encounter));	yy += 16;
		draw_text(xx, yy, "encounterHP = "+string(obj_BattleController.encounterHP)+"/"+encounterMaxHp); yy += 16;
		draw_text(xx, yy, "actionSelected = "+string(obj_BattleController.actionSelected));	yy += 16;
		draw_text(xx, yy, "enemyPreEmptive = "+string(obj_BattleController.enemyPreEmptive));	yy += 16;
		draw_text(xx, yy, "playerPreEmptive = "+string(obj_BattleController.playerPreEmptive));	yy += 16;
		draw_text(xx, yy, "initiative = "+string(obj_BattleController.initiative));	yy += 16;
		draw_text(xx, yy, "fleeSuccessful = "+string(obj_BattleController.fleeSuccessful));	yy += 16;
		draw_text(xx, yy, "damageCalculated = "+string(obj_BattleController.damageCalculated));	yy += 16;
		draw_text(xx, yy, "playerDamage = "+string(obj_BattleController.playerDamage));	yy += 16;
		draw_text(xx, yy, "enemyDamage = "+string(obj_BattleController.enemyDamage));	yy += 16;
		draw_text(xx, yy, "victoryConfirm1 = "+string(obj_BattleController.victoryConfirm1));	yy += 16;
		draw_text(xx, yy, "victoryConfirm2 = "+string(obj_BattleController.victoryConfirm2));	yy += 16;
		draw_text(xx, yy, "spellCasted = "+string(obj_BattleController.spellCasted));	yy += 16;
		draw_text(xx, yy, "spellSelected = "+string(obj_BattleController.spellSelected));	yy += 16;
		draw_text(xx, yy, "itemUsed = "+string(obj_BattleController.itemUsed));	yy += 16;
		draw_text(xx, yy, "itemSelected = "+string(obj_BattleController.itemSelected));	yy += 16;
		draw_text(xx, yy, "playerSleep = "+string(obj_BattleController.playerSleep));	yy += 16;
		draw_text(xx, yy, "playerSilenced = "+string(obj_BattleController.playerSilenced));	yy += 16;
		draw_text(xx, yy, "playerWeakened = "+string(obj_BattleController.playerWeakened));	yy += 16;
		draw_text(xx, yy, "enemySleep = "+string(obj_BattleController.enemySleep));	yy += 16;
		draw_text(xx, yy, "enemySilenced = "+string(obj_BattleController.enemySilenced));	yy += 16;
		draw_text(xx, yy, "enemyWeakened = "+string(obj_BattleController.enemyWeakened));	yy += 16;
		
	}
}