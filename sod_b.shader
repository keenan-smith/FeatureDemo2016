Shader "Outlined/Silhouetted Bumped Diffuse" {
	Properties{
		_Color("Main Color", Color) = (.5,.5,.5,1)
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_Outline("Outline width", Range(0.0, 0.03)) = .005
		_MainTex("Base (RGB)", 2D) = "white" { }
	_BumpMap("Bumpmap", 2D) = "bump" {}
	}

		#LINE 38


		SubShader{
		Tags{ "Queue" = "Transparent" }

		// note that a vertex shader is specified here but its using the one above
		Pass{
		Name "OUTLINE"
		Tags{ "LightMode" = "Always" }
		Cull Off
		ZWrite Off
		ZTest Always

		// you can choose what kind of blending mode you want for the outline
		Blend SrcAlpha OneMinusSrcAlpha // Normal
										//Blend One One // Additive
										//Blend One OneMinusDstColor // Soft Additive
										//Blend DstColor Zero // Multiplicative
										//Blend DstColor SrcColor // 2x Multiplicative

		CGPROGRAM
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 56 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
#pragma vertex vert
#pragma fragment frag

		half4 frag(v2f i) : COLOR{
		return i.color;
	}
		ENDCG

#LINE 65

	}


		
	// ------------------------------------------------------------
	// Surface shader code generated out of a CGPROGRAM block:
	

	// ---- forward rendering base pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_fwdbase
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
// no lightmaps:
#ifndef LIGHTMAP_ON
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD4; // SH
  #endif
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// with lightmaps:
#ifdef LIGHTMAP_ON
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifndef LIGHTMAP_ON
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // !LIGHTMAP_ON

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingLambert_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingLambert (o, gi);
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- forward rendering additive lights pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_fwdadd
#pragma skip_variants INSTANCING_ON
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  fixed3 tSpace0 : TEXCOORD1;
  fixed3 tSpace1 : TEXCOORD2;
  fixed3 tSpace2 : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
};
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
  #endif
  gi.light.color *= atten;
  c += LightingLambert (o, gi);
  c.a = 0.0;
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- deferred lighting base geometry pass:
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _BumpMap
#define UNITY_PASS_PREPASSBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_BumpMap = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // output normal and specular
  fixed4 res;
  res.rgb = o.Normal * 0.5 + 0.5;
  res.a = o.Specular;
  return res;
}

ENDCG

}

	// ---- deferred lighting final pass:
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_prepassfinal
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#define UNITY_PASS_PREPASSFINAL
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _MainTex
  float3 worldPos : TEXCOORD1;
  float4 screen : TEXCOORD2;
  float4 lmap : TEXCOORD3;
#ifndef LIGHTMAP_ON
  float3 vlight : TEXCOORD4;
#else
#ifdef DIRLIGHTMAP_OFF
  float4 lmapFadePos : TEXCOORD4;
#endif
#endif
  UNITY_FOG_COORDS(5)
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 tSpace0 : TEXCOORD6;
  fixed3 tSpace1 : TEXCOORD7;
  fixed3 tSpace2 : TEXCOORD8;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.screen = ComputeScreenPos (o.pos);
#ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#else
  o.lmap.zw = 0;
#endif
#ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
  o.lmap.xy = 0;
  float3 worldN = UnityObjectToWorldNormal(v.normal);
  o.vlight = ShadeSH9 (float4(worldN,1.0));
#endif
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}
sampler2D _LightBuffer;
sampler2D _CameraNormalsTexture;
#ifdef LIGHTMAP_ON
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  half4 light = tex2Dproj (_LightBuffer, UNITY_PROJ_COORD(IN.screen));
#if defined (SHADER_API_MOBILE)
  light = max(light, half4(0.001, 0.001, 0.001, 0.001));
#endif
#ifndef UNITY_HDR_ON
  light = -log2(light);
