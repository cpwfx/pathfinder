// pathfinder/shaders/gles2/common.inc.glsl
//
// Copyright (c) 2017 Mozilla Foundation

#version 100

#define MAX_PATHS   65536

precision highp float;

// https://stackoverflow.com/a/36078859
int imod(int ia, int ib) {
    float a = float(ia), b = float(ib);
    float m = a - floor((a + 0.5) / b) * b;
    return int(floor(m + 0.5));
}

vec2 transformVertexPosition(vec2 position, mat4 transform) {
    return (transform * vec4(position, 0.0, 1.0)).xy;
}

vec2 convertScreenToClipSpace(vec2 position, ivec2 framebufferSize) {
    return position / vec2(framebufferSize) * 2.0 - 1.0;
}

float convertPathIndexToDepthValue(int pathIndex) {
    return float(pathIndex + 1) / float(MAX_PATHS);
}

vec4 fetchFloat4Data(sampler2D dataTexture, int index, ivec2 dimensions) {
    ivec2 pixelCoord = ivec2(imod(index, dimensions.x), index / dimensions.x);
    return texture2D(dataTexture, (vec2(pixelCoord) + 0.5) / vec2(dimensions));
}

vec4 fetchFloat4NormIndexedData(sampler2D dataTexture, float normIndex, ivec2 dimensions) {
    return fetchFloat4Data(dataTexture, int(normIndex * float(dimensions.x)), dimensions);
}
