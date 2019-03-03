/// @description Initialize Variables

#region Enumerate Options list
enum optionsList{
	status,
	items,
	spells,
	equip,
	close,
	
	MAX
}
#endregion

// Initialize Variables
inSubMenu = false;						// Is a sub menu open?
optionSelected = optionsList.status;	// What sub menu option is selected (an enum of optionsList.xxx)
itemSelected = 0;
