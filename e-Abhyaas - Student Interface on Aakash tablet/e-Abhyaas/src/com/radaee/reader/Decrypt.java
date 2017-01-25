package com.radaee.reader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.CipherOutputStream;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class Decrypt {

	public static void Decryption() throws IOException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException{
		try{
			int read;
		System.out.println("one");
        File outfile = new File("mnt/sdcard/question.o");
		System.out.println("two");
/*        if(!outfile.exists())
        {
            outfile.createNewFile();
        }*/
        File decfile = new File("mnt/sdcard/question.pdf");
        if(!decfile.exists())
            decfile.createNewFile();
        FileInputStream encfis = new FileInputStream(outfile);
        FileOutputStream decfos = new FileOutputStream(decfile);
        Cipher decipher = Cipher.getInstance("AES");
		System.out.println("three");

        byte[] encoded = new BigInteger(Myclass.data, 16).toByteArray();
		System.out.println("four");
        SecretKey aesKey = new SecretKeySpec(encoded, "AES");
		System.out.println("five");
        decipher.init(Cipher.DECRYPT_MODE, aesKey);
		System.out.println("six");
        CipherOutputStream cos = new CipherOutputStream(decfos,decipher);
 //       while((read=encfis.read())!=-1)
        
        	for(int i =0; i< outfile.length();i++)
        
        {
        	read=encfis.read();
            cos.write(read);
            cos.flush();
            
        }
            cos.close();
        }catch(Exception e){
        	System.out.println("Error in decryption");
        }
	}
	


}
