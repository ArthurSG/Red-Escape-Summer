// Upgrade NOTE: upgraded instancing buffer 'BlackSunshader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Black Sun shader"
{
	Properties
	{
		_Amount_Add("Amount_Add", Float) = 2
		_F_Bias("F_Bias", Range( 0 , 2)) = 0
		_F_Scale("F_Scale", Range( 0 , 20)) = 1.632327
		[HDR]_Color0("Color 0", Color) = (1,0,0,1)
		_F_Power("F_Power", Range( 0 , 20)) = 9.361637
		_Opacity("Opacity", Range( 0 , 10)) = 2.411765
		_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma multi_compile_instancing
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color0;
		uniform float _F_Bias;
		uniform float _F_Scale;
		uniform float _F_Power;
		uniform float _Opacity;

		UNITY_INSTANCING_BUFFER_START(BlackSunshader)
			UNITY_DEFINE_INSTANCED_PROP(float, _Amount_Add)
#define _Amount_Add_arr BlackSunshader
		UNITY_INSTANCING_BUFFER_END(BlackSunshader)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float _Amount_Add_Instance = UNITY_ACCESS_INSTANCED_PROP(_Amount_Add_arr, _Amount_Add);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV20 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode20 = ( _F_Bias + _F_Scale * pow( 1.0 - fresnelNdotV20, _F_Power ) );
			float4 temp_output_52_0 = saturate( ( ( tex2D( _MainTex, uv_MainTex ) * 0.0 ) + ( _Amount_Add_Instance * ( _Color0 * fresnelNode20 ) ) ) );
			o.Albedo = temp_output_52_0.rgb;
			o.Emission = temp_output_52_0.rgb;
			float2 temp_cast_2 = (0.0).xx;
			float2 temp_cast_3 = (1.0).xx;
			float2 temp_cast_4 = (-1.0).xx;
			float2 temp_cast_5 = (1.0).xx;
			o.Alpha = ( ( 1.0 - length( (temp_cast_4 + (i.uv_texcoord - temp_cast_2) * (temp_cast_5 - temp_cast_4) / (temp_cast_3 - temp_cast_2)) ) ) * _Opacity );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;73;482;802;1416.417;-459.8454;3.523561;True;False
Node;AmplifyShaderEditor.RangedFloatNode;24;-2753.596,2096.653;Float;True;Property;_F_Scale;F_Scale;2;0;Create;True;0;0;False;0;1.632327;1.473789;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2746.263,1871.698;Float;True;Property;_F_Bias;F_Bias;1;0;Create;True;0;0;False;0;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2741.861,2368.363;Float;True;Property;_F_Power;F_Power;4;0;Create;True;0;0;False;0;9.361637;3.544535;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;20;-2204.382,2119.304;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-1971.812,2408.6;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-1686.247,2680.379;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-954.6807,1776.236;Float;False;Property;_Color0;Color 0;3;1;[HDR];Create;True;0;0;False;0;1,0,0,1;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-1680.691,2399.816;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-1687.636,2490.096;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1701.525,2580.377;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-624.684,1833.031;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;75;-966.796,1216.015;Float;True;Property;_MainTex;_MainTex;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-481.5944,1688.83;Float;False;InstancedProperty;_Amount_Add;Amount_Add;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;59;-1505.706,2431.048;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-722.6631,1498.496;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-233.4968,1714.174;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LengthOpNode;64;-1132.311,2349.369;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-525.5021,1425.391;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;42;-681.1415,2069.119;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-284.9065,2192.925;Float;False;Property;_Opacity;Opacity;5;0;Create;True;0;0;False;0;2.411765;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;-190.0954,1353.464;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-24.10647,2015.326;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;32.55387,1639.015;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;531.6008,1459.692;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Black Sun shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;1.6;1,1,1,1;VertexScale;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;1;43;0
WireConnection;20;2;24;0
WireConnection;20;3;27;0
WireConnection;29;0;28;0
WireConnection;29;1;20;0
WireConnection;59;0;58;0
WireConnection;59;1;62;0
WireConnection;59;2;63;0
WireConnection;59;3;60;0
WireConnection;59;4;61;0
WireConnection;36;0;35;0
WireConnection;36;1;29;0
WireConnection;64;0;59;0
WireConnection;76;0;75;0
WireConnection;76;1;77;0
WireConnection;42;0;64;0
WireConnection;78;0;76;0
WireConnection;78;1;36;0
WireConnection;56;0;42;0
WireConnection;56;1;57;0
WireConnection;52;0;78;0
WireConnection;0;0;52;0
WireConnection;0;2;52;0
WireConnection;0;9;56;0
ASEEND*/
//CHKSM=4699CA07D8F34D350A15B5490D8D3353D790E310