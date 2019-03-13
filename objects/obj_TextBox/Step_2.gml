/// @description Skip scrolling through text

if (!global.paused){
	if (keyboard_check_pressed(input.confirm) or keyboard_check_pressed(input.confirm2)){
		textToDraw = currentText;
	}
}