/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.net.*;
import java.io.*;

public class IPAddress {
/*
 This class is used to get ipAddress back using loop back address
 */
	public static String localIP() {

		try {

			InetAddress thisIp = InetAddress.getLocalHost();//this returns inet address
			return thisIp.getHostAddress();                 //host ip address is extracted from inetAddress
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
