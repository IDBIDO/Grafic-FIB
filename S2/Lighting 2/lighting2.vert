#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;    //a fragment
out vec3 normal;    //a fragment
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;


uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position
// (sempre estarà en eye space)

uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess


vec3 phone(vec3 N, vec3 R, vec3 L) {
    //ambient 
    vec3 componentAmbient = matAmbient*lightAmbient;

    //difus
    vec3 componentDifus = matDiffuse*lightDiffuse*(dot(N, L));

    vec3 componentEspecular = matSpecular*lightSpecular*(dot(R, V))^matShininess;

    return componentAmbient + componentDifus + componentEspecular;
}


void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vec4 vertxEye = modelViewProjectionMatrix * vec4(vertex, 1.0);
    vec3 L = normalize(vertex - lightPosition.xyz);
    vec3 R = normalize(2(dot(N, L)*N-L));
    frontColor = phone(N, R, L);
    //vec4(color,1.0)* N.z;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
