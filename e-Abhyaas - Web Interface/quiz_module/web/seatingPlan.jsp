<%--
This page is used by admin to allot invigilators to different students according to their centres.
As soon as the invigilator presses the edit button of any row,he/she is redirected to edit.jsp
The invigilatorAlloted column becomes editable and the admin can then update the invigilator alloted by clicking the update button
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
<script language="javascript">
function editRecord(sel){
     /*This function is called on the click of edit button corresponding to a row*/
    /*The variable 'sel' stores the email-id of the invigilator for whom the edit button is pressed*/
    window.location.replace("seatEdit.jsp?sel="+sel); //redirect to edit.jsp and simultaneously pass parameter 'sel' to the new page
    
}
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


                <li><a href="adminIndex.jsp"  >Home</a></li>
                <li><a href="testAllot.jsp"  >Test Allotment</a></li>
                <li><a href="invigilatorAllot.jsp"  >Centre Allotment</a></li>

               <li><a href="studentIndex.jsp"  >Student</a></li>
               <li><a href="seatingPlan.jsp"  class="current">Seating Plan</a></li>
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

        	 <%


            try
                    {
                 /*Establishing connection with the back end database*/
            Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
             Statement s1=con.createStatement();
             String query1="select * from student";
             ResultSet rs1=s1.executeQuery(query1);
            %>
            <table border="1" style="font-family: Calibri;font-size: medium;background-color:#E4E1E1;border-color:#1AACF0;"align="left" size="10" class="form_row" cellspacing="0" >
                <tr>
                    <th>Mac ID</th>
                    <th>Student Name</th>
                    <th>Centre Alloted</th>
                    <th>Invigilator ID Alloted</th>
                    <th>Select</th>
                </tr>
                 <%
                while(rs1.next()){
                       String sel_row=rs1.getString(1);
%>
<tr >

    <td><%=sel_row %></td>
    <td><%=rs1.getString(2)%></td>
    <td><%=rs1.getString(3)%></td>
    <td><%=rs1.getString(4)%></td>
    
    <td><form><input type="button" name="edit" value="Edit" onclick="editRecord('<%=sel_row%>');" class="button"/></form></td>

</tr>
    <% } %>
<%

con.close();
} catch (Exception ex) {}
%>
</table>
       
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