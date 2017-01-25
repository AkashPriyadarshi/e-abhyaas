<%--
    This page carries out the process of opening a browser window to save the zip file on invigilator's computer.
--%>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page contentType="application/octet-stream" pageEncoding="UTF-8" import="java.io.*,java.net.*,java.util.*,javax.servlet.* "%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>e-Abhyaas : Invigilator</title>
    </head>

    <%
    BufferedInputStream filein = null;
BufferedOutputStream outputs = null;
try {
File file = new File( request.getParameter("file"));//specify the file path

byte b[] = new byte[4000]; // setting the maximum size of file to be downloaded
int len = 0;
filein = new BufferedInputStream(new FileInputStream(file)); // reading the file which is to be provided for download
outputs = new BufferedOutputStream(response.getOutputStream()); // the output file
response.setHeader("Content-Length", ""+file.length());
response.setContentType("application/zip");//specifying the type of file to be provided for download
response.setHeader("Content-Disposition","attachment;filename=Invigilator.zip");//specifying the default name with which the concerned file will be saved on Invigilator's computer
response.setHeader("Content-Transfer-Encoding", "binary");
while ((len = filein.read(b)) > 0) // while we don't reach the end of file, we keep reading it and write it in 'outputs'
{
    outputs.write(b, 0, len);
    outputs.flush();
    }
}
catch(Exception e)
{ out.println(e);
}
%>
    <body>

    </body>
</html>
