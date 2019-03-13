/// @description Navigate menus

/// OPTIONS MENU
// If you're not already in a sub menu (i.e. selecting a choice in the options list)
if (!inSubMenu){
	
	#region Navigate the options list
	
	#region Down Key Pressed
	if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
		
			// If you're not at the bottom of the options list
			if (optionSelected < optionsList.close){
				
				// Move down an option
				optionSelected++;
			}
			
			// If you're at the bottom of the options list
			else{
				
				// Move back up to the top of the options list
				optionSelected = optionsList.status;
			}
	
	}
	#endregion

	#region Up Key Pressed
	if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){
		
		// If you're not at the top of the options list
		if (optionSelected > optionsList.status){
			
			// Move up an option
			optionSelected--;
		}
		
		// If you're at the top of the options list
		else{
			
			// Move back down to the bottom of the options list
			optionSelected = optionsList.close;
		}
	}
#endregion

	#region Confirm Key Pressed
	if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
	
		// Cycle through sub menus
		switch (optionSelected){
			
			// Close the pause menu if close is selected
			case optionsList.close:
				instance_destroy();
				break;
				
			// If something else is selected, you're now "inSubMenu" for that "optionSelected"
			default:
				inSubMenu = true;
				break;
		}
		
	}
	#endregion
	
	#region Back Key Pressed
	if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
		// Close the pause menu
		instance_destroy();
	}
	#endregion
	
	#region Start Key Pressed
	if (keyboard_check_pressed(input.start) or keyboard_check_pressed(input.start2)){
	
		// Close the pause menu
		instance_destroy();
	}
	#endregion
	
	#endregion
}

