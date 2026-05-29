shader_type spatial;
render_mode unshaded, depth_draw_never, cull_front;

uniform vec4 line_color : source_color;
uniform float line_width;

uniform sampler2D depth_texture : hint_depth_texture;
uniform vec2 grid_size = vec2(10.0, 10.0);
uniform vec3 world_offset;

void fragment() {
	vec2 screen_uv = SCREEN_UV;
	float depth = texture(depth_texture, SCREEN_UV).r;

	vec4 clip_pos = vec4(SCREEN_UV * 2.0 - 1.0, depth, 1.0);
	vec4 view_pos = INV_PROJECTION_MATRIX * clip_pos;
	view_pos /= view_pos.w;

	vec3 world_position = (INV_VIEW_MATRIX * view_pos).xyz - world_offset;

	vec2 grid_uv = world_position.xz / grid_size;
	vec2 uv_deriv = fwidth(grid_uv);
	vec2 grid_dist = abs(fract(grid_uv + 0.5) - 0.5);

	vec2 line_aa = uv_deriv * 0.5;
	vec2 line_alphas = 1.0 - smoothstep(uv_deriv * line_width * 0.5 - line_aa, uv_deriv * line_width * 0.5 + line_aa, grid_dist);
	float on_line = max(line_alphas.x, line_alphas.y);

	ALBEDO = line_color.rgb;
	ALPHA = line_color.a * on_line;
}