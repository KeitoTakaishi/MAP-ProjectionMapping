﻿Shader "Custom/Blocks" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		pass{

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
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
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                float2 uv = floor(i.uv*15.0 / 15.0);
                fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
		ENDCG
		}
	}
	FallBack "Diffuse"
}
