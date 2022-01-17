varying mediump vec2 var_texcoord0;
varying mediump vec3 var_light;
uniform highp mat4 mtx_proj;
uniform highp vec4 righttop; //right, top, near, far

uniform highp sampler2D tex0;
uniform mediump sampler2D tex1;
uniform highp sampler2D tex2;

uniform mediump vec4 mtx_light0;
uniform mediump vec4 mtx_light1;
uniform mediump vec4 mtx_light2;
uniform mediump vec4 mtx_light3;

uniform lowp vec4 mode;

float LIGHT_SIZE = 8.; 
float NEAR = 0.1;

const vec2 samples[128] = vec2[128](
	vec2(-0.9406119, 0.2160107),
	vec2(-0.920003, 0.03135762),
	vec2(-0.917876, -0.2841548),
	vec2(-0.9166079, -0.1372365),
	vec2(-0.8978907, -0.4213504),
	vec2(-0.8467999, 0.5201505),
	vec2(-0.8261013, 0.3743192),
	vec2(-0.7835162, 0.01432008),
	vec2(-0.779963, 0.2161933),
	vec2(-0.7719588, 0.6335353),
	vec2(-0.7658782, -0.3316436),
	vec2(-0.7341912, -0.5430729),
	vec2(-0.6825727, -0.1883408),
	vec2(-0.6777467, 0.3313724),
	vec2(-0.662191, 0.5155144),
	vec2(-0.6569989, -0.7000636),
	vec2(-0.6021447, 0.7923283),
	vec2(-0.5980815, -0.5529259),
	vec2(-0.5867089, 0.09857152),
	vec2(-0.5774597, -0.8154474),
	vec2(-0.5767041, -0.2656419),
	vec2(-0.575091, -0.4220052),
	vec2(-0.5486979, -0.09635002),
	vec2(-0.5235587, 0.6594529),
	vec2(-0.5170338, -0.6636339),
	vec2(-0.5114055, 0.4373561),
	vec2(-0.4844725, 0.2985838),
	vec2(-0.4803245, 0.8482798),
	vec2(-0.4651957, -0.5392771),
	vec2(-0.4529685, 0.09942394),
	vec2(-0.4523471, -0.3125569),
	vec2(-0.4268422, 0.5644538),
	vec2(-0.4187512, -0.8636028),
	vec2(-0.4160798, -0.0844868),
	vec2(-0.3751733, 0.2196607),
	vec2(-0.3656596, -0.7324334),
	vec2(-0.3286595, -0.2012637),
	vec2(-0.3147397, -0.0006635741),
	vec2(-0.3135846, 0.3636878),
	vec2(-0.3042951, -0.4983553),
	vec2(-0.2974239, 0.7496996),
	vec2(-0.2903037, 0.8890813),
	vec2(-0.2878664, -0.8622097),
	vec2(-0.2588971, -0.653879),
	vec2(-0.2555692, 0.5041648),
	vec2(-0.2553292, -0.3389159),
	vec2(-0.2401368, 0.2306108),
	vec2(-0.2124457, -0.09935001),
	vec2(-0.1877905, 0.1098409),
	vec2(-0.1559879, 0.3356432),
	vec2(-0.1499449, 0.7487829),
	vec2(-0.146661, -0.9256138),
	vec2(-0.1342774, 0.6185387),
	vec2(-0.1224529, -0.3887629),
	vec2(-0.116467, 0.8827716),
	vec2(-0.1157598, -0.539999),
	vec2(-0.09983152, -0.2407187),
	vec2(-0.09953719, -0.78346),
	vec2(-0.08604223, 0.4591112),
	vec2(-0.02128129, 0.1551989),
	vec2(-0.01478849, 0.6969455),
	vec2(-0.01231739, -0.6752576),
	vec2(-0.005001599, -0.004027164),
	vec2(0.00248426, 0.567932),
	vec2(0.00335562, 0.3472346),
	vec2(0.009554717, -0.4025437),
	vec2(0.02231783, -0.1349781),
	vec2(0.04694207, -0.8347212),
	vec2(0.05412609, 0.9042216),
	vec2(0.05812819, -0.9826952),
	vec2(0.1131321, -0.619306),
	vec2(0.1170737, 0.6799788),
	vec2(0.1275105, 0.05326218),
	vec2(0.1393405, -0.2149568),
	vec2(0.1457873, 0.1991508),
	vec2(0.1474208, 0.5443151),
	vec2(0.1497117, -0.3899909),
	vec2(0.1923773, 0.3683496),
	vec2(0.2110928, -0.7888536),
	vec2(0.2148235, 0.9586087),
	vec2(0.2152219, -0.1084362),
	vec2(0.2189204, -0.9644538),
	vec2(0.2220028, -0.5058427),
	vec2(0.2251696, 0.779461),
	vec2(0.2585723, 0.01621339),
	vec2(0.2612841, -0.2832426),
	vec2(0.2665483, -0.6422054),
	vec2(0.2939872, 0.1673226),
	vec2(0.3235748, 0.5643662),
	vec2(0.3269232, 0.6984669),
	vec2(0.3425438, -0.1783788),
	vec2(0.3672505, 0.4398117),
	vec2(0.3755714, -0.8814359),
	vec2(0.379463, 0.2842356),
	vec2(0.3822978, -0.381217),
	vec2(0.4057849, -0.5227674),
	vec2(0.4168737, -0.6936938),
	vec2(0.4202749, 0.8369391),
	vec2(0.4252189, 0.03818182),
	vec2(0.4445904, -0.09360636),
	vec2(0.4684285, 0.5885228),
	vec2(0.4952184, -0.2319764),
	vec2(0.5072351, 0.3683765),
	vec2(0.5136194, -0.3944138),
	vec2(0.519893, 0.7157083),
	vec2(0.5277841, 0.1486474),
	vec2(0.5474944, -0.7618791),
	vec2(0.5692734, 0.4852227),
	vec2(0.582229, -0.5125455),
	vec2(0.583022, 0.008507785),
	vec2(0.6500257, 0.3473313),
	vec2(0.6621304, -0.6280518),
	vec2(0.6674218, -0.2260806),
	vec2(0.6741871, 0.6734863),
	vec2(0.6753459, 0.1119422),
	vec2(0.7083091, -0.4393666),
	vec2(0.7106963, -0.102099),
	vec2(0.7606754, 0.5743545),
	vec2(0.7846709, 0.2282225),
	vec2(0.7871446, 0.3891495),
	vec2(0.8071781, -0.5257092),
	vec2(0.8230689, 0.002674922),
	vec2(0.8531976, -0.3256475),
	vec2(0.8758298, -0.1824844),
	vec2(0.8797691, 0.1284946),
	vec2(0.926309, 0.3576975),
	vec2(0.9608918, -0.03495717),
	vec2(0.972032, 0.2271516)
);

