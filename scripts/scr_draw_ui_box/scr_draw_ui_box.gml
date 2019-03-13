/*

scr_draw_ui_box(x1, y1, x2, y2);

x1		Left side of the box
y1		Top of the box
x2		Right side of the box
y2		Bottom of the box
color1	The background color of the box
color2	The outline of the box
alpha	The alpha to draw the box at

Draws a colored box with an outline on the GUI at the supplied coordinates and alpha.

*/

// Initialize Variables
var x1, y1, x2, y2, color1, color2, alpha;
x1 = argument0;
y1 = argument1;
x2 = argument2;
y2 = argument3;
color1 = argument4;
color2 = argument5;
alpha = argument6;

// Set alpha
draw_set_alpha(alpha);

// Draw the backdrop of the box
draw_set_color(color1);
draw_rectangle(x1, y1, x2, y2, false);

// Draw the outline of the box
draw_set_color(color2);
draw_rectangle(x1, y1, x2, y2, true);

// Reset alpha
draw_set_alpha(1);