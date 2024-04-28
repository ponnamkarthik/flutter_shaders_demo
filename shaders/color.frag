#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 resolution;
out vec4 fragColor;
uniform float iTime;

void main() {
  vec2 uv = FlutterFragCoord().xy / resolution.xy;

  vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0,2,4));

  fragColor = vec4(col,1.0);
}