shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float transition : hint_range(0.0, 1.0); // 0 = no reveal, 1 = full reveal
uniform float line_width : hint_range(0.01, 0.1) = 0.002; // Adjust this for a thinner line

void fragment() {
    vec2 uv = SCREEN_UV;
    vec4 current_color = texture(screen_texture, uv);
    
    // Create a thin vertical line that moves from left to right
    float edge = transition; // The current position of the wipe
    float min_edge = edge - line_width; // Left side of the peeling effect
    float max_edge = edge + line_width; // Right side of the peeling effect

    if (uv.x < min_edge) {
        // Show the new reality (what's behind)
        COLOR = current_color;
    } else if (uv.x > max_edge) {
        // Keep the old reality
        COLOR = vec4(1.0, 1.0, 1.0, 1.0); // White or another placeholder color
    } else {
        // Create a gradient transition for a "peeling" effect
        float alpha = smoothstep(0.0, 1.0, (uv.x - min_edge) / (max_edge - min_edge));
        COLOR = mix(vec4(1.0, 1.0, 1.0, 1.0), current_color, alpha);
    }
}
