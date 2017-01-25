<%--
The teacher is redirected to this page when he selects the pdf file which is the question paper,  from the browser window and click on upload button.
On this page, the uploaded file is saved at the desired location as mentioned in the web.xml file
--%>


<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>

<%@ page import="java.io.*,java.util.*, javax.servlet.*,java.sql.*,java.io.*,java.lang.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<HEAD>
<TITLE>e-Abhyaas : Teacher</TITLE>

</HEAD>
<%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>
<BODY>

<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

        
         while ( i.hasNext () )
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = session.getAttribute("fileName")+".pdf";
            System.out.println(fileName);
            Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz_moduledatabase","root","123");
            Statement s=con.createStatement();
            String qry="insert into quizdatabase(TestName) values('"+fileName +"')";
            s.executeUpdate(qry);
            con.close();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 )
            {
            file = new File( filePath +
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }
            else
            {
            file = new File( filePath +
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
           
        %>
        <jsp:forward page="encrypt.jsp"/>
        <%
            }
         }
        out.println("Thank you for uploading question paper ");
      }catch(Exception ex) {
         System.out.println(ex);
         %>
          <jsp:forward page="fileUpload.jsp"/>
         <%
          
      }
   }
   else
   {
 System.out.println("done!!");

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
