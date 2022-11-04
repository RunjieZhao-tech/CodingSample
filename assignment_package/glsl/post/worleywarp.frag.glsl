#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)),
                 dot(p, vec2(269.5,183.3))))
                 * 43758.5453);
}


float WorleyNoise(vec2 uv) {
    uv *= 10.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
    for(int y = -1; y <= 1; ++y) {
        for(int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            float dist = length(diff);
            minDist = min(minDist, dist);
        }
    }
    return minDist;
}

vec2 WorleyNoise1(vec2 uv) {
    uv *= 100.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
	vec2 res = vec2(0,0);
    for(int y = -1; y <= 1; ++y) {
        for(int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            float dist = length(diff);
			if(minDist > dist){
				minDist = min(minDist, dist);
				res = diff;
			}
        }
    }
    return res / 100.f;
}

float WorleyNoise2(vec2 uv) {
    uv *= 10.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
	vec2 res = vec2(0,0);
	float val = 0;
    for(int y = -1; y <= 1; ++y) {
        for(int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            float dist = length(diff);
			if(minDist > dist){
				minDist = min(minDist, dist);
				val = abs(diff.y + 1.0f);
			}
        }
    }
    return val;
}

//worley4 movement
vec2 WorleyNoise3(vec2 uv) {
    uv *= 100.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
	vec2 res = vec2(0,0);
    for(int y = 0; y <= 0; ++y) {
        for(int x = 0; x <= 0; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            res = diff;
        }
    }
    return res / 100.f;
}



void main()
{
    // TODO Homework 5
	
	//worley 1
	float wor1 = WorleyNoise(fs_UV);
	//wor1 = abs(cos((1 - wor1)*3.141592f));
	
	//worley 2
	vec2 val = WorleyNoise1(fs_UV);
	val = val * abs(cos(u_Time / 100.f));
	
	//worley3
	float wor3_bottom = WorleyNoise2(fs_UV);
	//worley4
	vec2 wor4 = WorleyNoise3(fs_UV);
	
        vec3 diffuseColor = texture(u_RenderedTexture, fs_UV+val).rbg;
	
	//apply reflection
	float reflect = pow(1-val.x*val.x-val.y*val.y,0.5f);
	
	color = vec3(diffuseColor.x * wor3_bottom, diffuseColor.y * wor3_bottom, diffuseColor.z);
}

