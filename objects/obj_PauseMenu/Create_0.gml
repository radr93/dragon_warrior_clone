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
itemSelected = 0;						// What item is selected (in item sub menu)
itemList[0] = 0;						// Stores each item id in the inventory
spellSelected = 0;						// What spell is selected (in spells sub menu)
equipSelected = 0;						// What equip slot is selected (in equip sub menu)