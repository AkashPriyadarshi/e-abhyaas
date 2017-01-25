<%-- 
   This jsp page provides the form to be filled in by the new user who is interested in registering with the quiz module.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>e-Abhyaas</title>
        <link href="main_style.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">
// function called during search.
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

        <script type="text/javascript">
// function called in order to validate the form.
function formValidation()
{
var tch = document.registration.RadioGroup1_0;
var inv = document.registration.RadioGroup1_1;
var ufname = document.registration.fname;
var ulname = document.registration.lname;
var udob = document.registration.dob;
var msex = document.registration.RadioGroup2_0;
var fsex = document.registration.RadioGroup2_1;
var ustate = document.registration.state;
var ucity = document.registration.city;
var umobile = document.registration.mobile;
var uemail = document.registration.email;
var upasswd_0 = document.registration.passwd_0;
var upasswd_1 = document.registration.passwd_1;



if(validrole(tch,inv))//validates whether role has been selected or not.
{
  if(allLetter(ufname)) // checks that only letters have been entered.
      {
          if(allLetter(ulname)) // checks that only letters have been entered.
              {
                  if(validdate(udob)) // checks that dob is entered in dd/mm/yyyy format.
                      {
                       if(validgender(msex,fsex)) // checks that user has selected one of the options.
                           {
                              if(state(ustate)) // checks that only letters have been entered.
                                  {
                                      if(city(ucity)) // checks that only letters have been entered.
                                          {
                                           if(mobile_validation(umobile,10,10)) // checks that 10 digit number has been entered.
                                               {
                                                if(ValidateEmail(uemail)) // checks that email should be of the format xyz@pqr.abc
                                                    {
                                                    if(ValidatePassword( upasswd_0, upasswd_1)) // checks that both passwords entered are same or not.
                                                        {
                                                               return true;
                                                              }
                                                    }
                                               }
                                          }
                                  }
                           }
                      }
              }
      }
}
return false;


}


        var dminyear = 1900;
        var dmaxyear = 2200;
        var chsep= "/"
        function checkinteger(str1){
        var x;
        for (x = 0; x < str1.length; x++)
		{// verify current character is number or not !
        var cr = str1.charAt(x);
        if (((cr < "0") || (cr > "9")))
        return false;
        }
        return true;
        }
        function getcharacters(s, chsep){
        var x;
        var Stringreturn = "";
        for (x = 0; x < s.length; x++){
        var cr = s.charAt(x);
        if (chsep.indexOf(cr) == -1)
        Stringreturn += cr;
        }
        return Stringreturn;
        }
        function februarycheck(cyear)
        {
        return (((cyear % 4 == 0) && ( (!(cyear % 100 == 0)) || (cyear % 400 == 0))) ? 29 : 28 );
        }
        function finaldays(nr) {
        for (var x = 1; x <= nr; x++) {
        this[x] = 31
        if (x==4 || x==6 || x==9 || x==11)
        {
        this[x] = 30}
        if (x==2)
        {
        this[x] = 29}
        }
        return this
        }
        function dtvalid(strdate)
        {
        var monthdays = finaldays(12)
        var cpos1=strdate.indexOf(chsep)
        var cpos2=strdate.indexOf(chsep,cpos1+1)
        var daystr=strdate.substring(0,cpos1)
        var monthstr=strdate.substring(cpos1+1,cpos2)
        var yearstr=strdate.substring(cpos2+1)
        strYr=yearstr
        if (strdate.charAt(0)=="0" && strdate.length>1) strdatestrdate=strdate.substring(1)
        if (monthstr.charAt(0)=="0" && monthstr.length>1) monthstrmonthstr=monthstr.substring(1)
        for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0)=="0" && strYr.length>1) strYrstrYr=strYr.substring(1)
        }
        // The parseInt is used to get a numeric value from a string
        pmonth=parseInt(monthstr)
        pday=parseInt(daystr)
        pyear=parseInt(strYr)
        if (cpos1==-1 || cpos2==-1){
            document.getElementById('error4').innerHTML='The date format must be : dd/mm/yyyy'
        return false
        }
        if (monthstr.length<1 || pmonth<1 || pmonth>12){
        document.getElementById('error4').innerHTML='Input a valid Month'
        return false
        }
        if (daystr.length<1 || pday<1 || pday>31 || (pmonth==2 && pday>februarycheck(pyear))         || pday > monthdays[pmonth]){
       document.getElementById('error4').innerHTML='Input a valid Day'
        return false
        }
        if (yearstr.length != 4 || pyear==0 || pyear<dminyear || pyear>dmaxyear){
       document.getElementById('error4').innerHTML='Input year between '+dminyear+' and '+dmaxyear
       return false
        }
        if (strdate.indexOf(chsep,cpos2+1)!=-1 || checkinteger(getcharacters(strdate, chsep))==false){
        document.getElementById('error4').innerHTML='Input a valid Date'
        return false
        }
        return true
        }
        function validdate(udob)
        {
        var crdt=udob.value
        if (dtvalid(crdt)==false)
        {
        document.registration.dob.focus()
        return false
        }
        return true
        }
