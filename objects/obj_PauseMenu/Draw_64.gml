/// @description Draw the Pause Menu

// If not in a sub menu (cycle through options list)
#region Options list

// Draw the options list
#region Draw the options list backdrop
// Get size of options list
var x1, y1, x2, y2;
x1 = 16;	// Left side of options list
y1 = 16;	// Top of options list
x2 = 127;	// Right side of options list
y2 = 191;	// Bottom of options list

// Draw the backdrop of the options list
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, false);

// Draw the outline of the options list
draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, true);
#endregion

#region Draw the options list text
// Initialize Variables
var xx, yy;
xx = 64;
yy = 32;
draw_set_font(Calibri_16);

// Loop through the options list
for (var o = 0; o < optionsList.MAX; o++){
	switch (o){
		case optionsList.status:
			draw_text(xx, yy, "Status");
			yy+=32;
			break;
		case optionsList.items:
			draw_text(xx, yy, "Items");
			yy+=32;
			break;
		case optionsList.spells:
			draw_text(xx, yy, "Spells");
			yy+=32;
			break;
		case optionsList.equip:
			draw_text(xx, yy, "Equip");
			yy+=32;
			break;
		case optionsList.close:
			draw_text(xx, yy, "Exit");
			yy+=32;
			break;
	}
}
#endregion

#region Draw the cursor in the options list

var cursorX, cursorY, yOffset;
cursorX = 32;
cursorY = 32;
yOffset = optionSelected*32;
draw_sprite(spr_MenuCursor, 0, cursorX, cursorY+yOffset);

#endregion

#endregion

