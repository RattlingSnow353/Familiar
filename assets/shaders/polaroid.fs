// @gips_version=1
// @coord=none
// @filter=linear

uniform float effectType;  
uniform vec3 colorTint;  

vec3 applyGrayscale(vec3 color) {
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    return vec3(gray);
}

vec3 applySepia(vec3 color) {
    return vec3(
        dot(color, vec3(0.393, 0.769, 0.189)),
        dot(color, vec3(0.349, 0.686, 0.168)),
        dot(color, vec3(0.272, 0.534, 0.131))
    );
}

vec3 applyInvert(vec3 color) {
    return vec3(1.0) - color;
}

vec3 applyColorTint(vec3 color, vec3 tint) {
    return mix(color, tint, 0.5);
}

vec4 run(vec2 texCoords) {
    vec4 texColor = pixel(texCoords);

    if (effectType < 0.5) {
        texColor.rgb = applyGrayscale(texColor.rgb);
    } else if (effectType < 1.5) {
        texColor.rgb = applySepia(texColor.rgb);
    } else if (effectType < 2.5) {
        texColor.rgb = applyInvert(texColor.rgb);
    } else {
        texColor.rgb = applyColorTint(texColor.rgb, colorTint);
    }

    return texColor;
}
