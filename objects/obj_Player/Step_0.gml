/// @description Handle Player Input

// If the game is not paused
if (!global.paused){
	
	// Only allow updating target if not already set
	if (targetX == x and targetY == y){
		// Set the player's destination
		if (keyboard_check(input.up)){		//  Move up
			sprite_index = spr_PlayerUp;
			if (!place_meeting(x, y-moveSpeed, obj_SolidParent)){
				targetY = y-moveSpeed;
			}
		}
		else if (keyboard_check(input.down)){	// Move down
			sprite_index = spr_PlayerDown;
			if (!place_meeting(x, y+moveSpeed, obj_SolidParent)){
				targetY = y+moveSpeed;
			}
		}
		else if (keyboard_check(input.left)){	// Move left
			sprite_index = spr_PlayerLeft;
			if (!place_meeting(x-moveSpeed, y, obj_SolidParent)){
				targetX = x-moveSpeed;
			}
		}
		else if (keyboard_check(input.right)){	// Move right
			sprite_index = spr_PlayerRight;
			if (!place_meeting(x+moveSpeed, y, obj_SolidParent)){
				targetX = x+moveSpeed;
			}
		}
	}
	else{
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