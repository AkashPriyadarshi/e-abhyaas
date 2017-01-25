package com.radaee.reader;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.Method;
import java.util.StringTokenizer;

import android.app.Activity;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.ClipDrawable;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.shapes.RoundRectShape;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.android.internal.telephony.ITelephony;
import com.radaee.pdf.Document;
import com.radaee.pdf.Global;

public class PDFReaderAct extends Activity implements OnClickListener {
	// Beginning of global variable declarations and initializations

	private static final String TAG = null;
	private Document m_doc = new Document();
	private PDFReader m_vPDF = null;
	int[][] quizData; // Storing the quiz specifications in an integer array
	int[][] questionImages = {
			{ R.drawable.a, R.drawable.b, R.drawable.c, R.drawable.d,
					R.drawable.e, R.drawable.f, R.drawable.g, R.drawable.h,
					R.drawable.i, R.drawable.j },
			{ R.drawable.a_checked, R.drawable.b_checked, R.drawable.c_checked,
					R.drawable.d_checked, R.drawable.e_checked,
					R.drawable.f_checked, R.drawable.g_checked,
					R.drawable.h_checked, R.drawable.i_checked,
					R.drawable.j_checked },
			{ R.drawable.zero, R.drawable.one, R.drawable.two,
					R.drawable.three, R.drawable.four, R.drawable.five,
					R.drawable.six, R.drawable.seven, R.drawable.eight,
					R.drawable.nine, R.drawable.decimal },
			{ R.drawable.zero_checked, R.drawable.one_checked,
					R.drawable.two_checked, R.drawable.three_checked,
					R.drawable.four_checked, R.drawable.five_checked,
					R.drawable.six_checked, R.drawable.seven_checked,
					R.drawable.eight_checked, R.drawable.nine_checked,
					R.drawable.decimal_checked } }; // Stores all the images in
													// a convenient integer
													// array
	int local = 0; // Timer variable
	int noOfQuestions = 0; // Number of questions in the quiz
	String[] solutions; // Array to store the answers attempted by the student
	String[][] match_temp; // Temporarily stores the answers for Match the
							// Following and Matrix Match
	String[][] num_temp; // Temporarily stores the answers for Integer Type
							// Questions
	static String finalAnswer; // Stores the string of all the answers
	static String result;
	static int time = 0; // Duration of the quiz
	RelativeLayout globalLayout; // The relative layout of the app - inside this
									// all the child layouts exist
	RelativeLayout answerSheet_relative; // Relative Layout for the answer
											// sheet; declared globally as it
											// used in onCreate and onClick
	ScrollView answerSheet; // Adds a vertical scroll bar to
							// "answerSheet_relative"
	RelativeLayout lout;
	static Timer quiz_timer = new Timer(); // Timer class
	static Thread timer_thread; // Tick of the timer
	static ProgressBar time_pb; // Progress Bar for time
	static ProgressBar questions_pb; // Progress Bar for questions attempted