#endif
  #ifdef LIGHTMAP_ON
    #ifdef DIRLIGHTMAP_OFF
      // single lightmap
      fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
      fixed3 lm = DecodeLightmap (lmtex);
      light.rgb += lm;
    #elif DIRLIGHTMAP_COMBINED
      half4 nspec = tex2Dproj (_CameraNormalsTexture, UNITY_PROJ_COORD(IN.screen));
      half3 normal = nspec.rgb * 2 - 1;
      o.Normal = normalize(normal);
      // directional lightmaps
      fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
      fixed4 lmIndTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, IN.lmap.xy);
      half4 lm = half4(DecodeDirectionalLightmap (DecodeLightmap(lmtex), lmIndTex, o.Normal), 0);
      light += lm;
    #elif DIRLIGHTMAP_SEPARATE
      // directional with specular - no support
    #endif // DIRLIGHTMAP_OFF
  #else
    light.rgb += IN.vlight;
  #endif // LIGHTMAP_ON

  #ifdef DYNAMICLIGHTMAP_ON
  fixed4 dynlmtex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, IN.lmap.zw);
  light.rgb += DecodeRealtimeLightmap (dynlmtex);
  #endif

  half4 c = LightingLambert_PrePass (o, light);
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- deferred shading pass:
	Pass {
		Name "DEFERRED"
		Tags { "LightMode" = "Deferred" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma exclude_renderers nomrt
#pragma multi_compile_prepassfinal
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_DEFERRED
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
#ifndef LIGHTMAP_ON
  #if UNITY_SHOULD_SAMPLE_SH
    half3 sh : TEXCOORD5; // SH
  #endif
#else
  #ifdef DIRLIGHTMAP_OFF
    float4 lmapFadePos : TEXCOORD5;
  #endif
#endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
#ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#else
  o.lmap.zw = 0;
#endif
#ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
  o.lmap.xy = 0;
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
#endif
  return o;
}
#ifdef LIGHTMAP_ON
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;

// fragment shader
void frag_surf (v2f_surf IN,
    out half4 outGBuffer0 : SV_Target0,
    out half4 outGBuffer1 : SV_Target1,
    out half4 outGBuffer2 : SV_Target2,
    out half4 outEmission : SV_Target3) {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
fixed3 originalNormal = o.Normal;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;
  half atten = 1;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  gi.light.color = 0;
  gi.light.dir = half3(0,1,0);
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingLambert_GI(o, giInput, gi);

  // call lighting function to output g-buffer
  outEmission = LightingLambert_Deferred (o, gi, outGBuffer0, outGBuffer1, outGBuffer2);
  #ifndef UNITY_HDR_ON
  outEmission.rgb = exp2(-outEmission.rgb);
  #endif
}

ENDCG

}

	// ---- meta information extraction pass:
	Pass {
		Name "Meta"
		Tags { "LightMode" = "Meta" }
		Cull Off

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#pragma skip_variants INSTANCING_ON
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 67 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	
#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
};
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}

ENDCG

}

	// ---- end of surface shader generated code

#LINE 82


	}

		SubShader{
		Tags{ "Queue" = "Transparent" }

		Pass{
		Name "OUTLINE"
		Tags{ "LightMode" = "Always" }
		Cull Front
		ZWrite Off
		ZTest Always
		Offset 15,15

		// you can choose what kind of blending mode you want for the outline
		Blend SrcAlpha OneMinusSrcAlpha // Normal
										//Blend One One // Additive
										//Blend One OneMinusDstColor // Soft Additive
										//Blend DstColor Zero // Multiplicative
										//Blend DstColor SrcColor // 2x Multiplicative


		SetTexture[_MainTex]{ combine primary }
	}

		
	// ------------------------------------------------------------
	// Surface shader code generated out of a CGPROGRAM block:
	

	// ---- forward rendering base pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_fwdbase
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
// no lightmaps:
#ifndef LIGHTMAP_ON
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  #if UNITY_SHOULD_SAMPLE_SH
  half3 sh : TEXCOORD4; // SH
  #endif
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// with lightmaps:
#ifdef LIGHTMAP_ON
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifndef LIGHTMAP_ON
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      // Approximated illumination from non-important point lights
      #ifdef VERTEXLIGHT_ON
        o.sh += Shade4PointLights (
          unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
          unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
          unity_4LightAtten0, worldPos, worldNormal);
      #endif
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
  #endif // !LIGHTMAP_ON

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
  #endif
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingLambert_GI(o, giInput, gi);

  // realtime lighting: call lighting function
  c += LightingLambert (o, gi);
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- forward rendering additive lights pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_fwdadd
#pragma skip_variants INSTANCING_ON
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  fixed3 tSpace0 : TEXCOORD1;
  fixed3 tSpace1 : TEXCOORD2;
  fixed3 tSpace2 : TEXCOORD3;
  float3 worldPos : TEXCOORD4;
  SHADOW_COORDS(5)
  UNITY_FOG_COORDS(6)
};
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = fixed3(worldTangent.x, worldBinormal.x, worldNormal.x);
  o.tSpace1 = fixed3(worldTangent.y, worldBinormal.y, worldNormal.y);
  o.tSpace2 = fixed3(worldTangent.z, worldBinormal.z, worldNormal.z);
  o.worldPos = worldPos;

  TRANSFER_SHADOW(o); // pass shadow coordinates to pixel shader
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  #if !defined(LIGHTMAP_ON)
      gi.light.color = _LightColor0.rgb;
      gi.light.dir = lightDir;
  #endif
  gi.light.color *= atten;
  c += LightingLambert (o, gi);
  c.a = 0.0;
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- deferred lighting base geometry pass:
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _BumpMap
#define UNITY_PASS_PREPASSBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_BumpMap = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;

  // output normal and specular
  fixed4 res;
  res.rgb = o.Normal * 0.5 + 0.5;
  res.a = o.Specular;
  return res;
}

