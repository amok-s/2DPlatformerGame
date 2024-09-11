shader_type canvas_item;
uniform float x_axis_modifier = 1;
uniform float y_axis_modifier = 1;


void vertex() {
	UV.x += TIME * x_axis_modifier;
	UV.y += TIME * y_axis_modifier;
	}