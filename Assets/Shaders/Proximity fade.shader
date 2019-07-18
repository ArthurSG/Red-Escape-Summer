// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Proximity fade"
{
	Properties
	{
		_Distance("Distance", Float) = 5
		_Range("Range", Vector) = (4,4,0,0)
		_Albedo("Albedo", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Albedo;
		uniform float _Distance;
		uniform float2 _Range;


		float2 MyCustomExpression81( float In1 , float In2 , float In3 , float2 _UV , float In0 )
		{
			 float2x2 rMatrix = float2x2(In0, -In1, In2, In3);
			    rMatrix *= 0.5;
			    rMatrix += 0.5;
			rMatrix = rMatrix * 2 - 1;
			return mul(_UV.xy, rMatrix);
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Albedo.rgb;
			float temp_output_67_0 = ( 180.0 * ( UNITY_PI / 180.0 ) );
			float temp_output_71_0 = sin( temp_output_67_0 );
			float In181 = temp_output_71_0;
			float In281 = temp_output_71_0;
			float temp_output_73_0 = cos( temp_output_67_0 );
			float In381 = temp_output_73_0;
			float3 ase_worldPos = i.worldPos;
			float temp_output_4_0 = (0.0 + (distance( ase_worldPos , _WorldSpaceCameraPos ) - 0.0) * (1.0 - 0.0) / (_Distance - 0.0));
			float2 appendResult34 = (float2(temp_output_4_0 , temp_output_4_0));
			float2 temp_output_44_0 = ( appendResult34 - _Range );
			float dotResult46 = dot( temp_output_44_0 , temp_output_44_0 );
			float2 appendResult12 = (float2(temp_output_4_0 , temp_output_4_0));
			float2 temp_cast_1 = (1.0).xx;
			float2 appendResult25 = (float2(_ScreenParams.z , _ScreenParams.w));
			float temp_output_11_0 = length( ( ( ( appendResult12 * 2.0 ) - temp_cast_1 ) / appendResult25 ) );
			float temp_output_28_0 = saturate( ( ( 1.0 - temp_output_11_0 ) / fwidth( temp_output_11_0 ) ) );
			float2 appendResult43 = (float2(temp_output_28_0 , temp_output_28_0));
			float2 _Vector1 = float2(1,1);
			float2 _UV81 = ( ( ( appendResult34 + ( temp_output_44_0 * ( ( dotResult46 * dotResult46 ) * float2( 20,20 ) ) ) ) + appendResult43 ) - _Vector1 );
			float In081 = temp_output_73_0;
			float2 localMyCustomExpression81 = MyCustomExpression81( In181 , In281 , In381 , _UV81 , In081 );
			o.Alpha = ( localMyCustomExpression81 + _Vector1 ).x;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;73;793;804;-38.0321;-237.3332;1;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-2720.156,-223.5144;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;2;-2801.617,18.67981;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;9;-2401.62,-10.32744;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;26;-2021.559,221.0926;Float;False;1946.533;797.6882;Ellipse;15;28;32;31;30;29;20;11;19;23;22;24;25;13;14;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;3;-2398.567,-117.1965;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2403.147,70.58765;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2735.969,295.0125;Float;False;Property;_Distance;Distance;0;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2400.093,160.663;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;13;-1971.559,271.0926;Float;False;217;183;UV;1;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;4;-2201.623,41.58033;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;-1953.62,487.5034;Float;False;179.3884;199.2356;Width;1;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1713.391,379.6507;Float;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;15;-1961.709,748.7565;Float;False;180.687;238.3206;Height;1;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1921.56,321.0927;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;56;125.0335,200.5276;Float;False;2457.013;1010.994;Spherize;9;55;51;49;47;45;40;38;35;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenParams;16;-2457.3,560.6229;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;41;-262.8687,30.51262;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1561.897,300.6102;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1472.977,429.051;Float;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;17;-1910.993,608.5383;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;35;175.0335,527.7813;Float;False;253.3921;231.4789;Center;1;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RelayNode;18;-1914.254,852.3436;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;33;187.8161,253.8674;Float;False;205.9136;187.6526;UV;1;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-1341.242,302.257;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;235.2946,317.7806;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;36;234.869,595.3469;Float;False;Property;_Range;Range;1;0;Create;True;0;0;False;0;4,4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;45;585.3942,259.7373;Float;False;224;183;Delta;1;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-1487.796,651.3519;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;47;912.4209,261.2657;Float;False;204.0001;183;Delta2;1;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;635.3942,309.7373;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-1123.881,325.3105;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;11;-919.1853,339.0534;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-834.0178,252.97;Float;False;Constant;_Float5;Float 5;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;38;180.1249,815.3616;Float;False;225;165;Stength;1;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;46;962.4209,311.2657;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;49;1199.618,250.5276;Float;False;219;183;Delta4;1;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;51;1536.437,251.4964;Float;False;219;183;Delta_Offset;1;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FWidthOpNode;32;-656.176,478.5648;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;42;231.7947,855.1146;Float;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;20,20;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1249.618,300.5276;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-677.5839,295.7836;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;1586.437,301.4963;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-458.5753,305.6637;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;55;1905.505,672.3721;Float;False;626.5413;392.3648;Out;3;53;52;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;40;177.9901,1011.001;Float;False;237;211;Offset;1;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;68;3060.035,585.8684;Float;False;631.7371;369.6032;Rotation;4;65;66;64;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1955.505,722.3721;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;28;-262.1151,309.6747;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;2133.855,896.4773;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;63;2805.048,802.1819;Float;False;225;165;Rotation;1;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PiNode;65;3110.035,635.8684;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;260.327,1078.522;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;66;3147.462,741.3431;Float;False;Constant;_Float7;Float 7;2;0;Create;True;0;0;False;0;180;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;59;2804.159,298.5192;Float;False;204;160;UV;1;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;61;2785.252,522.5367;Float;False;237;211;Center;1;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;2378.046,931.7369;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;2855.048,852.1819;Float;False;Constant;_Float6;Float 6;2;0;Create;True;0;0;False;0;180;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;64;3352.391,677.7613;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;70;3100.278,301.9006;Float;False;224;183;UV;1;69;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;72;3761.359,683.6878;Float;False;204;160;s;1;71;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;3528.23,726.0496;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;58;2854.159,348.5192;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;74;3768.896,874.9886;Float;False;204;160;c;1;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;60;2835.252,572.5367;Float;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CosOpNode;73;3818.896,924.9886;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;84;4028.441,628.387;Float;False;517.1204;369.0663;Expression;3;81;82;83;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;71;3814.998,733.6878;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;69;3150.278,351.9006;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;81;4078.441,678.387;Float;False; float2x2 rMatrix = float2x2(In0, -In1, In2, In3)@$    rMatrix *= 0.5@$    rMatrix += 0.5@$rMatrix = rMatrix * 2 - 1@$return mul(_UV.xy, rMatrix)@;2;False;5;True;In1;FLOAT;0;In;float2x2;True;In2;FLOAT;0;In;;True;In3;FLOAT;0;In;;True;_UV;FLOAT2;0,0;In;;True;In0;FLOAT;0;In;;My Custom Expression;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RelayNode;83;4151.738,887.4533;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;86;4345.745,361.6916;Float;False;Property;_Albedo;Albedo;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;82;4391.561,701.9432;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4745.995,417.1556;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Proximity fade;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;4;0;3;0
WireConnection;4;1;9;0
WireConnection;4;2;5;0
WireConnection;4;3;10;0
WireConnection;4;4;8;0
WireConnection;12;0;4;0
WireConnection;12;1;4;0
WireConnection;41;0;4;0
WireConnection;19;0;12;0
WireConnection;19;1;20;0
WireConnection;17;0;16;3
WireConnection;18;0;16;4
WireConnection;22;0;19;0
WireConnection;22;1;23;0
WireConnection;34;0;41;0
WireConnection;34;1;41;0
WireConnection;25;0;17;0
WireConnection;25;1;18;0
WireConnection;44;0;34;0
WireConnection;44;1;36;0
WireConnection;24;0;22;0
WireConnection;24;1;25;0
WireConnection;11;0;24;0
WireConnection;46;0;44;0
WireConnection;46;1;44;0
WireConnection;32;0;11;0
WireConnection;48;0;46;0
WireConnection;48;1;46;0
WireConnection;29;0;30;0
WireConnection;29;1;11;0
WireConnection;50;0;48;0
WireConnection;50;1;42;0
WireConnection;31;0;29;0
WireConnection;31;1;32;0
WireConnection;53;0;44;0
WireConnection;53;1;50;0
WireConnection;28;0;31;0
WireConnection;52;0;34;0
WireConnection;52;1;53;0
WireConnection;43;0;28;0
WireConnection;43;1;28;0
WireConnection;54;0;52;0
WireConnection;54;1;43;0
WireConnection;64;0;65;0
WireConnection;64;1;66;0
WireConnection;67;0;62;0
WireConnection;67;1;64;0
WireConnection;58;0;54;0
WireConnection;73;0;67;0
WireConnection;71;0;67;0
WireConnection;69;0;58;0
WireConnection;69;1;60;0
WireConnection;81;0;71;0
WireConnection;81;1;71;0
WireConnection;81;2;73;0
WireConnection;81;3;69;0
WireConnection;81;4;73;0
WireConnection;83;0;60;0
WireConnection;82;0;81;0
WireConnection;82;1;83;0
WireConnection;0;0;86;0
WireConnection;0;9;82;0
ASEEND*/
//CHKSM=3397410AFF8AA9B5DFEF180AA47079682988DF94