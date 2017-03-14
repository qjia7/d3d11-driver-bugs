//--------------------------------------------------------------------------------------
// File: Tutorial02.fx
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
float4 VS( float4 Pos : POSITION ) : SV_POSITION
{
    return Pos;
}

//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
static int sideEffectCounter = 0;
int func() {
    sideEffectCounter++;
    return sideEffectCounter > 1 ? 1 : 0;
}

float4 PS( float4 Pos : SV_POSITION ) : SV_Target
{
    float4 V[2] = {0, 0, 0, 0, 0, 0, 0, 0};
    V[0] = float4(1.0, 1.0, 1.0, 1.0);
    V[1] = float4(3.0, 3.0, 3.0, 3.0);
    for (int i = 1; bool(V[func()][0]++); ++i)
    {
        if (i >= 3) { break; }
    }
	// Expected result
    return (abs(V[0][0] - 2.0) < 0.01 && abs(V[1][0] - 5.0) < 0.01 && sideEffectCounter == 3) ? float4(0, 1.0, 0, 1.0) : float4(1.0, 0, 0, 1.0);

    //Actual result
    // return (abs(V[0][0] - 1.0) < 0.01 && abs(V[1][0] - 6.0) < 0.01 && sideEffectCounter == 9) ? float4(0, 1.0, 0, 1.0) : float4(1.0, 0, 0, 1.0);
}