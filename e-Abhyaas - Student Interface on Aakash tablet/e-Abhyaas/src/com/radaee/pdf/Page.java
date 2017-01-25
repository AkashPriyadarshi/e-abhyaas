package com.radaee.pdf;

public class Page
{
	protected int hand = 0;
	static private native void close( int hand );
	static private native void renderPrepare( int hand, int dib );
	static private native void render( int hand, int dib, int matrix, int quality );
	static private native void renderCancel(int hand);
	static private native boolean renderIsFinished(int hand);

	static private native void objsStart( int hand );
	static private native String objsGetString( int hand, int from, int to );
	static private native void objsGetCharRect( int hand, int index, float[]vals );
	static private native String objsGetCharFontName( int hand, int index );
	static private native int objsGetCharCount( int hand );

	static private native int findOpen( int hand, String str, boolean match_case, boolean whole_word );
	static private native int findGetCount( int hand_finder );
	static private native int findGetFirstChar( int hand_finder, int index );
	static private native int findClose( int hand_finder );

	static private native int getAnnotCount( int hand );
	static private native int getAnnot( int hand, int index );
	static private native int getAnnotFromPoint( int hand, float x, float y );
	static private native boolean isAnnotLocked( int hand, int annot );
	static private native boolean isAnnotLockedContent( int hand, int annot );
	static private native void getAnnotRect( int hand, int annot, float[] rect );
	static private native void setAnnotRect( int hand, int annot, float[] rect );
	static private native int getAnnotDest( int hand, int annot );
	static private native String getAnnotURI( int hand, int annot );
	static private native String getAnnotMovie( int hand, int annot );
	static private native String getAnnotSound( int hand, int annot );
	static private native String getAnnotAttachment( int hand, int annot );
	static private native boolean getAnnotMovieData( int hand, int annot, String save_file );
	static private native boolean getAnnotSoundData( int hand, int annot, int paras[], String save_file );
	static private native boolean getAnnotAttachmentData( int hand, int annot, String save_file );

	static private native boolean removeAnnot( int hand, int annot );
	static private native boolean addAnnotHWriting( int hand, int matrix, int hwriting, float orgx, float orgy );
	static private native boolean addAnnotRect( int hand, int matrix, float[] rect, float width, int r, int g, int b );
	
	public void Close()
	{
		close( hand );
		hand = 0;
	}
	public void RenderPrePare( int dib )
	{
		renderPrepare( hand, dib );
	}
	public void Render( int dib, Matrix mat )
	{
		render( hand, dib, mat.hand, Global.render_mode );
	}
	public void RenderCancel()
	{
		renderCancel( hand );
	}
	public boolean RenderIsFinished()
	{
		return renderIsFinished( hand );
	}
	public void ObjsStart()
	{
		objsStart( hand );
	}
	public String ObjsGetString( int from, int to )
	{
		return objsGetString( hand, from, to );
	}
	public void ObjsGetCharRect( int index, float[]vals )
	{
		objsGetCharRect( hand, index, vals );
	}
	public String ObjsGetCharFontName( int index )
	{
		return objsGetCharFontName( hand, index );
	}
	public int ObjsGetCharCount()
	{
		return objsGetCharCount( hand );
	}
	public int FindOpen( String str, boolean match_case, boolean whole_word )
	{
		return findOpen( hand, str, match_case, whole_word );
	}
	public int FindGetCount( int hand_finder )
	{
		return findGetCount( hand_finder );
	}
	public int FindGetFirstChar( int hand_finder, int index )
	{
		return findGetFirstChar( hand_finder, index );
	}
	public int FindClose( int hand_finder )
	{
		return findClose( hand_finder );
	}

	public int GetAnnotCount()
	{
		return getAnnotCount( hand );
	}
	public int GetAnnot( int index )
	{
		return getAnnot( hand, index );
	}
	public int GetAnnotFromPoint( float x, float y )
	{
		return getAnnotFromPoint( hand, x, y );
	}
	public boolean IsAnnotLocked( int annot )
	{
		return isAnnotLocked( hand, annot );
	}
	public boolean IsAnnotLockedContent( int annot )
	{
		return isAnnotLockedContent( hand, annot );
	}
	public void GetAnnotRect( int annot, float[] rect )
	{
		getAnnotRect( hand, annot, rect );
	}
	public void SetAnnotRect( int annot, float[] rect )
	{
		setAnnotRect( hand, annot, rect );
	}
	public int GetAnnotDest( int annot )
	{
		return getAnnotDest( hand, annot );
	}
	public String GetAnnotURI( int annot )
	{
		return getAnnotURI( hand, annot );
	}
	public String GetAnnotMovie( int annot )
	{
		return getAnnotMovie( hand, annot );
	}
	public String GetAnnotSound( int annot )
	{
		return getAnnotSound( hand, annot );
	}
	public String GetAnnotAttachment( int annot )
	{
		return getAnnotAttachment( hand, annot );
	}
	public boolean GetAnnotMovieData( int annot, String save_file )
	{
		return getAnnotMovieData( hand, annot, save_file );
	}
	public boolean GetAnnotSoundData( int annot, int paras[], String save_file )
	{
		return getAnnotSoundData( hand, annot, paras, save_file );
	}
	public boolean GetAnnotAttachmentData( int annot, String save_file )
	{
		return getAnnotAttachmentData( hand, annot, save_file );
	}
	public boolean RemoveAnnot( int annot )
	{
		return removeAnnot( hand, annot );
	}
	public boolean AddAnnotHWriting( Matrix mat, HWriting hwriting, float orgx, float orgy )
	{
		return addAnnotHWriting( hand, mat.hand,  hwriting.hand, orgx, orgy );
	}
	public boolean AddAnnotRect( Matrix mat, float[] rect, float width, int r, int g, int b )
	{
		return addAnnotRect( hand, mat.hand, rect, width, r, g, b );
	}
}