/// SUB-MENUS
// If you are in a sub menu (i.e. status, item, spell, equip)
else{
	
	#region Navigate the different sub menus
	
	// Navigate the Item Sub-Menu
	#region Item Sub-Menu
	if (optionSelected == optionsList.items){
				
		#region Check what items the player has
		
		var player, itemCount, itemList;
		player = obj_PlayerController;	// Get player as shorthand variable
		itemCount = 0;					// How many items the player has
		
		// Loop through player's items
		for (var item = 0; item < itemID.MAX; item++){
			
			// If the player has 1 or more of an item in their inventory
			if (player.items[item] > 0){
				
				// Look up that item ID in the item database
				var itemDB, gridHeight, index;
				itemDB = obj_ItemDatabase.itemDB;								// The ds grid of the item database
				gridHeight = ds_grid_height(itemDB);							// The height of the database grid				
				index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, item);	// The Y index of the item in the database
				
				// If the item isn't equipment
				if (itemDB[# idb.equippable, index] == 0){
					itemList[itemCount] = itemDB[# idb.id, index];				// Store that item in a temporary array
					itemCount++;												// Increment the number of items counted
				}
			}
		}
		itemList[itemCount] = "Back";											// When done looping, the last entry is always "Back"
		#endregion
		
		#region Create a text box for the item's description
		
		// Get textbox instance ID as local variable
		if (!instance_exists(obj_TextBox)){
			var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);
		}
		else{
			var textbox = obj_TextBox;
		}
		
		// Give textbox item descriptions
		if (itemList[itemSelected] != "Back"){
			index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, itemList[itemSelected]);
			textbox.newText = itemDB[# idb.description, index];
		}
		
		// Give textbox back button description
		else{
			textbox.newText = "Exit the item menu.";
		}
		
		#endregion
		
		#region Down Key Pressed
		if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
			
			// If you're not at the bottom of the options list
			if (itemSelected < itemCount){
				
				// Move down an option
				itemSelected++;
			}
			
			// If you're at the bottom of the options list
			else{
				
				// Move back up to the top of the options list
				itemSelected = 0;
			}
		}
		#endregion

		#region Up Key Pressed
		if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){
			
			// If you're not at the top of the options list
			if (itemSelected > 0){
			
				// Move up an option
				itemSelected--;
			}
		
			// If you're at the top of the options list
			else{
			
				// Move back down to the bottom of the options list
				itemSelected = itemCount;
			}
		}
		#endregion		
		
		#region Confirm Key Pressed
		if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
			
			// If the "Back" option is selected
			if (itemList[itemSelected] == "Back"){
				
				// No longer in the item sub menu
				itemSelected = 0;		// Reset item selected (so arrow goes back to top of the list)
				inSubMenu = false;		// No longer in the item sub menu
			
				// Destroy textbox
				if (instance_exists(obj_TextBox)){
					instance_destroy(obj_TextBox);
				}				
			}
			
			// If an item is selected
			else{
				
				// Look up the selected item's item ID in the item database
				var itemDB, gridHeight, index;
				itemDB = obj_ItemDatabase.itemDB;		// The ds grid of the item database
				gridHeight = ds_grid_height(itemDB);	// The height of the database grid				
				index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, itemList[itemSelected]);
				
				// If the item is usable
				if (itemDB[# idb.usable, index] == 1){
					
					// Loop through possible effects
					switch (itemDB[# idb.effect, index]){
						
						// Heal Player
						case itemEffect.heal:
						
							// Only heal if player has less than max hp
							if (player.stats[playerStat.hpCurrent] < player.stats[playerStat.hpMax]){
								
								// Roll for heal effectiveness
								var healRoll = irandom_range(itemDB[# idb.effectValue, index], itemDB[# idb.effectRange, index]);
								
								// If heal will bring you to greater than your max hp
								if (player.stats[playerStat.hpCurrent] + healRoll > player.stats[playerStat.hpMax]){
									// Go to max HP
									player.stats[playerStat.hpCurrent] = player.stats[playerStat.hpMax];
								}
								// Otherwise
								else{
									// Heal for the full amount of the healRoll
									player.stats[playerStat.hpCurrent] += healRoll;
								}
								
								// Remove the item from the inventory
								player.items[itemDB[# idb.id, index]]--;
								
							}
							break;
						case itemEffect.teleHome:
							// INSERT CODE TO TELEPORT HOME
							break;
						case itemEffect.illuminate:
							// INSERT CODE TO ILLUMINATE CAVES
							break;
						case itemEffect.unlock:
							// INSERT CODE TO UNLOCK CHESTS OR DOORS
							break;
					
					}
				}
			}
		}	
		
		#endregion
		
		#region Back Key Pressed
		if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
			// No longer in the item sub menu
			itemSelected = 0;		// Reset item selected (so arrow goes back to top of the list)
			inSubMenu = false;		// No longer in the item sub menu
			
			// Destroy textbox
			if (instance_exists(obj_TextBox)){
				instance_destroy(obj_TextBox);
			}
		}
		#endregion
	}
	
	#endregion
	
	// Navigate the Spells Sub-Menu
	#region Spell Sub-Menu
	else if (optionSelected == optionsList.spells){
				
		#region Check what spells the player has
		
		var player, spellCount, spellList;
		player = obj_PlayerController;	// Get player as shorthand variable
		spellCount = 0;					// How many spells the player has
		
		// Loop through player's spells
		for (var spell = 0; spell < spellID.MAX; spell++){
			
			// If the player has 1 or more of a spell in their inventory
			if (player.spells[spell] == 1){
				
				// Look up the spell ID in the spell database
				var spellDB, gridHeight, index;
				spellDB = obj_SpellDatabase.spellDB;							// The ds grid of the spell database
				gridHeight = ds_grid_height(spellDB);							// The height of the database grid				
				index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spell); // The Y index of the spell in the database
				
				spellList[spellCount] = spellDB[# idb.id, index];				// Store that spell in a temporary array
				spellCount++;													// Increment number of spells counted
			}
		}
		spellList[spellCount] = "Back";											// When done looping, the last entry is always "Back"
		#endregion
		
		#region Create a text box for the item's description
		
		// Get textbox instance ID as local variable
		if (!instance_exists(obj_TextBox)){
			var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);
		}
		else{
			var textbox = obj_TextBox;
		}
		
		// Give textbox item descriptions
		if (spellList[spellSelected] != "Back"){
			index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spellList[spellSelected]);
			textbox.newText = spellDB[# sdb.description, index];
		}
		
		// Give textbox back button description
		else{
			textbox.newText = "Exit the spell menu.";
		}
		
		#endregion
		
		#region Down Key Pressed
		if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
				
				// If you're not at the bottom of the options list
				if (spellSelected < spellCount){
				
					// Move down an option
					spellSelected++;
				}
			
				// If you're at the bottom of the options list
				else{
				
					// Move back up to the top of the options list
					spellSelected = 0;
				}
	
		}
		#endregion

		#region Up Key Pressed
		if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){

			// If you're not at the top of the options list
			if (spellSelected > 0){
			
				// Move up an option
				spellSelected--;
			}
		
			// If you're at the top of the options list
			else{
			
				// Move back down to the bottom of the options list
				spellSelected = spellCount;
			}
		}
	#endregion		
		
		#region Confirm Key Pressed
		if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
			// If the back option is selected
			if (spellList[spellSelected] == "Back"){
				
				// Close the spell sub menu
				spellSelected = 0;
				inSubMenu = false;
				
				// Destroy textbox
				if (instance_exists(obj_TextBox)){
					instance_destroy(obj_TextBox);
				}
			}
			
			// If an spell is selected
			else{
				
				// Look up the selected spell's spell ID in the spell database
				var spellDB, gridHeight, index;
				spellDB = obj_SpellDatabase.spellDB;		// The ds grid of the spell database
				gridHeight = ds_grid_height(spellDB);		// The height of the database grid				
				index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spellList[spellSelected]);
				
				// If you can use the spell outside of battle
				if (spellDB[# sdb.usableOutOfBattle, index]){
					
					show_debug_message("YES YOU CAN YOU THIS SPELL OUTSIDE OF BATTLE!!!");
					// If the player has enough mana to make the cast
					if (player.stats[playerStat.mpCurrent] >= spellDB[# sdb.spellCost, index]){
						
						// Perform the cast depending what kind of spell it was
						switch(spellDB[# sdb.spellEffect, index]){
						
							// Healing Spells
							case spellEffect.heal:
								
								// Only heal if player has less than max hp
								if (player.stats[playerStat.hpCurrent] < player.stats[playerStat.hpMax]){
									
									// Subtract mana
									player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
									// Roll for heal effectiveness
									var healRoll = irandom_range(spellDB[# sdb.effectMin, index], spellDB[# sdb.effectMax, index]);
									
									// If heal will bring you to greater than your max hp
									if (player.stats[playerStat.hpCurrent] + healRoll > player.stats[playerStat.hpMax]){
										// Go to max HP
										player.stats[playerStat.hpCurrent] = player.stats[playerStat.hpMax];
									}
									// Otherwise
									else{
										// Heal for the full amount of the healRoll
										player.stats[playerStat.hpCurrent] += healRoll;
									}
								}
								break;
							// Illumination Spells
							case spellEffect.illuminate:
								
								// Subtract player MP
								player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
								// CODE TO ILLUMINATE CAVES GOES HERE
								break;
							
							// Teleport Spells
							case spellEffect.teleOut:
								
								// Subtract player MP
								player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
								// CODE TO TELEPORT OUT OF CAVES GOES HERE
								break;
								
							case spellEffect.teleHome:
								// Subtract player MP
								player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
								// CODE TO TELEPORT HOME GOES HERE
								break;
						
						}
					}
				}
			}
		}
		
		
		#endregion
		
		#region Back Key Pressed
		if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
			// No longer in sub menu
			spellSelected = 0;
			inSubMenu = false;
			
			// Destroy textbox
			if (instance_exists(obj_TextBox)){
				instance_destroy(obj_TextBox);
			}
		}
		#endregion
	}
	
	#endregion
	
	// Navigate the Equipment Sub-Menu
	#region Equip Sub-Menu
	else if (optionSelected == optionsList.equip){
				
		#region Check what items the player has
		
		var player, itemCount, itemList;
		player = obj_PlayerController;	// Get player as shorthand variable
		itemCount = 0;					// How many items the player has
		
		// Loop through player's items
		for (var item = 0; item < itemID.MAX; item++){
			
			// If the player has 1 or more of an item in their inventory
			if (player.items[item] > 0){
				
				// Look up the item ID in the item database
				var itemDB, gridHeight, index;
				itemDB = obj_ItemDatabase.itemDB;								// The ds grid of the item database
				gridHeight = ds_grid_height(itemDB);							// The height of the database grid				
				index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, item);	// The Y index of the item in the database
				
				// If the item is equipment
				if (itemDB[# idb.equippable, index] == 1){
					itemList[itemCount] = itemDB[# idb.id, index];				// Store that item in a temporary array
					itemCount++;												// Increment the number of items counted
				}
			}
		}
		itemList[itemCount] = "Back";											// When done looping, the last entry is always "Back"
		#endregion
		
		#region Create a text box for the item's description
		
		// Get textbox instance ID as local variable
		if (!instance_exists(obj_TextBox)){
			var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);
		}
		else{
			var textbox = obj_TextBox;
		}
		
		// Give textbox item descriptions
		if (itemList[equipSelected] != "Back"){
			index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, itemList[equipSelected]);
			textbox.newText = itemDB[# idb.description, index];
		}
		
		// Give textbox back button description
		else{
			textbox.newText = "Exit the equip menu.";
		}
		
		#endregion
			
		#region Down Key Pressed
		if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
				
			// If you're not at the bottom of the options list
			if (equipSelected < itemCount){
				
				// Move down an option
				equipSelected++;
			}
			
			// If you're at the bottom of the options list
			else{
				
				// Move back up to the top of the options list
				equipSelected = 0;
			}
	
		}
		#endregion

		#region Up Key Pressed
		if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){
			
			// If you're not at the top of the options list
			if (equipSelected > 0){
			
				// Move up an option
				equipSelected--;
			}
		
			// If you're at the top of the options list
			else{
			
				// Move back down to the bottom of the options list
				equipSelected = itemCount;
			}
		}
	#endregion		
		
		#region Confirm Key Pressed
		if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
			// If the back option is selected
			if (itemList[equipSelected] == "Back"){
				
				// No longer in sub menu
				equipSelected = 0;		// Reset equip selected (so arrow goes back to top of the list)
				inSubMenu = false;		// No longer in the equip sub menu
			
				// Destroy textbox
				if (instance_exists(obj_TextBox)){
					instance_destroy(obj_TextBox);
				}
			}
			
			// If an item is selected
			else{
				
				// Look up the selected item's item ID in the item database
				var itemDB, gridHeight, index;
				itemDB = obj_ItemDatabase.itemDB;		// The ds grid of the item database
				gridHeight = ds_grid_height(itemDB);	// The height of the database grid				
				index = ds_grid_value_y(itemDB, 0, 1, 0, gridHeight-1, itemList[equipSelected]);
				
				// If it's a weapon
				if (itemDB[# idb.effect, index] == itemEffect.weapon){
					player.equip[equipSlot.weapon] = itemDB[# idb.id, index];
				}
				
				// If it was armor
				else if (itemDB[# idb.effect, index] == itemEffect.armor){
					player.equip[equipSlot.armor] = itemDB[# idb.id, index];
				}
				
				// If it was a shield
				else if (itemDB[# idb.effect, index] == itemEffect.shield){
					player.equip[equipSlot.shield] = itemDB[# idb.id, index];
				}
			}
			
		}
		
		
		#endregion
			
		#region Back Key Pressed
		if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
			// No longer in sub menu
			equipSelected = 0;		// Reset equip selected (so arrow goes back to top of the list)
			inSubMenu = false;		// No longer in the equip sub menu
			
			// Destroy textbox
			if (instance_exists(obj_TextBox)){
				instance_destroy(obj_TextBox);
			}
		}
		#endregion
	}
	
	#endregion
	
	// Close Status Sub Menu
	else{
		
		#region Back Key Pressed
		if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
			// No longer in sub menu
			inSubMenu = false;		// No longer in the status sub-menu
		}
		#endregion
	}
	
	#endregion
}