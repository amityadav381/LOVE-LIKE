shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float color = (texture(TEXTURE, UV).r + texture(TEXTURE, UV).g + texture(TEXTURE, UV).b)/3.0;
	COLOR = vec4(color, color, color, texture(TEXTURE, UV).a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