	// End of global variable declarations and initializations

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
				WindowManager.LayoutParams.FLAG_FULLSCREEN);

		setContentView(R.layout.main);
		Global.Init(this);
		System.out.println("hhhhhhhh");

		// Beginning of onCreate variable declarations
		File quizSpecs; // File object to read the quiz specifications CSV file
		BufferedReader csvReader; // Buffered reader for file handling
		String line; // Storing each line of the CSV file
		StringTokenizer currentLine; // Stores the tokens of the CSV file as
										// they are read
		int maxMarks; // Maximum marks of the test
		int i, j, k; // Loop variables
		int topElementId; // Id of the top element
		RelativeLayout essentials; // The fixed layout at the top which has the
									// essential objects - the photograph of the
									// student and the two progress bars (one
									// for time and another for questions
									// attempted)
		final RelativeLayout.LayoutParams params_answerSheet; // LayoutParams
																// for
																// "answerSheet"
																// so that it
																// can be added
																// to the global
																// relative
																// layout
		RelativeLayout.LayoutParams params_essentials; // LayoutParams for
														// "essentials" so that
														// it can be added to
														// the global relative
														// layout
		String imageOfStudent; // path containing the photograph of the student
		// End of onCreate variable declarations
		// Beginning of onCreate variable initializations
		csvReader = null;
		answerSheet = new ScrollView(this);
		quizSpecs = new File("mnt/sdcard/questions.csv"); // Assigning the CSV
															// file
		line = "";
		currentLine = null;
		i = 0;
		j = 0;
		k = 0;
		topElementId = 0;
		maxMarks = 0;
		globalLayout = new RelativeLayout(this);
		answerSheet_relative = new RelativeLayout(this);
		essentials = new RelativeLayout(this);
		params_answerSheet = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.FILL_PARENT,
				RelativeLayout.LayoutParams.FILL_PARENT);
		params_essentials = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		time_pb = new ProgressBar(this, null,
				android.R.attr.progressBarStyleHorizontal);
		questions_pb = new ProgressBar(this, null,
				android.R.attr.progressBarStyleHorizontal);// Both progress bars
															// are of horizontal
															// bar type
		imageOfStudent = "mnt/sdcard/photo.jpg";
		// End of onCreate variable initializations
		// Now adding the upper view
		params_essentials.addRule(RelativeLayout.ALIGN_PARENT_TOP);
		params_essentials.setMargins(0, 0, 0, 10);
		essentials.setId(10);
		globalLayout.addView(essentials, params_essentials);
		// End
		// Reading the CSV file to get the number of questions and duration of
		// quiz for other initializations
		try {
			csvReader = new BufferedReader(new FileReader(quizSpecs));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			line = csvReader.readLine();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		currentLine = new StringTokenizer(line, ",");
		noOfQuestions = Integer.parseInt(currentLine.nextToken());
		time = 60 * Integer.parseInt(currentLine.nextToken()); // Time converted
																// to seconds
		maxMarks = Integer.parseInt(currentLine.nextToken());
		// End
		// Inserting the student's photograph
		ImageView img_student = new ImageView(this);
		Bitmap bm_student = BitmapFactory.decodeFile(imageOfStudent);
		img_student.setImageBitmap(bm_student);
		img_student.setId(30);
		RelativeLayout.LayoutParams params_imgStudent = new RelativeLayout.LayoutParams(
				75, 75);
		params_imgStudent.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
		params_imgStudent.setMargins(0, 0, 10, 10);
		img_student.setLayoutParams(params_imgStudent);
		essentials.addView(img_student, params_imgStudent);
		// End
		// Now drawing the progress bar for time
		TextView txt_pbTime = new TextView(this);
		txt_pbTime.setText("Elapsed Time                 ");
		txt_pbTime.setId(21);
		txt_pbTime.setTypeface(Typeface.DEFAULT_BOLD);
		txt_pbTime.setTextSize(18);
		RelativeLayout.LayoutParams params_txtpbTime = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_txtpbTime.addRule(RelativeLayout.ALIGN_PARENT_TOP);
		params_txtpbTime.addRule(RelativeLayout.RIGHT_OF, 30);
		params_txtpbTime.setMargins(0, 0, 0, 10);
		txt_pbTime.setLayoutParams(params_txtpbTime);
		essentials.addView(txt_pbTime, params_txtpbTime);
		time_pb.setVisibility(ProgressBar.VISIBLE); // Making it visible
		time_pb.setProgress(0); // Initial value
		time_pb.setMax(time); // Max value
		time_pb.setId(11);
		final float[] roundedCorners = new float[] { 5, 5, 5, 5, 5, 5, 5, 5 };
		final ShapeDrawable pbTimeDrawable = new ShapeDrawable(
				new RoundRectShape(roundedCorners, null, null));
		final String normalColor = "#3BC74F"; // Normal color of progress bar is
												// green
		final String alertColor = "#C83C3E"; // Last 20% of time, color is
												// changed to red
		ClipDrawable time_progress = new ClipDrawable(pbTimeDrawable,
				Gravity.LEFT, ClipDrawable.HORIZONTAL);
		time_pb.setProgressDrawable(time_progress);
		time_pb.setBackgroundDrawable(getResources().getDrawable(
				android.R.drawable.progress_horizontal));
		timer_thread = new Thread(new Runnable() {
			public void run() throws NullPointerException {
				try {
					while (local < time) {
						local = quiz_timer.getTime();
						Thread.sleep(1000);
						if (local > (0.8 * time)) {
							pbTimeDrawable.getPaint().setColor(
									Color.parseColor(alertColor));
						} else {
							pbTimeDrawable.getPaint().setColor(
									Color.parseColor(normalColor));
						}
						time_pb.setProgress(local);
					}
					endOfExam();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}); // This block of code makes the progress bar update every second and
			// then calls the endOfExam() function once time is up
		timer_thread.setPriority(7);
		timer_thread.start();
		RelativeLayout.LayoutParams params_timepb = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.FILL_PARENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_timepb.addRule(RelativeLayout.RIGHT_OF, 21);
		time_pb.setLayoutParams(params_timepb);
		params_timepb.setMargins(0, 10, 0, 10);
		essentials.addView(time_pb, params_timepb);
		// End
		// Now drawing the progress bar for questions attempted
		TextView txt_pbQuestions = new TextView(this);
		txt_pbQuestions.setText("Questions Attempted   ");
		txt_pbQuestions.setId(22);
		txt_pbQuestions.setTypeface(Typeface.DEFAULT_BOLD);
		txt_pbQuestions.setTextSize(18);
		RelativeLayout.LayoutParams params_txtpbQuestions = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_txtpbQuestions.addRule(RelativeLayout.BELOW, 21);
		params_txtpbQuestions.addRule(RelativeLayout.RIGHT_OF, 30);
		params_txtpbQuestions.setMargins(0, 10, 0, 10);
		txt_pbQuestions.setLayoutParams(params_txtpbQuestions);
		essentials.addView(txt_pbQuestions, params_txtpbQuestions);
		questions_pb.setVisibility(ProgressBar.VISIBLE);
		questions_pb.setProgress(0);
		questions_pb.setMax(noOfQuestions);
		questions_pb.setId(12);
		final float[] roundedCorners_2 = new float[] { 5, 5, 5, 5, 5, 5, 5, 5 };
		final ShapeDrawable pbQuestionsDrawable = new ShapeDrawable(
				new RoundRectShape(roundedCorners_2, null, null));
		final String questionColor = "#3CC7C7";
		ClipDrawable questions_progress = new ClipDrawable(pbQuestionsDrawable,
				Gravity.LEFT, ClipDrawable.HORIZONTAL);
		questions_pb.setProgressDrawable(questions_progress);
		questions_pb.setBackgroundDrawable(getResources().getDrawable(
				android.R.drawable.progress_horizontal));
		pbQuestionsDrawable.getPaint()
				.setColor(Color.parseColor(questionColor));
		RelativeLayout.LayoutParams params_questionspb = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.FILL_PARENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_questionspb.addRule(RelativeLayout.BELOW, 11);
		params_questionspb.addRule(RelativeLayout.RIGHT_OF, 22);
		params_questionspb.setMargins(0, 10, 0, 10);
		questions_pb.setLayoutParams(params_questionspb);
		essentials.addView(questions_pb, params_questionspb);
		// End
		// Now displaying the maximum marks of the test
		TextView txt_maxMarks = new TextView(this);
		txt_maxMarks.setText("Max Marks: " + maxMarks);
		txt_maxMarks.setId(13);
		txt_maxMarks.setTypeface(Typeface.DEFAULT_BOLD);
		txt_maxMarks.setTextSize(18);
		RelativeLayout.LayoutParams params_txtmaxMarks = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_txtmaxMarks.addRule(RelativeLayout.BELOW, 30);
		txt_maxMarks.setLayoutParams(params_txtmaxMarks);
		essentials.addView(txt_maxMarks, params_txtmaxMarks);
		// End
		// Now displaying the number of questions
		TextView txt_Questions = new TextView(this);
		txt_Questions.setText(noOfQuestions + " questions");
		txt_Questions.setId(14);
		txt_Questions.setTypeface(Typeface.DEFAULT_BOLD);
		txt_Questions.setTextSize(18);
		RelativeLayout.LayoutParams params_txtQuestions = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_txtQuestions.addRule(RelativeLayout.CENTER_HORIZONTAL);
		params_txtQuestions.addRule(RelativeLayout.BELOW, 30);
		txt_Questions.setLayoutParams(params_txtQuestions);
		essentials.addView(txt_Questions, params_txtQuestions);
		// End
		// Now displaying the duration of the test
		TextView txt_time = new TextView(this);
		txt_time.setText("Duration: " + (time / 60)
				+ ((time / 60 == 1) ? " minute" : " minutes"));
		txt_time.setId(15);
		txt_time.setTypeface(Typeface.DEFAULT_BOLD);
		txt_time.setTextSize(18);
		RelativeLayout.LayoutParams params_txtTime = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_txtTime.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
		params_txtTime.addRule(RelativeLayout.BELOW, 30);
		txt_time.setLayoutParams(params_txtTime);
		essentials.addView(txt_time, params_txtTime);
		// End
		// Another set of initializations
		quizData = new int[noOfQuestions][6];
		solutions = new String[noOfQuestions];
		match_temp = new String[noOfQuestions][10];
		num_temp = new String[noOfQuestions][10];
		for (i = 0; i < noOfQuestions; i++) {
			solutions[i] = "";
			for (j = 0; j < 10; j++) {
				match_temp[i][j] = "";
				num_temp[i][j] = "";
			}
		}
		// End
		// Creating the array of the question specifications
		while (currentLine.hasMoreTokens()) {
			currentLine.nextToken();
		}
		for (i = 0; i < noOfQuestions; i++) {
			try {
				line = csvReader.readLine();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			currentLine = new StringTokenizer(line, ",");
			for (j = 0; j < 6; j++) {
				quizData[i][j] = Integer.parseInt(currentLine.nextToken());
			}
		}
		try {
			csvReader.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// End
		// Preparing the answer sheet
		for (i = 0; i < noOfQuestions; i++) {
			TextView questionNo = new TextView(this);
			questionNo.setText(String.valueOf(i + 1));
			questionNo.setId(1000 * (i + 1));
			questionNo.setTextSize(20);
			questionNo.setTypeface(Typeface.DEFAULT_BOLD);
			RelativeLayout.LayoutParams params_questionNo = new RelativeLayout.LayoutParams(
					RelativeLayout.LayoutParams.WRAP_CONTENT,
					RelativeLayout.LayoutParams.WRAP_CONTENT);
			params_questionNo.setMargins(0, 0, 10, 0);
			params_questionNo.addRule(RelativeLayout.BELOW, topElementId);
			topElementId = (1000 * (i + 1));
			questionNo.setLayoutParams(params_questionNo);
			answerSheet_relative.addView(questionNo, params_questionNo);
			switch (quizData[i][1]) {
			// Drawing for single correct and multiple correct type questions
			case 1:
			case 2:
				for (j = 0; j < quizData[i][2]; j++) {
					ImageView option = new ImageView(this);
					option.setImageResource(questionImages[0][j]);
					option.setId((1000 * (i + 1)) + j + 1);
					option.setOnClickListener(this);
					option.setTag("0");
					RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					params.addRule(RelativeLayout.BELOW, ((1000 * i) + 1));
					params.addRule(RelativeLayout.RIGHT_OF,
							((1000 * (i + 1)) + j));
					topElementId = ((1000 * (i + 1)) + j);
					option.setLayoutParams(params);
					answerSheet_relative.addView(option, params);
				}
				break;
			// Drawing for integer type questions
			case 3:
				for (j = 0; j < (quizData[i][3] == 0 ? quizData[i][2]
						+ quizData[i][3] : quizData[i][2] + quizData[i][3] + 1); j++) {
					for (k = 10; k > -1; k--) {
						ImageView num = new ImageView(this);
						num.setImageResource(questionImages[2][10 - k]);
						num.setId((1000 * (i + 1)) + (100 * j) + k + 1);
						num.setOnClickListener(this);
						num.setTag("0");
						RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
								RelativeLayout.LayoutParams.WRAP_CONTENT,
								RelativeLayout.LayoutParams.WRAP_CONTENT);
						if (j == 0) {
							params.addRule(RelativeLayout.RIGHT_OF,
									(1000 * (i + 1)));
						} else {
							params.addRule(RelativeLayout.RIGHT_OF,
									(1000 * (i + 1)) + (100 * (j - 1)) + k + 1);
						}
						if (k == 10) {
							params.addRule(RelativeLayout.BELOW, (1000 * i) + 1);
						} else {
							params.addRule(RelativeLayout.BELOW,
									((1000 * (i + 1)) + (100 * j) + k + 2));
						}
						num.setLayoutParams(params);
						answerSheet_relative.addView(num, params);
					}
				}
				topElementId = (1000 * (i + 1)) + 1;
				break;
			// Drawing for match the following and matrix match
			case 4:
			case 5:
				for (j = quizData[i][2] - 1; j > -1; j--) {
					for (k = 0; k < quizData[i][3]; k++) {
						ImageView match = new ImageView(this);
						match.setImageResource(questionImages[0][k]);
						match.setId((1000 * (i + 1)) + (100 * j) + k + 1);
						match.setOnClickListener(this);
						match.setTag("0");
						RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
								RelativeLayout.LayoutParams.WRAP_CONTENT,
								RelativeLayout.LayoutParams.WRAP_CONTENT);
						if (k == 0) {
							params.addRule(RelativeLayout.RIGHT_OF,
									(1000 * (i + 1)));
						} else {
							params.addRule(RelativeLayout.RIGHT_OF,
									(1000 * (i + 1)) + (100 * j) + k);
						}
						if (j == quizData[i][2] - 1) {
							params.addRule(RelativeLayout.BELOW, (1000 * i) + 1);
						} else {
							params.addRule(RelativeLayout.BELOW,
									(1000 * (i + 1)) + (100 * (j + 1)) + k + 1);
						}
						match.setLayoutParams(params);
						answerSheet_relative.addView(match, params);
					}
				}
				topElementId = (1000 * (i + 1)) + 1;
				break;
			}
		}
		// Adding the submit button
		Button submit = new Button(this);
		submit.setId(0);
		submit.setText("Submit Test");
		submit.setOnClickListener(this);
		RelativeLayout.LayoutParams params_submit = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_submit.addRule(RelativeLayout.BELOW, topElementId);
		params_submit.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
		params_submit.setMargins(0, 20, 0, 0);
		submit.setLayoutParams(params_submit);
		answerSheet_relative.addView(submit, params_submit);
		// End
		// Adding the back button
		final RelativeLayout back_button = new RelativeLayout(this);
		Button back = new Button(this);
		back.setId(2);
		back.setText("Question Paper");
		back.setOnClickListener(this);
		RelativeLayout.LayoutParams params_back = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		params_back.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
		params_back.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
		params_back.setMargins(0, 0, 0, 20);
		back.setLayoutParams(params_back);
		back_button.addView(back, params_back);
		final RelativeLayout.LayoutParams params_backButton = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.FILL_PARENT,
				RelativeLayout.LayoutParams.FILL_PARENT);
		params_backButton.addRule(RelativeLayout.BELOW, 10);
		// End
		// Now adding the answer sheet to the global layout
		params_answerSheet.addRule(RelativeLayout.BELOW, 10);
		answerSheet.addView(answerSheet_relative, new LayoutParams(
				LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT));
		answerSheet.setLayoutParams(params_answerSheet);
		globalLayout.addView(answerSheet, params_answerSheet);
		globalLayout.addView(back_button, params_backButton);
		this.setContentView(globalLayout);

		String val = "mnt/sdcard/question.pdf";
		m_doc.Open(val, "", "");

		lout = (RelativeLayout) LayoutInflater.from(this).inflate(
				R.layout.main, null);
		globalLayout.removeView(answerSheet);
		globalLayout.addView(lout, params_answerSheet);
		globalLayout.removeView(back_button);
		this.setContentView(globalLayout);
		// setContentView(lout);

		m_vPDF = (PDFReader) lout.findViewById(R.id.PDFView);
		m_vPDF.open(m_doc);
		// m_vPDF.setAnnotListener(this);
		m_vPDF.setViewListener(m_vPDF);

		Button b = (Button) findViewById(com.radaee.reader.R.id.button1);
		b.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				globalLayout.removeView(lout);
				globalLayout.addView(answerSheet, params_answerSheet);
				globalLayout.addView(back_button, params_backButton);
				PDFReaderAct.this.setContentView(globalLayout);
			}
		});

		back.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				globalLayout.removeView(answerSheet);
				globalLayout.removeView(back_button);
				globalLayout.addView(lout, params_answerSheet);
				PDFReaderAct.this.setContentView(globalLayout);
			}
		});

		NotificationManager nm = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
		nm.cancelAll();
	}

	// Function to set the progress bar for questions attempted
	public void setQuestionProgress() {
		int i; // Loop variable
		int questionsAttempted = 0; // Variable to store the number of questions
									// attempted
		for (i = 0; i < noOfQuestions; i++) {
			if (solutions[i] != "") {
				questionsAttempted++;
			}
		}
		questions_pb.setProgress(questionsAttempted);
	}

	public String sortArray(String array, int val, int flag) {
		// Beginning of variable declarations and initializations
		if (array == null) {
			array = "";
		}
		int length = array.length(); // Length of the array
		int i = 0; // Loop variable
		int j = 0; // To catch the index of the deleted number
		int temp = 0; // For swapping
		int[] arrayVal = new int[length + 1];
		// End
		// If block is executed when option is added (flag = 1) and else block
		// is executed when option is removed (flag = 0)
		if (flag == 1) {
			for (i = 0; i < length; i++) {
				arrayVal[i] = Integer.parseInt("" + array.charAt(i));
			}
			arrayVal[i] = val;
			for (i = 0; i < length + 1; i++) {
				for (j = i + 1; j < length + 1; j++) {
					if (arrayVal[i] > arrayVal[j]) {
						temp = arrayVal[i];
						arrayVal[i] = arrayVal[j];
						arrayVal[j] = temp;
					}
				}
			}
			array = "";
			for (i = 0; i < length + 1; i++) {
				array = array + String.valueOf(arrayVal[i]);
			}
		} else if (flag == 0) {
			for (i = 0; i < length; i++) {
				if (val == Integer.parseInt("" + array.charAt(i))) {
					arrayVal[i] = -1;
					j = i;
				} else {
					arrayVal[i] = Integer.parseInt("" + array.charAt(i));
				}
			}
			for (i = j; i < length - 1; i++) {
				arrayVal[i] = arrayVal[i + 1];
			}
			arrayVal[i] = 1000;
			array = "";
			for (i = 0; i < length - 1; i++) {
				array = array + String.valueOf(arrayVal[i]);
			}
		}
		return array;
	}

	// Function which makes the final string with all the answers
	public String makeFinalString() {
		// Beginning of variable declarations
		String answers = ""; // All the answers as one string
		int i = 0; // Loop variable
		// End of variable declarations
		for (i = 0; i < noOfQuestions; i++) {
			if (solutions[i] == "") {
				answers = answers + "-1;"; // -1 is added when question is not
											// attempted
			} else {
				answers = answers + solutions[i] + ";";
			}
		}
		answers = answers.substring(0, answers.length() - 1);
		System.out.println(answers);
		return answers;
	}

	// Function called at the end of the exam - either when time runs out or
	// submit button is clicked
	public void endOfExam() {
		finalAnswer = makeFinalString();
		Myclass.setstate2(false);
		result = QuizStudentActivity.end();
		startActivity(new Intent(PDFReaderAct.this, Result.class));
//		System.exit(0);
	}

	// onClick event when anything is clicked
	public void onClick(View v) {
		// TODO Auto-generated method stub
		// Beginning of variable declarations and initializations
		int clickedButton = v.getId();
		int questionNo = clickedButton / 1000; // Finding the question number
		int i = 0; // Loop variable
		int rowNo = (clickedButton / 100) % 10;
		// End
		if (clickedButton == 0) {
			endOfExam();
		} else if (clickedButton == 2) {
			// Code for Back Button
		} else if (clickedButton == 41) {
			System.exit(0);
			// Code for ending the app
		} else {
			switch (quizData[questionNo - 1][1]) {
			case 1:
				for (i = 0; i < quizData[questionNo - 1][2]; i++) {
					ImageView option = new ImageView(this);
					option.setImageResource(questionImages[0][i]);
					option.setId((1000 * questionNo) + i + 1);
					option.setOnClickListener(this);
					option.setTag("0");
					RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					params.addRule(RelativeLayout.BELOW,
							((1000 * (questionNo - 1)) + 1));
					params.addRule(RelativeLayout.RIGHT_OF,
							((1000 * questionNo) + i));
					option.setLayoutParams(params);
					answerSheet_relative.addView(option, params);
				}
				if (v.getTag() == "0") {
					ImageView option = new ImageView(this);
					option.setImageResource(questionImages[1][(clickedButton % 10) - 1]);
					option.setId((1000 * questionNo) + (clickedButton % 10));
					option.setOnClickListener(this);
					option.setTag("1");
					solutions[questionNo - 1] = String
							.valueOf((clickedButton % 10) - 1);
					finalAnswer = makeFinalString();
					setQuestionProgress();
					RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					params.addRule(RelativeLayout.BELOW,
							((1000 * (questionNo - 1)) + 1));
					params.addRule(RelativeLayout.RIGHT_OF,
							((1000 * questionNo) + (clickedButton % 10) - 1));
					option.setLayoutParams(params);
					answerSheet_relative.addView(option, params);
				} else if (v.getTag() == "1") {
					solutions[questionNo - 1] = "";
					finalAnswer = makeFinalString();
					setQuestionProgress();
				}
				break;
			case 2:
				ImageView checked = new ImageView(this);
				if (v.getTag() == "0") {
					checked.setImageResource(questionImages[1][(clickedButton % 10) - 1]);
					checked.setId((1000 * questionNo) + (clickedButton % 10));
					checked.setOnClickListener(this);
					checked.setTag("1");
					solutions[questionNo - 1] = sortArray(
							solutions[questionNo - 1],
							(clickedButton % 10) - 1, 1);
				} else if (v.getTag() == "1") {
					checked.setImageResource(questionImages[0][(clickedButton % 10) - 1]);
					checked.setId((1000 * questionNo) + (clickedButton % 10));
					checked.setOnClickListener(this);
					checked.setTag("0");
					solutions[questionNo - 1] = sortArray(
							solutions[questionNo - 1],
							(clickedButton % 10) - 1, 0);
				}
				finalAnswer = makeFinalString();
				setQuestionProgress();
				RelativeLayout.LayoutParams params_checked = new RelativeLayout.LayoutParams(
						RelativeLayout.LayoutParams.WRAP_CONTENT,
						RelativeLayout.LayoutParams.WRAP_CONTENT);
				params_checked.addRule(RelativeLayout.BELOW,
						((1000 * (questionNo - 1)) + 1));
				params_checked.addRule(RelativeLayout.RIGHT_OF,
						((1000 * questionNo) + (clickedButton % 10) - 1));
				checked.setLayoutParams(params_checked);
				answerSheet_relative.addView(checked, params_checked);
				break;
			case 3:
				for (i = 10; i > -1; i--) {
					ImageView num = new ImageView(this);
					num.setImageResource(questionImages[2][10 - i]);
					num.setId((1000 * questionNo) + (100 * rowNo) + i + 1);
					num.setOnClickListener(this);
					num.setTag("0");
					RelativeLayout.LayoutParams params_num = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					if (rowNo == 0) {
						params_num.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo));
					} else {
						params_num.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo) + (100 * (rowNo - 1)) + i
										+ 1);
					}
					if (i == 10) {
						params_num.addRule(RelativeLayout.BELOW,
								(1000 * (questionNo - 1)) + 1);
					} else {
						params_num.addRule(RelativeLayout.BELOW,
								((1000 * questionNo) + (100 * rowNo) + i + 2));
					}
					num.setLayoutParams(params_num);
					answerSheet_relative.addView(num, params_num);
				}
				if (v.getTag() == "0") {
					ImageView num = new ImageView(this);
					num.setImageResource(questionImages[3][11 - (clickedButton % 100)]);
					num.setId((1000 * questionNo) + (100 * rowNo)
							+ (clickedButton % 100));
					num.setOnClickListener(this);
					num.setTag("1");
					if ((clickedButton % 100) == 1) {
						num_temp[questionNo - 1][rowNo] = ".";
					} else {
						num_temp[questionNo - 1][rowNo] = String
								.valueOf(11 - (clickedButton % 100));
					}
					solutions[questionNo - 1] = "";
					for (i = 0; i < (quizData[questionNo - 1][3] == 0 ? quizData[questionNo - 1][2]
							+ quizData[questionNo - 1][3]
							: quizData[questionNo - 1][2]
									+ quizData[questionNo - 1][3] + 1); i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ num_temp[questionNo - 1][i];
					}
					finalAnswer = makeFinalString();
					setQuestionProgress();
					// System.out.println(solutions[questionNo - 1]);
					RelativeLayout.LayoutParams params_num = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					if (rowNo == 0) {
						params_num.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo));
					} else {
						params_num.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo) + (100 * (rowNo - 1))
										+ (clickedButton % 100));
					}
					if (((clickedButton % 100) - 1) == 10) {
						params_num.addRule(RelativeLayout.BELOW,
								(1000 * (questionNo - 1)) + 1);
					} else {
						params_num.addRule(RelativeLayout.BELOW,
								((1000 * questionNo) + (100 * rowNo)
										+ (clickedButton % 100) + 1));
					}
					num.setLayoutParams(params_num);
					answerSheet_relative.addView(num, params_num);
				} else if (v.getTag() == "1") {
					num_temp[questionNo - 1][rowNo] = "";
					solutions[questionNo - 1] = "";
					for (i = 0; i < (quizData[questionNo - 1][3] == 0 ? quizData[questionNo - 1][2]
							+ quizData[questionNo - 1][3]
							: quizData[questionNo - 1][2]
									+ quizData[questionNo - 1][3] + 1); i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ num_temp[questionNo - 1][i];
					}
					finalAnswer = makeFinalString();
					setQuestionProgress();
				}
				break;
			case 4:
				for (i = 0; i < quizData[questionNo - 1][3]; i++) {
					ImageView match = new ImageView(this);
					match.setImageResource(questionImages[0][i]);
					match.setId((1000 * questionNo) + (100 * rowNo) + i + 1);
					match.setOnClickListener(this);
					match.setTag("0");
					RelativeLayout.LayoutParams params_match = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					if (i == 0) {
						params_match.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo));
					} else {
						params_match.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo) + (100 * rowNo) + i);
					}
					if (rowNo == quizData[questionNo - 1][2] - 1) {
						params_match.addRule(RelativeLayout.BELOW,
								(1000 * (questionNo - 1)) + 1);
					} else {
						params_match.addRule(RelativeLayout.BELOW,
								(1000 * questionNo) + (100 * (rowNo + 1)) + i
										+ 1);
					}
					match.setLayoutParams(params_match);
					answerSheet_relative.addView(match, params_match);
				}
				if (v.getTag() == "0") {
					ImageView match = new ImageView(this);
					match.setImageResource(questionImages[1][(clickedButton % 10) - 1]);
					match.setId((1000 * questionNo) + (100 * rowNo)
							+ (clickedButton % 10));
					match.setOnClickListener(this);
					match.setTag("1");
					match_temp[questionNo - 1][quizData[questionNo - 1][2]
							- (rowNo + 1)] = String
							.valueOf((clickedButton % 10) - 1);
					solutions[questionNo - 1] = "";
					for (i = 0; i < quizData[questionNo - 1][2]; i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ match_temp[questionNo - 1][i];
					}
					finalAnswer = makeFinalString();
					setQuestionProgress();
					// System.out.println(solutions[questionNo - 1]);
					RelativeLayout.LayoutParams params_match = new RelativeLayout.LayoutParams(
							RelativeLayout.LayoutParams.WRAP_CONTENT,
							RelativeLayout.LayoutParams.WRAP_CONTENT);
					if (((clickedButton % 10) - 1) == 0) {
						params_match.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo));
					} else {
						params_match.addRule(RelativeLayout.RIGHT_OF,
								(1000 * questionNo) + (100 * rowNo)
										+ (clickedButton % 10) - 1);
					}
					if (rowNo == quizData[questionNo - 1][2] - 1) {
						params_match.addRule(RelativeLayout.BELOW,
								(1000 * (questionNo - 1)) + 1);
					} else {
						params_match.addRule(RelativeLayout.BELOW,
								(1000 * (questionNo)) + (100 * (rowNo + 1))
										+ (clickedButton % 10));
					}
					match.setLayoutParams(params_match);
					answerSheet_relative.addView(match, params_match);
				} else if (v.getTag() == "1") {
					match_temp[questionNo - 1][quizData[questionNo - 1][2]
							- (rowNo + 1)] = "";
					solutions[questionNo - 1] = "";
					for (i = 0; i < quizData[questionNo - 1][2]; i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ match_temp[questionNo - 1][i];
					}
					finalAnswer = makeFinalString();
					setQuestionProgress();
				}
				break;
			case 5:
				ImageView match_checked = new ImageView(this);
				if (v.getTag() == "0") {
					match_checked
							.setImageResource(questionImages[1][(clickedButton % 10) - 1]);
					match_checked.setId((1000 * questionNo) + (100 * rowNo)
							+ (clickedButton % 10));
					match_checked.setOnClickListener(this);
					match_checked.setTag("1");
					match_temp[questionNo - 1][quizData[questionNo - 1][2]
							- (rowNo + 1)] = sortArray(
							match_temp[questionNo - 1][quizData[questionNo - 1][2]
									- (rowNo + 1)], (clickedButton % 10) - 1, 1);
					solutions[questionNo - 1] = "";
					for (i = 0; i < quizData[questionNo - 1][2]; i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ match_temp[questionNo - 1][i] + ".";
					}
					solutions[questionNo - 1] = solutions[questionNo - 1]
							.substring(0,
									solutions[questionNo - 1].length() - 1);
					finalAnswer = makeFinalString();
					setQuestionProgress();
				} else if (v.getTag() == "1") {
					match_checked
							.setImageResource(questionImages[0][(clickedButton % 10) - 1]);
					match_checked.setId((1000 * questionNo) + (100 * rowNo)
							+ (clickedButton % 10));
					match_checked.setOnClickListener(this);
					match_checked.setTag("0");
					match_temp[questionNo - 1][quizData[questionNo - 1][2]
							- (rowNo + 1)] = sortArray(
							match_temp[questionNo - 1][quizData[questionNo - 1][2]
									- (rowNo + 1)], (clickedButton % 10) - 1, 0);
					solutions[questionNo - 1] = "";
					for (i = 0; i < quizData[questionNo - 1][2]; i++) {
						solutions[questionNo - 1] = solutions[questionNo - 1]
								+ match_temp[questionNo - 1][i] + ".";
					}
					solutions[questionNo - 1] = solutions[questionNo - 1]
							.substring(0,
									solutions[questionNo - 1].length() - 1);
					int flag = 0;
					for (i = 0; i < quizData[questionNo - 1][2]; i++) {
						if (match_temp[questionNo - 1][i] != "") {
							flag = 1;
							break;
						}
					}
					if (flag == 0) {
						solutions[questionNo - 1] = "";
					}
					finalAnswer = makeFinalString();
					setQuestionProgress();
				}
				RelativeLayout.LayoutParams params_mc = new RelativeLayout.LayoutParams(
						RelativeLayout.LayoutParams.WRAP_CONTENT,
						RelativeLayout.LayoutParams.WRAP_CONTENT);
				if (((clickedButton % 10) - 1) == 0) {
					params_mc.addRule(RelativeLayout.RIGHT_OF,
							1000 * questionNo);
				} else {
					params_mc.addRule(RelativeLayout.RIGHT_OF,
							(1000 * questionNo) + (100 * rowNo)
									+ (clickedButton % 10) - 1);
				}
				if (rowNo == quizData[questionNo - 1][2] - 1) {
					params_mc.addRule(RelativeLayout.BELOW,
							(1000 * (questionNo - 1)) + 1);
				} else {
					params_mc.addRule(RelativeLayout.BELOW,
							(1000 * (questionNo)) + (100 * (rowNo + 1))
									+ (clickedButton % 10));
				}
				match_checked.setLayoutParams(params_mc);
				answerSheet_relative.addView(match_checked, params_mc);
				break;
			}
		}
	}

	protected void onDestroy() {
		if (m_vPDF != null)
			m_vPDF.close();
		super.onDestroy();
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


	 //disable home buton	  
	  @Override public void onAttachedToWindow() {
	  this.getWindow().setType(WindowManager.LayoutParams.TYPE_KEYGUARD);
	  super.onAttachedToWindow(); }
	 
	@Override
	protected void onPause() {
		getTeleService();
		MediaPlayer mp = MediaPlayer.create(PDFReaderAct.this, R.raw.beep);
		if (Myclass.getstate2()) {
			System.out.println("beep");
			mp.start();
		}
		super.onPause();
	}

	@Override
	protected void onStop() {
		getTeleService();
		MediaPlayer mp = MediaPlayer.create(PDFReaderAct.this, R.raw.beep);
		if (Myclass.getstate2()) {
			System.out.println("beep");
			mp.start();
		}
		super.onStop();
	}

	@Override
	protected void onResume() {
		Myclass.setstate2(true);
		super.onResume();
	}

	@Override
	protected void onRestart() {
		Myclass.setstate2(true);
		super.onRestart();
	}

}