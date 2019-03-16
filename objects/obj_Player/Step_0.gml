// @description Handle Player Input

// If the game is not paused
if (!global.paused){
	
	// If the player isn't in battle
	if (!global.inBattle){
		// Only allow player to set movement destination if not already moving
		if (targetX == x and targetY == y){
			
			var encounterRate = 1/16;
			
			// Move up
			if (keyboard_check(input.up) or keyboard_check(input.up2)){
				sprite_index = spr_PlayerUp;
			
				// Don't move through walls
				if (!place_meeting(x, y-moveSpeed, obj_SolidParent)){
					targetY = y-moveSpeed;
				
					// Check for random encounter
					if (random(1) <= encounterRate){
						global.inBattle = true;
						scr_battle_get_encounter(enemyID.slime, 40/100, enemyID.redSlime, 40/100, enemyID.ghost, 20/100);
					}
				}
			}
		
			// Move Down
			else if (keyboard_check(input.down) or keyboard_check(input.down2)){
				sprite_index = spr_PlayerDown;
			
				// Don't move through walls
				if (!place_meeting(x, y+moveSpeed, obj_SolidParent)){
					targetY = y+moveSpeed;
				
					// Check for random encounter
					if (random(1) <= encounterRate){
						global.inBattle = true;
						scr_battle_get_encounter(enemyID.slime, 40/100, enemyID.redSlime, 40/100, enemyID.ghost, 20/100);
					}
				}
			}
		
			// Move Left
			else if (keyboard_check(input.left) or keyboard_check(input.left2)){
				sprite_index = spr_PlayerLeft;
			
				// Don't move through walls
				if (!place_meeting(x-moveSpeed, y, obj_SolidParent)){
					targetX = x-moveSpeed;
				
					// Check for random encounter
					if (random(1) <= encounterRate){
						global.inBattle = true;
						scr_battle_get_encounter(enemyID.slime, 40/100, enemyID.redSlime, 40/100, enemyID.ghost, 20/100);
					}
				}
			}
		
			// Move Right
			else if (keyboard_check(input.right) or keyboard_check(input.right2)){
				sprite_index = spr_PlayerRight;
			
				// Don't move through walls
				if (!place_meeting(x+moveSpeed, y, obj_SolidParent)){
					targetX = x+moveSpeed;
				
					// Check for random encounter
					if (random(1) <= encounterRate){
						global.inBattle = true;
						scr_battle_get_encounter(enemyID.slime, 40/100, enemyID.redSlime, 40/100, enemyID.ghost, 20/100);
					}
				}
			}
		}
	}
	
	// If the player isn't at their destination yet
	if (targetX != x or targetY != y){
		
		// Move towards the destination
		image_speed = 1.5;
		if (targetY < y)		{	y-=4;	}
		else if (targetY > y)	{	y+=4;	}
		else if (targetX < x)	{	x-=4;	}
		else if (targetX > x)	{	x+=4;	}
	}
	
	// Check for key release
	if (!keyboard_check(input.up or input.down or input.left or input.right)){
		if (targetX == x and targetY == y){
			image_speed = 0;
			image_index = 0;
		}
	}
}
else{
	image_speed = 0;
}