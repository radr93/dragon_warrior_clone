/// @description Skip text or close textbox

if (!global.paused){
	if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
		if (textToDraw != currentText){
			textToDraw = currentText;
		}
	}
}