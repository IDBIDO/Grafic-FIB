#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

const float PI = 3.141592;
uniform float amp = 0.5;
uniform float freq = 0.25;
uniform float time;

void main()
{
    float fase = vertex.y;
    float angulo = amp * (sin(2*PI*freq*time + fase));

    mat3 rotateX = mat3( vec3(1, 0, 0),
                        vec3(0, cos(angulo), sin(angulo)),
                        vec3(0, -sin(angulo), cos(angulo))
    );

    float vectorTranslacio = vec3(0, 1, 0);

    //A * sin(2π * f * t + Θ)
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0)* N.z;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vectorTranslacio*(vertex) + rotateX*vertex, 1.0 - (vectorTranslacio)*(vertex));
}
