package com.radaee.reader;

import java.io.File;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;

public class Result extends Activity {

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
				WindowManager.LayoutParams.FLAG_FULLSCREEN);
	
		setContentView(R.layout.result);
		
		TextView t = (TextView) findViewById(R.id.textView1);
		Button b = (Button) findViewById(R.id.button1);

		t.setText("YOU HAVE SCORED : " + PDFReaderAct.result);
		b.setText("OK");
		File file_pdf = new File("mnt/sdcard/question.pdf");
		file_pdf.delete();
		File file_o = new File("mnt/sdcard/question.o");
		file_o.delete();
		File file_csv = new File("mnt/sdcard/questions.csv");
		file_csv.delete();
		File file_photo = new File("mnt/sdcard/photo.jpg");
		file_photo.delete();
		b.setOnClickListener(new OnClickListener() {
			
			public void onClick(View v) {
//				android.os.Process.killProcess(android.os.Process.myPid());
				Intent intent = new Intent(Intent.ACTION_MAIN);
				intent.addCategory(Intent.CATEGORY_HOME);
				intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
				startActivity(intent);
				System.exit(0);
			}
		});
	}
}
