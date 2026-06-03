shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D color_palette_gradient : repeat_disable;

uniform float transition_threshold : hint_range(0.0, 1.0);

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec3 screen_color = texture(screen_texture, SCREEN_UV).rgb;

	float luminance = dot(screen_color, vec3(0.2126, 0.7152, 0.0722));
	if (luminance < transition_threshold) {
		luminance = .2;
		ALPHA *= abs(luminance - transition_threshold);
	}

	ALBEDO = texture(color_palette_gradient, vec2(luminance, 0.0)).rgb;
}