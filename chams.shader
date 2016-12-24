Shader "Chams/Chams1" {

Properties
{
	_Color1 ("Color 1", Color) = (1,0,0)
	_Color2 ("Color 2", Color) = (1,1,0)
}

SubShader
{
	Tags {"Queue" = "Geometry+1"}
	Pass
	{
		ZTest Greater
		Color [_Color1]
	}

	Pass
	{
		ZTest LEqual
		Color [_Color2]
	}
}


}