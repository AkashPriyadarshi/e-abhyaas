package com.radaee.reader;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

import android.R.string;

public class Ipaddrress {
	InetAddress inetAddress ;
	public String getIpaddrress(){
		
		try{
	
	for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
		NetworkInterface intf = en.nextElement();
		for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
			inetAddress= enumIpAddr.nextElement();
		if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress()) {
		//System.out.println(inetAddress.getHostAddress());
			return inetAddress.getHostAddress();
		}
		}
		}
	}catch(Exception e){
		System.out.println("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
		
	}
		
		return inetAddress.getHostAddress();
	}

}
