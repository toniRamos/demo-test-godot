shader_type canvas_item;

uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.0;
uniform vec4 explosion_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float edge_thickness : hint_range(0.0, 0.3) = 0.1;

// Función de ruido simple
float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Generar valor de ruido basado en la posición
    float noise = random(UV * 10.0);
    
    // Calcular el threshold para la disolución
    float dissolve_threshold = dissolve_amount;
    
    // Si el ruido es menor que el threshold, hacer transparente
    if (noise < dissolve_threshold) {
        COLOR.a = 0.0;
    } else {
        // Crear un borde brillante en el efecto de disolución
        float edge = smoothstep(dissolve_threshold, dissolve_threshold + edge_thickness, noise);
        
        // Mezclar color original con color de explosión en el borde
        vec3 final_color = mix(explosion_color.rgb, tex_color.rgb, edge);
        
        COLOR = vec4(final_color, tex_color.a);
    }
}
