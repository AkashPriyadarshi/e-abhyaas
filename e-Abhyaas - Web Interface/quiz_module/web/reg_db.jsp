<%-- 
    This jsp page is used to store data into the the database table when the new user is registering for the quiz module.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


    
    <%

try
        {

//Establishing connection with back end database
Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
    Statement s=con.createStatement();
    //Getting the various parameters which have been given by the user.
    String role=request.getParameter("RadioGroup1");
    String fname=request.getParameter("fname");
    String lname=request.getParameter("lname");
String dob=request.getParameter("dob");
String gender=request.getParameter("RadioGroup2");
String state=request.getParameter("state");
String city=request.getParameter("city");
String mobile=request.getParameter("mobile");
String email=request.getParameter("email");
String passwd_0=request.getParameter("passwd_0");
String s1="NA";
String s2="NA";
if(role!= null)
    {
    String qry="insert into registration values('" + role + "','" + fname + "','"+ lname + "','" + dob + "','"+gender+"','"+state+"','"+city+"','"+mobile+"','"+email+"','"+passwd_0+"','"+s1+"','"+s2+"')";//Inserting into the table resgistration.

    s.executeUpdate(qry);
     }con.close();

} catch(Exception e){e.printStackTrace();}

%>
<jsp:forward page="registration.jsp"/>