bool invalid_uv(vec2 uv){
	return (uv.x <0 ||uv.x > 1 || uv.y <0 ||uv.y > 1);
}

float rgba_to_float(vec4 rgba)
{
	return dot(rgba, vec4(1.0, 1.0/255.0, 1.0/65025.0, 1.0/16581375.0));
}

float random(vec3 seed, int i){
	vec4 seed4 = vec4(seed,i);
	float dot_product = dot(seed4, vec4(12.9898,78.233,45.164,94.673));
	return fract(sin(dot_product) * 43758.5453);
}

float poisson(vec3 proj, int count, vec2 scale, float bias) {
	float sum = 0; 
	for (int i = 0; i < count; i++) {
		int index = int(128.0*random(gl_FragCoord.xyy, i))%128;
		vec2 uv = proj.xy + scale * samples[index];
		if (invalid_uv(uv)) {continue;}
		
		float depth = rgba_to_float(texture2D(tex0, uv));
		float shadow = (depth < proj.z - bias) ? 1. : 0.;
		sum += shadow; 
	}

	return sum / count;
}

float pcf(vec3 proj, int num_samples, float scale, float bias) {
	vec2 texel = scale / textureSize(tex0, 0);
	float sum = 0;
	int count = 0;
	float x, y; 
	for (y = -num_samples/2; y < num_samples/2; y += 1.0) {
		for (x = -num_samples/2; x < num_samples/2; x += 1.0) {
			vec2 uv = proj.xy + texel* vec2(x, y);
			if (invalid_uv(uv)) {continue;}
			float depth = rgba_to_float(texture2D(tex0, uv));
			float shadow = (depth < proj.z - bias) ? 1. : 0.;
			sum += shadow; 
			count ++;
		}
	}

	return sum / count;
}

