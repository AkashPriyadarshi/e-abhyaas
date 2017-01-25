package com.radaee.reader;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.*;

public class Accept {

	public void FileAccept(InputStream clientInputStream, String fileName,
			DataInputStream in) {

		FileOutputStream file;
		boolean flag = true;
		System.out.print("hi file transfer start in few sec...");

		try {
			long startTime = System.currentTimeMillis();

			file = new FileOutputStream(fileName, true);
			System.out.println("file trsnsfer start of file");
			String s = in.readUTF();
			byte[] buffer = new byte[64];
			int read;
			int totalRead = 0;

			int i = Integer.parseInt(s);
			System.out.println(i + "  " + s);
			for (int j = i; j > 0; j -= 64) {

				 {  
					 if(j<64){buffer=new byte[j];}
					read = clientInputStream.read(buffer);
					file.write(buffer);
				}
				totalRead += read;
			}
			System.out.println(fileName);
			file.flush();
			file.close();
			long endTime = System.currentTimeMillis();
			System.out.println(totalRead + " bytes read in "
					+ (endTime - startTime) + " ms.");
		} catch (FileNotFoundException f) {
			System.out.println("error two " + f);
		} catch (IOException e) {
			System.out.println(e);
			System.exit(0);
		}

	}
}
