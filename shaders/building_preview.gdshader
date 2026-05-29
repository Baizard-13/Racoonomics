shader_type spatial;
render_mode unshaded, cull_disabled;

uniform bool is_valid;

uniform float wire_width = 5.0;
uniform float wire_smoothness : hint_range(0.0, 0.1) = 0.01;

uniform vec4 wire_color_valid : source_color;
uniform vec4 fill_color_valid : source_color;

uniform vec4 wire_color_invalid : source_color;
uniform vec4 fill_color_invalid : source_color;

// thanks https://godotshaders.com/shader/wireframe-shader-godot-4-0/
varying vec3 barys;

void vertex() {
	int index = VERTEX_ID % 3;
	switch (index) {
		case 0:
			barys = vec3(1.0, 0.0, 0.0);
			break;
		case 1:
			barys = vec3(0.0, 1.0, 0.0);
			break;
		case 2:
			barys = vec3(0.0, 0.0, 1.0);
			break;
	}

	VERTEX += NORMAL * (is_valid ? 0.0 : .02);
}

void fragment() {
	vec3 deltas = fwidth(barys);
	vec3 barys_s = smoothstep(deltas * wire_width - wire_smoothness, deltas * wire_width + wire_smoothness, barys);
	float wires = min(barys_s.x, min(barys_s.y, barys_s.z));

	vec4 wire_color = is_valid ? wire_color_valid : wire_color_invalid;
	vec4 fill_color = is_valid ? fill_color_valid : fill_color_invalid;

	float ff_mult = FRONT_FACING ? 1.0 : 0.3;

	ALBEDO = mix(wire_color, fill_color, wires).rgb * ff_mult;
	ALPHA = mix(wire_color, fill_color, wires).a * ff_mult;
}