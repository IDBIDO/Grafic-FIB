#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;    //a fragment
out vec3 vvertex;
out vec3 vnormal;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelMatrix;

uniform bool world = false;

void main()
{
    if (world) {    //world space
        vvertex = (modelMatrix * vec4(vertex, 1.0)).xyz;
        vnormal = normalMatrix * normal;
    }
    else {      //eye space
        vvertex = (modelViewMatrix * vec4(vertex, 1.0)).xyz;
        vnormal = normalMatrix * normal;
    }
    
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
