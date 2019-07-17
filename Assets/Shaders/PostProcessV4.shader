Shader "Custom/PostProcessV4"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _InvertAmount("Invert Amount", Float) = 0
        _ParameterTwo("Param 2", Float) = 0
        _ParameterThree("Param 3", Float) = 0
        _ParameterFour("Param 4", Float) = 0.5
        _ParameterRed("Red Value", Float) = 1
        _ParameterGreen("Green Value", Float) = 1
        _ParameterBlue("Blue Value", Float) = 1
        _ParameterGlobalValue("Global Value", Float) = 1
        _MaskMinValue("Mask Min Value", Float) = 0.1
        _MaskMaxValue("Mask Min Value", Float) = 0.2
        _Brightness("Brightness", Float) = 0
        _Contrast("Contrast", Float) = 0


        _ParameterD1("D1", Float) = 6.3
        _ParameterF1("F1", Float) = 2
        _ParameterG1("G1", Float) = 1
        _ParameterH1("H1", Float) = 0.5
        _ParameterI1("I1", Float) = 0.5
        _ParameterJ1("J1", Float) = 1
        _ParameterK1("K1", Float) = 1

        _ParameterD2("D2", Float) = 6.3
        _ParameterF2("F2", Float) = 2
        _ParameterG2("G2", Float) = 0
        _ParameterH2("H2", Float) = -0.5
        _ParameterI2("I2", Float) = 0.5
        _ParameterJ2("J2", Float) = 0.17
        _ParameterK2("K2", Float) = 5.98
        

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
            uniform float _InvertAmount;
            uniform float _ParameterTwo;
            uniform float _ParameterThree;
            uniform float _ParameterFour;
            uniform float _ParameterRed;
            uniform float _ParameterGreen;
            uniform float _ParameterBlue;
            uniform float _ParameterGlobalValue;
            uniform float _Brightness;
            uniform float _Contrast;
            uniform float _MaskMinValue;
            uniform float _MaskMaxValue;

            uniform sampler2D _CameraDepthTexture;


            uniform float _ParameterD1;
            uniform float _ParameterF1;
            uniform float _ParameterG1;
            uniform float _ParameterH1;
            uniform float _ParameterI1;
            uniform float _ParameterJ1;
            uniform float _ParameterK1;

            uniform float _ParameterD2;
            uniform float _ParameterF2;
            uniform float _ParameterG2;
            uniform float _ParameterH2;
            uniform float _ParameterI2;
            uniform float _ParameterJ2;
            uniform float _ParameterK2;


            float custFrexp(float value)
            {

                if (value > _ParameterFour)
                {
                    float d = _ParameterD1; //6.3 par défaut
                    float f = _ParameterF1; //2
                    float g = _ParameterG1; //1
                    float h = _ParameterH1; //0.5
                    float i = _ParameterI1; //0.5
                    float j = _ParameterJ1; //1
                    float k = _ParameterK1; //1 // Permet comme le paramètre D1 à Param 4 = 0.05 de gérer la transparence de la zone centrale

                    float a = (value + j) * k;
                    
                    float b = ceil(log2(a));

                    float result = h * cos(((a * pow(2, -b)) * f - g) * d) + i;

                    return result;
                }

                else 
                {
                    float d = _ParameterD2; //6.3 // Permet de gérer la profondeur des couches extérieures      //Ajoute également plus de couches quand le paramètre a des valeurs extrèmes
                    float f = _ParameterF2; //2
                    float g = _ParameterG2; //0 // Permet dans une certaine mesure d'inverser les couleurs
                    float h = _ParameterH2; //-0.5 // Permet de gérer l'intensité de la couleur des couches concernées et de rencentrer le changement de couleur sur les zones plus claires (moins sur le background)
                    float i = _ParameterI2; //0.5
                    float j = _ParameterJ2; //0.17
                    float k = _ParameterK2; //5.98 // Permet de gérer la largeur des couches

                    float a = (value + j) * k;
                    
                    float b = ceil(log2(a));

                    float result = h * cos(((a * pow(2, -b)) * f - g) * d) + i;

                    return result;
                }
            }


			fixed4 frag (v2f i) : SV_Target
			{

				fixed4 col = tex2D(_MainTex, i.uv);
				// just invert the colors
				/*if (i.uv.x > MousePosition.x - _DistToMouse && i.uv.x < MousePosition.x + _DistToMouse && i.uv.y > MousePosition.y - _DistToMouse && i.uv.y < MousePosition.y + _DistToMouse)
				{
					col = 1 - col;
				}*/
				//float4 col2 = col;
				//col = 1 - col;
                float alpha = col.a;
                float4 col2 = col;

                col = frac(1 - col); 
                //col = frexp(1 - col.r, _InvertAmount);
                //col = frexp(1 - col, float4(_InvertAmount, _InvertAmount, _InvertAmount, _InvertAmount));
                //col = col * ldexp(col2, float4(_InvertAmount, _InvertAmount, _InvertAmount, _InvertAmount));
                col = col2 * pnoise(col2.rgb, _InvertAmount);
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

                col.r *= _ParameterRed;
                col.g *= _ParameterGreen;
                col.b *= _ParameterBlue;
                col *= _ParameterGlobalValue;

                col = 1-col;

                //col = clamp(smoothstep(col2, col,  (length(col.rgb) - _MaskMaxValue)/_MaskMinValue), col, col2);
                //col = col2;


                // Brightness / Constrast Management

				col.rgb = ((col.rgb - 0.5f) * max(_Contrast, 0)) + 0.5f;
				
                
				    col.rgb += _Brightness;


                col.a = alpha;
                //return col;
				return saturate(col);
			}
			ENDCG
		}
	}
}
