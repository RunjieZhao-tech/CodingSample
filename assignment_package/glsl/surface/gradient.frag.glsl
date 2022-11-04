#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec3 fs_Nor;
in vec3 fs_LightVec;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
	float t = dot(normalize(fs_Nor), normalize(fs_LightVec));
	vec3 a = vec3(0.5,0.5,0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(1.0, 1.0, 1.0);
	vec3 d = vec3(0.00, 0.33, 0.67);
	vec3 res_color = a + b * cos(2 * 3.14159265 * (c * t + d));
    out_Col = res_color;
}
