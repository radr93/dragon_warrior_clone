/// @description Draw the Pause Menu

#region Options list

#region Backdrop
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

#region Draw the cursor

var cursorX, cursorY, yOffset;
cursorX = 32;
cursorY = 32;
yOffset = optionSelected*32;
draw_sprite(spr_MenuCursor, 0, cursorX, cursorY+yOffset);

#endregion

#endregion

// If in a sub-menu
if (inSubMenu){
	
	#region Status sub menu
	if (optionSelected == optionsList.status){
		
		#region Backdrop
		// Get size of status menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of options list
		y1 = 16;	// Top of options list
		x2 = 543;	// Right side of options list
		y2 = 191;	// Bottom of options list

		// Draw the backdrop of the options list
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the options list
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
		
		draw_text(xx, yy, "Level: "+string(player.stats[playerStat.level]));
		yy+=32;
		
		draw_text(xx, yy, "HP: "+string(player.stats[playerStat.hpCurrent])+"/"+string(player.stats[playerStat.hpMax]));
		yy+=32;
		
		draw_text(xx, yy, "MP: "+string(player.stats[playerStat.mpCurrent])+"/"+string(player.stats[playerStat.mpMax]));
		yy+=32;
		
		draw_text(xx, yy, "XP: "+string(player.stats[playerStat.xpCurrent])+"/"+string(player.stats[playerStat.xpMax]));
		xx = 352;
		yy = 32;
		
		draw_text(xx, yy, "Gold: "+string(player.stats[playerStat.goldCount]));
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
	
	#region Items sub menu
	if (optionSelected == optionsList.items){
		
		#region Backdrop
		// Get size of status menu
		var x1, y1, x2, y2;
		x1 = 144;	// Left side of options list
		y1 = 16;	// Top of options list
		x2 = 591;	// Right side of options list
		y2 = 351;	// Bottom of options list

		// Draw the backdrop of the options list
		draw_set_color(c_black);
		draw_rectangle(x1, y1, x2, y2, false);

		// Draw the outline of the options list
		draw_set_color(c_white);
		draw_rectangle(x1, y1, x2, y2, true);
		#endregion
		
		#region Draw the Item list text
		
		var xx, xx2, yy, itemCount;
		xx = 176;	// X position of name
		xx2 = 336;	// X position of quantity
		yy = 32;	// Y position 
		itemCount = 0;
		
		// Loop through player's currently held items
		var player = obj_PlayerController;
		for (var i = 0; i < itemID.MAX; i++){
			
			// If the player has 1 or more of the item
			if (player.items[i] > 0){
				
				// Look up the item ID in the item database
				var itemId, itemDB, gridHeight, index;
				itemId = i;
				itemDB = obj_ItemDatabase.itemDB;
				gridHeight = ds_grid_height(itemDB);
				index = ds_grid_value_y(itemDB, 0, 0, 0, gridHeight-1, itemId);
				
				// If the item isn't equipment
				//if (itemDB[# idb.equippable, index] == 0){
					
					// Draw Item Name
					draw_text(xx, yy, string(itemDB[# idb.name, index]));
					
					// Draw Item Quantity
					draw_text(xx2, yy, "x"+string(player.items[i]));
					
					itemCount++;					
					if (itemCount == 10){
						xx = 384;
						xx2 = 560;
						yy = 32;
					}
					else{
						yy += 32;
					}
					
					
				//}
				
			}
		}
		
		#endregion
	
	}



	#endregion
	
}