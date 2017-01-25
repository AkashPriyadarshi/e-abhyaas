<%--
This page is used to obfuscate the question paper uploaded by  the teacher so as to make it incomprehensible for anyone except the student and teacher.
It yields a .o file which is provided to the invigilator for download
The file is decrypted on the student tablet to lead the original pdf question paper for the student.
This file is also used to create a CSV file and write the encryption key in it
This CSV file(key.csv) also has to be made available to the invigilator as it has to be passed onto each student tablet so that the question paper gets
successfully decrypted at the student's end

--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@ page import="java.io.*,java.util.*, javax.servlet.*,java.sql.*,java.io.*,java.lang.*,javax.crypto.*,java.math.*,java.security.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>

<title>e-Abhyaas : Teacher</title>

</HEAD>
<%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>
<BODY>

<%
   String fileName=(String)session.getAttribute("fileName");
   
      try{

          int read;
		FileInputStream fis = new FileInputStream(new File("uploads/"+fileName+".pdf"));
		File outfile = new File("uploads/"+fileName+".o");// initialises the output file which is a .o file
        if(!outfile.exists())
        {
    		outfile.createNewFile(); // create a new object file with name same as the invigilator's id
        }
        FileOutputStream fos = new FileOutputStream(outfile);
        Cipher encipher = Cipher.getInstance("AES");
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        SecretKey skey = kgen.generateKey();

        byte[] encoded = skey.getEncoded();
        String data = new BigInteger(1, encoded).toString(16);//the variable 'data' contains the encryption/decryption key
        
        /*creating a CSV file and writing the encryption key in it*/
       FileWriter fw = new FileWriter("k$"+fileName+".csv");
 fw.append(data);
fw.append(",");

fw.flush();
fw.close();
/*creation of CSV file complete*/
/*encryption process continues*/
        encipher.init(Cipher.ENCRYPT_MODE, skey);
        CipherInputStream cis = new CipherInputStream(fis, encipher);
        while((read = cis.read())!=-1)
                {
            System.out.println("123");
                    fos.write((char)read);
                    fos.flush();
                }
        fos.close();
        
/*encryption ends, the .o file is successfully created and saved at desired location*/

        %>
        <jsp:forward page="teacherIndex.jsp"/>
        <%
            
         
        out.println("Thank you for uploading question paper ");
      }catch(Exception ex) {
         System.out.println(ex);
         %>
          <jsp:forward page="teacherIndex.jsp"/>
         <%

      }
   
  

%>
</BODY>

 <%
}
else
{
%>
<jsp:forward page="index.jsp"/>
<%
}
%>

</HTML>
