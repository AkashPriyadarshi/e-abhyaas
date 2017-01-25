<%-- 
   This is the index page on which the user signs in and his email-id and password are validated using javascript and jsp.
   If the username and password are correct then the user is redirected to his/her concerned Role page.
   These pages are invigilatorIndex.jsp,adminIndex.jsp and teacherIndex.jsp.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.lang.String"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>e-Abhyaas </title>

        <link href="main_style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
        function validate(){
            /*This function checks whether the user has entered data in the e-mail id text field and password field or not */
            /*This function is called when the user clicks on the 'Login' button*/

var username=document.login.userid; //getting the value of textfield with name 'userid' of form with name 'login'
var password=document.login.password;//getting the value of textfield with name 'password' of form with name 'login'

// condition check,prompting and then reloading the page if the user leaves any  field blank
if(username==""){
 alert("Enter Username!");
  return false;
}
if(password==""){
 alert("Enter Password!");
  return false;
}
return true;
window.location.reload();
}

function doSearch ( s ) {
 var regExp1 = /\bfield\b/;
 var regExp2 = /[(,),<,>,\[,\]]/;
 var str = s.value; if ( str == "" ){
alert("Please be sure to enter something to search for.");
 s.focus();
 } else {
if ( typeof regExp1.source != 'undefined' ) //supports regular expression testing
if ( regExp1.test( str ) || regExp2.test( str ) ){
 var alrt = "Please note that you can not include:";
alrt += "\n\nThe reserved word 'field'\nthe characters [, ], (, ), < or >";
 alrt += "\n\nin your search query!\n\nIf you are confident that you know";
 alrt += "\nwhat you are doing, then you can\nmanually produce the URL required."
 s.focus();
 return alert( alrt );
 }
 openDbRelativeURL("All?SearchView&Query=" + escape( str ) + "&start=1&count=10");
 }
 }
 function openDbRelativeURL( url, target ){
 //Check we have a target window;
 target = (target == null ) ? window : target;
 //Work out the path of the database;
 path = location.pathname.split('.nsf')[0] + '.nsf/';
 target.location.href = path + url;
 }


</script>
    </head>
    <body>
        <div id="main_container">

            <div id="main_header">
                <div id="logosection">
                    <div class="sitelogo">
                      <div align="center"><img src="images/people.gif" width="253" height="75" align="center"></div>
                    </div>
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
                    <form method="get" action="http://www.google.com/search">
				<input class="textfield" type="text" value="" alt="search"/> <input class="send_btn" type="submit" value="Go" doSearch(this.form.Query); />
        </form>
                </div>
                <div id="menu">
                    <ul>
                        <li><a href="index.jsp" class="current">Home</a></li>
                <li><a href="about.jsp">About </a></li>
                <li><a href="registration.jsp">Registration</a></li>
                <li><a href="announcements.jsp">Announcements</a></li>
                <li><a href="contact.jsp">Contact Us</a></li>
                    </ul>
                </div>
            </div>



            <div id="main_content">



                <div id="main_left_column">

                    <div id="leftcolumn_box01">
                        <div class="leftcolumn_box01_top">
                            <h2> Login</h2>
                        </div>
                        <div class="leftcolumn_box01_bottom">
                            <form method="post" action="login.jsp"  name="login" onsubmit="return validate()" >
                                <div class="form_row">Email Id
                                    <input class="inputfield" name="userid" type="text" id="userid"/></div>
                                <div class="form_row"><label>Password</label><input class="inputfield" name="password" type="password" id="password"/></div>
                                <input class="button" type="submit" name="Submit" value="Login" />
                                <%
                                /*if username or password is invalid then the user is redirected back from the page login.jsp to this page with the message "Invalid UserId/Password" stored in the variable 'msg'*/
                                /*The error message is printed here and user has to enter the data again*/
                                String str= request.getParameter("msg");
                                    if(str != null)
                                        {
                                 %>
                                 <h2 align="left">
                                    <%out.println(str);%>
                                </h2>
                                <%
                                }
                                %>
                            </form>
                           
                        </div>
                    </div>

                    <div id="leftcolumn_box02">
                        <h2>Contact Details</h2>
                        <ul>
                            <li><a href="contact.jsp"><span class="style4">&nbsp;&nbsp;&nbsp;Quiz Module Team</span></a></li>
                            <li><a href="contact.jsp"><span class="style4">Indian Institute of Technology</span></a> </li>
                            <li><a href="contact.jsp"><span class="style4">&nbsp;Powai</span></a></li>
                            <li><a href="contact.jsp"><span class="style4">&nbsp;Mumbai-400076</span></a></li>
                            <li><a href="contact.jsp"><span class="style4">India</span></a><a href="#" target="_parent"></a></li>
                            <li> </li>
                            <li></li>
                        </ul>
                    </div>

                    <div id="imagebutton"><a href="#"><img src="images/SM111378.gif" alt="" width="220" height="138" /></a></div>

                </div>


                <div id="main_middle_column">

                    <h1>Welcome to our  website</h1>
                    <p><span class="style4">&nbsp;An Introduction to the Quiz Module which has&nbsp;been developed. The benefits of the Quiz Module which will be enjoyed by the Teachers and&nbsp;&nbsp;Invigilators. And also an introduction to the various types of Quizzes that are available on the module. The various responsibilities shared among            &nbsp;the teachers and the invigilators.</span></p>
                    <p><a href="about.jsp">Read more...</a></p>
                    <p><br />
                    </p>
                    <div id="section1">
                        <h3><u>Announcements</u></h3>
                        <h4><span class="style4">1.The Teachers are asked to upload the question and answers in CSV format one week before the</span><span class="style4"> Test.</span></h4>
                        <h4><span class="style4">2.The Invigilators are asked to download the Seating Arrangement and the Centre allotted to them now.</span></h4>
                        <h4>3. All Teachers and Invigilators are requested to check their respective emails and confirm their registration</h4>
                        <h4>&nbsp;</h4>
                        <h4><a href="announcements.jsp">Read more...</a> </h4>
                    </div>
                    <img src="images/aakash_tablet.gif" width="219" height="321">
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
</html>