float pcf_4x4(vec3 proj, float bias) {
	vec2 texel = 1.0 / textureSize(tex0, 0);
	float sum = 0; 
	float x, y; 
	for (y = -1.5; y <= 1.5; y += 1.0) {
		for (x = -1.5; x <= 1.5; x += 1.0) {
			vec2 uv = proj.xy + texel* vec2(x, y);
			if (invalid_uv(uv)) {continue;}
			float depth = rgba_to_float(texture2D(tex0, uv));
			float shadow = (depth < proj.z - bias) ? 1. : 0.;
			sum += shadow; 
		}
	}

	return sum / 16.0;
}

float simple(vec3 proj, float bias) {
	float depth = rgba_to_float(texture2D(tex0, proj.xy));
	return (depth < proj.z - bias) ? 1 : 0;
}


float find_blockers(vec3 proj, out float distance){
	distance = 0;
	float count = 0;
	float scale =  (proj.z - 0.1) / proj.z;
	float shadow = 0;
	float range = scale * LIGHT_SIZE;
	vec2 texel = vec2(range) / textureSize(tex0, 0);
	
	int limit = 8;
	for (int i = 0; i < limit; i++) {
		int index = int(128.0 * random(gl_FragCoord.xyy, i)) % 128;
		vec2 uv = proj.xy + texel* samples[index];
		if (invalid_uv(uv)) {continue;}
		
		float depth = rgba_to_float(texture2D(tex0, uv));

		if (depth < 0.015) {
			continue;
		}
		
		if (depth < proj.z - 0.03) {
			distance += depth;
			shadow += 1.;
			count ++;
		}
	}

	distance = count > 0. ? distance / count : -1;
	return shadow / limit; 
}

float pcss(vec3 proj, float bias, out float is_penumbra)
{
	float d_blocker = 0.;
	is_penumbra = 0.;
	float shadow = find_blockers(proj, d_blocker);
	if(d_blocker < 0.001 ) {
		return 0.;
	}

	if (shadow == 1.) //full shadow, no penumbra?
	{
		return 1.;
	}

	int count = 16;
	
	is_penumbra = 1.;
	
	float penumbra = (proj.z - d_blocker) / d_blocker;
	float scale = penumbra * LIGHT_SIZE * NEAR / proj.z;
	if (scale > 20.) {return 0;}
	
	return poisson(proj, count, scale /textureSize(tex0, 0), bias);
}

mat4 get_shadow_mat()
{
	return mat4(mtx_light0, mtx_light1, mtx_light2, mtx_light3);
}

vec3 unproject(vec2 uv)
{
	float near = righttop.z;
	float far = righttop.w;
	float d = rgba_to_float(texture2D(tex2, uv));
	vec2 ndc = uv * 2.0 - 1.0;
	vec2 pnear = ndc * righttop.xy;
	float pz = -d * far;
	return vec3(-pz * pnear.x / near, -pz * pnear.y / near, pz);
}

void main()
{
	vec3 pos = unproject(var_texcoord0);

	vec4 dp = get_shadow_mat() * vec4(pos.xyz, 1.0);
	dp = dp / dp.w;

	vec3 normal = texture(tex1, var_texcoord0).xyz * 2.0 - 1.0;
	vec3 light_dir = normalize(var_light);
	float bias = max(0.1 * (1.0 - dot(normal, light_dir)), 0.005);

	float is_penumbra = 0.;
	float shadow = 0.;
	if (mode.x == 0.) {shadow = simple(dp.xyz, bias);}
	else if (mode.x == 1.) {shadow = pcf_4x4(dp.xyz, bias);}
	else if (mode.x == 2.) {shadow = poisson(dp.xyz, 4, 1./textureSize(tex0, 0), bias);}
	else if (mode.x == 3.) {shadow = pcss(dp.xyz, bias, is_penumbra);}
	else {
		float dist;
		shadow = find_blockers(dp.xyz, dist);
	}

	shadow = clamp(1. - shadow, 0.3, 1);
	gl_FragColor = vec4(shadow, is_penumbra, 0, 1);
	
	//gl_FragColor = vec4(vec3(rgba_to_float(texture2D(tex0,var_texcoord0))), 1);
}