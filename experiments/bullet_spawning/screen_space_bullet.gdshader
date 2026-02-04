shader_type canvas_item;

uniform sampler2D screenspaced_texture;

uniform float radius = 10.0;

void fragment() {

    // Make it round
    float dist = distance(UV, vec2(0.5));
    if(dist > 0.50) { 
        discard; 
    } else if (dist > 0.475) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // Screenspace
   	    vec4 result = texture(screenspaced_texture, SCREEN_UV);
   	    COLOR = result.rgba;
    }
}

