<%--
The user is redirected to this page on login if he is an invigilator
On this page, the StudentList.csv and StudentNames.csv is created by selecting the particular students have Invigilator alloted same as the invigilator logged in
Here the folder of photographs of all students having invigilator alloted as the invigilator logged in, is also created.
Each photograph is a .jpg image and has a name same as the mac ID of the student,just the colon being replaced by hyphen.
(For ex.- if the mac address is 00:0f:cf:02:24:39 then the corresponding student's photograph must be saved with the name 00-0f-cf-02-24-39.jpg)

--%>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.lang.*,java.util.zip.*,org.apache.commons.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas : Invigilator</title>

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

    <%
    if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
    {
        String filename=(String)session.getAttribute("name"); //variable 'filename' consists of the email-id of the invigilator logged in.
    %>

<body>
    <%
try
{
    /*creating a new CSV file and writing the total number of students and mac id of each student alloted to this particular invigilator in it, each value seperated by a comma*/
    FileWriter fw = new FileWriter("uploads\\student;"+filename+".csv");
 /*establishing connection with the back end Ms-Access database 'one'*/
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
             Statement st=con.createStatement();

String[] mac_add; // array to store mac ids of all students
mac_add=new String[100];
String str="";  // the comma seperated string that has to be appended/written in the file created above
int n=0; //counter
String qry="select count(*) from student where InvigilatorAllotted='"+filename+"'";
ResultSet rs=st.executeQuery(qry);
if(rs.next())
    {
       int num=rs.getInt(1);
          str=str+num+","; // append the string with the total number of students
    }
String q="select * from student where InvigilatorAllotted='"+filename+"'";
ResultSet rs1=st.executeQuery(q);
while(rs1.next())
    {
    
   String mac= rs1.getString(1);
   mac_add[n]=mac;
   str=str+mac+","; // appending mac ids of students seperated by commas

mac_add[n]=mac_add[n].replace(":", "-");// changing the name for photograph purpose


n++;
}
fw.append(str);
fw.flush();
fw.close();
/*creation of StudentList.csv complete*/

/*creating a new CSV file and writing the total number of students and name of each student alloted to this particular invigilator in it, each value seperated by a comma*/
FileWriter fw1 = new FileWriter("uploads\\student;"+filename+"_1.csv");
             
String[] stu_nm; // array to store names of all students
stu_nm=new String[100];
String str1=""; // the comma seperated string that has to be appended/written in the file created above
int n1=0; //counter
String qry1="select count(*) from student where InvigilatorAllotted='"+filename+"'";
ResultSet rs_new=st.executeQuery(qry1);
if(rs_new.next())
    {
   int num1=rs_new.getInt(1);
    System.out.println(num1);

            str1=str1+num1+","; // append the string with the total number of students
    }
String q_new="select * from student where InvigilatorAllotted='"+filename+"'";
ResultSet rs_new1=st.executeQuery(q_new);
while(rs_new1.next())
    {

   String sname= rs_new1.getString(2);
   stu_nm[n1]=sname;
   str1=str1+sname+","; // appending names of students seperated by commas

   n1++;
}

fw1.append(str1);//appending the final string to the file created

fw1.flush();
fw1.close();
/*creation of StudentList.csv complete*/
con.close();

/*transfering the photos of the students under the invigilator who is currently logged in to a newly created folder*/
File directory = new File("Photographs");
                        
File newfolder = new File(filename+";photo"); //creating a new folder with invigilator specific name
newfolder.mkdir();
File[] myarray; // array to store the path of  all photographs found in the folder

myarray=directory.listFiles();


for (int j = 0; j < myarray.length; j++)
{

    String name=myarray[j].getName();

    
    for(int a=0;a<n;a++)
        {
    
    if(name.contains(mac_add[a])==true && name.contains(".jpg")==true)//mac_add array consists of mac ids of students with all : replaced with -
        {


        File path0=myarray[j];
        File newPath0= (new File((filename+";photo/"+myarray[j].getName())));

            FileUtils.copyFile(path0, newPath0);
        
         }
}
}
/*transfer of  photos to the new folder complete*/

}
catch(Exception e){
System.out.println(e);
}

        
%>
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
                    <form method="get" action="http://www.google.com/search">
				<input class="textfield" type="text" value="" alt="search"/> <input class="send_btn" type="submit" value="Go" doSearch(this.form.Query); />
        </form>
                </div>
        <div id="menu">
            <ul>
                
                
                <li><a href="invigilatorIndex.jsp" class="current">Home</a></li>
                
                <li><a href="centreallotment.jsp">Centre Allotment</a></li>
                <li><a href="seatingArrangement.jsp">Seating Arrangement</a></li>
                <li><a href="download.jsp">Downloads</a></li>
                <li><a href="uploadResults.jsp">Result</a></li>
                
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
      <h1>Instructions : </h1>
      <p>&nbsp;</p>
      <p style="color: red">1. Go To Download Section and Download the CONNECTIFY INSTALLER.</p>
      <p style="color: red">2.Install it by double clicking on it.</p>
      <p style="color: red">3.Install it to take full control over your Hotspot.</p>
      <p style="color: red">4.Download the Question Paper in pdf format.</p>
      <p style="color: red">5.Download the Questions and Answers (CSV format).</p>
      <p style="color: red">5.Download the Photographs of Students(ZIP folder).</p>
      <p style="color: red">5.Download the Key for encryption (CSV format).</p>
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