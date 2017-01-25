<%--
This page is used by admin to allot invigilators to different student.
On this page the student can see the invigilator table and student table and can edit the student table
As soon as the invigilator presses the edit button on seatingPlan.jsp,he/she is redirected to this page
The Invigilator Alloted column becomes editable and the admin can then update the invigilator alloted by clicking the update button
Update button redirects the user to seatUpdate.jsp where he/she is shown the updated table
--%>


<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.lang.*"%>
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

                <li></li>
                <li><a href="adminIndex.jsp" >Home</a></li>

                <li><a href="invigilatorAllot.jsp" >Centre Allotment</a></li>
               <li><a href="studentIndex.jsp"  >Student</a></li>
               <li><a href="seatingPlan.jsp"   class="current">Seating Plan</a></li>
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
              <h1>Invigilator List (Allot Invigilator to each Student) :</h1>
              <h1>&nbsp;</h1>
       <%
       
       String sel=request.getParameter("sel");// mac id of the student for which the edit button was pressed
          session.setAttribute("mid", sel);
          
            try
                    {
            Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
             Statement s1=con.createStatement();
             String query="select * from registration where Role='Invigilator'";
             ResultSet rs=s1.executeQuery(query);
             %>
             <form method="post" >
            <table border="1" style="font-family: Calibri;font-size: medium;"align="left" size="10" class="form_row" >
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>

                    <th>Gender</th>
                    <th>State</th>
                    <th>City</th>

                    <th>Email</th>
                    <th>Centre Alloted</th>
                    <th>Test Alloted</th>
                 
                </tr>
                 <%
                while(rs.next()){
             
%>
<tr>
                <td><%=rs.getString(2)%></td>
    <td><%=rs.getString(3)%></td>

    <td><%=rs.getString(5)%></td>
    <td><%=rs.getString(6)%></td>
    <td><%=rs.getString(7)%></td>

    <td><%=rs.getString(9)%></td>
    <td><%=rs.getString(11)%></td>
    <td><%=rs.getString(12)%></td>
</tr>
  <% } %>

            </table>
            </form>
  <h1>&nbsp;</h1>
<h1>Student List :</h1>
<h1>&nbsp;</h1>
             <%
             String query1="select * from student where MacID='"+sel+"'";
             ResultSet rs1=s1.executeQuery(query1);
            %>
            <form method="post" action="seatUpdate.jsp">
            <table border="1" style="background-color:#E4E1E1;border-color:#1AACF0" class="form_row" >
                <tr>
                    <th>Mac ID</th>
                    <th>Student Name</th>
                    <th>Centre Alloted</th>
                    <th>Invigilator Alloted</th>
                    <th>Select</th>
                </tr>
                <%
                while(rs1.next()){

                  
                   
%>
<tr >

     <td><%=rs1.getString(1)%></td>
    <td><%=rs1.getString(2)%></td>
    <td><%=rs1.getString(3)%></td>
    
    <td><input type="text" name="centre" value="<%= rs1.getString("InvigilatorAllotted") %>"/></td>

    <td><input type="submit" name="Submit" value="Update" class="button"/></td>
</tr>
<% } %>
<%

con.close();
} catch (Exception ex) {}
%>
            </table>
            </form>

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