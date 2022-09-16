#version 330 core

in vec4 frontColor;
in vec3 v_normal;

out vec4 fragColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 N = normalize(normalMatrix * v_normal);

    fragColor = frontColor*N.z;
}