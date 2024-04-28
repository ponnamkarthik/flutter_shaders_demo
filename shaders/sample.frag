#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 iResolution;

void main() {
    // Calculate a normalized value between 0.0 and 1.0 based on the pixel's x position
    vec2 uv = FlutterFragCoord().xy / iResolution.xy;

    // paint red color in all pixels
    fragColor = vec4(0.0, 0.58, 0.86, 1.0);
}