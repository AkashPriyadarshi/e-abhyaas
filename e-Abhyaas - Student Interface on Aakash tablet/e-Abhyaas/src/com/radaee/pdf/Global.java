package com.radaee.pdf;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import com.radaee.pdfex.PDFRecent;

import android.app.Activity;
import android.content.res.AssetManager;
import android.graphics.Bitmap;

public class Global
{
	private static native void setCMapsPath( String cmaps, String umaps );
	private static native void fontfileListStart();
	private static native void fontfileListAdd( String font_file );
	private static native void fontfileListEnd();
	private static native boolean setDefaultFont( String collection, String fontname, boolean fixed );
	private static native int getFaceCount();
	private static native String getFaceName(int index);
	private static native boolean active( String pkg_name, String company, String mail, String serial );

	public static native int lockBitmap( Bitmap bitmap );
	public static native void unlockBitmap( Bitmap bitmap, int bmp );
	public static native void drawToBmp( int bmp, int dib, int x, int y );
	public static native void drawRect( int bmp, int color, int x, int y, int width, int height );
	public static native void drawScroll( Bitmap bmp, int dib1, int dib2, int x, int y, int style );
	public static native int dibGet( int dib, int width, int height );
	public static native int dibFree( int dib );
	private static native void toDIBPoint( int dib, int matrix, float[] ppoint, float[] dpoint );
	private static native void toPDFPoint( int dib, int matrix, float[] dpoint, float[] ppoint );
	private static native void toDIBRect( int dib, int matrix, float[] prect, float[] drect );
	private static native void toPDFRect( int dib, int matrix, float[] drect, float[] prect );
	public static PDFRecent recentFiles = null;

	public static int selColor = 0x40C00000;//selection color
	public static float fling_dis = 1.0f;//0.5-2
	public static float fling_speed = 0.2f;//0.1 - 0.4
	public static int def_view = 0;//0,1,2    0:vertical 1:horizon 2:scroll
	public static int render_mode = 2;//0,1,2 0:draft    1:normal  2:best
	
	public static void Init(Activity act)
	{
   		System.loadLibrary("rdpdf");
		AssetManager assets = act.getAssets();
		byte buf[] = new byte[4096];
		File sub;
		int read;

		File files = act.getFilesDir();
        String cmaps_path = files.getAbsolutePath() + "/cmaps";
        String umaps_path = files.getAbsolutePath() + "/umaps";
        files = null;
        
		sub = new File(cmaps_path);
		if( !sub.exists() )
		{
			try
	    	{
    			InputStream src;

	    		FileOutputStream dst = new FileOutputStream( new File(cmaps_path) );

	    		src = assets.open( "cmaps1" );
   				while( (read = src.read( buf )) > 0 )
   					dst.write( buf, 0, read );
   				src.close();
	   			src = null;
    			src = assets.open( "cmaps2" );
   				while( (read = src.read( buf )) > 0 )
   					dst.write( buf, 0, read );
   				src.close();
	   			src = null;
   				
   				dst.close();
	   			dst = null;
	   			src = null;
	    	}
			catch(Exception e)
			{
			}
		}
		sub = null;

		sub = new File(umaps_path);
		if( !sub.exists() )
		{
			try
	    	{
    			InputStream src;

	    		FileOutputStream dst = new FileOutputStream( new File(umaps_path) );

	    		src = assets.open( "umaps1" );
   				while( (read = src.read( buf )) > 0 )
   					dst.write( buf, 0, read );
   				src.close();
	   			src = null;
    			src = assets.open( "umaps2" );
   				while( (read = src.read( buf )) > 0 )
   					dst.write( buf, 0, read );
   				src.close();
	   			src = null;
   				
   				dst.close();
	   			dst = null;
	   			src = null;
	    	}
			catch(Exception e)
			{
			}
		}
		sub = null;

		buf = null;
		assets = null;

		active( "com.radaee.reader", "radaee", "radaee_com@yahoo.cn", "Z5A7JV-5WQAJY-9ZOU9E-OQ31K2-FADG6Z-XEBCAO" );
		setCMapsPath( cmaps_path, umaps_path );

		fontfileListStart();
		fontfileListAdd( "/system/fonts/DroidSansFallback.ttf" );
		fontfileListEnd();
		int face_first = 0;
		int face_count = getFaceCount();
		String face_name = null;
		while( face_first < face_count )
		{
			face_name = getFaceName(face_first);
			if( face_name != null )
				break;
			face_first++;
		}
		if( !setDefaultFont( null, "DroidSansFallback", true ) && face_name != null )
		{
			setDefaultFont( null, face_name, true );
		}
		if( !setDefaultFont( null, "DroidSansFallback", false ) && face_name != null )
		{
			setDefaultFont( null, face_name, false );
		}

		default_config();
	}
	public static void default_config()
	{
		selColor = 0x40C00000;//selection color
		fling_dis = 1.0f;//0.5-2
		fling_speed = 0.2f;//0.1 - 0.4
		def_view = 0;//0,1,2    0:vertical 1:horizon 2:scroll
		render_mode = 2;//0,1,2 0:draft    1:normal  2:best
	}
	public static void ToDIBPoint( int dib, Matrix mat, float[] ppoint, float[] dpoint )
	{
		toDIBPoint( dib, mat.hand, ppoint, dpoint );
	}
	public static void ToPDFPoint( int dib, Matrix mat, float[] dpoint, float[] ppoint )
	{
		toPDFPoint( dib, mat.hand, dpoint, ppoint );
	}
	public static void ToDIBRect( int dib, Matrix mat, float[] prect, float[] drect )
	{
		toDIBRect( dib, mat.hand, prect, drect );
	}
	public static void ToPDFRect( int dib, Matrix mat, float[] drect, float[] prect )
	{
		toPDFRect( dib, mat.hand, drect, prect );
	}
}
