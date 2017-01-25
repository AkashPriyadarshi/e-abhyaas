package com.radaee.pdf;

public class Matrix
{
	protected int hand = 0;
	private static native int create( float xx, float yx, float xy, float yy, float x0, float y0 );
	private static native int createScale( float sx, float sy, float x0, float y0 );
	private static native void destroy( int matrix );
	public Matrix( float xx, float yx, float xy, float yy, float x0, float y0 )
	{
		hand = create( xx, yx, xy, yy, x0, y0 );
	}
	public Matrix( float sx, float sy, float x0, float y0 )
	{
		hand = createScale( sx, sy, x0, y0 );
	}
	public void Destroy()
	{
		destroy( hand );
		hand = 0;
	}
}
