<%-- 
    This page allows the invigilator to download all the files required at the time of test invigilation.
    Invigilator is provided a download link of the ZIP folder containing all the files
    The ZIP folder includes-
   1. Question specifications CSV file
   2. Questions specifications and Answers CSV file
   3. Photographs of all students
      (each photograph must be saved by the name of student's tablet mac ID with all colons(:) replaced by (-). 
       For ex.- if the mac address is 00:0f:cf:02:24:39 then the corresponding student's photograph must be saved with the name 00-0f-cf-02-24-39.jpg)
   4. CSV file containing total number of students, names and mac IDs of all students under the invigilator logged in
   5. Obfuscated Question Paper(Obfuscation is done by encrypting .pdf file to .o file)
   6. CSV file containing the key for decryption
   7. Connectify Installer(this is a .exe file which the invigilator needs to install on his computer to connect to all the student tablets)


--%>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<%@ page import="org.apache.commons.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.zip.*,java.io.*,java.sql.*,java.io.*,java.lang.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>e-Abhyaas : Invigilator</title>
        <link href="main_style.css" rel="stylesheet" type="text/css" />

    </head>
     <%
    if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
    {
     String filename= (String)(session.getAttribute("name"));  /*email id of the invigilator logged in*/
    %>
    <body>
        
    <div id="main_container">

    <div id="main_header">
    	<div id="logosection">
	        <div class="sitelogo"><img src="images/people.gif" width="215" height="75"></img></div>
        	<div class="sitename">&nbsp;e-<font style="font-family: Samarkan">&nbsp;Abhyaas</font></div>
      </div>
        <div id="header">
        	<div class="title">
        	  <p>Education through<br />
       	      <span class="bigtext">The Aakash Tablet</span></p>
        	  <p><br />
      	    </p>
            </div>

        </div>
	</div>

	<div id="main_menu">
    	<div id="search">
				
    	</div>
        <div id="menu">
            <ul>
               <li><a href="invigilatorIndex.jsp">Home</a></li>
                <li><a href="centreallotment.jsp">Centre Allotment</a></li>
                <li><a href="seatingArrangement.jsp">Seating Arrangement</a></li>
                <li><a href="download.jsp" class="current" >Downloads</a></li>
                <li><a href="uploadResults.jsp" >Result</a></li>
            </ul>
        </div>
	</div>



	<div id="main_content">



    	<div id="main_left_column">

            <div id="leftcolumn_box01">
                <div class="leftcolumn_box01_top">
                    <h2>Welcome <%= session.getAttribute("firstName")%>!!</h2>
                </div>
                <div class="leftcolumn_box01_bottom">
                    <form method="post" action="#">
                      <div class="form_row"><a href="logout.jsp"/></div>
                        <div class="form_row"><label></label>
                        </div>
                  </form>
                </div>
            </div>

          <div id="leftcolumn_box02">
       	    <h2>Log Out</h2>
              <ul>

                  <li> </li>
                  <li></li>
              </ul>
            </div>

			<div id="imagebutton"><a href="#"><img src="images/SM111378.gif" alt="" width="220" height="138" /></a></div>

        </div>


   	  <div id="main_middle_column">
        
        <p>&nbsp;</p>
        <%
        /*Establishing connection with the back end Ms-Access database named 'one'*/
        
            Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
             Statement s1=con.createStatement();
             String query1="select TestAllotted from registration where Email='"+filename+"' and Role='Invigilator'";
             ResultSet rs=s1.executeQuery(query1);
             while(rs.next())
                {
                 String s=rs.getString(1);
                 s=s.replace(".pdf",""); /*removing the extension of the testname(testname contains the name of teacher who uploaded the paper followed by a ';' and then the name of the test as given by the teacher)*/

                  
                 try
 {
                     File newfolder = new File(filename);
                       newfolder.mkdir(); /*creating a new folder by the name of invigilator*/
                       /*copying all concerned files in this folder from their current location*/
                       File path=new File("q$"+s+";1.csv");
                      File newPath= (new File(filename+"/Questions.csv"));
                     FileUtils.copyFile(path, newPath);
           
                      File path1=new File("a$"+s+";1.csv");
                      File newPath1= (new File(filename+"/QuestionsAndAnswers.csv"));
                      FileUtils.copyFile(path1, newPath1);

                      File path2=new File("k$"+s+".csv");
                      File newPath2= (new File(filename+"/Key.csv"));
                      FileUtils.copyFile(path2, newPath2);
               /*read the directory containing all the photos to transfer photos*/
              File directory=new File(filename+";photo");
              File[] myarray;
            myarray=directory.listFiles();


for (int j = 0; j < myarray.length; j++)
{
    /*iterate to transfer all the photos to the newly created folder*/
        File path3=myarray[j];
        File newPath3= (new File((filename+"/"+myarray[j].getName())));
        FileUtils.copyFile(path3, newPath3);

}
          /*transfer the remaining files to the newly created folder*/
             File path4=new File("uploads/"+s+".o");
            File newPath4= (new File(filename+"/Questions.o"));
            FileUtils.copyFile(path4, newPath4);

              File path5=new File("uploads/student;"+filename+".csv");
              File newPath5= (new File(filename+"/StudentList.csv"));
              FileUtils.copyFile(path5, newPath5);

              File path6=new File("ConnectifyInstaller.exe");
              File newPath6= (new File(filename+"/ConnectifyInstaller.exe"));
              FileUtils.copyFile(path6, newPath6);

              File path7=new File("uploads/student;"+filename+"_1.csv");
              File newPath7= (new File(filename+"/StudentNames.csv"));
              FileUtils.copyFile(path7, newPath7);
        
     /*zipping the newly created folder*/
 File inFolder=new File(filename);
   File outFolder=new File(filename+".zip");
 ZipOutputStream outp = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(outFolder)));
 BufferedInputStream in = null;
 byte[] data  = new byte[4000];
 String files[] = inFolder.list();
 for (int i=0; i<files.length; i++)
  {
  in = new BufferedInputStream(new FileInputStream
(inFolder.getPath() + "/" + files[i]), 4000);
outp.putNextEntry(new ZipEntry(files[i]));
  int count;
  while((count = in.read(data,0,4000)) != -1)
  {
 outp.write(data, 0, count);
  }
  outp.closeEntry();
  }
  outp.flush();
  outp.close();
  }
  catch(Exception e)
 {
  e.printStackTrace();
  }
     %>
             <p>The Zip folder contains-</p>
             <p>1.Questions.csv</p>
             <p>2.QuestionsAndAnswers.csv</p>
             <p>3.Key.csv</p>
             <p>4.StudentList.csv</p>
             <p>5.StudentNames.csv</p>
             <p>6.Photographs of Students</p>
             <p>7.ConnectifyInstaller</p>
             <p>Please unzip the downloaded file to get the above mentioned contents</p>
             <p style="color: red">**Note** -- Restart the computer after installing Connectify</p>
              <br />
   	    <h1><a href="downloadZIP.jsp?file=<%= filename%>.zip">Download (ZIP folder)</a></h1>
            <p>&nbsp;</p>
   	    

            <% } %>
<%

con.close();
%>
   	  </div>
        
    	

      <div id="main_right_column">
       <div class="rightbig_button"><img src="images/edu.gif" width="196" height="123"></img></div>
       <div class="sitename" align="left">
         <p><font size="+2">Let us sacrifice</font></p>
         <p><font size="+2"> our today</font></p>
         <p><font size="+2">so that </font></p>
         <p><font size="+2">our children </font></p>
         <p><font size="+2">can have </font>         </p>
         <p><font size="+2">a better</font></p>
         <p><font size="+2">tomorrow.</font></p>
         <p>&nbsp;</p>
         <p>&nbsp;</p>
       </div>

         <p>&nbsp;</p>
         <p>&nbsp;</p>
         <p><br />
         </p>
</div>

  </div>

    <!-- end of content -->


	<div id="main_footer">
             Copyright Â© Quiz Module| Designed by Quiz Module Team</div>
    <div id="main_footer_bottom"></div>

</div>
</body>
                <%
    }
    else
    {
    %>
    <jsp:forward page="index.jsp"/>
    <%
     }
    %>

</html>
