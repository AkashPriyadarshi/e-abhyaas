<%--
This page uses javascript to allow the teacher to submit quiz specification.
A table with 1 row by default is already present and user can add more questions by using the add button
***********************************************************************
 *
 *
 *       Inputs:      Index into question Array
 *
 *       Explanation:
 *           Type 1     Multiple Choice Single Answer     needs     1 row
 *           Type 2     Multiple Choice Multiple Answer   needs     1 row
 *           Type 3     Numerical Answer                  needs     qualifier rows
 *           Type 4     Matrix Type                       needs     qualifier rows
 *           Type 4     Match Columns                     needs     qualifier rows

 *
 *    Question string format is as follows :
 *       - First the test high level definition
 *           - comma separated list of number of questions, total marks and total duration
 *       - comma separated low level definition of each question
 *           - each question definition contains comma separated list of
 *                - question number
 *                - question type
 *                - question qualifier
 *                - question subqualifier
 *                - question marks
 *
 *    Following question types and their qualifiers are supported
 *   |----|-------------------------------|----------------------------|--------------------------------|
 *   |Type|          description          |          qualifier         |          sub qualifier         |
 *   |----|-------------------------------|----------------------------|--------------------------------|
 *   |    |                               |                            |                                |
 *   |  1 | multiple choice single answer | number of options (<=10)   | No sub qualifier               |
 *   |    |                               |                            |                                |
 *   |  2 |multiple choice multiple answer| number of options (<=10)   | No sub qualifier               |
 *   |    |                               |                            |                                |
 *   |  3 | numerical answer              |number of digitsbefore decim| number of digits after decimal |
 *   |    |                               |                            |                                |
 *   |  4 | matrix type                   | number of rows             | number of columns              |
 *   |    |                               |                            |                                |
 *   |  5 | match columns                 | number of rows in column 1 | number of rows in column 2     |
 *   |____|_______________________________|____________________________|________________________________|
 *
 *
 *
 *
 *       Inputs:      String containing test definitions
 *
 *       Example:
 *           test Specification portion      10,40,30,        (defines a test of 10 questions, 40 marks and 30 minutes)
 *           question  1 specifiation        13,1,4,,3,       (defines Q13, M Choice S correct, 4 options, no subqualifier, 3 marks)
 *           question  2 specifiation        14,1,5,,4,       (defines Q14, M Choice S correct, 5 options, no subqualifier, 4 marks)
 *           question  3 specifiation        15,1,2,,1,       (defines Q15, M Choice S correct, 2 options, no subqualifier, 1 marks)     (T/F)
 *           question  4 specifiation        16,2,4,,4,       (defines Q16, M Choice M correct, 4 options, no subqualifier, 4 marks)
 *           question  5 specifiation        17,2,5,,5,       (defines Q17, M Choice M correct, 5 options, no subqualifier, 5 marks)
 *           question  6 specifiation        18,3,3,,4,       (defines Q18, numerical answer, 3 digits, no decimal, 4 marks)             (175)
 *           question  7 specifiation        19,3,5,2,4,      (defines Q19, numerical answer, 5 digits, 2 digits after decimal, 4 marks) (105.75)
 *           question  8 specifiation        23,4,4,4,6,      (defines Q23, matrix type, 4 rows, 4 columns, 6 marks)
 *           question  9 specifiation        24,5,4,4,4,      (defines Q24, match columns, 4 rows in column 1, 4 rows in column 2, 4 marks)
 *           question 10 specifiation        25,5,5,4,5,      (defines Q25, match columns, 5 rows in column 1, 4 rows in column 2, 5 marks)
 ********************************************************************************************************************************************************
--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>



<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="main_style.css" rel="stylesheet" type="text/css" />
        <title>e-Abhyaas : Teacher</title>
