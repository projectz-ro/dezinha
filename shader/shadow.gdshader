shader_type canvas_item;

uniform sampler2D viewport_texture : hint_screen_texture;

void fragment() {
    // Get the main texture color from our object
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Get the screen color at this position
    vec4 screen_color = texture(viewport_texture, UV);
    
    // Apply black multiply only where we have content on layer 9
    vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
    COLOR = screen_color * black;
}