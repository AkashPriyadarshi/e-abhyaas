package com.radaee.pdf;

public class Document
{
	private static Document mInstance = new Document();
	private int hand_val = 0;
	private int page_count = 0;
	private static native int open( String path, String opassword, String upassword );
	private static native void close( int hand );
	private static native int getPage( int hand, int pageno );
	private static native int getPageCount( int hand );
	private static native float getPageWidth( int hand, int pageno );
	private static native float getPageHeight( int hand, int pageno );
	private static native String getOutlineTitle( int hand, int outline );
	private static native int getOutlineDest( int hand, int outline );
	private static native int getOutlineNext( int hand, int outline );
	private static native int getOutlineChild( int hand, int outline );
	private static native String getMeta( int hand, String tag );
	private static native boolean canSave( int hand );
	private static native boolean save( int hand );
	private static native boolean saveAs( int hand, String dst );//remove security info and save to another file.
	private static native boolean isEncrypted( int hand );
	public Document()
	{
	}
	public static Document getInstance()
	{
		return mInstance;
	}
	public void release()
	{
		if (mInstance.is_opened())
		{
			mInstance.Close();
		}
	}
	private int getOutlineRoot( int hand )
	{
		return getOutlineNext( hand_val, 0 );
	}
	public boolean is_opened()
	{
		return (hand_val != 0);
	}
	public int Open( String path, String opassword, String upassword )
	{
		if( hand_val == 0 )
		{
			int ret = 0;
			hand_val = open( path, opassword, upassword );
			if( hand_val <= 0 )//error
			{
				ret = hand_val;
				hand_val = 0;
				page_count = 0;
			}
			else
				page_count = getPageCount(hand_val);
			return ret;
		}
		return 0;
	}
	public void Close()
	{
		if( hand_val != 0 )
			close( hand_val );
		hand_val = 0;
		page_count = 0;
	}
	public Page GetPage( int pageno )
	{
		if( hand_val == 0 ) return null;
		int hand = getPage( hand_val, pageno );
		if( hand == 0 ) return null;
		Page page = new Page();
		if( page != null ) page.hand = hand;
		return page;
	}
	public int GetPageCount()
	{
		//it loads all pages. sometimes the function is very slow.
		return page_count;
	}
	public float GetPageWidth( int pageno )
	{
		return getPageWidth( hand_val, pageno );
	}
	public float GetPageHeight( int pageno )
	{
		return getPageHeight( hand_val, pageno );
	}
	public String GetMeta( String tag )
	{
		return getMeta( hand_val, tag );
	}
	public int GetOutlines()
	{
		return getOutlineRoot(hand_val);
	}
	public int GetOutlineDest( int outline )
	{
		//return the page NO.
		//from 0 to page_count - 1 
		return getOutlineDest( hand_val, outline );
	}
	public int GetOutlineNext( int outline )
	{
		return getOutlineNext( hand_val, outline );
	}
	public int GetOutlineChild( int outline )
	{
		return getOutlineChild( hand_val, outline );
	}
	public String GetOutlineTitle(int outline)
	{
		return getOutlineTitle( hand_val, outline );
	}
	public boolean CanSave()
	{
		return canSave( hand_val );
	}
	public boolean Save()
	{
		return save( hand_val );
	}
	public boolean SaveAs( String path )
	{
		return saveAs( hand_val, path );
	}
	public boolean IsEncrypted()
	{
		return isEncrypted( hand_val );
	}
}