ENDCG

}

	// ---- deferred lighting final pass:
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_fog
#pragma multi_compile_prepassfinal
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#define UNITY_PASS_PREPASSFINAL
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _MainTex
  float3 worldPos : TEXCOORD1;
  float4 screen : TEXCOORD2;
  float4 lmap : TEXCOORD3;
#ifndef LIGHTMAP_ON
  float3 vlight : TEXCOORD4;
#else
#ifdef DIRLIGHTMAP_OFF
  float4 lmapFadePos : TEXCOORD4;
#endif
#endif
  UNITY_FOG_COORDS(5)
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 tSpace0 : TEXCOORD6;
  fixed3 tSpace1 : TEXCOORD7;
  fixed3 tSpace2 : TEXCOORD8;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  #endif
  #if defined(LIGHTMAP_ON) && defined(DIRLIGHTMAP_COMBINED)
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #endif
  o.worldPos = worldPos;
  o.screen = ComputeScreenPos (o.pos);
#ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#else
  o.lmap.zw = 0;
#endif
#ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
  o.lmap.xy = 0;
  float3 worldN = UnityObjectToWorldNormal(v.normal);
  o.vlight = ShadeSH9 (float4(worldN,1.0));
#endif
  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  return o;
}
sampler2D _LightBuffer;
sampler2D _CameraNormalsTexture;
#ifdef LIGHTMAP_ON
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = IN.worldPos;
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  half4 light = tex2Dproj (_LightBuffer, UNITY_PROJ_COORD(IN.screen));
#if defined (SHADER_API_MOBILE)
  light = max(light, half4(0.001, 0.001, 0.001, 0.001));
#endif
#ifndef UNITY_HDR_ON
  light = -log2(light);
#endif
  #ifdef LIGHTMAP_ON
    #ifdef DIRLIGHTMAP_OFF
      // single lightmap
      fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
      fixed3 lm = DecodeLightmap (lmtex);
      light.rgb += lm;
    #elif DIRLIGHTMAP_COMBINED
      half4 nspec = tex2Dproj (_CameraNormalsTexture, UNITY_PROJ_COORD(IN.screen));
      half3 normal = nspec.rgb * 2 - 1;
      o.Normal = normalize(normal);
      // directional lightmaps
      fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
      fixed4 lmIndTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, IN.lmap.xy);
      half4 lm = half4(DecodeDirectionalLightmap (DecodeLightmap(lmtex), lmIndTex, o.Normal), 0);
      light += lm;
    #elif DIRLIGHTMAP_SEPARATE
      // directional with specular - no support
    #endif // DIRLIGHTMAP_OFF
  #else
    light.rgb += IN.vlight;
  #endif // LIGHTMAP_ON

  #ifdef DYNAMICLIGHTMAP_ON
  fixed4 dynlmtex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, IN.lmap.zw);
  light.rgb += DecodeRealtimeLightmap (dynlmtex);
  #endif

  half4 c = LightingLambert_PrePass (o, light);
  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}

