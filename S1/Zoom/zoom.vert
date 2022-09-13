#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

mat4 scale(float sx, float sy, float sz) {
    return mat4(
        vec4(sx, 0, 0, 0),
        vec4(0, sy, 0, 0),
        vec4(0, 0, sz, 0),
        vec4(0, 0, 0, 1)
    );
}


void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;
    vtexCoord = texCoord;

    float factorEscalat = 0.5 + abs(sin(time));

    vec4 clipSpace = modelViewProjectionMatrix * vec4(vertex, 1.0);
    vec3 ndcSpace = clipSpace.xyz/clipSpace.w;
    
    vec4 ndcSpaceTransform = scale(factorEscalat, factorEscalat, 1.0)* vec4(ndcSpace, 1.0);
    gl_Position = ndcSpaceTransform;
}
