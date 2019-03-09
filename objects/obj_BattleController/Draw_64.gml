/// @description Draw Battles

// If in a battle
if (global.inBattle){
	
	// All battle states
	
	#region Look up enemy ID's row index in enemy DB
		
	// Look up enemy ID's row index in enemy DB
	var enemyDB, index;
	enemyDB = obj_EnemyDatabase.enemyDB;
	index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, encounter);
		
	#endregion
	
	#region Draw the battle scenery
	
	switch (scenery){
		case sceneryType.field:
			//draw_sprite(spr_AreaField, 0, sceneryX, sceneryY);
			break;
		case sceneryType.jungle:
			draw_sprite(spr_AreaJungle, 0, sceneryX, sceneryY);
			break;
		case sceneryType.swamp:
			//draw_sprite(spr_AreaSwamp, 0, sceneryX, sceneryY);
			break;
		case sceneryType.mountain:
			//draw_sprite(spr_AreaMountain, 0, sceneryX, sceneryY);
			break;
		case sceneryType.cave:
			//draw_sprite(spr_AreaCave, 0, sceneryX, sceneryY);
			break;
		case sceneryType.dungeon:
			//draw_sprite(spr_AreaDungeon, 0, sceneryX, sceneryY);
			break;
	}
	#endregion
	
	#region Draw the enemy sprite
	
	// Get the y index of the enemy id in the enemy database
	var sprite = enemyDB[# edb.sprite, index];
	
	// Make sure you have a valid enemy index
	if (!is_undefined(sprite)){
				
		// If it was a valid sprite
		if (sprite_exists(sprite)){
			
			// Draw the enemy
			var xOffset, yOffset;
			xOffset = sprite_get_width(sprite)/2;
			yOffset = sprite_get_height(sprite)/2;
			draw_sprite(sprite, 0, enemyX-xOffset, enemyY-yOffset);
		}
	}
	#endregion
	
	#region Draw the Player's Stats
		
	// Initialize Variables
	var x1, y1, x2, y2;
	x1 = 800;
	y1 = 88;
	x2 = 959;
	y2 = 295;
		
	// Draw black background
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, false);
		
	// Draw white outline
	draw_set_color(c_white);
	draw_rectangle(x1, y1, x2, y2, true);
		
	// Draw Player Stats
	var player, yOffset;
	player = obj_PlayerController;
	yOffset = 0;
		
	// Name
	draw_text(statsTextX, statsTextY+yOffset, player.stats[playerStat.name]);
	yOffset += 32;
		
	// Level
	var level = string(player.stats[playerStat.level])
	draw_text(statsTextX, statsTextY+yOffset, "Level: " + level);
	yOffset += 32;
		
	// HP
	var hpCurr, hpMax;
	hpCurr = string(player.stats[playerStat.hpCurrent]);
	hpMax = string(player.stats[playerStat.hpMax]);
	draw_text(statsTextX, statsTextY+yOffset, "HP: "+hpCurr+"/"+hpMax);
	yOffset += 32;
		
	// MP
	var mpCurr, mpMax;
	mpCurr = string(player.stats[playerStat.mpCurrent]);
	mpMax = string(player.stats[playerStat.mpMax]);
	draw_text(statsTextX, statsTextY+yOffset, "MP: "+mpCurr+"/"+mpMax);
	yOffset += 32;
		
	// XP
	var xp = add_commas_to_number_strings(player.stats[playerStat.xpCurrent], true);
	draw_text(statsTextX, statsTextY+yOffset, "XP: "+ xp);
	yOffset += 32;
		
	// Gold Count
	var gold = add_commas_to_number_strings(player.stats[playerStat.goldCount], true);
	draw_text(statsTextX, statsTextY+yOffset, "Gold: "+ gold);
		
	#endregion
	
	#region Draw the enemy name and level
	
	// Initialize Variables
	var x1, y1, x2, y2;
	x1 = 352;
	y1 = 336;
	x2 = 671;
	y2 = 367;
		
	// Draw black background
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, false);
		
	// Draw white outline
	draw_set_color(c_white);
	draw_rectangle(x1, y1, x2, y2, true);
		
	// Draw enemy name and level
	var name = enemyDB[# edb.name, index];
	var level = enemyDB[# edb.level, index];
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if (!is_undefined(name) and !is_undefined(level)){
		draw_text(enemyNameX, enemyNameY, name+" [Level "+string(level)+"]");
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
		
	#endregion
		
	// Draw for specific battle states
	switch (state){
		
		case battleState.enemyPreEmptive:
			
			break;
		case battleState.selectAction:
		
			#region Draw the Action List
		
			// Initialize Variables
			var x1, y1, x2, y2;
			x1 = 112;
			y1 = 120;
			x2 = 223;
			y2 = 263;
		
			// Draw black background
			draw_set_color(c_black);
			draw_rectangle(x1, y1, x2, y2, false);
		
			// Draw white outline
			draw_set_color(c_white);
			draw_rectangle(x1, y1, x2, y2, true);
		
			// Draw action list
			var yOffset = 0;
			draw_text(actionTextX, actionTextY+yOffset, "Fight");	yOffset += 32;
			draw_text(actionTextX, actionTextY+yOffset, "Spell");	yOffset += 32;
			draw_text(actionTextX, actionTextY+yOffset, "Item");	yOffset += 32;
			draw_text(actionTextX, actionTextY+yOffset, "Run");
		
			// Draw arrow pointing to selection
			draw_sprite(spr_MenuCursor, 0, actionTextX-32, actionTextY + (actionSelected*32));
		
			#endregion
			
			break;
	
		case battleState.fight:
			
			break;		
	
		case battleState.spell:
			
			break;
		case battleState.item:
			
			break;
		case battleState.flee:
			
			break;
		case battleState.takeDamage:
			
			break;
		case battleState.death:
			
			break;
	}
}