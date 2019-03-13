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
optionSelected = optionsList.status;	// What sub menu option is selected (an enum choice in optionsList.xxx)
itemList[0] = 0;						// Stores each item id the player has in the item or equip screen
itemSelected = 0;						// What item is selected (in the item sub menu)
spellSelected = 0;						// What spell is selected (in the spells sub menu)
equipSelected = 0;						// What equip slot is selected (in equip sub menu)