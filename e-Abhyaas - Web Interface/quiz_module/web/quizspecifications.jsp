<%--
Simple JSP and HTML page which provides the teacher with the instructions for filling the table of question specifications
--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>


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
                <li></li>
                <li></li>
                <li><a href="teacherIndex.jsp">Home</a></li>
                <li><a href="quizspecifications.jsp"  class="current">Quiz Specifications</a></li>
                <li><a href="selectTest.jsp">Results</a></li>
            </ul>
        </div>
	</div>
    
    
    
	<div id="main_content">
    
    	
    
    	<div id="main_left_column">        	

            <div id="leftcolumn_box01">
                <div class="leftcolumn_box01_top">
                    <h2>Welcome <%= session.getAttribute("firstName")%> !!</h2>
                </div>
                <div>
                    <form method="post" action="#">
                     <div align="left"><a href="logout.jsp"/></div>
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
        
        	<h1>Instructions :</h1>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p align="justify">1.Multiple Choice Single Correct Answer : Enter the number of Options in column 2 and enter ZERO in column 3.</p>
      <p align="justify">2.Multiple Choice Multiple Correct Answer : Enter the number of Options in column 2 and enter ZERO in column 3.</p>
      <p align="justify">3.Numerical Answer : Enter the total number of Digits before decimal in column 2 and enter number of digits after decimal in column 3.</p>
      <p align="justify">4.Matrix Type : Enter the number of rows in column 2 and number of columns in column 3.</p>
      <p align="justify">5.Match Columns : Enter the number of Rows in Column 2 and the number of Columns in Column3.</p>
      <p align="justify"><a href="quizspecification.jsp">Click HERE to submit Quiz Specifications...</a></p>
   	  </div>
        
       <div id="main_right_column">
       <div class="rightbig_button"><img src="images/edu.gif" width="196" height="123"></div>
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