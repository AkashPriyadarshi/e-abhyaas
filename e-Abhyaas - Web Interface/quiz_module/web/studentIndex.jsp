<%--
This page uses javascript to allow the admin to submit student list.
A table with 1 row by default is already present and user can add more students by using the add button
For each student the admin has to give the mac id of the tablet alloted to him/her and the name of the student
He is also required to enter the total number of students
--%>

<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Abhyaas : Admin</title>

<link href="main_style.css" rel="stylesheet" type="text/css" />
<script  type="text/javascript">
            var id_str="";
            var name_str="";
            var i=1;
            
            function addRow(tableID)
            {
               /*this function adds a row to the table dynamically when the user presses add button*/
                var table = document.getElementById(tableID);

                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount);

                var cell1 = row.insertCell(0);
                cell1.innerHTML = rowCount + 1;
                var cell2 = row.insertCell(1);
               cell2.innerHTML=table.rows[0].cells[1].innerHTML;
                var cell3 = row.insertCell(2);
                var element2=document.createElement('input');
                element2.setAttribute('name', 'sname'+i);
                element2.setAttribute('id', 'sname'+i);
                cell3.appendChild(element2);
                var cell4 = row.insertCell(3);
               cell4.innerHTML=table.rows[0].cells[3].innerHTML;
                var cell5 = row.insertCell(4);
                var element3=document.createElement('input');
                element3.setAttribute('name', 'mac'+i);
                element3.setAttribute('id', 'mac'+i);
                cell5.appendChild(element3);
              
                  
                i++;

                            }



            function getValues(){
                /*this function creates a ',' seperated string of macids and another of student names,both seperated by an '_'*/
                id_str="";
                name_str="";
               
                var ftotal= document.getElementById("total").value;
                for (var j=0;j<i;j++){
                   var name= document.getElementById("sname"+j).value;
                   var id= document.getElementById("mac"+j).value;
               
                 id_str += id+",";
                 name_str += name+",";
                }
                alert(id_str+"\n"+name_str);
               window.location.replace("newjsp2.jsp?str="+ftotal+"_"+id_str+"_"+name_str);
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

               <li><a href="studentIndex.jsp" class="current" >Student</a></li>
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

        <div id="main_content" border="1" align="center" width="1000">
                  <p>&nbsp;</p>
                  <form id="form1" name="form1" method="post"  >
                  <h1>&nbsp;</h1>
                  
                  <p>Total Students-
          <input type="text" class="form_row" name="total" id="total"/>

                          
                  </p>
                  <table width="555" border="1" class="form_row" id="form_table" bordercolor="#999999" cellspacing="0" align="left">
                    <tr>
          <td width="7" height="42">1</td>
          
          <td width="91"> Student Name-</td>
         
          <td width="165"><input name="sname" type="text" class="form_row" id="sname0" width="1"/></td>
          
          <td width="91"> Mac IDs Alloted-</td>
          
          <td><input  type="text" class="form_row"  width="1" name="mac" id="mac0" align="left"/></td>

         
                 </tr>
      </table>
                  
                  <p><br />
                  </p>
                  <p>&nbsp;</p>
                  <table width="255" border="0" class="form_row" >
                    <tr>
                      <td width="151"><input name="add" type="button" class="button" value="Add " onclick="addRow('form_table')" align="left"/></td>
                      <td width="122"><input name="done" type="button" class="button" id="done" value="Done" onClick="getValues()" align="centre"/></td>
                      <td width="113"><input name="reset" type="reset" class="button" id="reset" value="Reset" align="centre"/></td>
                      
                    </tr>
                  </table>
             
                </form>

                    
                </div>
          
         
        
        
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