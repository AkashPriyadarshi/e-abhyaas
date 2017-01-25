<%-- 
    The teacher is redirected to this page when he/she submits the question specifications
    The CSV file of question specifications is created on this page and saved by the name of the test the teacher has specified
    As the CSV recieved from the previous page contains ';' to distinguish different questions, we append the incoming CSV directly to a file first
We then read the currently created file on page temp.jsp and replace ';' with '\n' that is break line and store the new content in another file

--%>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
     String s=(String)session.getAttribute("name");  /*e-mail address of the logged in user(primary key)stored in variable s */
%>


   
     <%
               
             String str=request.getParameter("str"); /*str stores the question specifications coming from page quizspecification.jsp*/
              String[] str1;  // array to store the recieved parameter's value by spliting it at '_'
              str1=str.split("_");
              session.setAttribute("testName",str1[0]);//str1[0] contains the name of the test as given by the teacher
              try
                    {

                       FileWriter fw = new FileWriter("q$"+s+";" +str1[0]+ ".csv");
                       /*making first CSV file and giving it a unique name that is a combination of email id of the teacher who submitted the test and the name of the test as given by the teacher  */
                       fw.append(str1[1]); /*appending the CSV to the file*/
                        fw.flush();
                        fw.close();
                       

response.sendRedirect("temp.jsp"); //redirecting to temp.jsp where the new and final CSV is created
 %>

 <%
    }
                    catch (Exception e) {
                         e.printStackTrace();
                         }
                

                %>

  



<%
}
else
{
    response.sendRedirect("index.jsp");
%>
<jsp :forward page="index.jsp"/>
<%
}
%>