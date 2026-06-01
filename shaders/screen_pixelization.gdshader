shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;
uniform float pixel_size : hint_range(1.0, 32.0) = 4.0;
uniform float color_levels : hint_range(2.0, 32.0) = 8.0;

void fragment() {
	vec2 screen_size = vec2(textureSize(SCREEN_TEXTURE, 0));

	// personally i don't think either of these effects really fits this game and its art style and vfx as they are, but idk man maybe i'm just old and grumpy  - B.
	//vec2 grid = screen_size / pixel_size; 
	//vec2 pixelated_uv = floor(SCREEN_UV * grid) / grid;
	vec3 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	color = floor(color * color_levels) / (color_levels - 1.0);

	COLOR.rgb = color;
}
