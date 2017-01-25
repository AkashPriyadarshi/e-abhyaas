<%--
This page is used to insert data of the student provided by the admin in the student table

--%>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.lang.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>
    

</HEAD>
<%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>
<BODY>
  


     <%
             /*We recieve the CSV in variable 'str' containing student names(semi-colon-seperated) and mac ids(semi-colon-seperated)of the student  seperated by '_'*/
             /*The sample CSV is as follows for 2 students-
               2_name1;name2;_macid;macid
               where 2 is the number of students
              */
                  String str=request.getParameter("str");
              String[] str1;
              str1=str.split("_");
             String[] sname; // store the names of students
             String[] macid; //store the mac ids of students

               int numEnt=0;// to count the total number of students
              for(int i=0;i<=str1[1].lastIndexOf(';');i++)
                  {
                  if(str1[1].charAt(i)==';')
                      numEnt++;
                    }
              //out.println(numEnt);
        
       
              sname=str1[2].split(";");//str1[2] consists of the name of the students
              macid=str1[1].split(";"); //str1[1] consists of the mac ids of the students
             

                    try
                    {                 
 /*establishing connection with the back-end database*/
Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
    Statement s=con.createStatement();
    for(int m=0;m<numEnt;m++)
        {
        //fill student table in database
     String qry="insert into student values('"+macid[m] +"','"+sname[m]+"')";
      s.executeUpdate(qry);
     }
    con.close();
%>

<jsp:forward page="studentIndex.jsp"/>
<%


    }
                    catch (Exception e) {
                         e.printStackTrace();
                         }


                %>


</BODY>


<%
}
else
{
%>
<jsp:forward page="index.jsp"/>
<%
}
%>

</HTML>