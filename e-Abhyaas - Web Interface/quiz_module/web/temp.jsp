<%--
This page is used to create a new CSV file which stores the question specifications

--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.io.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas : Teacher</title>

 <link href="main_style.css" rel="stylesheet" type="text/css" />
 
</head>
    <%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
     //String filename=(String)session.getAttribute("name");
%>

<body>
<%
String s=(String)session.getAttribute("name"); //e-mail address of the teacher currently logged in
 String str1=(String) session.getAttribute("testName"); //name of the test as given by the teacher
try
        {
    File file = new File("q$"+s+";"+str1+".csv"); /*reading the previously created CSV file on newjsp.jsp*/
    File file_1=new File("q$"+s+";"+str1+";1.csv"); /*making final CSV file and giving it a unique name */
                        BufferedReader br = new BufferedReader( new InputStreamReader( new FileInputStream(file)));
                        BufferedWriter wrf = new BufferedWriter(new OutputStreamWriter( new FileOutputStream(file_1)));

String lineData = "";
while((lineData =br.readLine()) != null)
{
lineData = lineData.replace(";", ",\n");/*replacing ';' with '\n'*/

wrf.append(lineData); /*appending data to final CSV*/
}


br.close();
wrf.flush();
wrf.close();
 

}
catch(Exception e)
        {
        e.printStackTrace();
        }
     
%>
<div id="main_container">

            <div id="main_header">
                <div id="logosection">
                    <div class="sitelogo"><img src="images/people.gif" width="215" height="75" /></div>
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
                <li></li>
                <li></li>
                <li><a href="teacherIndex.jsp">Home</a></li>
                <li><a href="quizspecifications.jsp"  class="current">Quiz Specifications</a></li>
                <li><a href="displayResults.jsp">Results</a></li>
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

                        </ul>
                    </div>

                    <div id="imagebutton"><a href="#"><img src="images/SM111378.gif" alt="" width="220" height="138" /></a></div>

                </div>


              <div id="main_middle_column">

                  <h1>Thanks for giving quiz specifications</h1>
                   <h1>Click the link below to give Model Answers</h1>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <a href="option_check.jsp">Mark Answers</a>


                  <p><br />
                    </p>
              </div>
                <div id="main_right_column">
                    <div class="rightbig_button"><img src="images/edu.gif" width="196" height="123" /></div>
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

                Copyright © Quiz Module| Designed by Quiz Module Team</div>
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
