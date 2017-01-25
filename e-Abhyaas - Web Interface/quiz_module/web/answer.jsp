<%--
 The current page is used to write the questions CSV appended with the answers to a CSV file using FileWriter class of java
As the CSV recieved from the previous page contains ';' to distinguish different questions, we append the incoming CSV directly to a file first
We then read the currently created file and replace ';' with '\n' that is break line and store the new content in another file

--%>
<%

    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.io.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>
 <title>e-Abhyaas : Teacher</title>
    
</HEAD>
<%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>
<BODY>

   
     <%
    
      String s=(String)session.getAttribute("name");                     /*e-mail address of the logged in user(primary key)stored in variable s */
                    String str=request.getParameter("final_str");        /*str stores the question specifications appended with the corresponding answer values coming from page option_check.jsp*/
                   String str1=(String) session.getAttribute("testName"); /*Name of the test as given by teacher*/
               
                    try
                    {
 
                       FileWriter fw = new FileWriter("a$"+s+";"+str1+".csv"); /*making first CSV file and giving it a unique name  */
                       fw.append(str);/*appending data to first CSV*/
                        fw.flush();
                        fw.close();

                       


                           File file = new File("a$"+s+";"+str1+".csv");/*reading the currently created CSV file*/
                        BufferedReader br = new BufferedReader( new InputStreamReader( new FileInputStream(file)));
                        FileWriter wrf = new FileWriter("a$"+s+";"+str1+";1.csv");/*making final CSV file and giving it a unique name  */
                        session.setAttribute("fileName",s+";"+str1); /*setting an attribute named fileName containing the unique name of CSV file so that we can refer it on other pages*/
String lineData = "";
while((lineData =br.readLine()) != null)
{
lineData = lineData.replace(";", "\r\n"); /*replacing ';' with '\n'*/

wrf.append(lineData); /*appending data to final CSV*/
}
br.close();
wrf.flush();
wrf.close();

%>

<jsp:forward page="fileUpload.jsp"/>
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