<script  type="text/javascript">
            var str="";
            var i=1; //counter to add rows
            function addRow(tableID)
            {
                /* this function is used to create a new row for the table when the user presses add button */
                var table = document.getElementById(tableID);           
                  
                var rowCount = table.rows.length; /*get the number of rows currently in the table*/
                var row = table.insertRow(rowCount); /*insert a new row*/
                
               
                var cell1 = row.insertCell(0);
                cell1.innerHTML = rowCount + 1;/*display question numbe rin first cell*/


                var cell2 = row.insertCell(1); /*create a select element from which the user can select the type of questions*/
                 
                var element1=document.createElement('select');
                element1.setAttribute('name', 'type'+i);
                element1.setAttribute('id', 'type'+i);
                element1.add(new Option("Multiple Choice Single Correct","1"));
                element1.add(new Option("Multiple Choice Multiple Correct","2"));
                element1.add(new Option("Numerical Answer","3"));
                element1.add(new Option("Match the Column","4"));
                element1.add(new Option("Matrix Match","5"));

                cell2.appendChild(element1);

                var cell3 = row.insertCell(2);/*create a select element from which the user can select the qualifier*/
                var element2=document.createElement('select');
                element2.setAttribute('name', 'qualifier'+i);
                element2.setAttribute('id', 'qualifier'+i);
                element2.add(new Option("1","0"));
                element2.add(new Option("2","1"));
                element2.add(new Option("3","2"));
                element2.add(new Option("4","3"));
                element2.add(new Option("5","4"));
                element2.add(new Option("6","5"));
                element2.add(new Option("7","6"));
                element2.add(new Option("8","7"));
                element2.add(new Option("9","8"));
                element2.add(new Option("10","9"));

                cell3.appendChild(element2);
                     var cell4 = row.insertCell(3);  /*create a select element from which the user can select the sub qualifier*/
                var element3=document.createElement('select');
                element3.setAttribute('name', 'subqualifier'+i);
                element3.setAttribute('id', 'subqualifier'+i);
                element3.add(new Option("0","0"));
                element3.add(new Option("1","1"));
                element3.add(new Option("2","2"));
                element3.add(new Option("3","3"));
                element3.add(new Option("4","4"));
                element3.add(new Option("5","5"));
                element3.add(new Option("6","6"));
                element3.add(new Option("7","7"));
                element3.add(new Option("8","8"));
                element3.add(new Option("9","9"));
                element3.add(new Option("10","10"));
                cell4.appendChild(element3);
               var cell5 = row.insertCell(4);
               cell5.innerHTML=table.rows[0].cells[4].innerHTML;
                var cell6 = row.insertCell(5);
                cell6.innerHTML=table.rows[0].cells[5].innerHTML;
                 var cell7 = row.insertCell(6);
                var element4=document.createElement('input');/*create a text field in which the user can enter the marks for correct answer*/
                element4.setAttribute('name', 'right'+i);
                element4.setAttribute('id', 'right'+i);

                cell7.appendChild(element4);
                 var cell8 = row.insertCell(7);
                 cell8.innerHTML=table.rows[0].cells[7].innerHTML;
                 var cell9 = row.insertCell(8);
                var element5=document.createElement('input');/*create a text field in which the user can enter the marks deducted for wrong answer*/
                element5.setAttribute('name', 'wrong'+i);
                element5.setAttribute('id', 'wrong'+i);

                cell9.appendChild(element5);
            
               var qType1 = document.getElementById("type" + (i-1));
               var qTypevalue1 = qType1.options[qType1.selectedIndex].value;
                var q1=document.getElementById("qualifier" + (i-1));
                var qvalue1 = q1.options[q1.selectedIndex].text;
                var sq1=document.getElementById("subqualifier" + (i-1));
                var sqvalue1 = sq1.options[sq1.selectedIndex].text;
                 var right1= document.getElementById("right"+(i-1)).value;
                 var right2=parseInt(right1);
                 var wrong1= document.getElementById("wrong"+(i-1)).value;
                  var wrong2=parseInt(wrong1);
                if(qTypevalue1==1)
                    {
                        document.getElementById("subqualifier"+ (i-1)).disabled=true;/*no sub-qualifier for type1 i.e single correct*/
                    }
                    if(qTypevalue1==2)
                        {
                           document.getElementById("subqualifier"+ (i-1)).disabled=true; /*no sub-qualifier for type2 i.e multiple correct*/
                        }
                        if(wrong2>right2)
                            {
                                alert("Marks deducted for wrong answer cannot be more than those alloted for correct answer");
                            }


              
                i++;
                // alert(document.getElementById(type1).name);    
            
     
 
            }


            
            function getValues(){
                /*This function is used to make a comma seperated string of the question specifications*/
                /*The first line in this string has the total number of questions, the total marks and the total time seperated by commas*/
                str="";

                 var test=document.getElementById("test").value;
                var total=document.getElementById("total").value;
                var total1=0;
                var time=document.getElementById("time").value;
                if(time=='')
                    {
                    //alert("You Forgot to Enter Total time !!");
                    time=10;
                    }
                for(var m=0;m<i;m++)
                    {
                        var right_t= document.getElementById("right"+m).value;
                        if(right_t == '')
                            var right1_t=0;
                        else
                            var right1_t=parseInt(right_t);
                      total1 +=right1_t;
                    }
                str+=test+"_"+i + ","+total1+","+time+";";
                for (var j=0;j<i;j++){


                   var qType = document.getElementById("type" + j);
                    var qTypevalue = qType.options[qType.selectedIndex].value;
                    if(qTypevalue==1)
                        {
                    var q=document.getElementById("qualifier" + j);
                    var qvalue = q.options[q.selectedIndex].text;                    
                    var sq=document.getElementById("subqualifier" + j);
                    sq.disabled=true;
                    var sqvalue = "0";
                    var right= document.getElementById("right"+j).value;
                    var right1=parseInt(right);
                    var wrong= document.getElementById("wrong"+j).value;
                    var wrong1=parseInt(wrong);
                    if(right == '' || wrong=='')
                        {
                            if(right == '')right1=0;
                            if(wrong == '') wrong1=0;
                        }
                        if(parseInt(right)<parseInt(wrong))
                          {
                           wrong1=right1-1;
                          }
                          if(parseInt(wrong)<0)
                              {
                                  alert("Dont enter - sign");
                                  wrong1=0;
                              }
                        }
                        else if(qTypevalue==2)
                        {
                    var q=document.getElementById("qualifier" + j);
                    var qvalue = q.options[q.selectedIndex].text;
                    var sq=document.getElementById("subqualifier" + j);
                    sq.disabled=true;
                    var sqvalue = "0";
                    var right= document.getElementById("right"+j).value;
                     var right1=parseInt(right);
                    var wrong= document.getElementById("wrong"+j).value;
                     var wrong1=parseInt(wrong);
                    if(right == '' || wrong=='')
                        {
                            if(right == '')right1=0;
                            if(wrong == '') wrong1=0;
                        }
                    if(parseInt(right)<parseInt(wrong))
                          {
                           wrong1=right1-1;
                          }
                          if(parseInt(wrong)<0)
                              {
                                  alert("Dont enter - sign");
                                  wrong1=0;
                              }
                        }
                        else
                            {
                              var q=document.getElementById("qualifier" + j);
                       var qvalue = q.options[q.selectedIndex].text;
                    var sq=document.getElementById("subqualifier" + j);
                    var sqvalue = sq.options[sq.selectedIndex].text;
                    var right= document.getElementById("right"+j).value;
                     var right1=parseInt(right);

                    var wrong= document.getElementById("wrong"+j).value;
                     var wrong1=parseInt(wrong);
                    if(right == '' || wrong=='')
                        {
                            if(right == '')right1=0;
                            if(wrong == '') wrong1=0;
                        }

                     if(parseInt(right)<parseInt(wrong))
                          {
                           wrong1=right1-1;
                          }
                          if(parseInt(wrong)<0)
                              {
                                  alert("Dont enter - sign");
                                  wrong1=0;
                              }
                            }
                    str +=(j+1)+"," +qTypevalue+","+qvalue+"," +sqvalue+ ","+right1+","+wrong1+";";
                     
                    
                }
              //  alert(str);
               window.location.replace("newjsp.jsp?str="+str);
            }
            

        </script>


    </head>


    <%
