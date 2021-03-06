// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Tree Leaf"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 232
		[BBanner(ADS Standard Lit, Tree Leaf)]_ADSStandardLitTreeLeaf("< ADS Standard Lit Tree Leaf >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		_Color("Leaf Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Leaf Albedo", 2D) = "white" {}
		_NormalScale("Leaf Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Leaf Normal", 2D) = "bump" {}
		[NoScaleOffset]_SurfaceTex("Leaf Surface", 2D) = "white" {}
		_Smoothness("Leaf Smoothness (A)", Range( 0 , 1)) = 0.5
		_Occlusion("Leaf Occlusion (G)", Range( 0 , 1)) = 0
		_SubsurfaceColor("Leaf Subsurface (B)", Color) = (1,1,1,1)
		[BCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_DetailTint("Detail Tint", Range( 0 , 1)) = 1
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0
		[BCategory(Trunk Motion)]_TRUNKMOTIONN("[ TRUNK MOTIONN ]", Float) = 0
		[BMessage(Info, The Trunk Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_TrunkMotionParameters("!!! Trunk Motion Parameters !!!", Float) = 0
		_MotionAmplitude("Trunk Motion Amplitude", Float) = 0
		_MotionSpeed("Trunk Motion Speed", Float) = 0
		_MotionScale("Trunk Motion Scale", Float) = 0
		[BCategory(Branch Motion)]_BRANCHMOTIONN("[ BRANCH MOTIONN ]", Float) = 0
		[BMessage(Info, The Branch Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_BranchMotionParameters("!!! Branch Motion Parameters !!!", Float) = 0
		_MotionAmplitude2("Branch Motion Amplitude", Float) = 0
		_MotionSpeed2("Branch Motion Speed", Float) = 0
		_MotionScale2("Branch Motion Scale", Float) = 0
		_MotionVariation2("Branch Motion Variation", Float) = 0
		_MotionVertical2("Branch Motion Vertical", Range( 0 , 1)) = 0
		[BCategory(Leaf Motion)]_LEAFMOTIONN("[ LEAF MOTIONN ]", Float) = 0
		[BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_LeafMtionParameters("!!! Leaf Mtion Parameters !!!", Float) = 0
		_MotionAmplitude3("Leaf Flutter Amplitude", Float) = 0
		_MotionSpeed3("Leaf Flutter Speed", Float) = 0
		_MotionScale3("Leaf Flutter Scale", Float) = 0
		[BCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0)]_BatchingInfo("!!! BatchingInfo", Float) = 0
		[HideInInspector]_Internal_ADS("Internal_ADS", Float) = 1
		[HideInInspector]_MetallicGlossMap("_MetallicGlossMap", 2D) = "white" {}
		[HideInInspector]_MainUVs("_MainUVs", Vector) = (1,1,0,0)
		[HideInInspector]_BumpMap("_BumpMap", 2D) = "white" {}
		[HideInInspector]_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector]_CullMode("_CullMode", Float) = 0
		[HideInInspector]_Glossiness("_Glossiness", Float) = 0
		[HideInInspector]_Mode("_Mode", Float) = 0
		[HideInInspector]_BumpScale("_BumpScale", Float) = 0
		[HideInInspector]_Internal_UnityToBoxophobic("_Internal_UnityToBoxophobic", Float) = 0
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_TypeTreeLeaf("Internal_TypeTreeLeaf", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_Internal_DebugMask2("Internal_DebugMask2", Float) = 1
		[HideInInspector]_Internal_DebugMask3("Internal_DebugMask3", Float) = 1
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector]_Internal_SetByScript("Internal_SetByScript", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 300
		Cull [_RenderFaces]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		 
		//ADS Features
		//ADS End
		  
		#pragma exclude_renderers gles 
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
			float4 screenPosition;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
		};

		uniform float _MotionNoise;
		uniform half _LeafMtionParameters;
		uniform half _TrunkMotionParameters;
		uniform half _Cutoff;
		uniform half _RENDERINGG;
		uniform half _Internal_DebugMask3;
		uniform half _ADVANCEDD;
		uniform half _Internal_TypeTreeLeaf;
		uniform half _BRANCHMOTIONN;
		uniform half _Internal_SetByScript;
		uniform half _RenderFaces;
		uniform half _Internal_LitStandard;
		uniform half _BatchingInfo;
		uniform half _TRUNKMOTIONN;
		uniform half _LEAFMOTIONN;
		uniform half _LEAFF;
		uniform half _SETTINGSS;
		uniform half _ADSStandardLitTreeLeaf;
		uniform half _Internal_DebugMask;
		uniform half _Internal_DebugVariation;
		uniform half _BranchMotionParameters;
		uniform half _Internal_ADS;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Internal_UnityToBoxophobic;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform half _Internal_DebugMask2;
		uniform half _Internal_Version;
		uniform half ADS_GlobalScale;
		uniform float _MotionScale;
		uniform half ADS_GlobalSpeed;
		uniform float _MotionSpeed;
		uniform half ADS_GlobalAmplitude;
		uniform float _MotionAmplitude;
		uniform half3 ADS_GlobalDirection;
		uniform half ADS_GlobalLeavesAmount;
		uniform half ADS_GlobalLeavesVar;
		uniform float _MotionScale2;
		uniform float _MotionSpeed2;
		uniform float _MotionVariation2;
		uniform float _MotionAmplitude2;
		uniform float _MotionVertical2;
		uniform float _MotionScale3;
		uniform float _MotionSpeed3;
		uniform float _MotionAmplitude3;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform float _GlobalTurbulence;
		uniform half _NormalScale;
		uniform sampler2D _NormalTex;
		uniform sampler2D _AlbedoTex;
		uniform half4 _Color;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half _DetailTint;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;
		uniform sampler2D _SurfaceTex;
		uniform half _Smoothness;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform half4 _SubsurfaceColor;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g2031 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g2031 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g2031 = _Time.y * MotionSpeed62_g2031;
			float2 temp_output_95_0_g2031 = ( ( (ase_worldPos).xz * MotionScale60_g2031 ) + mulTime90_g2031 );
			half MotionlAmplitude58_g2031 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float2 temp_output_92_0_g2031 = ( sin( temp_output_95_0_g2031 ) * MotionlAmplitude58_g2031 );
			float2 temp_output_160_0_g2031 = ( temp_output_92_0_g2031 + MotionlAmplitude58_g2031 + MotionlAmplitude58_g2031 );
			half3 GlobalDirection349_g2031 = ADS_GlobalDirection;
			float3 break339_g2031 = mul( unity_WorldToObject, float4( GlobalDirection349_g2031 , 0.0 ) ).xyz;
			float2 appendResult340_g2031 = (float2(break339_g2031.x , break339_g2031.z));
			half2 MotionDirection59_g2031 = appendResult340_g2031;
			half Packed_Trunk21809 = ( v.color.r * v.color.r );
			half ADS_TreeLeavesAffectMotion168_g1872 = 0.2;
			half ADS_TreeLeavesAmount157_g1872 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g1873 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1873 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g1872 = saturate( ( ADS_TreeLeavesAmount157_g1872 - ( frac( ( localunity_ObjectToWorld0w1_g1873 + localunity_ObjectToWorld2w3_g1873 ) ) * ADS_GlobalLeavesVar ) ) );
			half LeavesAmountSimple172_g1872 = temp_output_142_0_g1872;
			float lerpResult156_g1872 = lerp( ADS_TreeLeavesAffectMotion168_g1872 , 1.0 , LeavesAmountSimple172_g1872);
			half MotionMask137_g2031 = ( Packed_Trunk21809 * lerpResult156_g1872 );
			float2 temp_output_94_0_g2031 = ( ( temp_output_160_0_g2031 * MotionDirection59_g2031 ) * MotionMask137_g2031 );
			float2 break311_g2031 = temp_output_94_0_g2031;
			float3 appendResult308_g2031 = (float3(break311_g2031.x , 0.0 , break311_g2031.y));
			half3 Motion_Trunk1749 = appendResult308_g2031;
			half MotionScale60_g2032 = ( ADS_GlobalScale * _MotionScale2 );
			half MotionSpeed62_g2032 = ( ADS_GlobalSpeed * _MotionSpeed2 );
			float mulTime90_g2032 = _Time.y * MotionSpeed62_g2032;
			float3 temp_output_95_0_g2032 = ( ( ase_worldPos * MotionScale60_g2032 ) + mulTime90_g2032 );
			half Packed_Variation1815 = v.color.a;
			half MotionVariation269_g2032 = ( _MotionVariation2 * Packed_Variation1815 );
			half MotionlAmplitude58_g2032 = ( ADS_GlobalAmplitude * _MotionAmplitude2 );
			float3 temp_output_92_0_g2032 = ( sin( ( temp_output_95_0_g2032 + MotionVariation269_g2032 ) ) * MotionlAmplitude58_g2032 );
			half3 GlobalDirection349_g2032 = ADS_GlobalDirection;
			float3 lerpResult280_g2032 = lerp( GlobalDirection349_g2032 , float3(0,1,0) , _MotionVertical2);
			half3 MotionDirection59_g2032 = mul( unity_WorldToObject, float4( lerpResult280_g2032 , 0.0 ) ).xyz;
			half Packed_Branch1830 = v.color.g;
			half ADS_TreeLeavesAffectMotion168_g1870 = 0.2;
			half ADS_TreeLeavesAmount157_g1870 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g1871 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1871 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g1870 = saturate( ( ADS_TreeLeavesAmount157_g1870 - ( frac( ( localunity_ObjectToWorld0w1_g1871 + localunity_ObjectToWorld2w3_g1871 ) ) * ADS_GlobalLeavesVar ) ) );
			half LeavesAmountSimple172_g1870 = temp_output_142_0_g1870;
			float lerpResult156_g1870 = lerp( ADS_TreeLeavesAffectMotion168_g1870 , 1.0 , LeavesAmountSimple172_g1870);
			half MotionMask137_g2032 = ( Packed_Branch1830 * lerpResult156_g1870 );
			float3 temp_output_94_0_g2032 = ( ( temp_output_92_0_g2032 * MotionDirection59_g2032 ) * MotionMask137_g2032 );
			half3 Motion_Branch1750 = temp_output_94_0_g2032;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 break311_g2033 = ase_vertex3Pos;
			half MotionFlutterScale60_g2033 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g2033 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime303_g2033 = _Time.y * MotionFlutterSpeed62_g2033;
			half MotionlFlutterAmplitude58_g2033 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half Packed_Leaf1819 = v.color.b;
			half MotionMask137_g2033 = Packed_Leaf1819;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1751 = ( sin( ( ( ( break311_g2033.x + break311_g2033.y + break311_g2033.z ) * MotionFlutterScale60_g2033 ) + mulTime303_g2033 ) ) * MotionlFlutterAmplitude58_g2033 * MotionMask137_g2033 * ase_vertexNormal );
			float2 temp_cast_4 = (ADS_TurbulenceSpeed).xx;
			half localunity_ObjectToWorld0w1_g2036 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g2036 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g2036 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g2036 = (float3(localunity_ObjectToWorld0w1_g2036 , localunity_ObjectToWorld1w2_g2036 , localunity_ObjectToWorld2w3_g2036));
			float2 panner73_g2034 = ( _Time.y * temp_cast_4 + ( (appendResult6_g2036).xz * ADS_TurbulenceScale ));
			float lerpResult136_g2034 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g2034, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			half Motion_Turbulence1921 = lerpResult136_g2034;
			half3 Motion_Output1220 = ( ( Motion_Trunk1749 + Motion_Branch1750 + Motion_Leaf1751 ) * Motion_Turbulence1921 );
			v.vertex.xyz += Motion_Output1220;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 break17_g2046 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float switchResult12_g2046 = (((i.ASEVFace>0)?(break17_g2046.z):(-break17_g2046.z)));
			float3 appendResult18_g2046 = (float3(break17_g2046.x , break17_g2046.y , switchResult12_g2046));
			half3 Main_NormalTex620 = appendResult18_g2046;
			o.Normal = Main_NormalTex620;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			float4 temp_cast_0 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g2040 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g2040 = ADS_GlobalTintColorTwo;
			half localunity_ObjectToWorld0w1_g2044 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g2044 = ( unity_ObjectToWorld[2].w );
			half Packed_Variation1815 = i.vertexColor.a;
			float lerpResult194_g2040 = lerp( frac( ( localunity_ObjectToWorld0w1_g2044 + localunity_ObjectToWorld2w3_g2044 ) ) , Packed_Variation1815 , _DetailTint);
			float4 lerpResult166_g2040 = lerp( ADS_GlobalTintColorOne176_g2040 , ADS_GlobalTintColorTwo177_g2040 , lerpResult194_g2040);
			half ADS_GlobalTintIntensity181_g2040 = ADS_GlobalTintIntensity;
			half GlobalTint186_g2040 = _GlobalTint;
			float4 lerpResult168_g2040 = lerp( temp_cast_0 , ( lerpResult166_g2040 * ADS_GlobalTintIntensity181_g2040 ) , GlobalTint186_g2040);
			half4 Gloabl_Tint1908 = lerpResult168_g2040;
			o.Albedo = saturate( ( Main_AlbedoTex487 * Main_Color486 * Gloabl_Tint1908 ) ).rgb;
			float2 uv_SurfaceTex645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _SurfaceTex, uv_SurfaceTex645 );
			half Main_SurfaceTex_A744 = tex2DNode645.a;
			half SMOOTHNESS660 = ( Main_SurfaceTex_A744 * _Smoothness );
			o.Smoothness = SMOOTHNESS660;
			half Main_SurfaceTex_G1788 = tex2DNode645.g;
			float lerpResult1793 = lerp( 1.0 , Main_SurfaceTex_G1788 , _Occlusion);
			half Main_Occlusion1794 = lerpResult1793;
			float lerpResult1308 = lerp( 1.0 , i.uv_tex4coord.z , _VertexOcclusion);
			half Vertex_Occlusion1312 = lerpResult1308;
			o.Occlusion = ( Main_Occlusion1794 * Vertex_Occlusion1312 );
			half Main_SurfaceTex_B1836 = tex2DNode645.b;
			half4 OUT_TRANSMISSION1935 = ( Main_SurfaceTex_B1836 * _SubsurfaceColor );
			o.Transmission = ( Vertex_Occlusion1312 * OUT_TRANSMISSION1935 ).rgb;
			o.Alpha = 1;
			half Main_AlbedoTex_A616 = tex2DNode18.a;
			float temp_output_152_0_g2037 = i.uv_tex4coord.w;
			half ADS_TreeLeavesAmount157_g2037 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g2038 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g2038 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g2037 = saturate( ( ADS_TreeLeavesAmount157_g2037 - ( frac( ( localunity_ObjectToWorld0w1_g2038 + localunity_ObjectToWorld2w3_g2038 ) ) * ADS_GlobalLeavesVar ) ) );
			float lerpResult175_g2037 = lerp( 0.0 , ceil( ( temp_output_152_0_g2037 - temp_output_142_0_g2037 ) ) , step( temp_output_152_0_g2037 , 3.0 ));
			half Opacity1306 = saturate( ( Main_AlbedoTex_A616 - lerpResult175_g2037 ) );
			float temp_output_41_0_g2047 = Opacity1306;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen39_g2047 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither39_g2047 = Dither4x4Bayer( fmod(clipScreen39_g2047.x, 4), fmod(clipScreen39_g2047.y, 4) );
			float temp_output_47_0_g2047 = max( unity_LODFade.x , step( unity_LODFade.x , 0.0 ) );
			dither39_g2047 = step( dither39_g2047, temp_output_47_0_g2047 );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch40_g2047 = ( temp_output_41_0_g2047 * dither39_g2047 );
			#else
				float staticSwitch40_g2047 = temp_output_41_0_g2047;
			#endif
			#ifdef ADS_LODFADE_DITHER
				float staticSwitch50_g2047 = staticSwitch40_g2047;
			#else
				float staticSwitch50_g2047 = temp_output_41_0_g2047;
			#endif
			clip( staticSwitch50_g2047 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16800
1927;29;1906;1014;644.6513;2963.171;1;True;False
Node;AmplifyShaderEditor.VertexColorNode;1804;-1280,768;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1808;-1024,1072;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1815;-1024,1216;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1830;-1024,848;Half;False;Packed_Branch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1809;-832,1088;Half;False;Packed_Trunk2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1819;-1024,928;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1637;-384,1152;Float;False;1809;Packed_Trunk2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1930;-384,1280;Float;False;ADS Leaves Amount;-1;;1872;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.GetLocalVarNode;1712;896,1168;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1732;896,1088;Float;False;Property;_MotionVariation2;Branch Motion Variation;41;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1820;896,1264;Float;False;1830;Packed_Branch;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1929;896,1360;Float;False;ADS Leaves Amount;-1;;1870;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1892;0,1152;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1562;896,848;Float;False;Property;_MotionSpeed2;Branch Motion Speed;39;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1555;-384,768;Float;False;Property;_MotionAmplitude;Trunk Motion Amplitude;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1715;2240,848;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;46;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1714;2240,928;Float;False;Property;_MotionScale3;Leaf Flutter Scale;47;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1722;2240,1024;Float;False;1819;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1556;-384,848;Float;False;Property;_MotionSpeed;Trunk Motion Speed;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1563;896,768;Float;False;Property;_MotionAmplitude2;Branch Motion Amplitude;38;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1903;896,1008;Float;False;Property;_MotionVertical2;Branch Motion Vertical;42;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1716;2240,768;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;45;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-896;Float;True;Property;_AlbedoTex;Leaf Albedo;9;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1895;1344,1264;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1557;-384,928;Float;False;Property;_MotionScale;Trunk Motion Scale;35;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1561;896,928;Float;False;Property;_MotionScale2;Branch Motion Scale;40;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1733;1152,1088;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1924;-1280,-32;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;645;1536,-896;Float;True;Property;_SurfaceTex;Leaf Surface;12;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1919;2560,768;Float;False;ADS Motion Flutter;-1;;2033;87d8028e5f83178498a65cfa9f0e9ace;1,312,0;5;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;310;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1942;256,768;Float;False;ADS Motion Generic;30;;2031;81cab27e2a487a645a4ff5eb3c63bd27;6,252,0,278,0,228,0,292,0,330,0,326,0;8;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;279;FLOAT;0;False;342;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1943;1536,768;Float;False;ADS Motion Generic;30;;2032;81cab27e2a487a645a4ff5eb3c63bd27;6,252,1,278,1,228,1,292,1,330,1,326,1;8;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;279;FLOAT;0;False;342;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;1920,-832;Half;False;Main_SurfaceTex_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1751;2816,768;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1888;-1280,-128;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1749;512,768;Half;False;Motion_Trunk;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1905;-1280,1920;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1920;-1280,1344;Float;False;ADS Global Turbulence;19;;2034;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1750;1856,768;Half;False;Motion_Branch;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1931;-1008,0;Float;False;ADS Leaves Amount;-1;;2037;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.RegisterLocalVarNode;1836;1920,-768;Half;False;Main_SurfaceTex_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1901;0,-128;Float;False;const;-1;;2039;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1906;-1024,1920;Float;False;ADS Global Settings;23;;2040;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.GetLocalVarNode;1796;3200,864;Float;False;1750;Motion_Branch;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1933;3200,-800;Half;False;Property;_SubsurfaceColor;Leaf Subsurface (B);15;0;Create;False;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1902;895.382,-127.3066;Float;False;const;-1;;2045;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1921,-704;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1797;3200,960;Float;False;1751;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;896,192;Half;False;Property;_Occlusion;Leaf Occlusion (G);14;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1921;-1024,1344;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1889;-608,-128;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1752;3200,768;Float;False;1749;Motion_Trunk;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;0,192;Half;False;Property;_VertexOcclusion;Vertex Occlusion;28;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;384,-896;Half;False;Property;_NormalScale;Leaf Normal Scale;10;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;896,0;Float;False;1788;Main_SurfaceTex_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-384,-896;Half;False;Property;_Color;Leaf Color;8;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1932;3200,-896;Float;False;1836;Main_SurfaceTex_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1814;0,0;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;294;2304,-816;Half;False;Property;_Smoothness;Leaf Smoothness (A);13;0;Create;False;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1922;3200,1056;Float;False;1921;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;2304,-896;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1890;-464,-128;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1801;3584,768;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;607;656,-896;Float;True;Property;_NormalTex;Leaf Normal;11;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1908;-704,1920;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1793;1280,-128;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-128,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1934;3520,-896;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1308;384,-128;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;1472,-128;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;-320,-128;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;576,-128;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1629;3776,768;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2048;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-1280,-1984;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1939;960,-896;Float;False;Normal BackFace;-1;;2046;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1935;3712,-896;Half;False;OUT_TRANSMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1914;-1280,-1920;Float;False;1908;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2624,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1783;-1280,-1488;Float;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1937;-1280,-1584;Float;False;1935;OUT_TRANSMISSION;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1800;-1280,-1712;Float;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;1200,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2816,-896;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1220;3936,768;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;-1280,-1648;Float;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;-768,-2048;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;-1088,-3232;Half;False;Property;_LEAFF;[ LEAFF ];7;0;Create;True;0;0;True;1;BCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1473;-80,-3232;Half;False;Property;_LEAFMOTIONN;[ LEAF MOTIONN ];43;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;-736,-3232;Half;False;Property;_SETTINGSS;[ SETTINGSS ];18;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1837;1168,-2560;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;63;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;-1280,-3328;Half;False;Property;_ADSStandardLitTreeLeaf;< ADS Standard Lit Tree Leaf >;2;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Tree Leaf);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1842;928,-2560;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;61;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-624,-2560;Half;False;Property;_RenderFaces;Render Faces;5;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1918;-368,-3040;Half;False;Property;_BatchingInfo;!!! BatchingInfo;49;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1470;-544,-3232;Half;False;Property;_TRUNKMOTIONN;[ TRUNK MOTIONN ];29;0;Create;True;0;0;True;1;BCategory(Trunk Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1898;-1024,-1712;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1897;1888,-2560;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;66;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1221;-1024,-1408;Float;False;1220;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1838;1408,-2560;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;64;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1938;-1024,-1616;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1944;240,-2560;Float;False;ADS Internal Version;0;;2050;858e1f7f7bf8673449834f9aaa5bae83;0;0;1;FLOAT;5
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;1920,-896;Half;False;Main_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1799;-1280,-3136;Half;False;Property;_EnableBlendingg;# EnableBlendingg;17;0;Create;True;0;0;False;1;BInteractive(_ENABLEBLENDING_ON);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1865;-1024,768;Half;False;Packed_Trunk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1708;-976,-3040;Half;False;Property;_BranchMotionParameters;!!! Branch Motion Parameters !!!;37;0;Create;True;0;0;True;1;BMessage(Info, The Branch Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1846;0,-2560;Float;False;Internal Unity Props;51;;2049;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1896;480,-2560;Half;False;Property;_Internal_ADS;Internal_ADS;50;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1923;-384,1024;Float;False;1921;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1856;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;-1280,-3232;Half;False;Property;_RENDERINGG;[ RENDERINGG ];3;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1845;1648,-2560;Half;False;Property;_Internal_DebugMask3;Internal_DebugMask3;65;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1941;-1024,-1488;Float;False;ADS LODFade Dither;-1;;2047;f1eaf6a5452c7c7458970a3fc3fa22c1;1,44,0;1;41;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2560;Half;False;Property;_SrcBlend;_SrcBlend;68;1;[HideInInspector];Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1724;-674,-3040;Half;False;Property;_LeafMtionParameters;!!! Leaf Mtion Parameters !!!;44;0;Create;True;0;0;True;1;BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1723;-1280,-3040;Half;False;Property;_TrunkMotionParameters;!!! Trunk Motion Parameters !!!;32;0;Create;True;0;0;True;1;BMessage(Info, The Trunk Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2560;Half;False;Property;_ZWrite;_ZWrite;70;1;[HideInInspector];Create;True;2;Off;0;On;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2560;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1471;160,-3232;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];48;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1839;2144,-2560;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;67;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1792;Float;False;660;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2560;Half;False;Property;_DstBlend;_DstBlend;69;1;[HideInInspector];Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1940;2400,-2560;Float;False;ADS Features Support;-1;;2048;217a332a46517ae4cb8ca16677bdb217;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1513;-928,-3232;Half;False;Property;_BLENDINGG;[ BLENDINGG ];16;0;Create;True;0;0;False;1;BCategory(Trunk Blending);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-800,-2560;Half;False;Property;_RenderType;Render Type;4;1;[Enum];Create;True;2;Opaque;0;Cutout;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1841;672,-2560;Half;False;Property;_Internal_TypeTreeLeaf;Internal_TypeTreeLeaf;62;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1688;-320,-3232;Half;False;Property;_BRANCHMOTIONN;[ BRANCH MOTIONN ];36;0;Create;True;0;0;True;1;BCategory(Branch Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1343;-576,-2048;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;-128,-800;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Tree Leaf;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2688;Float;False;1104;100;Rendering (Unused);0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;2304,-1024;Float;False;709.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1913;-1280,1792;Float;False;772.918;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1543;-1280,-256;Float;False;1155.176;100;Leaf Amount;0;;0.5,0.5,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1465;-1280,-3456;Float;False;1614.13;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1536,-1024;Float;False;638;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1544;0,-256;Float;False;1668.041;100;Ambient Occlusion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Float;False;1364.434;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1542;-1280,640;Float;False;5413.799;100;Tree Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1936;3200,-1024;Float;False;770.26;100;Transmission;0;;0.7843137,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;384,-1024;Float;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1844;0,-2688;Float;False;2622.372;100;Internal Only;0;;1,0,0,1;0;0
WireConnection;1808;0;1804;1
WireConnection;1808;1;1804;1
WireConnection;1815;0;1804;4
WireConnection;1830;0;1804;2
WireConnection;1809;0;1808;0
WireConnection;1819;0;1804;3
WireConnection;1892;0;1637;0
WireConnection;1892;1;1930;148
WireConnection;1895;0;1820;0
WireConnection;1895;1;1929;148
WireConnection;1733;0;1732;0
WireConnection;1733;1;1712;0
WireConnection;1919;220;1716;0
WireConnection;1919;221;1715;0
WireConnection;1919;222;1714;0
WireConnection;1919;136;1722;0
WireConnection;1942;220;1555;0
WireConnection;1942;221;1556;0
WireConnection;1942;222;1557;0
WireConnection;1942;136;1892;0
WireConnection;1943;220;1563;0
WireConnection;1943;221;1562;0
WireConnection;1943;222;1561;0
WireConnection;1943;218;1733;0
WireConnection;1943;136;1895;0
WireConnection;1943;279;1903;0
WireConnection;616;0;18;4
WireConnection;1788;0;645;2
WireConnection;1751;0;1919;0
WireConnection;1749;0;1942;0
WireConnection;1750;0;1943;0
WireConnection;1931;152;1924;4
WireConnection;1836;0;645;3
WireConnection;1906;171;1905;0
WireConnection;744;0;645;4
WireConnection;1921;0;1920;85
WireConnection;1889;0;1888;0
WireConnection;1889;1;1931;154
WireConnection;1890;0;1889;0
WireConnection;1801;0;1752;0
WireConnection;1801;1;1796;0
WireConnection;1801;2;1797;0
WireConnection;607;5;655;0
WireConnection;1908;0;1906;165
WireConnection;1793;0;1902;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;486;0;409;0
WireConnection;487;0;18;0
WireConnection;1934;0;1932;0
WireConnection;1934;1;1933;0
WireConnection;1308;0;1901;0
WireConnection;1308;1;1814;3
WireConnection;1308;2;1309;0
WireConnection;1794;0;1793;0
WireConnection;1306;0;1890;0
WireConnection;1312;0;1308;0
WireConnection;1629;0;1801;0
WireConnection;1629;1;1922;0
WireConnection;1939;13;607;0
WireConnection;1935;0;1934;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;620;0;1939;0
WireConnection;660;0;745;0
WireConnection;1220;0;1629;0
WireConnection;1075;0;36;0
WireConnection;1075;1;1076;0
WireConnection;1075;2;1914;0
WireConnection;1898;0;1800;0
WireConnection;1898;1;1313;0
WireConnection;1938;0;1313;0
WireConnection;1938;1;1937;0
WireConnection;646;0;645;1
WireConnection;1865;0;1804;1
WireConnection;1941;41;1783;0
WireConnection;1343;0;1075;0
WireConnection;1057;0;409;4
WireConnection;0;0;1343;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;5;1898;0
WireConnection;0;6;1938;0
WireConnection;0;10;1941;0
WireConnection;0;11;1221;0
ASEEND*/
//CHKSM=4F89429F1BE7226D77A60CF31AFEC422722A6224