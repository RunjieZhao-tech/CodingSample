#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec2 fs_UV;
in vec3 fs_normal;
layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
	vec4 diffuseColor = texture(u_Texture, vec2(fs_normal.x / 2+0.5f,fs_normal.y/2+0.5f));
    out_Col = vec3(diffuseColor.rgb);
	//out_Col = vec3(0,0,0);
}
