/// @description Draw the Text Box

draw_sprite(spr_TextBox, 0, textboxX, textboxY);

draw_set_color(c_white);
draw_set_font(Calibri_16);
draw_text_ext(textX, textY, text, textH, textW);