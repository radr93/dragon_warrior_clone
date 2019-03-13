/// @description Draw the Text Box

// Draw the text box backdrop
draw_set_alpha(0.7);
scr_draw_ui_box(textboxX, textboxY, textboxX+textboxW, textboxY+textboxH, c_black, c_white, 0.7);
draw_set_alpha(1);

draw_set_color(c_white);
draw_set_font(Calibri_16);
draw_text_ext(textX, textY, textToDraw, textH, textW);