Shader "Custom/PostProcessScanlines"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
       _Scanlines ("Scan lines", 2D) = "white" {}
	   _LineOpacity ("Line Opacity", Range(0.000, 1)) = 0

	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            #include "noise3D.hlsl"
			//#define Vibrance 0.3  //Intelligently saturates (or desaturates if you use negative values) the pixels depending on their original saturation.
			//#define Vibrance_RGB_balance float3(1.00, 1.00, 1.00)  //[-10.00 to 10.00,-10.00 to 10.00,-10.00 to 10.00] A per channel multiplier to the Vibrance strength so you can give more boost to certain colors over others

			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;

				return o;
			}
			
			uniform sampler2D _MainTex;
			uniform sampler2D _Scanlines;
			uniform float _LineOpacity;
            

            uniform sampler2D _CameraDepthTexture;


           

			fixed4 frag (v2f i) : SV_Target
			{

				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 Sline = tex2D(_Scanlines, i.uv);

				col = length(col) < length(Sline) ? col : lerp(Sline, col, _LineOpacity);
				// just invert the colors
				/*if (i.uv.x > MousePosition.x - _DistToMouse && i.uv.x < MousePosition.x + _DistToMouse && i.uv.y > MousePosition.y - _DistToMouse && i.uv.y < MousePosition.y + _DistToMouse)
				{
					col = 1 - col;
				}*/
				//float4 col2 = col;
				//col = 1 - col;
                //float alpha = col.a;
                //float4 col2 = col;

                //col = frac(1 - col); 
                //col = frexp(1 - col.r, _InvertAmount);
                //col = frexp(1 - col, float4(_InvertAmount, _InvertAmount, _InvertAmount, _InvertAmount));
                //col = col * ldexp(col2, float4(_InvertAmount, _InvertAmount, _InvertAmount, _InvertAmount));
                //col = col2 * pnoise(col2.rgb, _InvertAmount);
                //col2 = frac(rcp(col2));
                //col2 = 1 - col2;
                //col.gb = col * frexp(1 - col.r, _InvertAmount);
                //col = 1 - col;
				
                //col2 = col * pnoise(col2.rgb, _ParameterTwo);
                //col2 = 1 - col2;
                //col = round(col);
                //float temp;
                
               /* col.r = (col.r * custFrexp(col2.r) * _ParameterRed) * _ParameterThree + (col2.r * (1 - _ParameterThree));
                col.g = (col.g * custFrexp(col2.g) * _ParameterGreen) * _ParameterThree + (col2.g * (1 - _ParameterThree));
                col.b = (col.b * custFrexp(col2.b) * _ParameterBlue) * _ParameterThree + (col2.b * (1 - _ParameterThree));*/

                /*col.r *= _ParameterRed;
                col.g *= _ParameterGreen;
                col.b *= _ParameterBlue;
                col *= _ParameterGlobalValue;*/

                //col = 1-col;

                //col = clamp(smoothstep(col2, col,  (length(col.rgb) - _MaskMaxValue)/_MaskMinValue), col, col2);
                //col = col2;


                // Brightness / Constrast Management

				/*col.rgb = ((col.rgb - 0.5f) * max(_Contrast, 0)) + 0.5f;
				
                
				    col.rgb += _Brightness;


                col.a = alpha;*/
                //return col;
				return saturate(col);
			}
			ENDCG
		}
	}
}
