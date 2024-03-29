package com.radaee.reader;
import java.io.File;
import java.util.Vector;

import android.content.Context;
import android.database.DataSetObserver;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ExpandableListAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

public class SnatchAdt implements ExpandableListAdapter
{
	static protected int clr_back = 0xFFCCCCCC;
	static protected int clr_text = 0xFF000044;
	public class SnatchItem
	{
		public String m_path;
		public String m_name;
		LinearLayout m_view;
	}
	public class SnatchGroup
	{
		private Vector<SnatchItem> m_items = new Vector<SnatchItem>();
		public SnatchItem get(int index)
		{
			return m_items.get(index);
		}
		public int get_count()
		{
			return m_items.size();
		}
		public void add_item( String path, String name )
		{
			SnatchItem item = new SnatchItem();
			item.m_name = name;
			item.m_path = path;
			item.m_view = new LinearLayout(m_context);
			TextView view = new TextView(m_context);
			view.setText(name);
			view.setTextSize(18);
			view.setTextColor(clr_text);
			item.m_view.addView(view);
			item.m_view.setPadding(46, 2, 2, 2);
			item.m_view.setBackgroundColor(clr_back);
			m_items.add(item);
		}
		String m_path;
		LinearLayout m_view;
	}
	private Vector<SnatchGroup> m_groups = new Vector<SnatchGroup>();
	private DataSetObserver m_obs;
	private String m_path;
	private Context m_context;
	private Handler m_hand_ui = new Handler()
	{
		public void handleMessage(Message msg)
		{
			if( m_obs != null )
				m_obs.onChanged();
			super.handleMessage(msg);
		}
	};
	private Thread m_thread = new Thread()
	{
		@Override
	    public void run()
		{
			File file = new File(m_path);
			if( !file.exists() ) return;
			set_group_files( file );
		}
	};
	public SnatchAdt( Context ctx )
	{
		m_context = ctx;
	}
	private synchronized Object get_child(int groupPosition, int childPosition)
	{
		return m_groups.get(groupPosition).get(childPosition);
	}
	private synchronized String get_child_path(int groupPosition, int childPosition)
	{
		return m_groups.get(groupPosition).get(childPosition).m_path;
	}
	private synchronized View get_child_view(int groupPosition, int childPosition)
	{
		return m_groups.get(groupPosition).get(childPosition).m_view;
	}
	private synchronized int get_children_count(int groupPosition)
	{
		return m_groups.get(groupPosition).get_count();
	}
	private synchronized Object get_group(int groupPosition)
	{
		return m_groups.get(groupPosition);
	}
	private synchronized View get_group_view(int groupPosition)
	{
		return m_groups.get(groupPosition).m_view;
	}
	private synchronized int get_group_cnt()
	{
		return m_groups.size();
	}
	private synchronized void add_to_group( SnatchGroup group, String path, String name )
	{
		group.add_item(path, name);
	}
	private synchronized void add_group( SnatchGroup group )
	{
		m_groups.add(group);
		m_hand_ui.sendEmptyMessage(0);
	}

	private void set_group_files( File file )
	{
		File files[] = file.listFiles();
		SnatchGroup group = new SnatchGroup();
		group.m_path = file.getPath();
		group.m_view = new LinearLayout(m_context);
		TextView view = new TextView(m_context);
		view.setText(group.m_path);
		view.setTextSize(20);
		view.setTextColor(clr_text);
		group.m_view.addView(view);
		group.m_view.setPadding(36, 3, 2, 3);
		group.m_view.setBackgroundColor(clr_back);
		if( files == null ) return;
		int cur = 0;
		int cnt = files.length;
		while( cur < cnt )
		{
			if( !files[cur].isHidden() )
			{
				if( files[cur].isFile() )
				{
					String name = files[cur].getName();
					int len = name.length();
					if( len > 4 )
					{
						String ext = name.substring(name.length() - 4);
						if( ext.compareToIgnoreCase(".pdf") == 0 )
							add_to_group(group, files[cur].getPath(), files[cur].getName());
					}
				}
				if( files[cur].isDirectory() )
					set_group_files( files[cur] );
			}
			cur++;
		}
		if( group.get_count() != 0 ) add_group(group);
	}
	public void set_dir( String path )
	{
		m_path = path;
		m_thread.start();
	}
	public boolean areAllItemsEnabled()
	{
		return true;
	}
	public Object getChild(int groupPosition, int childPosition)
	{
		return get_child(groupPosition, childPosition);
	}
	public String getChildPath(int groupPosition, int childPosition)
	{
		return get_child_path(groupPosition, childPosition);
	}

	public long getChildId(int groupPosition, int childPosition)
	{
		return 0;
	}

	public View getChildView(int groupPosition, int childPosition,
			boolean isLastChild, View convertView, ViewGroup parent)
	{
		return get_child_view(groupPosition, childPosition);
	}

	public int getChildrenCount(int groupPosition)
	{
		return get_children_count(groupPosition);
	}

	public long getCombinedChildId(long groupId, long childId)
	{
		return 0;
	}

	public long getCombinedGroupId(long groupId)
	{
		return 0;
	}

	public Object getGroup(int groupPosition)
	{
		return get_group(groupPosition);
	}

	public int getGroupCount()
	{
		return get_group_cnt();
	}

	public long getGroupId(int groupPosition)
	{
		return 0;
	}

	public View getGroupView(int groupPosition, boolean isExpanded,
			View convertView, ViewGroup parent)
	{
		return get_group_view(groupPosition);
	}

	public boolean hasStableIds()
	{
		return false;
	}

	public boolean isChildSelectable(int groupPosition, int childPosition)
	{
		return true;
	}

	public boolean isEmpty()
	{
		return get_group_cnt() == 0;
	}

	public void onGroupCollapsed(int groupPosition)
	{
	}

	public void onGroupExpanded(int groupPosition)
	{
	}

	public void registerDataSetObserver(DataSetObserver observer)
	{
		m_obs = observer;
	}

	public void unregisterDataSetObserver(DataSetObserver observer)
	{
		m_obs = null;
	}
}
