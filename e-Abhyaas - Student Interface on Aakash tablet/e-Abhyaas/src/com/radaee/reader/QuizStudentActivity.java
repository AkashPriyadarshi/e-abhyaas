package com.radaee.reader;

import java.lang.reflect.Method;
import java.net.*;
import java.io.*;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.awt.*;

import com.android.internal.telephony.ITelephony;

import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.os.Handler;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class QuizStudentActivity extends Activity {
	/** Called when the activity is first created. */
	static String serverip;
	public static final int SERVERPORT = 8080;
	private static final String TAG = null;
	public long duration = 100;
	Handler handler;
	static DataOutputStream out;
	static DataInputStream in;
	static Socket client;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
				WindowManager.LayoutParams.FLAG_FULLSCREEN);
		
		setContentView(R.layout.input);
		System.out.println("hhhhhhhh111111111111111111");
		Myclass.setstate1(false);
//		 startActivity(new
//		 Intent(QuizStudentActivity.this,PDFReaderAct.class));
		try {
			File f1 = new File("mnt/sdcard/question.pdf");
			f1.createNewFile();
			f1.delete();
			f1 = new File("mnt/sdcard/questions.csv");
			f1.createNewFile();
			f1.delete();
			f1 = new File("mnt/sdcard/question.o");
			f1.createNewFile();
			f1.delete();
			f1 = new File("mnt/sdcard/photo.jpg");
			f1.createNewFile();
			f1.delete();

		} catch (Exception e) {
			System.out.println("Error");
		}

		String serverIp = new Ipaddrress().getIpaddrress();
		System.out.println(serverIp);
		char[] splitIp = serverIp.toCharArray();
		int i = 0;
		serverIp = "";
		for (char concat : splitIp) {

			if ((concat == '.')) {
				i++;
			}
			if ((i == 3) && (concat == '.')) {
				serverIp += ".1";
				break;
			}
			serverIp += concat;
		}
		System.out.println(serverip + "        " + serverIp);
		serverip = "192.168.48.1";
		try {
			System.out.println("hhhhhhh77777777777777777");
			client = new Socket(serverIp, SERVERPORT);
			in = new DataInputStream(client.getInputStream());
			out = new DataOutputStream(client.getOutputStream());
			String s = in.readUTF();
			System.out.println(s);
			String mac = "not found";
			WifiManager wimanager = (WifiManager) getSystemService(Context.WIFI_SERVICE);
			if (wimanager != null) {
				mac = wimanager.getConnectionInfo().getMacAddress();
			}

			out.writeUTF(mac + "");

			InputStream clientInputStream = client.getInputStream();
			Accept file = new Accept();
			file.FileAccept(clientInputStream, "mnt/sdcard/question.o", in);
			file.FileAccept(clientInputStream, "mnt/sdcard/photo.jpg", in);
			file.FileAccept(clientInputStream, "mnt/sdcard/questions.csv", in);

			String start = null;

			start = in.readUTF();
			Myclass.data = start;
			
			System.out.println("timer start of 60 sec " + start);
			
			Decrypt.Decryption();
			System.out.println("After decryption");

			// out.writeUTF("3;124;436.45;-1;-1");

			startActivity(new Intent(QuizStudentActivity.this,
					PDFReaderAct.class));

		} catch (IOException e) {
			System.out.println("error");
			e.printStackTrace();			
			System.exit(0);
		} catch (Exception e) {
			System.out.println("errrrrrrrrrrror");
			e.printStackTrace();
			System.exit(0);
		}

	}

	public static String end() {
		String result = "0";
		try {
			System.out.println("qwerty");
			out.writeUTF(PDFReaderAct.finalAnswer);
			result = in.readUTF();
			System.out.println(result);
			in.close();
			out.close();
			client.close();
					
		} catch (Exception e) {
			System.out.println("error in sending the answer");

		}
		return result;		
	}


	protected void getTeleService() {
		TelephonyManager tm = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);

		try {
			// Java reflection to gain access to TelephonyManager's
			// ITelephony getter
			Log.v(TAG, "Get getTeleService...");
			Class c = Class.forName(tm.getClass().getName());
			Method m = c.getDeclaredMethod("getITelephony");
			m.setAccessible(true);
			com.android.internal.telephony.ITelephony telephonyService = (ITelephony) m
					.invoke(tm);
			telephonyService.endCall();
		} catch (Exception e) {
			e.printStackTrace();
			Log.e(TAG, "FATAL ERROR: could not connect to telephony subsystem");
			Log.e(TAG, "Exception object: " + e);
		}

	}

	@Override
	public void onBackPressed() {
		return;
	}

	// disable home buton
	@Override
	public void onAttachedToWindow() {
		this.getWindow().setType(WindowManager.LayoutParams.TYPE_KEYGUARD);
		super.onAttachedToWindow();
	}

	@Override
	protected void onPause() {
		getTeleService();
		MediaPlayer mp = MediaPlayer.create(QuizStudentActivity.this,
				R.raw.beep);
		if (Myclass.getstate1()) {
			System.out.println("beep");
			mp.start();
		}
		super.onPause();
	}

	@Override
	protected void onStop() {
		getTeleService();
		MediaPlayer mp = MediaPlayer.create(QuizStudentActivity.this,
				R.raw.beep);
		if (Myclass.getstate1()) {
			System.out.println("beep");
			mp.start();
		}
		super.onStop();
	}

	@Override
	protected void onResume() {
		// Myclass.setstate1(true);
		super.onResume();
	}

	@Override
	protected void onRestart() {
		// Myclass.setstate1(true);
		super.onRestart();
	}

}