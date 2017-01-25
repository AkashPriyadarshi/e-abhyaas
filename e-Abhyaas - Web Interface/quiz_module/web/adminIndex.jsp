<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas : Admin</title>
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

                
                <li><a href="adminIndex.jsp"  class="current">Home</a></li>
                <li><a href="testAllot.jsp" >Test Allotment</a></li>
                <li><a href="invigilatorAllot.jsp" >Centre Allotment</a></li>

               <li><a href="studentIndex.jsp"  >Student</a></li>
               <li><a href="seatingPlan.jsp"  >Seating Plan</a></li>
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

        	<h1>Welcome to our  website</h1>
          <p><span class="style4">&nbsp;An Introduction to the Quiz Module which has&nbsp;been developed. The benefits of the Quiz Module which will be enjoyed by the Teachers and&nbsp;&nbsp;Invigilators. And also an introduction to the various types of Quizzes that are available on the module. The various responsibilities shared among            &nbsp;the teachers and the invigilators.</span></p>
        <p></p>
         <p><br />
        </p>
        <div id="section1">
       	  <h3><u>Announcements</u></h3>
            <h4><span class="style4">1.The Teachers are asked to upload the question and answers in CSV format one week before the</span><span class="style4"> Test.</span></h4>
<h4><span class="style4">2.The Invigilators are asked to download the Seating Arrangement and the Centre allotted to them now.</span></h4>
                <h4>3. All Teachers and Invigilators are requested to check their respective emails and confirm their registration</h4>
                <h4>&nbsp;</h4>
                <h4> </h4>
        </div>
        <img src="images/aakash_tablet.gif" width="219" height="321"></img>
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