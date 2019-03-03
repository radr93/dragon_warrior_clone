/*

Syntax:
ds_grid_number_strings_to_real(ds_grid);

ds_grid		The ID of the ds grid to change number strings to real numbers for

This script parses the provided ds grid for numbers that are strings, then
converts them from strings to real numbers. Only converts strings that do not
contain any other letters or characters.

Returns the grid with all numbers converted.

*/

// Initialize Variables
var grid, gridWidth, gridHeight, cellContents;
grid = argument0;										// Get the ds grid
gridWidth = ds_grid_width(grid);						// Width of the Grid
gridHeight = ds_grid_height(grid);						// Height of the Grid

for (var c = 0; c < gridWidth; c++){					// Loop through each grid column
	for (var r = 0; r < gridHeight; r++){				// Loop through each grid row
		var cellContents = ds_grid_get(grid, c, r);		// Gather the contents of the current cell
		
		// See if the cell's string only contains digits
		if (string_length(string_digits(cellContents)) == string_length(cellContents)){
			// Convert it to a real number
			ds_grid_set(grid, c, r, real(string_digits(cellContents)));
		}
		
		// See if the cell contains a "-1" string
		if (cellContents == "-1"){
			// Convert it to a -1 real number
			ds_grid_set(grid, c, r, -1);	
		}
	}
}
return(grid);