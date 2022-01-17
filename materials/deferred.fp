varying mediump vec2 var_texcoord0;
uniform highp mat4 mtx_viewproj;

uniform mediump sampler2D tex0;
uniform mediump sampler2D tex1;
uniform mediump sampler2D tex2;
uniform mediump sampler2D tex3;

uniform mediump vec4 mtx_ivp0;
uniform mediump vec4 mtx_ivp1;
uniform mediump vec4 mtx_ivp2;
uniform mediump vec4 mtx_ivp3;

uniform mediump vec4 mtx_iview0;
uniform mediump vec4 mtx_iview1;
uniform mediump vec4 mtx_iview2;
uniform mediump vec4 mtx_iview3;

uniform mediump vec4 light;

float rgba_to_float(vec4 rgba)
{
	return dot(rgba, vec4(1.0, 1.0/255.0, 1.0/65025.0, 1.0/16581375.0));
}

mat4 get_invviewproj()
{
	return mat4(mtx_ivp0, mtx_ivp1, mtx_ivp2, mtx_ivp3);
}

mat4 get_invview()
{
	return mat4(mtx_iview0, mtx_iview1, mtx_iview2, mtx_iview3);
}

vec3 unproject(vec2 uv)
{
	vec4 position = vec4(1.0); 
	position.xy = uv.xy * 2.0 - 1.0; 
	position.z = rgba_to_float(texture2D(tex2, uv))* 2.0 - 1.0;
	position = get_invviewproj() * position; 
	position /= position.w;
	return position.xyz;
}
void main()
{
	vec4 color = texture(tex0, var_texcoord0);
	vec4 shadow = texture(tex3, var_texcoord0);
	vec3 normal = texture(tex1, var_texcoord0).xyz * 2.0 - 1.0;
	vec3 pos = unproject(var_texcoord0);

	normal = normalize(get_invview() * vec4(normal, 0)).xyz;
	
	float shade = shadow.x;

	/*
	if (shadow.y == 1.) { //penumbra extra blur ?
	
	}*/
	
	vec3 ambient_light = vec3(0.2);
	
	// diffuse
	vec3 diff_light = normalize(light.xyz - pos);
	diff_light = max(dot(normal, diff_light), 0.0) + ambient_light;
	diff_light = clamp(diff_light, 0.0, 1.0);


	gl_FragColor = vec4(diff_light * color.xyz * shade, color.w);
	//gl_FragColor = texture(tex3, var_texcoord0);

}