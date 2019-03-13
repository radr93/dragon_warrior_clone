/// @description Initialize Variables

// Position
textboxX = 32;	// Left side of the textbox
textboxY = 384; // Top of the textbox
textboxW = 960; // Width of the textbox
textboxH = 160; // Height of the textbox

textX = 64;		// Left side of the text start position
textY = 400;	// Top of the text start position
textW = sprite_get_width(spr_TextBox)-64;	// Max width of the text
textH = 32;		// Height between each line of text


// Text
textSpeed = 4;
newText = "";		// New text provided from an object to draw
currentText = "";	// The current text being parsed to draw
textToDraw = "";	// This gets text added to it 1 character at a time in alarm[0] to draw text on screen slowly