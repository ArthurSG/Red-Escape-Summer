// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Black Sun shader"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "white" {}
		_Float10("Float 10", Range( -5 , 10)) = 0
		_Float9("Float 9", Range( 0 , 10)) = 2.033381
		[HDR]_Color1("Color 1", Color) = (1,0.8219881,0,0)
		[HDR]_Color2("Color 2", Color) = (1,0.06575368,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color1;
		uniform float _Float10;
		uniform float _Float9;
		uniform float4 _Color2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 temp_cast_0 = (0.0).xx;
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (-1.0).xx;
			float2 temp_cast_3 = (1.0).xx;
			float temp_output_42_0 = ( 1.0 - length( (temp_cast_2 + (i.uv_texcoord - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) ) );
			float temp_output_97_0 = ( (0.47 + (sin( ( ( _Time.y + 5.7 ) / 4.5 ) ) - -1.0) * (10.0 - 0.47) / (1.0 - -1.0)) * temp_output_42_0 );
			float smoothstepResult101 = smoothstep( _Float10 , _Float9 , temp_output_97_0);
			o.Albedo = saturate( ( ( ( tex2D( _MainTex, uv_MainTex ) * 0.0 ) + ( ( _Color1 * temp_output_97_0 ) * ( 1.0 - ( (0.9 + (sin( ( ( _Time.y + 15.0 ) / 3.5 ) ) - -1.0) * (1.17 - 0.9) / (1.0 - -1.0)) * smoothstepResult101 ) ) ) ) + ( _Color2 * smoothstepResult101 ) ) ).rgb;
			float temp_output_56_0 = ( temp_output_42_0 * (2.3 + (sin( ( ( _Time.y + 2.0 ) / 4.1 ) ) - -1.0) * (7.2 - 2.3) / (1.0 - -1.0)) );
			float smoothstepResult81 = smoothstep( 0.0 , 3.0 , temp_output_56_0);
			float smoothstepResult85 = smoothstep( 3.0 , 4.0 , temp_output_56_0);
			float temp_output_86_0 = ( smoothstepResult81 + smoothstepResult85 );
			o.Alpha = temp_output_86_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;73;704;804;285.585;-667.8962;1.550863;False;False
Node;AmplifyShaderEditor.CommentaryNode;167;-2244.008,1613.847;Float;False;1371.617;679.0343;Circle1;12;164;158;162;161;160;144;159;143;142;145;141;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;180;-2282.826,1004.77;Float;False;1388.448;601.8998;Circle 2;12;168;169;170;171;172;173;174;175;176;177;178;115;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;158;-2194.008,1896.067;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-2047.941,2086.305;Float;False;Constant;_Float23;Float 23;8;0;Create;True;0;0;False;0;5.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-2415.579,2980.567;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-2145.292,3152.344;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2124.459,2971.783;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-2130.015,3252.346;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-2131.404,3062.063;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-1931.987,2177.882;Float;False;Constant;_Float14;Float 14;8;0;Create;True;0;0;False;0;4.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;169;-2232.826,1209.855;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-2086.759,1400.093;Float;False;Constant;_Float24;Float 24;8;0;Create;True;0;0;False;0;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;162;-1935.711,1941.725;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-1974.529,1255.513;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;160;-1789.141,1987.69;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-1970.805,1491.67;Float;False;Constant;_Float25;Float 25;8;0;Create;True;0;0;False;0;3.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;59;-1949.474,3003.015;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;64;-1629.771,2859.167;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;159;-1634.225,1925.155;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-1420.225,2118.185;Float;False;Constant;_Float17;Float 17;11;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-1337.025,1815.284;Float;False;Constant;_Float13;Float 13;11;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-1363.025,1988.185;Float;False;Constant;_Float16;Float 16;11;0;Create;True;0;0;False;0;0.47;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;172;-1827.959,1301.478;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1335.725,1910.185;Float;False;Constant;_Float15;Float 15;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;141;-1166.391,1862.097;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-1401.843,1301.973;Float;False;Constant;_Float26;Float 26;11;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;42;-1351.218,2794.478;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-1374.543,1223.973;Float;False;Constant;_Float27;Float 27;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;174;-1673.043,1238.943;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-1459.043,1431.973;Float;False;Constant;_Float29;Float 29;11;0;Create;True;0;0;False;0;1.17;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;192;-1663.792,3216.738;Float;False;1371.617;594.2471;Opacity;12;181;182;183;184;185;186;187;188;189;190;191;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-1375.843,1129.072;Float;False;Constant;_Float28;Float 28;11;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;178;-1205.209,1175.885;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;182;-1613.792,3414.17;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-1467.725,3604.408;Float;False;Constant;_Float30;Float 30;8;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-722.828,1667.854;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-748.9605,1925.627;Float;False;Property;_Float9;Float 9;3;0;Create;True;0;0;False;0;2.033381;3.12;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-558.4677,1758.375;Float;False;Property;_Float10;Float 10;2;0;Create;True;0;0;False;0;0;-3.79;-5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;179;-390.9355,1587.508;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;101;-199.2785,1727.246;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-1351.771,3695.985;Float;False;Constant;_Float31;Float 31;8;0;Create;True;0;0;False;0;4.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;183;-1355.495,3459.828;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;93;-815.843,1339.223;Float;False;Property;_Color1;Color 1;4;1;[HDR];Create;True;0;0;False;0;1,0.8219881,0,0;0.7490196,0.7137255,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;99.13507,1678.663;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;185;-1208.925,3505.793;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-756.8086,3333.387;Float;False;Constant;_Float34;Float 34;11;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;187;-1054.009,3443.258;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-755.5085,3428.288;Float;False;Constant;_Float33;Float 33;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;-840.0085,3636.288;Float;False;Constant;_Float35;Float 35;11;0;Create;True;0;0;False;0;7.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;112;67.01219,1550.831;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-412.464,1269.97;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;75;-402.7116,652.7358;Float;True;Property;_MainTex;_MainTex;1;0;Create;True;0;0;False;0;None;b3d940e75e1f5d24684cd93a2758e1bf;True;0;True;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;77;-223.0057,954.0091;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;186;-782.8086,3506.288;Float;False;Constant;_Float32;Float 32;11;0;Create;True;0;0;False;0;2.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;191;-586.1746,3380.2;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;103;-170.8779,1384.74;Float;False;Property;_Color2;Color 2;5;1;[HDR];Create;True;0;0;False;0;1,0.06575368,0,0;48.50293,1.166037E-05,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;87.47393,1193.644;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-25.84425,880.9037;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;193;313.0483,992.0267;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;80;168.4457,2769.729;Float;False;Constant;_Float4;Float 4;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;158.1293,2916.738;Float;False;Constant;_Float5;Float 5;7;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;234.7472,1518.511;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-82.80893,3229.917;Float;False;Constant;_Float8;Float 8;7;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-93.12532,3376.926;Float;False;Constant;_Float7;Float 7;7;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-91.25752,2702.338;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;106;457.4104,1233.654;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;81;327.0397,2645.377;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;85;113.2038,3140.937;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1053.143,3266.738;Float;False;Property;_Opacity;Opacity;0;0;Create;True;0;0;False;0;2.411765;7.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;86;614.6022,2704.914;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-1500.818,1663.847;Float;False;Property;_Circle1;Circle 1;6;0;Create;True;0;0;False;0;3;3.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;117;341.404,3255.418;Float;True;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;154;-672.2459,2481.864;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;-358.5328,2121.595;Float;False;Constant;_Float19;Float 19;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-385.8327,2199.595;Float;False;Constant;_Float21;Float 21;11;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;151;-127.6517,2064.642;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;130.2748,1969.849;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-1090.379,1054.77;Float;False;Property;_Circle2;Circle 2;7;0;Create;True;0;0;False;0;0;0.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;708.2007,1513.28;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;1038.412,2657.38;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;126;798.6585,3027.146;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-443.0327,2329.595;Float;False;Constant;_Float20;Float 20;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;157;-886.2413,2536.936;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;628.098,3344.396;Float;False;Constant;_Float11;Float 11;11;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;155;-1062.473,2485.011;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;123;562.0797,3082.949;Float;False;Constant;_Float12;Float 12;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-359.8326,2026.694;Float;False;Constant;_Float18;Float 18;11;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-1045.165,2643.934;Float;False;Constant;_Float22;Float 22;11;0;Create;True;0;0;False;0;5.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1528.07,1789.215;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Black Sun shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;4;1;False;-1;1;False;-1;-1;False;-1;3;False;-1;0;False;1.6;1,1,1,1;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;162;0;158;0
WireConnection;162;1;164;0
WireConnection;170;0;169;0
WireConnection;170;1;168;0
WireConnection;160;0;162;0
WireConnection;160;1;161;0
WireConnection;59;0;58;0
WireConnection;59;1;62;0
WireConnection;59;2;63;0
WireConnection;59;3;60;0
WireConnection;59;4;61;0
WireConnection;64;0;59;0
WireConnection;159;0;160;0
WireConnection;172;0;170;0
WireConnection;172;1;171;0
WireConnection;141;0;159;0
WireConnection;141;1;142;0
WireConnection;141;2;143;0
WireConnection;141;3;144;0
WireConnection;141;4;145;0
WireConnection;42;0;64;0
WireConnection;174;0;172;0
WireConnection;178;0;174;0
WireConnection;178;1;176;0
WireConnection;178;2;175;0
WireConnection;178;3;173;0
WireConnection;178;4;177;0
WireConnection;97;0;141;0
WireConnection;97;1;42;0
WireConnection;179;0;178;0
WireConnection;101;0;97;0
WireConnection;101;1;100;0
WireConnection;101;2;99;0
WireConnection;183;0;182;0
WireConnection;183;1;181;0
WireConnection;114;0;179;0
WireConnection;114;1;101;0
WireConnection;185;0;183;0
WireConnection;185;1;184;0
WireConnection;187;0;185;0
WireConnection;112;0;114;0
WireConnection;102;0;93;0
WireConnection;102;1;97;0
WireConnection;191;0;187;0
WireConnection;191;1;189;0
WireConnection;191;2;188;0
WireConnection;191;3;186;0
WireConnection;191;4;190;0
WireConnection;111;0;102;0
WireConnection;111;1;112;0
WireConnection;76;0;75;0
WireConnection;76;1;77;0
WireConnection;193;0;76;0
WireConnection;193;1;111;0
WireConnection;104;0;103;0
WireConnection;104;1;101;0
WireConnection;56;0;42;0
WireConnection;56;1;191;0
WireConnection;106;0;193;0
WireConnection;106;1;104;0
WireConnection;81;0;56;0
WireConnection;81;1;80;0
WireConnection;81;2;82;0
WireConnection;85;0;56;0
WireConnection;85;1;84;0
WireConnection;85;2;83;0
WireConnection;86;0;81;0
WireConnection;86;1;85;0
WireConnection;154;0;157;0
WireConnection;151;0;154;0
WireConnection;151;1;147;0
WireConnection;151;2;148;0
WireConnection;151;3;150;0
WireConnection;151;4;149;0
WireConnection;153;0;179;0
WireConnection;153;1;151;0
WireConnection;52;0;106;0
WireConnection;124;0;86;0
WireConnection;124;1;126;0
WireConnection;126;0;117;4
WireConnection;126;1;123;0
WireConnection;157;0;155;2
WireConnection;157;1;156;0
WireConnection;0;0;52;0
WireConnection;0;9;86;0
ASEEND*/
//CHKSM=DBDC05D36B68D9AEA6A20798E9EB0AB33D0578B5