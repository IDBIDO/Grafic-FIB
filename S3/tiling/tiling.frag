#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D colorMap;
in vec2 vtexCoord;
uniform float time;
uniform float speed=0.1;

void main()
{
    //vec2 vtexAnimate = vec2(vtexCoord.x , vtexCoord.y + time*speed);
    fragColor = texture(colorMap, vtexCoord);
}