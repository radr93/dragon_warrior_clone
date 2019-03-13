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
		
	// Draw the backdrop
	scr_draw_ui_box(x1, y1, x2, y2, c_black, c_white, 0.7);
		
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
		
	// Draw the backdrop
	scr_draw_ui_box(x1, y1, x2, y2, c_black, c_white, 0.7);
		
	// Draw enemy name and level
	var name = enemyDB[# edb.name, index];
	var level = enemyDB[# edb.level, index];
	var hpCurr = encounterHP;
	var hpMax = enemyDB[# edb.hp, index];
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if (!is_undefined(name) and !is_undefined(level)){
		draw_text(enemyNameX, enemyNameY, name+" [Level: "+string(level)+"] [HP: "+string(hpCurr)+"/"+string(hpMax)+"]");
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
		
	#endregion
	
	// Draw for specific battle states
	switch (state){
		
		case battleState.playerPreEmptive:
			
			break;
			
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
		
			// Draw the backdrop
			scr_draw_ui_box(x1, y1, x2, y2, c_black, c_white, 0.7);
		
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
			
			if (!spellCasted){
				
				#region Backdrop
		
				// Get size of spells menu
				var x1, y1, x2, y2;
				x1 = 144;	// Left side of spells menu
				y1 = 16;	// Top of spells menu
				x2 = 671;	// Right side of spells menu
				y2 = 223;	// Bottom of spells menu

				// Draw the spells menu backdrop
				scr_draw_ui_box(x1, y1, x2, y2, c_black, c_white, 0.7);
	
				#endregion
		
				#region Draw Spell List text and spell index arrow
		
				// Initialize Variables
				var xx, xx2, yy;
				xx = 208;					// X position of spell name
				xx2 = 336;					// X position of mana cost
				yy = 32;					// Y position of current spell
		
		
				// Loop through player's currently held items
				var player, spellCount, spellList;
				player = obj_PlayerController;
				spellCount = 0;					// Number of spells the player knows
		
				for (var spell = 0; spell < spellID.MAX; spell++){
			
					// If the player knows 1 or more spell
					if (player.spells[spell] == 1){
				
						// Look up the spell ID in the item database
						var spellDB, gridHeight, index;
						spellDB = obj_SpellDatabase.spellDB;
						gridHeight = ds_grid_height(spellDB);
						index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spell);
									
						// Draw Spell's Sprite
						if (sprite_exists(spellDB[# sdb.sprite, index])){
							draw_sprite(spellDB[# sdb.sprite, index], 0, xx-32, yy);
						}
					
						// Draw Spell's Name
						draw_text(xx, yy, string(spellDB[# sdb.name, index]));
					
						// Draw Spell's Mp cost
						draw_text(xx2, yy, "MP: "+string(spellDB[# sdb.spellCost, index]));

						// Draw arrow if this spell is selected
						if (spellSelected == spellCount){
							draw_sprite(spr_MenuCursor, 0, xx-64, yy);
						}
					
						spellList[spellCount] = spellDB[# sdb.id, index];
						spellCount++;
					
						if (spellCount == 6){
							xx = 464;
							xx2 = 592;
							yy = 32;
						}
						else{
							yy += 32;
						}
					}
				}
		
				// Draw arrow if the Back button is selected
				if (spellSelected == spellCount){
					draw_sprite(spr_MenuCursor, 0, xx-64, yy);
				}
				spellList[spellCount] = "Back";
				draw_text(xx-32, yy, "Back");
		
				#endregion
			}
			break;
		case battleState.item:
				
			#region Backdrop
		
			// Get size of item menu
			var x1, y1, x2, y2;
			x1 = 144;	// Left side of item menu
			y1 = 16;	// Top of item menu
			x2 = 703;	// Right side of item menu
			y2 = 351;	// Bottom of item menu

			// Draw the item menu backdrop
			scr_draw_ui_box(x1, y1, x2, y2, c_black, c_white, 0.7);
		
			#endregion
		
			#region Draw Item List text and item index arrow
		
			// Initialize Variables
			var xx, xx2, yy, itemCount;
			xx = 208;					// X position of item name
			xx2 = 368;					// X position of item quantity
			yy = 32;					// Y position 
		
		
			// Loop through player's currently held items
			var player, itemCount, itemList;
			player = obj_PlayerController;
			itemCount = 0;					// Number of items
			for (var item = 0; item < itemID.MAX; item++){
			
				// If the player has 1 or more of an item
				if (player.items[item] > 0){
				
					// Look up the item ID in the item database
					var itemDB, gridHeight, index;
					itemDB = obj_ItemDatabase.itemDB;
					gridHeight = ds_grid_height(itemDB);
					index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, item);
				
					// If the item isn't equipment
					if (itemDB[# idb.equippable, index] == 0){
					
						// Draw Item's Sprite
						if (sprite_exists(itemDB[# idb.sprite, index])){
							draw_sprite(itemDB[# idb.sprite, index], 0, xx-32, yy);
						}
					
						// Draw Item's Name
						draw_text(xx, yy, string(itemDB[# idb.name, index]));
					
						// Draw Item's Quantity
						draw_text(xx2, yy, "x"+string(player.items[item]));
					
						// Draw arrow if this item is selected
						if (itemSelected == itemCount){
							draw_sprite(spr_MenuCursor, 0, xx-64, yy);
						}
					
						itemList[itemCount] = itemDB[# idb.id, index];
						itemCount++;
					
						if (itemCount == 10){
							xx = 480;
							xx2 = 656;
							yy = 32;
						}
						else{
							yy += 32;
						}
					}
				}
			}
		
			// Draw arrow if this Back button is selected
			if (itemSelected == itemCount){
				draw_sprite(spr_MenuCursor, 0, xx-64, yy);
			}
			itemList[itemCount] = "Back";
			draw_text(xx-32, yy, "Back");
		
			#endregion
	
			break;
		case battleState.flee:
			
			break;
		case battleState.dealDamage:
			
			break;
		case battleState.takeDamage:
			
			break;
		case battleState.death:
			
			break;
		case battleState.victory:
			
			break;
	}
}