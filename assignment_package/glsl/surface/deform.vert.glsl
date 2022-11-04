#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Pos;
out vec3 fs_Nor;

void main()
{
    // TODO Homework 4
    fs_Nor = normalize(u_ModelInvTr * vec3(vs_Nor));

    vec4 modelposition = u_Model * vs_Pos;
    fs_Pos = vec3(modelposition);
	vec3 far_point = 3*normalize(fs_Pos);
	vec4 temp = u_View * modelposition;
	float side_len = pow(temp.x*temp.x+temp.y*temp.y,0.5f);
	//float sin = temp.y / side_len;
	//float cos = temp.x / side_len;
	
	//between 6 and side_len
	//float cur_len = (6 - side_len) * abs(cos(u_Time / 200.f)) + side_len;
	
	//use mix
	float t = abs(cos(u_Time / 200.f));
	vec3 cur_len = mix(fs_Pos,far_point,vec3(t,t,t));
	//float new_x = cos * cur_len;
	//float new_y = sin * cur_len;
	gl_Position = u_Proj * vec4(cur_len.x,cur_len.y,temp.z,temp.w);
	
	
	
	//gl_Position = vec4(new_x,new_y,temp.z,temp.w);
	//gl_Position = vec4(cos(u_Time / 200.f) * vec2(temp),temp.z,temp.w);
    //gl_Position = u_Proj * u_View * modelposition + vec4(cos(u_Time / 100.f) * vec2(temp),temp.z,temp.w);
}