function mobile_validation(umobile,mx,my)
{
var umobile_len = umobile.value.length;
if (umobile_len == 0 ||umobile_len > my || umobile_len < mx)
{
document.getElementById('error8').innerHTML='Mobile Number is not valid'
umobile.focus();
return false;
}
return true;
}
function ValidatePassword(pwd1,pwd2)
    {
       if(pwd1.value != "" && pwd1.value == pwd2.value) {
      if(pwd1.value.length < 6) {
       document.getElementById('error10').innerHTML='Password must contain at least six characters!'
        pwd1.focus();
        return false;
      }
      if(pwd1.value == registration.fname.value) {
       document.getElementById('error10').innerHTML='Password must be different from Username!'
        pwd1.focus();
        return false;
      }
      var re = /[0-9]/;
      if(!re.test(pwd1.value)) {
       document.getElementById('error10').innerHTML='Password must contain atleast one number(0-9)!!'
        pwd1.focus();
        return false;
      }
      re = /[a-z]/;
      if(!re.test(pwd1.value)) {
        document.getElementById('error10').innerHTML='Password must contain at least one lowercase letter(a-z)!'
       pwd1.focus();
        return false;
      }
      re = /[A-Z]/;
      if(!re.test(pwd1.value)) {
       document.getElementById('error10').innerHTML='Password must contain atleast one uppercase letter (A-Z)!'
       pwd1.focus();
      return false;
      }
    }
    else {
     document.getElementById('error10').innerHTML='Please check that you have entered and confirmed your password!'
      pwd1.focus();
     return false;
    }

   alert("Form Succesfully Submitted !! Go to Home and LogIn");
    return true;

    }

function allLetter(uname)
{
var letters = /^[A-Za-z]+$/;
if(uname.value.match(letters))
{
return true;
}
else
{
document.getElementById('error2').innerHTML='Alphabet characters only'
uname.focus();
return false;
}
}
function city(ucity)
{
    if(ucity.value=="")
{
document.getElementById('error7').innerHTML='Write your city'
ucity.focus();
            return false;
}
else
{
return true;
}
}
function state(ustate)
{
    if(ustate.value=="")
{
document.getElementById('error6').innerHTML='Write your State'
ustate.focus();
return false;
}
else
{
return true;
}
}
function ValidateEmail(uemail)
{
var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
if(uemail.value.match(mailformat))
{
return true;
}
else
{
document.getElementById('error9').innerHTML='an invalid email address !!'
uemail.focus();
return false;
}
}
function validrole(tch,inv)
{
x=0;

if(tch.checked)
{
x++;
}if(inv.checked)
{
x++;
}
if(x==0)
{
document.getElementById('error1').innerHTML='Select Teacher/Invigilator'
tch.focus();
return false;
}
else
{
return true;}
}
function validgender(msex,fsex)
{
x=0;

if(msex.checked)
{
x++;
}if(fsex.checked)
{
x++;
}
if(x==0)
{
document.getElementById('error5').innerHTML='Select Male/Female'
msex.focus();
return false;
}
else
{
return true;}
}

        </script>
</head>
    <body>
       
<div id="main_container">

    <div id="main_header" >
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
                    <form method="get" action="http://www.google.com/search">
				<input class="textfield" type="text" value="" alt="search"/> <input class="send_btn" type="submit" value="Go" doSearch(this.form.Query); />
        </form>
                </div>
        <div id="menu">
            <ul>
                <li><a href="index.jsp" >Home</a></li>
                <li><a href="about.jsp">About </a></li>
                <li><a href="registration.jsp" class="current">Registration</a></li>
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
                      <div class="form_row">
                        </div>
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

        	<h1>Registration</h1>
                <h4 style="color: red">*Password must be of atleast 6 Characters.*<br>It must contain atleast one uppercase,one lowercase letter and a number.</h4>
                <form method="post" action="reg_db.jsp" name="registration" id="registration" onsubmit="return formValidation()">
<table>
<tr><td>Select your Role:</td>
  <td><p>
    <label>

      <input type="radio" name="RadioGroup1" value="Teacher" id="RadioGroup1_0" />
      Teacher</label>
    <br />
    <label>
      <input type="radio" name="RadioGroup1" value="Invigilator" id="RadioGroup1_1" />
      Invigilator</label>
    <br />
  </p></td><tr><span id="error1" style="color: red; font-weight: bold;"/></tr>
</tr>

<tr><td>First Name:</td><td><input type="text" name="fname"></td><td><span id="error2" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Last Name:</td><td><input type="text" name="lname"><span id="error3" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Date Of Birth</td><td><input type="text" name="dob"></td><td><span id="error4" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Gender</td><td><p>
    <label>
      <input type="radio" name="RadioGroup2" value="Male" id="RadioGroup2_0" /> Male</label>
    <br />
    <label>
      <input type="radio" name="RadioGroup2" value="Female" id="RadioGroup2_1" />Female</label>
    <br />
  </td><td><span id="error5" style="color: red; font-weight: bold;"/></p></td></tr>
<tr><td>State:</td><td><input type="text" name="state"></td><td><span id="error6"style="color: red; font-weight: bold;"/></td></tr>
<tr><td>City</td><td><input type="text" name="city"></td><td><span id="error7" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Mobile:</td><td><input type="text" name="mobile"></td><td><span id="error8" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Email:</td><td><input type="text" name="email"></td><td><span id="error9" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>Enter your Password:</td><td><input type="password" name="passwd_0"></td><td><span id="error10" style="color: red; font-weight: bold;"/></td></tr>
<tr><td>ReEnter your Password:</td><td><input type="password" name="passwd_1"></td></tr>
<tr><td><input type="submit" value="Submit" class="button" ></td><td><input type="reset" value="Reset" class="button"></td></tr>
</table>
</form>

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
