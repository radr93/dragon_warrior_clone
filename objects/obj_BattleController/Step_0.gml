/// @description Check for a battle

// If the player is in a battle (triggered randomly when player takes a step)
if (global.inBattle){
	
	// If encounter has not been set yet
	if (encounter == -1){
		
		#region Get and set the encounter
		
		// Set state to begin encounter
		state = battleState.beginEncounter;
		
		#region Find out what was encountered (get variable "encounter" as enemyID enum randomly from encounter List)
		
		// Initialize Variables
		var hh, rangeChecking, roll;
		hh = array_height_2d(encounterList);
		rangeChecking = 0;		// Increments each iteration until you get a monster
		roll = random(1);		// Percentage rolled
		
		// Loop through encounter list
		for (var e = 0; e < hh; e++){
	
			rangeChecking += encounterList[e, encounterParam.chance];
			
			// If you found an encounter
			if (roll <= rangeChecking){
				
				// Set the encounter
				encounter = encounterList[e, encounterParam.id];
				break;
			}
		}
		
		#endregion
		
		#region Look up enemy ID's row index in enemy DB
		
		// Look up enemy ID's row index in enemy DB and set encounter's HP
		var enemyDB, index;
		enemyDB = obj_EnemyDatabase.enemyDB;
		index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, encounter);
		encounterHP = enemyDB[# edb.hp, index];
		
		#endregion
	
		#region Create a textbox and/or hold the textbox instance ID as local variable
	
		// If a textbox doesn't already exist, create one and store it's instance ID in a local variable
		if (!instance_exists(obj_TextBox)){	var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);	}
	
		// If a textbox does already exist, get the instance ID as a local variable
		else{ var textbox = obj_TextBox; }
		
		#endregion
		
		#region Find out if using a, an or the
		var a_an_the, name;
		
		// A
		a_an_the = "A ";		// Default "A "
		// An
		if (enemyDB[# edb.id, index] == enemyID.armoredKnight or enemyDB[# edb.id, index] == enemyID.axeKnight){
			a_an_the = "An "	// Use "An " for enemies with a vowel at the beginning of their name
		}
		// The
		else if (enemyDB[# edb.id, index] == enemyID.dragonlord or enemyDB[# edb.id, index] == enemyID.dragonlord2){
			a_an_the = "The "	// "The " is used for unique enemies
		}
		#endregion
		
		#region Draw the "A/An/The <monsterName> appeared" message in the textbox
		
		// Draw the "A/An/The <monsterName> appeared" message in the textbox
		name = enemyDB[# edb.name, index];
		textbox.newText = a_an_the + name + " appeared!";
		
		#endregion 
		
		#endregion
	}
	
	// If the encounter is set
	else if (encounter >= 0){
		
		
		#region Look up enemy ID's row index in enemy DB
		
		// Look up enemy ID's row index in enemy DB
		var player, enemyDB, index;
		player = obj_PlayerController;
		enemyDB = obj_EnemyDatabase.enemyDB;
		index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, encounter);
		
		#endregion
	
		#region Create a textbox and/or hold the textbox instance ID as local variable
	
		// If a textbox doesn't already exist, create one and store it's instance ID in a local variable
		if (!instance_exists(obj_TextBox)){	var textbox = instance_create_layer(x, y, "Controllers", obj_TextBox);	}
	
		// If a textbox does already exist, get the instance ID as a local variable
		else{ var textbox = obj_TextBox; }
		
		#endregion
		
		// Loop through battle states and behave accordingly
		switch (state){
			
			// battleState.beginEncounter
			#region Begin the encounter
			
			case battleState.beginEncounter:
				
				// Confirm past the "A/An/The <monsterName> appeared" message
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
					// If the message has finished drawing
					if (textbox.textToDraw == textbox.currentText){
						
						// Possible pre-emptive strikes
						if (random(1) < 0.90){
							var choice = choose(1, 2);
							
							// Enemy Pre-Emptive
							if (choice == 1){
								state = battleState.enemyPreEmptive;
							}
							
							// Player Pre-Emptive
							else{
								state = battleState.playerPreEmptive;
							}
						}
						
						else{
							// Prompt player for an action
							state = battleState.selectAction;
						}
					}
				}
				break;
				
			#endregion
			
			// battleState.playerPreEmptive
			#region Player gets a pre-emptive strike
			case battleState.playerPreEmptive:
				textbox.newText = "The "+enemyDB[# edb.name, index]+" doesn't notice you!"
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					if (textbox.textToDraw == textbox.currentText){
						// Find out which action you selected
						playerPreEmptive = true;
						state = battleState.selectAction;
					}
				}				
				break;
			#endregion
			
			// battleState.enemyPreEmptive
			#region Enemy gets a pre-emptive strike
			case battleState.enemyPreEmptive:
				textbox.newText = "The "+enemyDB[# edb.name, index]+" attacked before you were ready!"
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					if (textbox.textToDraw == textbox.currentText){
						enemyPreEmptive = true;
						state = battleState.takeDamage;
					}
				}
				break;
			#endregion
			
			// battleState.selectAction
			#region Select an action
			case battleState.selectAction:
				
				// Draw the appropriate text for the action selected
				switch(actionSelected){
					case action.fight:	textbox.newText = "Attack the "+enemyDB[# edb.name, index]+".";	break;
					case action.spell:	textbox.newText = "Cast a spell.";								break;
					case action.item:	textbox.newText = "Use an item.";								break;
					case action.flee:	textbox.newText = "Attempt to flee.";							break;
				}
				
				// Interact with the action list
				#region Down Key Pressed
				if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
			
					// If you're not at the bottom of the action list
					if (actionSelected < action.flee){
				
						// Move down an option
						actionSelected++;
					}
			
					// If you're at the bottom of the action list
					else{
				
						// Move back up to the top of the action list
						actionSelected = action.fight;
					}
				}
				#endregion
				
				#region Up Key Pressed
		if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){
						
			// If you're not at the top of the action list
			if (actionSelected > action.fight){
			
				// Move up an option
				actionSelected--;
			}
		
			// If you're at the top of the action list
			else{
			
				// Move back down to the bottom of the action list
				actionSelected = action.flee;
			}
		}
				#endregion		
				
				#region Confirm Key Pressed
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm)){
					
					// Find out which action you selected
					if (textbox.textToDraw == textbox.currentText){
						switch(actionSelected){
							case action.fight:
								state = battleState.fight;
								actionSelected = action.fight;
								break;						
							case action.spell:
								state = battleState.spell;
								actionSelected = action.fight;
								break;
							case action.item:
								state = battleState.item;
								actionSelected = action.fight;
								break;
							case action.flee:
								state = battleState.flee;
								actionSelected = action.fight;
								break;
						}
					}
				}
				#endregion
				
				break;
			#endregion
				
			// battleState.fight
			#region Fight the enemy (melee)
			case battleState.fight:
								
				// If initiative hasn't been decided
				if (is_undefined(initiative)){
					
					#region Decide if player or enemy gets initiative
					
					// If neither player or enemy got a pre-emptive strike, calculate who attacks first
					if (!playerPreEmptive and !enemyPreEmptive){
						
						// Get player and enemy agility
						var playerAgility, enemyAgility;
						playerAgility = player.stats[playerStat.agility];
						enemyAgility = enemyDB[# edb.agility, index];
					
						// Enemy attacks player first
						if (playerAgility*irandom(255) < enemyAgility * irandom(255) * 0.25){
							initiative = "enemy";
							show_debug_message("Fight state: Enemy gets the initative.");
						}
					
						// Player attacks enemy first
						else{
							initiative = "player";
							show_debug_message("Fight state: Player gets the initiative.");
						}
					}
					
					// If the player got a pre-emptive strike
					else if (playerPreEmptive){
						initiative = "player";
					}
					
					// If the enemy got a pre-emptive strike
					else if (enemyPreEmptive){
						initiative = "enemy";
					}
					
					#endregion
				}
				
				// When initiative has been decided
				else{
					
					#region If the player has initiative
					if (initiative == "player"){
						
						// If the player got a pre-emptive strike
						if (playerPreEmptive){
							
							// Deal damage outright, forgoing any enemy damage
							state = battleState.dealDamage;
						}
						
						// If the player did not get a pre-emptive strike
						else{
							#region If the player hasn't dealt damage yet
							if (playerDamage == -1){
								show_debug_message("Fight state: Player has initiative. Player has not dealt damage yet.");
								// Deal damage to the enemy first
								state = battleState.dealDamage;
							}
							#endregion
						
							#region If the enemy hasn't dealt damage yet
							else if (enemyDamage == -1){
								show_debug_message("Fight state: Player has initiative. Player has dealt damage. Enemy has not dealt damage.");
								// Enemy deals damage to the player second
								state = battleState.takeDamage;
							}
							#endregion
						
							#region If the enemy and the player have both dealt their damage
							else{
								show_debug_message("Fight state: Player has initiative. Player has dealt damage. Enemy has dealt damage.");
							
								// Reset initiative and damage variables
								initiative = undefined;
								playerDamage = -1;
								enemyDamage = -1;
							
								// Return to action selection
								state = battleState.selectAction;
							}
							#endregion
						}
					}
					#endregion
					
					#region If the enemy has initiative
					else if (initiative == "enemy"){
						
						// If the enemy got a pre-emptive strike
						if (enemyPreEmptive){
							
							// Take damage outright, forgoing any player damage
							state = battleState.takeDamage;
						}
						// If the player did not get a pre-emptive strike
						else{
							#region If the enemy hasn't dealt damage yet
						
							if (enemyDamage == -1){
								show_debug_message("Fight state: Enemy has initiative. Enemy has not dealt damage.");
								// Enemy deals damage first
								state = battleState.takeDamage;
							}
						
							#endregion
						
							#region If the player hasn't dealt damage yet
							else if (playerDamage == -1){
								show_debug_message("Fight state: Enemy has initiative. Enemy has dealt damage. Player has not dealt damage.");
								// Player deals damage second
								state = battleState.dealDamage;
							}
							#endregion
												
							#region If the enemy and the player have both dealt their damage
							else{
								show_debug_message("Fight state: Enemy has initiative. Player and enemy have dealt damage.");
							
								// Reset initiative and damage variables
								initiative = undefined;
								playerDamage = -1;
								enemyDamage = -1;
							
								// Return to action selection
								state = battleState.selectAction;
							}
							#endregion
						}
					}
					#endregion
				}
				
				break;
			#endregion
			
			// battleState.spell
			#region Select and cast spell
			case battleState.spell:
				
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
		
				#region Give the textbox the spell's description
				
				if (!spellCasted){
					// Give textbox spell descriptions
					if (spellList[spellSelected] != "Back"){
						index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spellList[spellSelected]);
						textbox.newText = spellDB[# sdb.description, index];
					}
		
					// Give textbox back button description
					else{
						textbox.newText = "Exit the spell menu.";
					}
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
						if (textbox.textToDraw == textbox.currentText){
							
							#region Calculate Spell Damage
							if (!spellCasted){
								// If the back option is selected
								if (spellList[spellSelected] == "Back"){
				
									// Close the spell sub menu
									spellSelected = 0;
									state = battleState.selectAction;
								}
			
								// If a spell is selected
								else{
				
									// Look up the selected spell's spell ID in the spell database
									var spellDB, gridHeight, index;
									spellDB = obj_SpellDatabase.spellDB;		// The ds grid of the spell database
									gridHeight = ds_grid_height(spellDB);		// The height of the database grid				
									index = ds_grid_value_y(spellDB, 0, 1, 0, gridHeight-1, spellList[spellSelected]);
				
									// If you can use the spell in battle
									if (spellDB[# sdb.usableInBattle, index] == 1){
					
										show_debug_message("YES YOU CAN YOU THIS SPELL IN BATTLE!!!");
							
										// If the player has enough mana to make the cast
										if (player.stats[playerStat.mpCurrent] >= spellDB[# sdb.spellCost, index]){
											
											enoughMana = true;
						
											// Perform the cast depending what kind of spell it was
											switch(spellDB[# sdb.spellEffect, index]){
									
												// Damaging Spells
												case spellEffect.damage:
										
													// Subtract mana
													player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
													
													// Roll for damage and do damage
													playerDamage = irandom_range(spellDB[# sdb.effectMin, index], spellDB[# sdb.effectMax, index]);
													textbox.newText = "You cast "+spellDB[# sdb.name, index]+" and deal "+string(playerDamage)+" damage.";
													spellCasted = true;
													
													break;
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
															textbox.newText = "You cast "+spellDB[# sdb.name, index]+" and restore your health to full.";
															playerDamage = 0;
															spellCasted = true;
														}
														// Otherwise
														else{
															// Heal for the full amount of the healRoll
															player.stats[playerStat.hpCurrent] += healRoll;
															textbox.newText = "You cast "+spellDB[# sdb.name, index]+" and restore your health by "+string(healRoll)+".";
															playerDamage = 0;
															spellCasted = true;
														}
													}
													break;
							
												// Sleep Spells
												case spellEffect.sleep:
								
													// Subtract player MP
													player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
													// CODE TO SLEEP ENEMIES GOES HERE
													
													break;
								
												case spellEffect.silence:
										
													// Subtract player MP
													player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
													// CODE TO SILENCE ENEMIES GOES HERE
													break;
									
												case spellEffect.debuff:
										
													// Subtract player MP
													player.stats[playerStat.mpCurrent] -= spellDB[# sdb.spellCost, index];
								
													// CODE TO DEBUFF ENEMIES GOES HERE
													break;
											}
										}
										else{
											enoughMana = false;
											textbox.newText = "Not enough mana to cast that spell!";
											spellCasted = true;
											
										}
									}
								}
							}
							#endregion
							
							#region Deal damage
							else{
								
								// If the player had enough mana
								if (enoughMana){
									
									// If the enemy has less HP than the damage value
									if (encounterHP <= playerDamage){
									
										// Battle victory
										encounterHP = 0;
										textbox.newText = "You defeated the "+enemyDB[# edb.name, index]+"!";
										state = battleState.victory;
									}
								
									// If the enemy has more HP than the damage value
									else{
									
										// If it was a pre-emptive strike
										if (playerPreEmptive){
										
											// Deal damage and go to the select action state
											encounterHP -= playerDamage;
											playerPreEmptive = false;
											playerDamage = -1;
											state = battleState.selectAction;
										}
									
										// If it was a normal strike
										else{
											// Deal damage and return to the fight state to either get attacked by the enemy or go back to action menu depending on initiative
											encounterHP -= playerDamage;
											playerDamage = -1;
											spellCasted = false;
											enoughMana = undefined;
											enemyPreEmptive = true;
											state = battleState.takeDamage;
										}
									}
									spellcasted = false;
									
								}
								
								// If the player didn't have enough mana
								else{
									
									// Clear the previous message, no spell selected and enoughMana isn't decided again
									spellCasted = false;
									enoughMana = undefined;
								}
							}
							#endregion
						}
					}
				
				#endregion
		
				#region Back Key Pressed
				if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
		
					// No longer in sub menu
					spellSelected = 0;
					state = battleState.selectAction;
				}
				#endregion
				
				break;
				
			#endregion
			
			// battleState.item
			#region Select and use an item
			case battleState.item:
				
				// Navigate the Item Sub-Menu

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
						state = battleState.selectAction;
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
											enemyPreEmptive = true;
											state = battleState.takeDamage;
										}
										// Otherwise
										else{
											// Heal for the full amount of the healRoll
											player.stats[playerStat.hpCurrent] += healRoll;
											enemyPreEmptive = true;
											state = battleState.takeDamage;
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
					state = battleState.selectAction;
				}
				#endregion
				
				break;
			#endregion
			
			// battleState.flee
			#region Flee the battle
			case battleState.flee:
							
				#region Roll for chance to flee
				if (is_undefined(fleeSuccessful)){
					
					textbox.newText = "You attempt to flee..."		
					
					// Confirm past the previous message "You attempt to flee..."
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						if (textbox.textToDraw == textbox.currentText){
							
							// Roll for chance to flee
							var fleeChance, fleeRange;
							fleeChance = random(1);
						
							// If the monster is double or more the player's level
							if (enemyDB[# edb.level, index] >= player.stats[playerStat.level]*2){
								// 25% chance to escape
								fleeRange = 0.25;
							}
							
							// If the mosnter is half or less the player's level
							else if (enemyDB[# edb.level, index] <= player.stats[playerStat.level]/2){
								// 75% chance to escape
								fleeRange = 0.75;
							}
							
							// If the monster is somewhere around the player's level
							else{
								// 50% chance to escape
								fleeRange = 0.5;
							}
							
							// If the player has a pre-emptive strike (or enemy is asleep)
							if (playerPreEmptive or enemySleep){
								fleeChance = 0;	// 0 means 100% chance
							}
							
							// If flee was successful
							if (fleeChance <= fleeRange){
								textbox.newText = "...and succeed! Got away safely.";
								fleeSuccessful = true;
							}
							
							// If flee was unsuccessful
							else{
								textbox.newText = "...but the "+enemyDB[# edb.name, index]+" blocks your path! Cannot escape!";
								fleeSuccessful = false;
							}
						}
					}
				}
				#endregion
				
				#region Provide outcome for success or failure
				else{
					
					// If the attempt was successful
					if (fleeSuccessful){
						
						if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
							
							if (textbox.textToDraw == textbox.currentText){
								
								// Reset all default parameters
								scr_battle_reset_variables();
							}
						}
					}
					// If the attempt was not successful
					else{
						if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
							
							if (textbox.textToDraw == textbox.currentText){
								
								// Take damage from the enemy
								state = battleState.takeDamage;
							}
						}
					}
					
				}
				#endregion

				break;
			#endregion
			
			// battleState.dealDamage
			#region Deal damage to the enemy
			
			case battleState.dealDamage:
				
				// If the damage hasn't been calculated yet
				if (is_undefined(damageCalculated)){
					
					#region Calculate the damage
					
					// Chance to miss the attack
					if (enemyDB[# edb.dodge, index] >= irandom_range(1, 64)){
						playerDamage = -1;
						damageCalculated = true;
					}
									
					// Calculate Damage
					else{
						
						var playerAttack, enemyDefence, criticalHit, minDamage, maxDamage;
						playerAttack = player.stats[playerStat.attackPower];
						enemyDefence = enemyDB[# edb.defence, index];
						criticalHit = false;
						
						// Critical Hit chance						
						if (random(1) < 0.15){
							criticalHit = true;
						}
						if (criticalHit){
							minDamage = (playerAttack - enemyDefence / 2) / 2;
							maxDamage = (playerAttack - enemyDefence / 2);
							if (minDamage <= 0) {	minDamage = 1	}
							if (maxDamage <= 1) {	maxDamage = 2	}
						}
						else{
							minDamage = (playerAttack - enemyDefence / 2) / 4;
							maxDamage = (playerAttack - enemyDefence / 2) / 2;
						}
						
						playerDamage = irandom_range(minDamage, maxDamage);
						
						if (playerDamage < 0){
							var choice = choose(1, 2);
							if (choice == 1){
								playerDamage = 1;
							}
							else{
								playerDamage = 0;
							}
						}
						
						damageCalculated = true;
						
						// Player damage messages
						if (!criticalHit){
							if (playerDamage == -1){
								textbox.newText = "You swing, but the "+enemyDB[# edb.name, index]+" dodges your strike!";
							}
							else if (playerDamage == 0){
								textbox.newText = "You swing at the "+enemyDB[# edb.name, index]+", but it blocks your strike!";
							}
							else{
								textbox.newText = "You swing at the "+enemyDB[# edb.name, index]+" and land a blow that deals "+string(playerDamage)+" damage.";
							}
						}
						else{
							textbox.newText = "A critical hit! You swing at the "+enemyDB[# edb.name, index]+" and land a well-placed strike that deals "+string(playerDamage)+" damage!";
						}
					}
					#endregion
				}
				
				// If the damage has been calculated
				else{
					
					#region Deal damage to the enemy
					
					// Try to confirm past the last message
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
								
						// If the message has finished drawing
						if (textbox.textToDraw == textbox.currentText){
							
							// If the player missed the attack or did no damage
							if (playerDamage <= 0){
								
								// If it was a pre-emptive strike
								if (playerPreEmptive){
									// Go to the select action state
									damageCalculated = undefined;
									playerPreEmptive = false;
									playerDamage = -1;
									state = battleState.selectAction;
								}
								
								// If it was a normal strike
								else{
									// Return to the fight state to either get attacked by the enemy or go back to action menu depending on initiative
									damageCalculated = undefined;
									state = battleState.fight;
								}
							}
							
							// If the player did damage
							else{
								
								// If the enemy has less HP than the damage value
								if (encounterHP <= playerDamage){
									
									// Battle victory
									encounterHP = 0;
									textbox.newText = "You defeated the "+enemyDB[# edb.name, index]+"!";
									state = battleState.victory;
								}
								
								// If the enemy has more HP than the damage value
								else{
									
									// If it was a pre-emptive strike
									if (playerPreEmptive){
										
										// Deal damage and go to the select action state
										encounterHP -= playerDamage;
										playerPreEmptive = false;
										playerDamage = -1;
										damageCalculated = undefined;
										state = battleState.selectAction;
									}
									
									// If it was a normal strike
									else{
										// Deal damage and return to the fight state to either get attacked by the enemy or go back to action menu depending on initiative
										encounterHP -= playerDamage;
										damageCalculated = undefined;
										state = battleState.fight;
									}
								}
								
							}
						}
					}
					#endregion
				}
									
				break;
				
			#endregion
			
			// battleState.takeDamage
			#region Take damage from enemy
			case battleState.takeDamage:
								
				#region Calculate Damage from enemy
				if (is_undefined(damageCalculated)){
				
					var roll = random(1);		// Roll for an enemy spell or regular attack
					var spellFailed = false;	// If the enemy doesnt possess a usable spell
				
					// Cast a damaging spell instead of a regular attack
					if (roll <= 0.25){
						
						#region Try to cast a damaging spell instead of a regular attack
						
						var enemyName, spellName;
						enemyName = enemyDB[# edb.name, index];
						var choice = choose(1, 2, 3, 4);
						switch (choice){
							case 1:
								#region Cast Super Breath if available
								if (enemyDB[# edb.superBreath, index] != -1){
									spellName = enemyDB[# edb.superBreath, index];
						
									var spellMin, spellMax;
									spellMin = 65;
									spellMax = 72;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+" and deals "+string(enemyDamage)+" damage.";
								}
								else{
									choice = 5;
								}
								#endregion
							case 2:
								#region Cast Flame Breath if available
								if (enemyDB[# edb.flameBreath, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.flameBreath, index];
						
									var spellMin, spellMax;
									spellMin = 16;
									spellMax = 23;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+" and deals "+string(enemyDamage)+" damage.";
								}
								else{
									choice = 5;
								}
								#endregion
							case 3:
								#region Cast Destroy if available
								
								// If Destroy is available
								if (enemyDB[# edb.destroy, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.destroy, index];
						
									var spellMin, spellMax;
									spellMin = 30;
									spellMax = 45;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+" and deals "+string(enemyDamage)+" damage.";
								}
								// Otherwise do a regular attack
								else{
									spellFailed = true;
								}
								#endregion
							case 4:
							#region Cast Afflict if available
							
								// If afflict is available
								if (enemyDB[# edb.afflict, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.afflict, index];
						
									var spellMin, spellMax;
									spellMin = 3;
									spellMax = 10;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									
									// Draw the damaging spell's text
									textbox.newText = "The "+enemyName+" uses "+spellName+" and deals "+string(enemyDamage)+" damage.";
								}
								// Otherwise do a regular attack
								else{
									spellFailed = true;
								}
								#endregion
							
						}
						
						#endregion
					}
					
					// Cast a damaging spell instead of a regular attack
					else if (roll > 0.25 and roll <= 0.50){
						
						#region Try to cast a healing spell instead of a regular attack
						
						var enemyName, spellName;
						enemyName = enemyDB[# edb.name, index];
						var choice = choose(1, 2);
						switch (choice){
							case 1:
								#region Cast Alleviate if available
								
								// If Alleviate is available
								if (enemyDB[# edb.alleviate, index] != -1){
									
									var enemyName, spellName, spellMin, spellMax, healRoll;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.alleviate, index];
									spellMin = 30;
									spellMax = 45;
									healRoll= irandom_range(spellMin, spellMax);
									damageCalculated = true;
									enemyDamage = 0;
									
									// If the heal will bring the monster to full health
									if (healRoll + encounterHP > enemyDB[# edb.hp, index]){
										encounterHP = enemyDB[# edb.hp, index];
										textbox.newText = "The "+enemyName+" uses "+spellName+" and heals itself up to full health.";
									}
									// Otherwise
									else{
										encounterHP += healRoll
										textbox.newText = "The "+enemyName+" uses "+spellName+" and heals itself for "+string(healRoll)+".";
									}
								}
								// Otherwise do a regular attack
								else{
									spellFailed = true;
								}
								
								#endregion
							case 2:
								#region Cast Revivify if available
							
									// If Revivify is available
									if (enemyDB[# edb.revivify, index] != -1){
										var enemyName, spellName, spellMin, spellMax, healRoll;
										enemyName = enemyDB[# edb.name, index];
										spellName = enemyDB[# edb.revivify, index];
										spellMin = 30;
										spellMax = 45;
										healRoll= irandom_range(spellMin, spellMax);
										damageCalculated = true;
										enemyDamage = 0;
										
									// If the heal will bring the monster to full health
									if (healRoll + encounterHP > enemyDB[# edb.hp, index]){
										encounterHP = enemyDB[# edb.hp, index];
										textbox.newText = "The "+enemyName+" uses "+spellName+" and heals itself up to full health.";
									}
									// Otherwise
									else{
										encounterHP += healRoll
										textbox.newText = "The "+enemyName+" uses "+spellName+" and heals itself for "+string(healRoll)+".";
									}
								}
								// Otherwise do a regular attack
								else{
									spellFailed = true;
								}
									#endregion
							
						}
						
						#endregion
					}
					// Cast a debuff instead of a regular attack
					else if (roll > 0.51 and roll <= 0.75){
						
						#region Try to cast a debuff instead of a regular attack
						
						var choice = choose(1, 2, 3);
						
						// Potentially try to cast all 3 spells if you don't have a particular one
						repeat(3){
							// Cast entrance if available
							if (choice == 1){
								if (enemyDB[# edb.entrance, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.entrance, index];
														
									// SLEEP CODE GOES HERE
									damageCalculated = true;
									enemyDamage = 0;
									playerSleep = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+", which puts you in a deep trance!";
									break;
								}
								// If entrance is not available
								else{
									spellFailed = true;
									choice = 2;
								}
							}
				
							// Cast silence if available 
							else if (choice == 2){
								if (enemyDB[# edb.silence, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.silence, index];
						
									// SILENCE CODE GOES HERE
									damageCalculated = true;
									enemyDamage = 0;
									playerSilenced = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+", which leaves you unable to speak incantations to cast your spells!.";
									break;
								}
								// If silence is not available
								else{
									spellFailed = true;
									choice = 3;
								}
							}
					
							// Cast weaken if available
							else if (choice == 3){
								if (enemyDB[# edb.weaken, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.weaken, index];
						
									// WEAKEN CODE GOES HERE
									damageCalculated = true;
									enemyDamage = 0;
									playerWeakened = true;
									textbox.newText = "The "+enemyName+" uses "+spellName+", which leaves you physically weakened.";
									break;
								}
								// If weaken is not available
								else{
									spellFailed = true;
									choice = 1;
								}
							}
						}
					
						#endregion
					}
				
					// Do a regular attack
					if (roll > 0.76 or spellFailed){
						
						#region Do a regular attack
							
							var enemyName, enemyStrength, playerDefence, minDamage, maxDamage;
							enemyName = enemyDB[# edb.name, index];
							enemyStrength = enemyDB[# edb.attackPower, index];
							playerDefence = player.stats[playerStat.defence];
						
							if (playerDefence >= enemyStrength){
								minDamage = 0;
								maxDamage = (enemyStrength + 4)  / 6;
							}
							else{
								minDamage = (enemyStrength - playerDefence / 2)  / 4;
								maxDamage = (enemyStrength - playerDefence / 2)  / 2;							
							}
						
							enemyDamage = irandom_range (minDamage, maxDamage);
							damageCalculated = true;
							if (enemyDamage > 0){
								textbox.newText = "The "+enemyName+" strikes and deals "+string(enemyDamage)+" damage!";
							}
							else{
								textbox.newText = "The "+enemyName+" strikes, but misses you!";
							}
						
						#endregion
					}
				}
				#endregion
			
				#region Take Damage from enemy
				else{
					
					// Confirm past previous damage message
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						if (textbox.textToDraw == textbox.currentText){
							
							// If the enemy damage is equal to or more than the player's health
							if (player.stats[playerStat.hpCurrent] <= enemyDamage){
								
								// Player death
								player.stats[playerStat.hpCurrent] = 0;
								textbox.newText = "The "+enemyDB[# edb.name, index]+" runs you down...\nYour deeds of valor will be remembered.";
								state = battleState.death;
							}
								
							// If enemy damage will not kill the player
							else{
								
								// If the enemy got a pre-emptive strike
								if (enemyPreEmptive){
									
									// Deal damage and return to the action menu
									enemyPreEmptive = false;
									if (enemyDamage != -1){
										player.stats[playerStat.hpCurrent] -= enemyDamage;
									}
									enemyDamage = -1;
									damageCalculated = undefined;
									state = battleState.selectAction;
								}
								
								// If the player didn't succeed at running
								else if (!is_undefined(fleeSuccessful) and fleeSuccessful == false){
									
									show_debug_message("TRIED TO FLEE, UNSUCCESSFUL, RUNNING THIS CODE NOW");
									// Deal damage and return to the action menu
									fleeSuccessful = undefined;
									if (enemyDamage != -1){
										player.stats[playerStat.hpCurrent] -= enemyDamage;
									}
									damageCalculated = undefined;
									state = battleState.selectAction;								
								}
								
								// Otherwise
								else{
									show_debug_message("Enemy didnt get pre-emptive, taking damage from enemy now")
									if (enemyDamage != -1){
										player.stats[playerStat.hpCurrent] -= enemyDamage;
									}
									damageCalculated = undefined;
									state = battleState.fight;
								}
							}
						}
					}
				}
				#endregion
				
				break;
			#endregion
			
			// battleState.death
			#region Enemy killed the player
			case battleState.death:
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
					if (textbox.textToDraw == textbox.currentText){
						game_restart();
					}
				}
				break;
			#endregion
			
			// battleState.victory
			#region Player killed the enemy
			case battleState.victory:
				
				if (!victoryConfirm1){
					// Confirm past the "You defeated the <monsterName>" message
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						// If the message has finished printing
						if (textbox.textToDraw == textbox.currentText){
							
							// Get variables for exp and gold gain
							var minGold, maxGold, goldGain, expGain;
							minGold = enemyDB[# edb.minGoldDrop, index];
							maxGold = enemyDB[# edb.maxGoldDrop, index];
							goldGain = irandom_range(minGold, maxGold);
							expGain = enemyDB[# edb.xpPerKill, index];
							
							victoryConfirm1 = true;
							textbox.newText = "You have gained "+string(expGain)+" experience points and "+string(goldGain)+" gold pieces.";
							
							player.stats[playerStat.xpCurrent] += expGain;
							player.stats[playerStat.goldCount] += goldGain;
							
							#region Level Up

							// If your xp meets or exceeds requirement for next level
							while (player.stats[playerStat.xpCurrent] >= player.stats[playerStat.xpMax]){
	
								// Increase Level
								player.stats[playerStat.level]++;
	
								// Update required experience and stats
								var levelDB = obj_LevelDatabase.levelDB;
								var index = ds_grid_value_y(levelDB, 0, 1, 0, ds_grid_height(levelDB)-1, player.stats[playerStat.level]);
	
								player.stats[playerStat.xpMax] += levelDB[# ldb.experience, index];
								player.stats[playerStat.hpMax] = levelDB[# ldb.hpMax, index];
								player.stats[playerStat.mpMax] = levelDB[# ldb.mpMax, index];
								player.stats[playerStat.strength] = levelDB[# ldb.strength, index];
								player.stats[playerStat.agility] = levelDB[# ldb.agility, index];
	
								// See if any new spells can be learned
								if (levelDB[# ldb.newSpell, index] != -1){
									player.spells[levelDB[# ldb.newSpell, index]] = 1;
								}
							}
							#endregion
						}					
					}
				}
				
				else if (!victoryConfirm2){
					
					// Confirm past the previous message (You have gained X experience points and y gold pieces)
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						
						
						// If the message has finished printing
						if (textbox.textToDraw == textbox.currentText){
							
							// Reset battle variables
							scr_battle_reset_variables();
						}
					}
				}
				
				else if (!victoryConfirm3){
					// Confirm past the previous message (you killed the <monsterName>)
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
						// If the message has finished printing
						if (textbox.textToDraw == textbox.currentText){
							
						}					
					}
				}
				
				else if (!victoryConfirm4){
					// Confirm past the previous message (you killed the <monsterName>)
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
						// If the message has finished printing
						if (textbox.textToDraw == textbox.currentText){
						
						}					
					}
				}
				break;
			#endregion
		}
	}
}