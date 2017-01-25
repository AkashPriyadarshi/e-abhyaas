<%--
This page is used to display the invigilator the centre alloted to him/her
--%>

<%

    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>e-Abhyaas : Invigilator</title>
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
                
                
                <li><a href="invigilatorIndex.jsp" >Home</a></li>
                
                <li><a href="centreallotment.jsp" class="current">Centre Allotment</a></li>
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
        
        	<h1>Centre Allotment</h1>
            <p>&nbsp;</p>
            <%
            try
    {
    String fname=null,fpassword=null;
    fname=(String)session.getAttribute("name"); /*getting email id of the invigilator  currently logged in*/
    fpassword=(String)session.getAttribute("password");
    /*establishing connection with the back-end Ms-Access database named "one"*/
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select Role,Email,CentreAllotted from registration where Email='"+fname+"' and Password='"+fpassword+"' and Role='Invigilator'");
    if(rs.next())
        {
    String s1=rs.getString(3);/* getting the  entry from the  column named 'centre alloted' into a string named s1*/
    
    if(s1.equals("NA")) /*if centre is not alloted to the invigiltor yet*/
        {
        
    %>
    <h1>Not Allotted Yet...!!</h1>
    <%
    }
    else  /*if centre has been alloted to the invigilator */
        {
        %>
        <h1><%= s1 %></h1>
        <%
        }
    }
    else
        {
        }

    }
    catch(Exception e)
    {
     System.out.println("errror"+e);
    }
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