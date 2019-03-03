/// @description Check for input

#region Toggle Paused

// If not in Main Menu
if (room != __init__){
	
	// If player presses the start button
	if (keyboard_check_pressed(input.start) or keyboard_check_pressed(input.start2)){
		
		// If the game wasn't already paused
		if (!instance_exists(obj_PauseMenu)){
			
			// Pause the game
			global.paused = true;
			instance_create_layer(0, 0, "Menus", obj_PauseMenu);
		}
	}
}

#endregion