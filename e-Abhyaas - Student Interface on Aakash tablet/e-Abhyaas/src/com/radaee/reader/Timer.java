package com.radaee.reader;

import java.util.Date;

public class Timer {
	int init_hh, init_mm, init_ss;
	static Date d;

	public Timer() {
		d = new Date();
		init_hh = d.getHours();
		init_mm = d.getMinutes();
		init_ss = d.getSeconds();
	}

	public int getTime() {
		d = new Date();
		int a, b, c, sum = 0, hh, mm, ss;
		a = init_hh;
		b = init_mm;
		c = init_ss;
		hh = d.getHours();
		mm = d.getMinutes();
		ss = d.getSeconds();
		if (ss >= c) {
			sum += ss - c;
		} else {
			ss += 60;
			sum += ss - c;
			mm--;
		}
		if (mm >= b) {
			sum += 60 * (mm - b);
		} else {
			mm += 60;
			sum += 60 * (mm - b);
			hh--;
		}
		if (hh >= a) {
			sum += 3600 * (hh - a);
		}
		return sum;
	}
}
