<%--
This page is used by admin to allot test to the invigilators from the set of available tests.
As soon as the invigilator selects any test from the set of available tests using radio button,he/she is redirected to testedit.jsp
The selected Test is shown to the admin and the admin can then update the test alloted by clicking the update button
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
function selectRecord(sel){
    window.location.replace("testedit.jsp?sel="+sel);
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
                <li><a href="testAllot.jsp" class="current" >Test Allotment</a></li>
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
       <%
     
          int i=1; //counter
            try
                    {
                /*establishing connection with the back-end database*/
            Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
             Statement s1=con.createStatement();
             String query1="select * from quizdatabase";
             ResultSet rs1=s1.executeQuery(query1);
            %>
          
            <table border="1" style="font-family: Calibri;font-size: medium;background-color:#E4E1E1;border-color:#1AACF0;"align="left" size="10" class="form_row" cellspacing="0" >
                <tr>
                    <th>Test No.</th>
                    <th>Test Name</th>
                    
                    <th>Select</th>
                </tr>
                <%
                //showing the complete list of tests in the form of table to the admin
                while(rs1.next()){
             String sel_row=rs1.getString(1);
%>
<tr >

    <td><%=i%></td>
    <td><%=sel_row%></td>
   
    <td><form><input type="radio" name="edit" onclick="selectRecord('<%=sel_row%>');" class="button"/></form></td>

</tr>
<% i++;} %>
<%

con.close();
} catch (Exception ex) {}
%>
            </table>
            

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