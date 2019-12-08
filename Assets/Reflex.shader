Shader "Custom/Reflex"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _TexScale("Texture Scale", Range(0.01, 10)) = 0.1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float3 pos : TEXCOORD0;
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
            };

            sampler2D _MainTex;
            float _TexScale;

            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.pos = UnityObjectToViewPos(v.vertex);         //transform vertex into eye space
                o.normal = mul(UNITY_MATRIX_IT_MV, v.normal);   //transform normal into eye space
                o.tangent = mul(UNITY_MATRIX_IT_MV, v.tangent); //transform tangent into eye space
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                float3 normal = normalize(i.normal);    //get normal of fragment
                float3 tangent = normalize(i.tangent);  //get tangent
                float3 cameraDir = normalize(i.pos);    //get direction from camera to fragment, normalize(i.pos - float3(0, 0, 0))

                float3 offset = cameraDir + normal;     //calculate offset from two points on unit sphere, cameraDir - -normal

                float3x3 mat = float3x3(
                    tangent,
                    cross(normal, tangent),
                    normal
                );

                offset = mul(mat, offset);  //transform offset into tangent space

                float2 uv = offset.xy / _TexScale;              //sample and scale
                return tex2D(_MainTex, uv + float2(0.5, 0.5));  //shift sample to center of texture
            }
            ENDCG
        }
    }
}
