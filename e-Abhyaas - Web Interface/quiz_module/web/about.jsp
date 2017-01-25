

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas</title>
<link href="main_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
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
	        <div class="sitelogo"><img src="images/people.gif" width="215" height="75"></div>
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
                    <form method="post" action="http://www.google.com/search">
				<input class="textfield" type="text" value="" alt="search"/> <input class="send_btn" type="submit" value="Go" doSearch(this.form.Query); />
        </form>
                </div>
        <div id="menu">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp"  class="current">About </a></li>
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
                    <h2></h2>
                </div>
                <div class="leftcolumn_box01_bottom">
                    <form method="post" action="#">
                      <div class="form_row"></div>
                        <div class="form_row"></div>
                        
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
          <p><span class="style4">&nbsp;An Introduction to the Quiz Module which has&nbsp;been developed. The benefits of the Quiz Module which will be enjoyed by the Teachers and&nbsp;&nbsp;Invigilators. And also an introduction to the various types of Quizzes that are available on the module. The various responsibilities shared among            &nbsp;the teachers and the invigilators.</span></p><p><span class="style4">Here we provide you a platform to share your questions and answers for the benifit of the students. This platform helps to ease the learning and spreading of the knowledge which every child deserves.</span></p><p><span class="style4">Also, the conduction of exams is now easier than before.Once a person is registered for the Invigilator post he is asked to download the questions and answers to conduct the exam on the sheduled dat and time.</span></p><p><span class="style4">So enjoy the journey towards changing the education to heights where every child can be embarked upon a new career.<br></span></p><p><br />
        </p>
        <div class="rightbig_button"><span class="style4">&nbsp; </span><span class="style4"><br /></span>
                <br /><h4>&nbsp;</h4></div></div>
        
       <div id="main_right_column">
         <div class="rightbig_button"><img src="images/edu.gif" alt="" width="196" height="123" /></div>
         <div class="sitename" align="left">
           <p><font size="+2">Let us sacrifice</font></p>
           <p><font size="+2"> our today</font></p>
           <p><font size="+2">so that </font></p>
           <p><font size="+2">our children </font></p>
           <p><font size="+2">can have </font> </p>
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