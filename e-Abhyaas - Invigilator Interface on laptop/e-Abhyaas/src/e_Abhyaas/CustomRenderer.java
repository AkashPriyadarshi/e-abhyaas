/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.awt.Component;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/**
 * 
 * @author akash
 */
class CustomRenderer extends DefaultTableCellRenderer {
	String[][] index = ServerSide.connected;
	// static int i= ServerSide.list.length-1;
	static int i = 0;

	@Override
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
            JLabel d = (JLabel) super.getTableCellRendererComponent(table, value,
				isSelected, hasFocus, row, column);
		i = row;
		if (index[i][1].equals("true")&&index[i][2].equals("false")) {//change color on connection
			d.setBackground(new java.awt.Color(70, 200, 50));

		} else if(index[i][1].equals("true")&&index[i][2].equals("true")){//changw color after transfer
                      d.setBackground(new java.awt.Color(100, 200, 220));
                
                }
                else
                {
		 d.setBackground(new java.awt.Color(255, 220, 220)); 	
                }
		// System.out.println(i+"  "+index[i][0]+"  "+d.getText());
		return d;
	}
}
