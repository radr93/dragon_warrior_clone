/// @description Check for a battle

// If player is in a battle
if (global.inBattle){
	
	// Find out what was encountered
	if (encounter = -1){
		
		var hh, rangeChecking, roll;
		hh = array_height_2d(encounterList);
		show_debug_message("The height of the encounter list is "+string(hh));
		rangeChecking = 0;		// Increments each time you don't roll a monster
		roll = random(1);		// Percentage rolled
		show_debug_message("Roll was: "+string(roll));
		
		// Loop through encounter list
		for (var e = 0; e < hh; e++){
	
			rangeChecking += encounterList[e, encounterParam.weight];
			show_debug_message("Range Checking: from "+string(rangeChecking-encounterList[e, encounterParam.weight])+" to "+string(rangeChecking));
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
	}
	
	
}
else{
	encounter = -1;
}