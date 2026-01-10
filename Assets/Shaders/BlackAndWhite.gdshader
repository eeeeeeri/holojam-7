shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float grayscale = (color.r + color.g + color.b) / 3.0;
	
	COLOR.rgb = vec3(grayscale, grayscale, grayscale);
}