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
bool foo() {
	++sideEffectCounter;
	return true;
}

float4 PS( float4 Pos : SV_POSITION ) : SV_Target
{
	int iterations = 0;
    bool u = false;
    while (u && foo()) {
	    ++iterations;
	    if (iterations >= 10) {
		    break;
	    }
    }

    bool success = (u && sideEffectCounter == 10) || (!u && sideEffectCounter == 0);
    return success ? float4(0, 1.0, 0, 1.0) : float4(1.0, 0, 0, 1.0);
}