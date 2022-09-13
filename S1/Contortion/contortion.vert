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

mat4 rotateX(float a) {
    return mat4 (   vec4(1, 0, 0, 0),
                    vec4(0.0, cos(a), sin(a), 0),
                    vec4(0.0, -sin(a), cos(a),0),
                    vec4(0, 0, 0, 1)
                );
}

mat4 translate(float tx, float ty, float tz) {
    return mat4(
        vec4(1, 0, 0, 0),
        vec4(0, 1, 0, 0),
        vec4(0, 0, 1, 0),
        vec4(tx, ty, tz, 1)
    );
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;

    float angle = (vertex.y-0.5)*sin(time);
    if (vertex.y < 0.5) angle = 0;

    vec4 vertexTransform = translate(0, 1, 0)*rotateX(angle)*translate(0, -1, 0)*vec4(vertex, 1.0);
    gl_Position = modelViewProjectionMatrix * vertexTransform;
}