// If in a sub-menu
if (inSubMenu){
	
	// Draw the status sub menu
	#region Status sub menu
	
	if (optionSelected == optionsList.status){
		
		#region Backdrop
		// Get size of status menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of status menu
		y1 = 16;	// Top of status menu
		x2 = 543;	// Right side of status menu
		y2 = 191;	// Bottom of status menu

		// Draw the backdrop of the status menu
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the status menu
		draw_set_color(c_white);
		draw_rectangle(x1, y1, x2, y2, true);
		#endregion
		
		#region Draw the Status list text
		
		// Initialize Variables
		var player, xx, yy;
		player = obj_PlayerController;
		xx = 160;
		yy = 32;
		
		// Draw Player Stats
		draw_text(xx, yy, string(player.stats[playerStat.name]));
		yy+=32;
				
		draw_text(xx, yy, "HP: "+string(player.stats[playerStat.hpCurrent])+"/"+string(player.stats[playerStat.hpMax]));
		yy+=32;
		
		draw_text(xx, yy, "MP: "+string(player.stats[playerStat.mpCurrent])+"/"+string(player.stats[playerStat.mpMax]));
		yy+=32;
		
		var xpCurrent = add_commas_to_number_strings(player.stats[playerStat.xpCurrent] , true);
		var xpMax = add_commas_to_number_strings(player.stats[playerStat.xpMax] , true);
		draw_text(xx, yy, "XP: "+xpCurrent+"/"+xpMax);
		yy+=32;
		
		var goldCount = add_commas_to_number_strings(player.stats[playerStat.goldCount], true);
		draw_text(xx, yy, "Gold: "+goldCount);
		xx = 352;
		yy = 32;
		
		draw_text(xx, yy, "Level: "+string(player.stats[playerStat.level]));
		yy+=32;
		
		draw_text(xx, yy, "Strength: "+string(player.stats[playerStat.strength]));
		yy+=32;
		
		draw_text(xx, yy, "Agility: "+string(player.stats[playerStat.agility]));
		yy+=32;
		
		draw_text(xx, yy, "Attack Power: "+string(player.stats[playerStat.attackPower]));
		yy+=32;
		
		draw_text(xx, yy, "Defence: "+string(player.stats[playerStat.defence]));
		
		#endregion
	
	}
	#endregion
	
	// Draw the items sub menu
	#region Items sub menu
	
	else if (optionSelected == optionsList.items){
		
		#region Backdrop
		
		// Get size of item menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of item menu
		y1 = 16;	// Top of item menu
		x2 = 703;	// Right side of item menu
		y2 = 351;	// Bottom of item menu

		// Draw the backdrop of the item menu
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the item menu
		draw_set_color(c_white);
		draw_rectangle(x1, y1, x2, y2, true);
		
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
	
	}
	#endregion
	
	// Draw the spells sub menu
	#region Spells sub menu
	
	else if (optionSelected == optionsList.spells){
		
		#region Backdrop
		
		// Get size of spells menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of spells menu
		y1 = 16;	// Top of spells menu
		x2 = 671;	// Right side of spells menu
		y2 = 223;	// Bottom of spells menu

		// Draw the backdrop of the spells menu
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the spells menu
		draw_set_color(c_white);
		draw_rectangle(x1, y1, x2, y2, true);
	
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
	#endregion
	
	// Draw the equip sub menu
	#region Equip sub menu
	
	else if (optionSelected == optionsList.equip){
		
		#region Backdrop
		
		// Get size of equip menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of equip menu
		y1 = 16;	// Top of equip menu
		x2 = 735;	// Right side of equip menu
		y2 = 351;	// Bottom of equip menu

		// Draw the backdrop of the equip menu
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the equip menu
		draw_set_color(c_white);
		draw_rectangle(x1, y1, x2, y2, true);
		
		#endregion
		
		#region Draw Equip List text and equip index arrow
		
		// Initialize Variables
		var xx, xx2, yy, itemCount;
		xx = 208;					// X position of equip name
		xx2 = 368;					// X position of equip power
		yy = 32;					// Y position		
		
		// Loop through player's currently held equip
		var player, itemCount, itemList;
		player = obj_PlayerController;
		itemCount = 0;					// Number of equippable items
		for (var item = 0; item < itemID.MAX; item++){
			
			// If the player has 1 or more of an item
			if (player.items[item] > 0){
				
				// Look up the item ID in the item database
				var itemDB, gridHeight, index;
				itemDB = obj_ItemDatabase.itemDB;
				gridHeight = ds_grid_height(itemDB);
				index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, item);
				
				// If the item is equipment
				if (itemDB[# idb.equippable, index] == 1){
					
					// Draw Equipment's Sprite
					if (sprite_exists(itemDB[# idb.sprite, index])){
						draw_sprite(itemDB[# idb.sprite, index], 0, xx-32, yy);
					}
					
					// Draw Equipment's Name
					draw_text(xx, yy, string(itemDB[# idb.name, index]));
					
					// Draw Weapon Power
					if (itemDB[# idb.effect, index] == itemEffect.weapon){
						
						if (player.equip[equipSlot.weapon] == itemDB[# idb.id, index]){
							draw_sprite(spr_WeaponEquippedIcon, 0, xx2, yy);
						}
						else{
							draw_sprite(spr_WeaponIcon, 0, xx2, yy);
						}
						draw_text(xx2+32, yy, string(itemDB[# idb.effectValue, index]));
					}
					
					// Draw Armor Defence
					else if (itemDB[# idb.effect, index] == itemEffect.armor){
						if (player.equip[equipSlot.armor] == itemDB[# idb.id, index]){
							draw_sprite(spr_ArmorEquippedIcon, 0, xx2, yy);
						}
						else{
							draw_sprite(spr_ArmorIcon, 0, xx2, yy);
						}
						draw_text(xx2+32, yy, string(itemDB[# idb.effectValue, index]));
					}
					
					// Draw Shield Defence
					else if (itemDB[# idb.effect, index] == itemEffect.shield){
						if (player.equip[equipSlot.shield] == itemDB[# idb.id, index]){
							draw_sprite(spr_ShieldEquippedIcon, 0, xx2, yy);
						}
						else{
							draw_sprite(spr_ShieldIcon, 0, xx2, yy);
						}
						draw_text(xx2+32, yy, string(itemDB[# idb.effectValue, index]));
						
					}
					// Draw arrow if this item is selected
					if (equipSelected == itemCount){
						draw_sprite(spr_MenuCursor, 0, xx-64, yy);
					}
					
					itemList[itemCount] = itemDB[# idb.id, index];
					itemCount++;
					
					if (itemCount == 10){
						xx = 496;
						xx2 = 672;
						yy = 32;
					}
					else{
						yy += 32;
					}
				}
			}
		}
		
		// Draw arrow if this Back button is selected
		if (equipSelected == itemCount){
			draw_sprite(spr_MenuCursor, 0, xx-64, yy);
		}
		itemList[itemCount] = "Back";
		draw_text(xx-32, yy, "Back");
		
		#endregion		
	
	}
	
	
	#endregion
}