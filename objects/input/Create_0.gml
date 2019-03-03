/// @description Set default key bindings

/*
This object keeps track of the game's key bindings.
Each "input" variable (up, down, etc.) is given a default binding ("vk_up", "ord("S")", etc.) in the create event.
These can be changed to custom user defined keys later on.
It makes for more efficient coding wherever user interaction is required.
	ex:	User presses "C" key to open character sheet.
		
		Instead of having a hardcoded line that checks for:
			if keyboard_check_pressed(ord("C"))
			
		it would instead look something like:
			if keyboard_check_pressed(input.OpenCharacterSheet)
		
		This way, if the user changes it from the "C" key to the "S" key, only the 
		input.OpenCharacterSheet variable needs to be changed and the rest is done
		automatically.
*/

// Player Movement
up = ord("W");
up2 = vk_up;

down = ord("S");
down2 = vk_down;

left = ord("A");
left2 = vk_left;

right = ord("D");
right2 = vk_right;

// Menus
start = ord("C");
start2 = vk_tab;
select = ord("Z");
select2 = vk_control;

// Other
confirm = ord("E");
confirm2 = vk_enter;

back = ord("Q");
back2 = vk_escape;