#version 330 core

//in vec4 frontColor;
in vec3 vvertex;
in vec3 vnormal;

out vec4 fragColor;


uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position
// (sempre estarà en eye space)

uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

void main()
{
    vec3 N = normalize(vnormal);
    //get vertex in eye space:
    vec3 vertex_eye = normalize(vvertex);

    //ambient
    vec4 ambient = matAmbient * lightAmbient;

    //diffuse
    vec3 L = normalize(lightPosition.xyz - vertex_eye);
    float NL = max(0.0, dot(N, L));
    vec4 diffuse = matDiffuse * lightDiffuse * NL;

    //specular
    //la llum arriba, calculem la component especular
    vec3 V =  - vertex_eye;
    vec3 R = normalize(2.0*(NL)*N-L);
    float RdotV = max(0.0, dot(R, V));
    float RV = 0;
    if (NL > 0) RV = pow(RdotV,matShininess); //max(0,dot(R, V));
    vec4 specular = matSpecular * lightSpecular * RV;

    fragColor = ambient + diffuse + specular;


    //fragColor = frontColor;
}