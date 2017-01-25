/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.io.File;

/**
 * 
 * @author akash
 */
/*
 * This class is used to transfer file to client tablet.
 * 
 */
public class Transfer {
         /*
          * this function takes client socket , file name and dataoutputStream as arguments and 
          * transfer the  specified file to client computer
          * 
          */
	public static void fileTransfer(Socket client, File file,
			DataOutputStream out) {
		try {

			System.out.println(file.length()); //file length is obtained
			String length = "" + file.length();
			FileInputStream fileInputStream = new FileInputStream(file);//fileinput Stream is created
			OutputStream socketOutputStream = client.getOutputStream(); //fileoutput Stream is created
			long startTime = System.currentTimeMillis();               //current system time is obtained 
			byte buffer[] = new byte[64];
			int read;
			int readTotal = 0;
			out.writeUTF(length);                                     //file length is transferred to client computer
			
			System.out.println(file.length());
                        //loop is used to read the file and send data packets to client tablet
			for (int j = (int) file.length(); j > 0; j -= 64) {
				read = fileInputStream.read(buffer);
				socketOutputStream.write(buffer, 0, read);
				readTotal += read;
			}
                       //time taken to transfer file is printed
			long endTime = System.currentTimeMillis();
			System.out.println(readTotal + " bytes written in "
					+ (endTime - startTime) + " ms.");

			// socketOutputStream.close();
			fileInputStream.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
