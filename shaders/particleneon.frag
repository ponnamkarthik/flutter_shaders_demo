#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 iResolution;
uniform float iTime;

/*originals https://www.shadertoy.com/view/lf33RX*/
// https://www.shadertoy.com/view/4fd3Rf

vec3 mapValueToColor(float value) {
    // Generate color using cosine function
    vec3 col = 0.5 + 0.2 * cos((value + vec3(0, 2, 4)));
    return col;
}

// Return the maximum of each component of two vec3s
vec3 maxVec3(vec3 a, vec3 b) {
    return vec3(max(a.x, b.x), max(a.y, b.y), max(a.z, b.z));
}

// Calculate the position of the light point
vec2 calculateLightPoint(vec2 pos,vec2 size, float time, float x) {

    float pi = 3.1415926;
    float t = time * x;
    vec2 R = 5./iResolution.xy,
    d = smoothstep( -.75,.75, vec2(sin(t),cos(t))) - .5;
    vec2 circle = R * vec2( sin(t*pi*2.), cos(t*pi*1.5));
    return pos + d*size + R + circle;
}

// Flashing effect function
float flashing(float time) {
    return 0.6 + 0.2 * sin(2.0 * time) * sin(time);
}

// Lighting function
float lighting(vec2 fragCoord, vec2 position) {
    return 1.0 / sqrt(distance(fragCoord, position) * 2.0);
}

// Render light points at a specific time
vec3 renderPointsAtTime(vec2 fragCoord, float currentTime) {
    vec3 color = vec3(0, 0, 0);
    vec2 position = vec2(0.5, 0.5);
    float t = iTime * .1 + ((.25 + .05 * sin(iTime * .1))/(length(position.xy) + .07)) * 2.2;
    float si = sin(t);
    float co = cos(t);
    mat2 ma = mat2(co, si, -si, co);

    float width = 250.0*cos(iTime);
    float height = 250.0*sin(iTime);

    vec2 size = vec2(width/iResolution.x,height/iResolution.y);

    for (float i = 1.0; i < 32.0; i++) {
        float time = currentTime * (40.1 - i * 0.016);
        size*=ma;
        float lightingEffect = lighting(fragCoord, calculateLightPoint(position,size, time, i * 0.013)) * flashing(time);
        vec3 newColor = lightingEffect * mix(mapValueToColor(float(currentTime * (i + 10.0) / 2.0)), vec3(0.02, 0.01, 0.02), 0.5);
        color = maxVec3(color,newColor);
    }
    return color;
}

void main() {
    // Calculate a normalized value between 0.0 and 1.0 based on the pixel's x position
    vec2 uv = FlutterFragCoord().xy / iResolution.xy;
    vec2 uv2 = FlutterFragCoord().xy / iResolution.xy - 0.5;
    // Final color value
    vec3 color = vec3(0, 0, 0);


    // Loop through time axis for rendering
    for (float i = 0.0; i < 10.0; i++) {
        float currentTime = iTime - i * 0.02;
        vec3 newColor = renderPointsAtTime(uv, currentTime) * ((10.0 - i) / 10.0);
        color = maxVec3(color, newColor);
    }

    // Output to the screen
    fragColor = vec4(color, 1.0);
}