/// @description Check for new text

// Update current working text to newest text sent
if (currentText != newText){
	textToDraw = "";		// Reset text to draw
	currentText = newText;	// Update current text
}

// Draw text slowly
if (textToDraw != currentText){
	if (alarm[0] == -1){
		alarm[0] = 1;
	}
}