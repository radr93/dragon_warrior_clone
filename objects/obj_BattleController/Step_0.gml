/// @description Check for a battle

// If the player is in a battle (first triggered when player takes a step)
if (global.inBattle){
	
	// If encounter has not been set yet
	if (encounter == -1){
		
		#region Get and set encounter
		
		// Set state to begin encounter
		state = battleState.beginEncounter;
		
		#region Find out what was encountered (get variable "encounter" as enemyID enum randomly from encounter List)
		
		// Initialize Variables
		var hh, rangeChecking, roll;
		hh = array_height_2d(encounterList);
		rangeChecking = 0;		// Increments each iteration until you get a monster
		roll = random(1);		// Percentage rolled
		
		show_debug_message("The height of the encounter list is "+string(hh));
		show_debug_message("Roll was: "+string(roll));
		
		// Loop through encounter list
		for (var e = 0; e < hh; e++){
	
			rangeChecking += encounterList[e, encounterParam.chance];
			show_debug_message("Range Checking: from "+string(rangeChecking-encounterList[e, encounterParam.chance])+" to "+string(rangeChecking));
			
			// If you found an encounter
			if (roll <= rangeChecking){
				encounter = encounterList[e, encounterParam.id];
				show_debug_message("Roll "+string(roll)+": Encountered a "+string(encounter));
				break;
			}
			else{
				show_debug_message("Roll "+string(roll)+": Did not encounter a "+string(encounterList[e, encounterParam.id]));
			}
		}
		#endregion
		
		#region Look up enemy ID's row index in enemy DB
		
		// Look up enemy ID's row index in enemy DB
		var enemyDB, index;
		enemyDB = obj_EnemyDatabase.enemyDB;
		index = ds_grid_value_y(enemyDB, 0, 1, 0, ds_grid_height(enemyDB)-1, encounter);
		
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
		textbox.text = a_an_the + name + " appeared!";
		
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
					
					// Possible pre-emptive strike by the enemy
					if (random(1) < 0.08){
						state = battleState.enemyPreEmptive;
					}					
					// Otherwise change state to prompt player for an action
					else{
						state = battleState.selectAction;
					}
				}
				break;
			#endregion
			
			// battleState.enemyPreEmptive
			#region If the enemy gets a pre-emptive strike
			case battleState.enemyPreEmptive:
				textbox.text = "The "+enemyDB[# edb.name, index]+" attacked before you were ready!"
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					state = battleState.takeDamage;
				}
				break;
			#endregion
			
			// battleState.selectAction
			#region Select an action
			case battleState.selectAction:
				 
				
				// Draw the appropriate text for the action selected
				switch(actionSelected){
					case action.fight:	textbox.text = "Attack the "+enemyDB[# edb.name, index]+".";	break;
					case action.spell:	textbox.text = "Cast a spell.";	break;
					case action.item:	textbox.text = "Use an item.";	break;
					case action.flee:	textbox.text = "Attempt to flee.";	break;
				}
				
				// Move up and down the action list
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
				
				// Confirm an action
				#region Confirm Key Pressed
				if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm)){
					
					// Find out which action you selected
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
				#endregion
				
				break;
			#endregion
				
			// battleState.fight
			#region Damage the enemy with melee
			case battleState.fight:
				
				var playerAgility, enemyAgility;
				playerAgility = player.stats[playerStat.agility];
				enemyAgility = enemyDB[# edb.agility, index]
				
				if (is_undefined(initiative)){
					// Enemy attacks player first
					if (playerAgility*irandom(255) < enemyAgility * irandom(255) * 0.25){
						initiative = "enemy";
					}
					// Player attacks enemy first
					else{
						initiative = "player";
						textbox.text = "You attempt to strike the " + enemyName+"...";
					}
				}
				else{
					var enemyName = enemyDB[# edb.name, index];
					
					if (initiative == "player"){
								
						if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
							
							if (is_undefined(damageCalculated)){
								// Miss the attack
								if (enemyDB[# edb.dodge, index] <= irandom_range(1, 64)){
									textbox.text = "... but you miss!"
								}
								// Attack the enemy
								else{
									var playerAttack, enemyDefence, minDamage, maxDamage;
									playerAttack = player.stats[playerStat.attackPower];
									enemyDefence = enemyDB[edb.defence, index];
									minDamage = (playerAttack - enemyDefence / 2) / 4;
									maxDamage = (playerAttack - enemyDefence / 2) / 2;
									playerDamage = irandom_range(minDamage, maxDamage);
									damageCalculated = true;
									textbox.text = "... and deliver a blow for "+string(playerDamage)+" damage points."
								}
							}
							else{
								
								
							}
						}
					}
					else{
						
						#region Calculate Damage from enemy
						if (is_undefined(damageCalculated)){
				
							var roll = random(1);		// Roll for an enemy spell or regular attack
							var spellFailed = false;	// If the enemy doesnt possess a usable spell
				
							// Cast a damaging spell instead of a regular attack
							if (roll <= 0.33){
								#region Try to cast a damaging spell instead of a regular attack
						
								#region Cast Super Breath if available
								if (enemyDB[# edb.superBreath, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.superBreath, index];
						
									var spellMin, spellMax;
									spellMin = 65;
									spellMax = 72;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
								}
								#endregion
								#region Cast Flame Breath if available
								else if (enemyDB[# edb.flameBreath, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.flameBreath, index];
						
									var spellMin, spellMax;
									spellMin = 16;
									spellMax = 23;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
								}
								#endregion
								#region Cast Destroy if available
								else if (enemyDB[# edb.destroy, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.destroy, index];
						
									var spellMin, spellMax;
									spellMin = 30;
									spellMax = 45;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
								}
								#endregion
								#region Cast Afflict if available
								else if (enemyDB[# edb.afflict, index] != -1){
									var enemyName, spellName;
									enemyName = enemyDB[# edb.name, index];
									spellName = enemyDB[# edb.afflict, index];
						
									var spellMin, spellMax;
									spellMin = 3;
									spellMax = 10;
									enemyDamage = irandom_range(spellMin, spellMax);
									damageCalculated = true;
									// Draw the damaging spell's text
									textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
								}
								#endregion
								// Otherwise do a regular attack
								else{
									spellFailed = true;
								}	
					
				
								#endregion
							}
				
							// Cast a debuff instead of a regular attack
							else if (roll > 0.33 and roll <= 0.66){
								#region Try to cast a debuff instead of a regular attack
					
								var choice = choose(1, 2, 3);
					
								// Cast entrance if available
								if (choice == 1){
									if (enemyDB[# edb.entrance, index] != -1){
										var enemyName, spellName;
										enemyName = enemyDB[# edb.name, index];
										spellName = enemyDB[# edb.entrance, index];
														
										// SLEEP CODE GOES HERE
										damageCalculated = true;
										textbox.text = "The "+enemyName+" uses "+spellName+", leaving you incapacitated!";
									}
									// If entrance is not available
									else{
										spellFailed = true;
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
										textbox.text = "The "+enemyName+" uses "+spellName+", leaving you unable to speak incantations to cast your spells!.";
									}
									// If silence is not available
									else{
										spellFailed = true;
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
										// Draw the damaging spell's text
										textbox.text = "The "+enemyName+" uses "+spellName+", leaving you physically weak and more vulnerable to attacks!";
									}
									// If weaken is not available
									else{
										spellFailed = true;
									}
								}	
					
								#endregion
							}
				
							// Do a regular attack
							if (roll > 0.66 or spellFailed){
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
									textbox.text = "The "+enemyName+" strikes, dealing "+string(enemyDamage)+" points of damage!";
						
								#endregion
							}
						}
						#endregion
			
						#region Take Damage from enemy
						else{
					
							// Confirm past previous damage message
							if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						
								if (player.stats[playerStat.hpCurrent] > enemyDamage){
									player.stats[playerStat.hpCurrent] -= enemyDamage;
									enemyDamage = 0;
									damageCalculated = undefined;
									state = battleState.selectAction;
								}
						
								else{
									player.stats[playerStat.hpCurrent] = 0;
									textbox.text = "You fought valiantly, but ultimately perished at the hands of the "+enemyDB[# edb.name, index];
									state = battleState.death
								}
							}
						}
						#endregion
				
						
					}
				}
				
				break;
			#endregion
			
			// battleState.spell
			#region Select and cast spell, enemy attack turn
			case battleState.spell:
				textbox.text = "Select a spell..."
				
				
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
				var spellCount, spellList;
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
	
				break;
			#endregion
			
			// battleState.item
			#region Select and use an item, enemy attack turn
			case battleState.item:
				textbox.text = "Select an item..."
				break;
			#endregion
			
			// battleState.flee
			#region Attempt to flee the battle
			case battleState.flee:
							
				#region Roll for chance to flee
				if (is_undefined(fleeSuccessful)){
					
					textbox.text = "You attempt to flee..."		
					
					// Confirm past the message and roll for chance to flee
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
					
						var fleeChance, fleeRange;
						fleeChance = random(1);
						
						// If the monster is double or more the player's level
						if (enemyDB[# edb.level, index] >= player.stats[playerStat.level]*2){
							fleeRange = 0.25; // 25% chance to escape
						}
						// If the mosnter is half or less the player's level
						else if (enemyDB[# edb.level, index] <= player.stats[playerStat.level]/2){
							fleeRange = 0.75; // 75% chance to escape
						}
						// If the monster is somewhere around the player's level
						else{
							fleeRange = 0.5 // 50% chance to escape
						}
						
						if (fleeChance <= fleeRange){
							textbox.text += "\n...and succeed! Got away safely.";
							fleeSuccessful = true;
						}
						else{
							textbox.text += "\n...but are blocked by the "+enemyDB[# edb.name, index];
							fleeSuccessful = false;
						}
					}
				}
				#endregion
				
				#region Provide outcome for success or failure
				else{
					
					// If the attempt was successful
					if (fleeSuccessful){
						
						if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
							
							// Reset all default parameters
							global.inBattle = false;
							state = battleState.beginEncounter;		// Initializes encounter
							encounter = -1;							// Encounter's enemyID
							actionSelected = 0;						// Battle Action selected (fight, spell, item, run)
							fleeSuccessful = undefined;				// Was the character's flee successful? (see battleState.flee in Step)
							instance_destroy(obj_TextBox);			// Destroy 
						}
					}
					// If the attempt was not successful
					else{
						if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
							
							// Take damage from the enemy
							state = battleState.takeDamage;
							fleeSuccessful = undefined;
						}
					}
					
				}
				#endregion

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
					if (roll <= 0.33){
						#region Try to cast a damaging spell instead of a regular attack
						
						#region Cast Super Breath if available
						if (enemyDB[# edb.superBreath, index] != -1){
							var enemyName, spellName;
							enemyName = enemyDB[# edb.name, index];
							spellName = enemyDB[# edb.superBreath, index];
						
							var spellMin, spellMax;
							spellMin = 65;
							spellMax = 72;
							enemyDamage = irandom_range(spellMin, spellMax);
							damageCalculated = true;
							textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
						}
						#endregion
						#region Cast Flame Breath if available
						else if (enemyDB[# edb.flameBreath, index] != -1){
							var enemyName, spellName;
							enemyName = enemyDB[# edb.name, index];
							spellName = enemyDB[# edb.flameBreath, index];
						
							var spellMin, spellMax;
							spellMin = 16;
							spellMax = 23;
							enemyDamage = irandom_range(spellMin, spellMax);
							damageCalculated = true;
							textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
						}
						#endregion
						#region Cast Destroy if available
						else if (enemyDB[# edb.destroy, index] != -1){
							var enemyName, spellName;
							enemyName = enemyDB[# edb.name, index];
							spellName = enemyDB[# edb.destroy, index];
						
							var spellMin, spellMax;
							spellMin = 30;
							spellMax = 45;
							enemyDamage = irandom_range(spellMin, spellMax);
							damageCalculated = true;
							textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
						}
						#endregion
						#region Cast Afflict if available
						else if (enemyDB[# edb.afflict, index] != -1){
							var enemyName, spellName;
							enemyName = enemyDB[# edb.name, index];
							spellName = enemyDB[# edb.afflict, index];
						
							var spellMin, spellMax;
							spellMin = 3;
							spellMax = 10;
							enemyDamage = irandom_range(spellMin, spellMax);
							damageCalculated = true;
							// Draw the damaging spell's text
							textbox.text = "The "+enemyName+" uses "+spellName+", dealing "+string(enemyDamage)+" points of damage.";
						}
						#endregion
						// Otherwise do a regular attack
						else{
							spellFailed = true;
						}	
					
				
						#endregion
					}
				
					// Cast a debuff instead of a regular attack
					else if (roll > 0.33 and roll <= 0.66){
						#region Try to cast a debuff instead of a regular attack
					
						var choice = choose(1, 2, 3);
					
						// Cast entrance if available
						if (choice == 1){
							if (enemyDB[# edb.entrance, index] != -1){
								var enemyName, spellName;
								enemyName = enemyDB[# edb.name, index];
								spellName = enemyDB[# edb.entrance, index];
														
								// SLEEP CODE GOES HERE
								damageCalculated = true;
								textbox.text = "The "+enemyName+" uses "+spellName+", leaving you incapacitated!";
							}
							// If entrance is not available
							else{
								spellFailed = true;
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
								textbox.text = "The "+enemyName+" uses "+spellName+", leaving you unable to speak incantations to cast your spells!.";
							}
							// If silence is not available
							else{
								spellFailed = true;
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
								// Draw the damaging spell's text
								textbox.text = "The "+enemyName+" uses "+spellName+", leaving you physically weak and more vulnerable to attacks!";
							}
							// If weaken is not available
							else{
								spellFailed = true;
							}
						}	
					
						#endregion
					}
				
					// Do a regular attack
					if (roll > 0.66 or spellFailed){
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
							textbox.text = "The "+enemyName+" strikes, dealing "+string(enemyDamage)+" points of damage!";
						
						#endregion
					}
				}
				#endregion
			
				#region Take Damage from enemy
				else{
					
					// Confirm past previous damage message
					if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
						
						if (player.stats[playerStat.hpCurrent] > enemyDamage){
							player.stats[playerStat.hpCurrent] -= enemyDamage;
							enemyDamage = 0;
							damageCalculated = undefined;
							state = battleState.selectAction;
						}
						
						else{
							player.stats[playerStat.hpCurrent] = 0;
							textbox.text = "You fought valiantly, but ultimately perished at the hands of the "+enemyDB[# edb.name, index];
							state = battleState.death
						}
					}
				}
				#endregion
				
				break;
			#endregion
			
			// battleState.death
			#region Enemy killed the player
			case battleState.death:
				
				break;
			#endregion
			
			// battleState.victory
			#region Player killed the enemy
			case battleState.victory:
				
				break;
			#endregion
		}
			
	}
}