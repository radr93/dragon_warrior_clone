/// @description Change position in options list

#region Down Key Pressed
if (keyboard_check_pressed(input.down) or keyboard_check_pressed(input.down2)){
	
	// If you're not in a sub-menu
	if (!inSubMenu){
		
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
}
#endregion

#region Up Key Pressed
if (keyboard_check_pressed(input.up) or keyboard_check_pressed(input.up2)){
	
	// If you're not in a sub-menu
	if (!inSubMenu){
		
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
}
#endregion

#region Right Key Pressed
if (keyboard_check_pressed(input.right) or keyboard_check_pressed(input.right2)){
	
	// If you're not in a sub-menu
	if (!inSubMenu){
		
		// You're now in a sub menu
		inSubMenu = true;
	}
}
#endregion

#region Left Key Pressed
if (keyboard_check_pressed(input.left) or keyboard_check_pressed(input.left2)){
	
	// If you're not in a sub-menu
	if (inSubMenu){
		
		// You're now in a sub menu
		inSubMenu = false;
	}
}
#endregion

#region Confirm Key Pressed
if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
	
	// If you're not in a sub-menu
	if (!inSubMenu){
		
		// Cycle through sub menus
		switch (optionSelected){
			
			case optionsList.status:
			case optionsList.items:
			case optionsList.spells:
			case optionsList.equip:
				inSubMenu = true;
				break;
			case optionsList.close:
				instance_destroy();
				break;
		}
	}
	
	// If you're in a sub menu
	else{
		
		// Cycle through sub menus
		switch (optionSelected){
			
			case optionsList.status:
				
				break;
			case optionsList.items:
				
				break;
			case optionsList.spells:
				
				break;
			case optionsList.equip:
				
				break;
			case optionsList.close:
				instance_destroy();
				break;
		}
	}
}
#endregion

#region Back Key Pressed
if (keyboard_check_pressed(input.back) or keyboard_check_pressed(input.back2)){
	
	// If you're not in a sub menu
	if (!inSubMenu){
		// Close the pause menu
		instance_destroy();
	}
	
	// If you were in a sub menu
	else{
		// No longer in sub menu
		inSubMenu = false;
	}
}
#endregion

#region Start Key Pressed
if (keyboard_check_pressed(input.start) or keyboard_check_pressed(input.start2)){
	
	// If you're not in a sub menu
	if (!inSubMenu){
		// Close the pause menu
		instance_destroy();
	}
}
#endregion