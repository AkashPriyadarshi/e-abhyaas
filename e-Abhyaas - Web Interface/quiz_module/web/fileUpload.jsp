<%--
The teacher uploads the question paper on this page
--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas : Teacher</title>

 <link href="main_style.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript">

 </script>
</head>

     <%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>

<body>

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
                
                <div id="menu">
            <ul>
                <li></li>
                <li></li>
                <li><a href="teacherIndex.jsp" >Home</a></li>
                <li><a href="quizspecifications.jsp" class="current">Quiz Specifications</a></li>
                <li><a href="selectTest.jsp">Results</a></li>
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
                    <form method="get" action="#">
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

                  <h1>Upload Question Paper(in pdf format):</h1>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <form action="UploadServlet.jsp" method="post" name="form1" id="form1"  enctype="multipart/form-data">
                    <p class="button">
                      <input name="file" type="file" class="textfield" id="file"  style="font-family:'Times New Roman', Times, serif " size="50" accept="application/pdf"/>
                        </p>
                  
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
               
                    <p>
                      <input name="button" type="submit" class="button" id="button" value="Submit" />
                      </p>
                  </form>
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
