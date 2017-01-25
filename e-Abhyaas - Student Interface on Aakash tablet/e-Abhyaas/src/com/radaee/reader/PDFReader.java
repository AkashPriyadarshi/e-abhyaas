package com.radaee.reader;

import java.io.File;

import com.radaee.pdf.*;
import com.radaee.pdfex.*;
import com.radaee.pdfex.PDFView.PDFAnnotListener;
import com.radaee.pdfex.PDFView.PDFPosition;
import com.radaee.pdfex.PDFView.PDFViewListener;

import android.app.ActivityManager;
import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Toast;

public class PDFReader extends View implements PDFView.PDFViewListener
{
	private PDFView m_viewer = null;
	private int m_style = -1;
	public PDFReader(Context context)
	{
		super(context);
	}
	public PDFReader(Context context, AttributeSet attrs)
	{
		super(context, attrs);
	}
	public void set_viewer( int view_style )
	{
		if( view_style == m_style ) return;
		PDFPosition pos = null;
		PDFAnnotListener annot_listener = null;
		PDFViewListener view_listener = null;
		if( m_viewer != null )
		{
			annot_listener = m_viewer.viewGetAnnotListener();
			view_listener = m_viewer.viewGetViewListener();
			pos = m_viewer.viewGetPos();
			m_viewer.viewClose();
		}
		switch( view_style )
		{
		case 1:
			m_viewer = new PDFViewHorz();
			break;
		case 2:
			m_viewer = new PDFViewScroll();
			break;
		default:
			m_viewer = new PDFViewVert();
			break;
		}
		if( m_viewer != null )
		{
			if( pos != null ) m_viewer.viewGoto(pos);
			m_viewer.viewSetAnnotListener( annot_listener );
			m_viewer.viewSetViewListener( view_listener );
			m_viewer.viewResize(getWidth(), getHeight());
		}
	}
	protected void onConfigurationChanged(Configuration newConfig)
	{
		super.onConfigurationChanged(newConfig);
	}
	public PDFView get_viewer()
	{
		return m_viewer;
	}
	public void open( Document doc )
	{
		set_viewer( Global.def_view );
		if( m_viewer != null )
			m_viewer.viewOpen(doc);
	}
	public void close()
	{
		if( m_viewer != null )
			m_viewer.viewClose();
		m_viewer = null;
	}
	protected void onSizeChanged (int w, int h, int oldw, int oldh)
	{
		if( m_viewer != null )
			m_viewer.viewResize(w, h);
	}
	protected void onDraw( Canvas canvas )
	{
		if( m_viewer != null )
		{
			m_viewer.viewDraw(canvas);

			ActivityManager mgr = (ActivityManager)getContext().getSystemService(Context.ACTIVITY_SERVICE);
			ActivityManager.MemoryInfo info = new ActivityManager.MemoryInfo();
			mgr.getMemoryInfo(info);
			Paint paint = new Paint();
			paint.setARGB(255, 255, 0, 0);
			canvas.drawText( String.valueOf(info.availMem/(1024*1024)), 20, 120, paint);
		}
	}
	public boolean onTouchEvent (MotionEvent event)
	{
		if( m_viewer != null )
			return m_viewer.viewTouchEvent(event);
		else
			return true;
	}
	public void setAnnotListener( PDFView.PDFAnnotListener listener )
	{
		if( m_viewer != null )
			m_viewer.viewSetAnnotListener(listener);
	}
	public void setViewListener( PDFView.PDFViewListener listener )
	{
		if( m_viewer != null )
			m_viewer.viewSetViewListener(listener);
	}
	public void annotInk()
	{
		if( m_viewer != null )
			m_viewer.annotInk();
	}
	public void annotRect()
	{
		if( m_viewer != null )
			m_viewer.annotRect();
	}
	public void annotPerform()
	{
		if( m_viewer != null )
			m_viewer.annotPerform();
	}
	public void annotEnd()
	{
		if( m_viewer != null )
			m_viewer.annotEnd();
	}
	public void annotRemove()
	{
		if( m_viewer != null )
			m_viewer.annotRemove();
	}
	public void find(int dir)
	{
		if( m_viewer != null )
			m_viewer.viewFind(dir);
	}
	public void findStart(String str, boolean match_case, boolean whole_word)
	{
		if( m_viewer != null )
			m_viewer.viewFindStart(str, match_case, whole_word);
	}
	public void onInvalidate()
	{
		if( m_viewer != null )
			invalidate();
	}
	public void onFound( boolean found )
	{
		if( !found )
			Toast.makeText(getContext(), "no more found", Toast.LENGTH_SHORT).show();
	}
	public void onOpenURL(String url)
	{
		Toast.makeText(getContext(), "todo open url:" + url, Toast.LENGTH_LONG).show();
	}
	public void onPageChanged(int pageno)
	{
	}
	public void onSingleTap( float x, float y )
	{
	}
	public void onOpenMovie(String file_name)
	{
		File file = new File(file_name);
		file.delete();//you should delete the temporary file, after played
	}

	public void onOpenSound(int[] paras, String file_name)
	{
		if( paras[0] == 0 )//means format sound file, example: mp3/wav
		{
		}
		else//means unformatted sond data
		{
			//paras[0]: sample rate
			//paras[1]: channels number
			//paras[2]: sample bits
			//paras[3]: 0:raw   1:Signed(16 bits)   2:mu-law   3:a-law
		}
		File file = new File(file_name);
		file.delete();//you should delete the temporary file, after played
	}

	public void onOpenAttachment(String file_name)
	{
		File file = new File(file_name);
		file.delete();//you should delete the temporary file, after played
	}
	public void onSelectStart()
	{
	}
	public void onSelectEnd(String text)
	{
		Toast.makeText(getContext(), "todo copy text:" + text, Toast.LENGTH_SHORT).show();
	}
}