if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
%>

    <body>
        <p id="p1"></p>
        <div id="main_container">

            <div id="main_header">
                <div id="logosection">
                    <div class="sitelogo"><img src="images/people.gif" width="215" height="75"></div>
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
                <li></li>
                <li><a href="teacherIndex.jsp" >Home</a></li>
                <li><a href="quizspecifications.jsp" class="current">Quiz Specifications</a></li>
                <li><a href="selectTest.jsp">Results</a></li>
            </ul>
                </div>
            </div>



            <div id="main_content">
                <div id="main_left_column">

            <div id="leftcolumn_box01">
                <div class="leftcolumn_box01_top">
                    <h2>Welcome <%= session.getAttribute("firstName")%> !!</h2>
                </div>
                <div>
                    <form method="post" action="#">
                        <div align="left"> <a href="logout.jsp"/></div>
                      <div class="form_row"><label></label>
                        </div>
                  </form>
                </div>
            </div>

           <div id="leftcolumn_box02">
                        <h2>Log Out</h2>
                        <ul>

                        </ul>
                    </div>

			<div id="imagebutton"><a href="#"><img src="images/SM111378.gif" alt="" width="220" height="138" /></a></div>

        </div>
              
            
                <div id="main_middle_column" border="1" align="center" width="1000">
                  <font size="1">  <h3>Instructions :</h3>

                <p align="justify">1.Multiple Choice Single Correct Answer : Enter the number of Options in column 2 and enter ZERO in column 3.
      <br/>2.Multiple Choice Multiple Correct Answer : Enter the number of Options in column 2 and enter ZERO in column 3.
      <br/>3.Numerical Answer : Enter the total number of Digits before decimal in column 2 and enter number of digits after decimal in column 3.
      <br/>4.Matrix Type : Enter the number of rows in column 2 and number of columns in column 3.
    <br />5.Match Columns : Enter the number of Rows in Column 2 and the number of Columns in Column3.
      <br/>6.Enter Test Name , Total marks for the test and the Total time</p></font>
                  <form id="form1" name="form1" method="post"  action="fileUpload.jsp">
                  <h1>&nbsp;</h1>
                  <p>Test Name-
          <input type="text" class="form_row" name="test" id="test">
                  <p>Total Marks-
          <input type="text" class="form_row" name="time" id="time">
