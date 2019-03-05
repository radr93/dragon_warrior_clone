/// @description Draw Battles

// If in a battle
if (global.inBattle){
	
	// Draw the battle scene
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
	
	// Draw the enemy
	var enemyDB, index, sprite;
	enemyDB = obj_EnemyDatabase.enemyDB;
	index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, encounter);
	
	if (index != -1){
		sprite = enemyDB[# edb.sprite, index];
	
		if (sprite_exists(sprite)){
			
			var xOffset, yOffset;
			xOffset = sprite_get_width(sprite)/2;
			yOffset = sprite_get_height(sprite)/2;
			draw_sprite(sprite, 0, enemyX-xOffset, enemyY-yOffset);
		}
	}
}