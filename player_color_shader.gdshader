shader_type spatial;

uniform vec3 playerColor;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(ALBEDO.rgb == vec3(1.0, 1.0, 1.0)){
		ALBEDO.rgb = playerColor;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