Total Time-
                          <input type="text" class="form_row" name="total" id="total">
<br />
                  </p>
                  <table width="705" border="1" class="form_row" id="form_table" bordercolor="#999999" cellspacing="0" align="left">
                    <tr>
          <td width="7" height="42">1</td>
          <td width="218"><select name="type" id="type0">
            <option value="1">Multiple Choice Single Correct</option>
            <option value="2">Multiple Choice Multiple Correct</option>
            <option value="3">Numerical Answer</option>
            <option value="5">Matrix Match</option>
            <option value="4">Match The Column</option>
          </select></td>
          <td width="52"><select name="qualifier" id="qualifier0">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
          </select></td>
          <td width="52"><select name="subqualifier" id="subqualifier0">
            <option value="0 ">0 </option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
          </select></td>
          <td width="41"> Marks Alloted-</td>
          <td width="39"><img src="images/right1.gif" alt="" width="39" height="34"></td>
          <td width="110"><input name="right" type="text" class="form_row" id="right0" width="1"></td>
          <td width="42"><img src="images/wrong.gif" width="42" height="32" alt=""></td>
          <td width="110"><p>
            <input name="wrong" type="text" class="form_row" id="wrong0" width="1">
          </p></td>
        </tr>
      </table>
                  
                  <table width="536" border="0" class="form_row" align="left">
                    <tr>
                      <td width="151"><input name="add" type="button" class="button" value="Add " onclick="addRow('form_table')" align="left"></td>
                      <td width="122"><input name="done" type="button" class="button" id="done" value="Done" onClick="getValues()" align="centre"></td>
                      <td width="113"><input name="reset" type="reset" class="button" id="reset" value="Reset" align="centre"></td>
                     
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
<p><br />
                        </p>
                </form>

                    <h1>&nbsp;</h1>
                
                
            </div>
            <!-- end of content -->

      <div id="main_footer">
                Copyright © Quiz Module| Designed by Quiz Module Team</div>
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
