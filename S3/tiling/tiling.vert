#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform int tiles=1;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;
uniform float freq = 10;
uniform float PI = 3.145;
uniform float amplitude = 8;
    //float dt = amplitude*(sin(2*PI*freq*time));

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(normalize(normalMatrix * normal).z);
    float intTime = trunc(time);
    int times = int(amplitude *sin(2*PI*freq*intTime));

    vtexCoord = times*texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
