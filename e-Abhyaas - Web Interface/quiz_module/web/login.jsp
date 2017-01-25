<%-- 
    This page takes the  input as entered by the user on index.jsp and validates it against the back-end database 'one'
--%>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    %>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">




<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>e-Abhyaas </title>

        <link href="main_style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript"/>
    </head>
    <body>
       <% 
        /*Here we verify the information entered by the user in the e-mail id text field and password field */
            /*This page is called when the user clicks on the 'Login' button as the action of the corresponding form on index.jsp is the current page 'login,jsp' */
       String fname=null,fpassword=null;
    try
    {
        
    fname=request.getParameter("userid");
    fpassword=request.getParameter("password");
    /*Establishing connection with the back end Ms-Access database named 'one'*/
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select Role,FirstName,Email,Password,TestAllotted from registration where Email='"+fname+"' and Password='"+fpassword+"'");

    String s1;
    String s2;
    String s3;
    if(rs.next())
          {
                   s1=rs.getString(1); // Role of the user
                   s2=rs.getString(2); // First name of the user
                   s3=rs.getString(5); // Test Alloted to the user, this entry is set as 'NA' by default if the centre is not alloted
                   if( s1.equals("Teacher")) // if the user who is trying to log in is a teacher

                    {
                       //set user's session
                         session.setAttribute("firstName",s2);
                    session.setAttribute("name",fname);
                    session.setAttribute("password",fpassword);
                  
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", "teacherIndex.jsp");//redirect to the teacher's page
                    %>
                   
                    <%

                    }
                    else if(s1.equals("Invigilator"))// if the user who is trying to log in is an Invigilator

                    {
                    //set user's session
                    session.setAttribute("firstName",s2);
                     session.setAttribute("name",fname);
                    session.setAttribute("password",fpassword);
                    session.setAttribute("testName",s3);
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", "invigilatorIndex.jsp");//redirect to the invigilator's page
                    %>
                   
                    <%


                    }

                   else if(s1.equals("admin")) // if the user who is trying to log in is the admin

                    {
                     //set user's session
                    session.setAttribute("firstName",s2);
                     session.setAttribute("name",fname);
                    session.setAttribute("password",fpassword);
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", "adminIndex.jsp");//redirect to the admin's page
                    %>

                    <%


                    }
                   else
          
    
        out.println("<h1 style=\"color : red\">Invalid Username/Password</h1>");



          }


     else 
          {
    
        out.println("Invalid Username/Password");
        
     response.sendRedirect("index.jsp?msg=Invalid UserId/Password");// redirect to index page, give error message and ask the user to enter the details again
        
   

      %>
    
     <%

          }
 
    }
    catch(Exception e)
    {
     System.out.println("errror"+e);
    }
    %>
    </body>
</html>
