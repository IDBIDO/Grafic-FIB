#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;


const vec4 colors[5] = vec4[5] (
                        vec4(1.0, 0.0, 0.0, 1.0), //red
                        vec4(1.0, 1.0, 0.0, 1.0), //yellow
                        vec4(0.0, 1.0, 0.0, 1.0), //green
                        vec4(0.0, 1.0, 1.0, 1.0), //cian
                        vec4(0.0, 0.0, 1.0, 1.0));//blue
/*
    Hay 5 colores, 4 intervalos: 
    [red-yellow][yellow-green][green-cian][cian-blue]
    donde el intervalo [red-yellow] empieza cuando vertex.y == boundingBoxMin.y, 
    y el intervalo [cian-blue] acaba en y == boundingBoxMax.y;


*/

void main()
{



    vec3 N = normalize(normalMatrix * normal);

    //posicion en clip space
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);

    vec3 vertexNDC = gl_Position.xyz/gl_Position.w;

    //calculmos la longitud de un intervalo

    //miramos en que intervalo se situa vertex.y

    //esto funciona pork las coordenadas x, y, z de NDC space tiene range [-1, 1]
    float intervalPos = (vertexNDC.y + 1) / 0.5;
    int pos = int(intervalPos);

    frontColor = mix(colors[pos], colors[pos+1], fract(intervalPos));

}
