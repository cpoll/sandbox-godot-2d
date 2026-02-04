shader_type canvas_item;

int radius = 10;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    //float relative_luminance = (0.2126*COLOR.r + 0.7152*COLOR.g + 0.0722*COLOR.b);
    //if (relative_luminance < 10.0) { discard; }
    
    if 
    
    vec4 left_wave =  vec4(0, 0.1 + 0.3 * ((UV.x - UV.y) / 2.0) * (sin(TIME/4.0) + 1.0), 0, 1.0);
    vec4 right_wave = vec4(0, 0, 0.3 + ((UV.x + UV.y) / 2.0) * (sin(TIME/4.0) + 1.0), 1.0);
    COLOR = left_wave + right_wave;
    
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
