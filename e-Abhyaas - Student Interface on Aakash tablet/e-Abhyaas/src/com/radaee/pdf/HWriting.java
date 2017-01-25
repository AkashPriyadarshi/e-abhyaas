package com.radaee.pdf;

public class HWriting
{
	protected int hand = 0;
	private static native int create( int w, int h, float min_w, float max_w, int clr_r, int clr_g, int clr_b );
	private static native void onDown( int hand, float x, float y );
	private static native void onMove( int hand, float x, float y );
	private static native void onUp( int hand, float x, float y );
	private static native void onDraw( int hand, int bmp );
	private static native void destroy( int hand );
	public HWriting( int w, int h, float min_w, float max_w, int clr_r, int clr_g, int clr_b )
	{
		hand = create( w, h, min_w, max_w, clr_r, clr_g, clr_b );
	}
	public void Destroy()
	{
		destroy( hand );
		hand = 0;
	}
	public void OnDown( float x, float y )
	{
		onDown( hand, x, y );
	}
	public void OnMove( float x, float y )
	{
		onMove( hand, x, y );
	}
	public void OnUp( float x, float y )
	{
		onUp( hand, x, y );
	}
	public void OnDraw( int bmp )
	{
		onDraw( hand, bmp );
	}
}
