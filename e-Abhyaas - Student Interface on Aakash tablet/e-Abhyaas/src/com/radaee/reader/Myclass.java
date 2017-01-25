package com.radaee.reader;

import android.R.string;
import android.app.Application;

public class Myclass extends Application {
private static boolean counter1 = true;
private static boolean counter2 = true;
static String data;

	public Myclass() {
		counter1 = true;
		counter2 = true;
	}
	
	public static boolean getstate1(){
		return counter1;
	}
	public static void setstate1(boolean x){
		counter1 = x;
	}
	public static boolean getstate2(){
		return counter2;
	}
	public static void setstate2(boolean x){
		counter2 = x;
	}
}
