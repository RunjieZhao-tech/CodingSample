#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

const float horizontal[9] = {3,0,-3,10,0,-10,3,0,-3};
const float vertical[9] = {3,10,3,0,0,0,-3,-10,-3};
void main()
{
    // TODO Homework 5
	color = vec3(0,0,0);
	float width_step = 1.f / 971.f;
	float height_step = 1.f / 746.f;
	vec3 hori = vec3(0,0,0);
	vec3 vert = vec3(0,0,0);
	for(int i = -1; i < 2; i++){
		for(int j = -1; j < 2; j++){
			vec2 temp = vec2(fs_UV.x+j*width_step,fs_UV.y+i*height_step);
			float h = horizontal[3*(i+1)+j+1];
			float v = vertical[3*(i+1)+j+1];
			vec4 dc = texture(u_RenderedTexture,temp);
			hori += vec3(dc)*h;
			vert += vec3(dc)*v;
		}
	}
	float xval = pow(hori.x * hori.x + vert.x * vert.x,0.5f);
	float yval = pow(hori.y * hori.y + vert.y * vert.y,0.5f);
	float zval = pow(hori.z * hori.z + vert.z * vert.z,0.5f);
	color = vec3(xval,yval,zval);
}
