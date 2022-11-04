#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

void main()
{
    // TODO Homework 5
	vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);
	float side_len = 0.5f*pow(2,0.5f);
	float distance = pow((fs_UV.x - 0.5)*(fs_UV.x - 0.5)+(fs_UV.y - 0.5)*(fs_UV.y - 0.5),0.5f);
	//float x_val = gl_Position.x;
	float grey = diffuseColor.x * 0.21f + 0.72f * diffuseColor.y + 0.07f * diffuseColor.z;
    color = vec3(grey,grey,grey)*(1-(distance / side_len));
}