ENDCG

}

	// ---- deferred shading pass:
	Pass {
		Name "DEFERRED"
		Tags { "LightMode" = "Deferred" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma exclude_renderers nomrt
#pragma multi_compile_prepassfinal
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 2 texcoords actually used
//   float2 _MainTex
//   float2 _BumpMap
#define UNITY_PASS_DEFERRED
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 pack0 : TEXCOORD0; // _MainTex _BumpMap
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
#ifndef LIGHTMAP_ON
  #if UNITY_SHOULD_SAMPLE_SH
    half3 sh : TEXCOORD5; // SH
  #endif
#else
  #ifdef DIRLIGHTMAP_OFF
    float4 lmapFadePos : TEXCOORD5;
  #endif
#endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
float4 _MainTex_ST;
float4 _BumpMap_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
#ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#else
  o.lmap.zw = 0;
#endif
#ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
  o.lmap.xy = 0;
    #if UNITY_SHOULD_SAMPLE_SH
      o.sh = 0;
      o.sh = ShadeSHPerVertex (worldNormal, o.sh);
    #endif
#endif
  return o;
}
#ifdef LIGHTMAP_ON
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;

// fragment shader
void frag_surf (v2f_surf IN,
    out half4 outGBuffer0 : SV_Target0,
    out half4 outGBuffer1 : SV_Target1,
    out half4 outGBuffer2 : SV_Target2,
    out half4 outEmission : SV_Target3) {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  surfIN.uv_BumpMap = IN.pack0.zw;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
fixed3 originalNormal = o.Normal;
  fixed3 worldN;
  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
  o.Normal = worldN;
  half atten = 1;

  // Setup lighting environment
  UnityGI gi;
  UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
  gi.indirect.diffuse = 0;
  gi.indirect.specular = 0;
  gi.light.color = 0;
  gi.light.dir = half3(0,1,0);
  // Call GI (lightmaps/SH/reflections) lighting function
  UnityGIInput giInput;
  UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
  giInput.light = gi.light;
  giInput.worldPos = worldPos;
  giInput.atten = atten;
  #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
    giInput.lightmapUV = IN.lmap;
  #else
    giInput.lightmapUV = 0.0;
  #endif
  #if UNITY_SHOULD_SAMPLE_SH
    giInput.ambient = IN.sh;
  #else
    giInput.ambient.rgb = 0.0;
  #endif
  giInput.probeHDR[0] = unity_SpecCube0_HDR;
  giInput.probeHDR[1] = unity_SpecCube1_HDR;
  #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMin[0] = unity_SpecCube0_BoxMin; // .w holds lerp value for blending
  #endif
  #if UNITY_SPECCUBE_BOX_PROJECTION
    giInput.boxMax[0] = unity_SpecCube0_BoxMax;
    giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
    giInput.boxMax[1] = unity_SpecCube1_BoxMax;
    giInput.boxMin[1] = unity_SpecCube1_BoxMin;
    giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
  #endif
  LightingLambert_GI(o, giInput, gi);

  // call lighting function to output g-buffer
  outEmission = LightingLambert_Deferred (o, gi, outGBuffer0, outGBuffer1, outGBuffer2);
  #ifndef UNITY_HDR_ON
  outEmission.rgb = exp2(-outEmission.rgb);
  #endif
}

ENDCG

}

	// ---- meta information extraction pass:
	Pass {
		Name "Meta"
		Tags { "LightMode" = "Meta" }
		Cull Off

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
#pragma skip_variants INSTANCING_ON
#include "HLSLSupport.cginc"
#include "UnityShaderVariables.cginc"
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: YES
// needs world space view direction for lighting: no
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#define UNITY_PASS_META
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 11

#include "UnityCG.cginc"

		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		// just make a copy of incoming vertex data but scaled according to normal direction
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);

		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	#line 106 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
//#pragma surface surf Lambert
		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};
	sampler2D _MainTex;
	sampler2D _BumpMap;
	uniform float3 _Color;
	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
	
#include "UnityMetaPass.cginc"

// vertex-to-fragment interpolation data
struct v2f_surf {
  float4 pos : SV_POSITION;
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
};
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  // prepare and unpack data
  Input surfIN;
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);
  UnityMetaInput metaIN;
  UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
  metaIN.Albedo = o.Albedo;
  metaIN.Emission = o.Emission;
  return UnityMetaFragment(metaIN);
}

ENDCG

}

	// ---- end of surface shader generated code

#LINE 121


	}

		Fallback "Outlined/Silhouetted Diffuse"
}