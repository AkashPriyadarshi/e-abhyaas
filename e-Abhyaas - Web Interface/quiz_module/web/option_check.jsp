<%--
This page is used by the teacher to give modal answers for the question specifications he submitted previously
This page uses simple HTML Scalable vector Graphics(SVG) and ARIA to generate an answer sheet for the user to mark answers
The data is first read from the question specification CSV using JSP
Each circle has a text with the option written at the centre
The final answers are appended to the question specifications CSV with answers to each question appended to its corresponding row
If option A is marked, the answer string is appended with 0,for B,it is 1 and so on.
For single correct, numerical answer and match the column function radio is called(only one option can be marked )
For multiple correct, function check is called
For multiple correct, the answer string is appended to question csv
For matrix match, the answer string for each row is appended to the final anwer string ,each row being followed by a '-'
For numerical answer, the exact answer is appended
for match the column, the answer for each row is appended to create the final answer string
--%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%>
<!DOCTYPE html>
<%


if((session.getAttribute("name"))!=null&&(session.getAttribute("password")!=null))
{
    //String filename=(String)session.getAttribute("name");
%>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,java.io.*,java.util.*" errorPage="" %>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>e-Abhyaas : Teacher</title>
<link href="main_style.css" rel="stylesheet" type="text/css" />
<%
//reading CSV file of question specifications and storing it in String type variable 'string' after replacing '\n' with '_'
String s=(String)session.getAttribute("name");
 String str1=(String) session.getAttribute("testName");

 char[] temp = new char[600];

        boolean flag = true;
        String string="";
        int abc[][]=new int[10][10];
        try {
            File file = new File("q$"+s+";"+str1+";1.csv");
            FileReader fileReader = new FileReader(file);
            fileReader.read(temp);

            for (int i=0;i<temp.length;i++) {
              if(temp[i]=='\n')
                  temp[i]='_';//replacing \n with '_'
                System.out.print(temp[i]);
                string+=temp[i];
                    }
            System.out.println(string);
          
            fileReader.close();
            }
            catch(Exception e){}
%>
<script type="text/javascript">
 var msg="";// stores the variable string of JSp
            var str;
            var s;
            var total=new Array();//array to store data of individual rows i.e. questions
            var numQues=0;//total number of questions
            var qType;//type of question
            var co_y;// y co-ordinate
            var op_sel=new Array();// array to store anwer at the question number(q_num) index
            var sel_id;//the id of the selected circle
            var q_num;// the q_num of the selected circle
            var match=new Array();//array to store answer of each row at row index for match the column
            var multiple=new Array();//array to store answers for multiple answer type
            var numerical=new Array();// array to store numerical answer type
            var matrix=new Array();// array to store matrix match type anwers
            var mat_match=new Array();
            var  n1=0;//simple counter
            var  n2=new Array();// array of counters
            var spl="";
            var final_str;// final answer string to be appended to the question specifications CSV
            for(var chk=0;chk<11;chk++)
                {
                    n2[chk]=0;
                }
            var s1="";
            function loadXMLDoc()
            {

               
                      msg="<%=string%>";
                      
                        s=msg.split('_');
                        numQues=s[0].split(",",1);//total number of questions
                        //alert(i);



                        for(qType=1;qType<=numQues;qType++)
                        {
                            total[qType-1]=s[qType].split(',');//total now becomes 2-d with values between each comma and values for each row
                        }
            
                      
            }



function start()
{

j=104;//x-coordinate
 var container = document.getElementById("svgContainer");// creating new SVG
        var mySvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        mySvg.setAttribute("version", "1.1");
        mySvg.setAttribute("height", "900");
         mySvg.setAttribute("width", "900");
         mySvg.setAttribute("border", "5");
        container.appendChild(mySvg);
		for(var k=1;k<=numQues;k++)
	{
var qno = document.createElementNS("http://www.w3.org/2000/svg", "text");//creating text element to write question numbers
qno.setAttribute("x",60);
if(k==1)// if it is the first question
    {
        qno.setAttribute("y",60);//set new value of y co-ordinate
    }
    else
        {
            qno.setAttribute("y",co_y);// otherwise value will be relative to the previous question
        }

qno.setAttribute("font-size","20");
qno.setAttribute("font-color","black");
qno.appendChild( document.createTextNode(k,k ));
mySvg.appendChild(qno);

            if(total[k-1][1].charAt(0)=='1')//single answer question
                {
                    j=104;
                     if(k==1)
                {
                    co_y=50;
                }
                    for(var x=1;x<=total[k-1][2];x++)//creating as many circles as the number of options
                        {
                               var ch=String.fromCharCode(64+x);// to write the option in the circle like A,B,C...
var c1 = document.createElementNS("http://www.w3.org/2000/svg", "circle");//creating circle
c1.setAttribute("cx", j);
c1.setAttribute("cy", co_y);
c1.setAttribute("r", "10");
c1.setAttribute("fill", "none");
c1.setAttribute("stroke-width", "1");
c1.setAttribute("stroke", "black");
c1.setAttribute("id", "q"+k+"_"+(x));// the id of the circle for option C of question 1 is- q1_4

c1.setAttribute("onclick","radio('q"+k+"_',"+(x)+","+total[k-1][2]+")");//calling function radio on click of the circle

var text = document.createElementNS("http://www.w3.org/2000/svg", "text");//writing option in circle
text.setAttribute("x",j-5);
text.setAttribute("y",co_y+5);
text.setAttribute("font-size","15");
text.setAttribute("font-color","black");
text.setAttribute("onclick","radio('q"+k+"_',"+(x)+","+total[k-1][2]+")");
 text.appendChild( document.createTextNode(ch,ch ));
mySvg.appendChild(c1);
mySvg.appendChild(text);
j+=50;
                        }
                        co_y+=50;
                }
       if(total[k-1][1].charAt(0)=='2')// for multiple anwer correct type
                {
                    j=104;
                     if(k==1)
                {
                    co_y=50;
                }

                    for(var y=1;y<=total[k-1][2];y++)
                        {
                               var ch1=String.fromCharCode(64+y);
var c1 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
c1.setAttribute("cx", j);
c1.setAttribute("cy", co_y);
c1.setAttribute("r", "10");
c1.setAttribute("fill", "none");
c1.setAttribute("stroke-width", "1");
c1.setAttribute("stroke", "black");
c1.setAttribute("id", "q"+k+"_"+(y-1));
c1.setAttribute("onclick","check('q"+k+"_"+(y-1)+"')");// id of circle for option C of Q1 is- q1_2

var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
text.setAttribute("x",j-5);
text.setAttribute("y",co_y+5);
text.setAttribute("font-size","15");
text.setAttribute("font-color","black");
text.setAttribute("onclick","check('q"+k+"_"+(y-1)+"')");
 text.appendChild( document.createTextNode(ch1,ch1 ));
mySvg.appendChild(c1);
mySvg.appendChild(text);
j+=50;
                        }
                        co_y+=50;
                }
                 if(total[k-1][1].charAt(0)=='3') // for numerical answer
                {
                     if(k==1)
                {
                    co_y=50;
                }
                    j=104;
                    if(total[k-1][3]=='0')// if number of digits after decimal is 0
                    var tot_d=(parseInt(total[k-1][2]));
                    else
                    var tot_d=(parseInt(total[k-1][2]) + parseInt(total[k-1][3]) +1);// number of digits before decimal +number of digits after decimal +1(for decimal)
                    for(var z=1;z<=tot_d;z++)//creating tot_d number of columns
                        {
                           for(var a=0;a<=10;a++)// each column should contain 11 circles with 0-9 and one for decimal
                               {

var c2 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
c2.setAttribute("cx", j);
c2.setAttribute("cy", co_y + 25*a);
c2.setAttribute("r", "10");
c2.setAttribute("fill", "none");
c2.setAttribute("stroke-width", "1");
c2.setAttribute("stroke", "black");
c2.setAttribute("id", "q"+k+"_"+z+""+(a+1));//id for choosing first digit as 2 for Q1- q1_13

c2.setAttribute("onclick","radio('q"+k+"_"+z+"',"+(a+1)+",11)");

var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
text.setAttribute("x",j-5);
text.setAttribute("y",co_y+25*a+5);

text.setAttribute("font-color","black");
text.setAttribute("onclick","radio('q"+k+"_"+z+"',"+(a+1)+",11)");
if(a==10)
    {
        var point=String.fromCharCode(8226);// for decimal point
        text.setAttribute("font-size","20");
      text.appendChild( document.createTextNode(point,point));
    }
    else
        {
            text.setAttribute("font-size","15");
           text.appendChild( document.createTextNode(a,a));
        }

mySvg.appendChild(c2);
mySvg.appendChild(text);


                               }
j+=50;
                        }
                        co_y+=(25*10);
                        co_y+=50;

                }
      if(total[k-1][1].charAt(0)=='4')// for match the column
                {
                     if(k==1)
                {
                    co_y=50;
                }

                    var c1_r=(parseInt)(total[k-1][2])// no. of rows
                    var c2_r=(parseInt)(total[k-1][3]);//no. of columns
                    for(var w=1;w<=c1_r;w++)// create rows
                        {
                            j=104;
                            var sub_ch=String.fromCharCode(79+w);// for writing P,Q,R... so on for rows
                            var sub_q = document.createElementNS("http://www.w3.org/2000/svg", "text");
                                sub_q.setAttribute("x",60);
                                sub_q.setAttribute("y",co_y + 25*w+5);
                                sub_q.setAttribute("font-size","17");
                               sub_q.setAttribute("font-color","black");
                              sub_q.appendChild( document.createTextNode(sub_ch,sub_ch ));
                                mySvg.appendChild(sub_q);
                           for(var b=1;b<=c2_r;b++) //create columns
                               {
var ch2=String.fromCharCode(64+b);
var c2 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
c2.setAttribute("cx", j);
c2.setAttribute("cy", co_y +25*w);
c2.setAttribute("r", "10");
c2.setAttribute("fill", "none");
c2.setAttribute("stroke-width", "1");
c2.setAttribute("stroke", "black");
c2.setAttribute("id", "q"+k+"_"+w+""+(b));// circle id- q'Question no.'_'row no.''column no.'

c2.setAttribute("onclick","radio('q"+k+"_"+w+"',"+(b)+","+c2_r+")");

var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
text.setAttribute("x",j-5);
text.setAttribute("y",co_y+25*w +5);
text.setAttribute("font-size","15");
text.setAttribute("font-color","black");
text.setAttribute("onclick","radio('q"+k+"_"+w+"',"+(b)+","+c2_r+")");
text.appendChild( document.createTextNode(ch2,ch2));
mySvg.appendChild(c2);
mySvg.appendChild(text);
j+=50;

                               }

                        }
                        co_y+=(25*c1_r);
                        co_y+=50;
                }
                  if(total[k-1][1].charAt(0)=='5')// for matrix match
                {
                     if(k==1)
                {
                    co_y=50;
                }

                    var n_r=(parseInt)(total[k-1][2])
                    var n_c=(parseInt)(total[k-1][3]);
                    for(var v=1;v<=n_r;v++)
                        {
                            j=104;
                             var sub_ch1=String.fromCharCode(79+v);
                            var sub_q1 = document.createElementNS("http://www.w3.org/2000/svg", "text");
                                sub_q1.setAttribute("x",60);
                                sub_q1.setAttribute("y",co_y + 25*v+5);
                                sub_q1.setAttribute("font-size","17");
                               sub_q1.setAttribute("font-color","black");
                              sub_q1.appendChild( document.createTextNode(sub_ch1,sub_ch1 ));
                                mySvg.appendChild(sub_q1);
                           for(var c=1;c<=n_c;c++)
                               {
var ch3=String.fromCharCode(64+c);
var c2 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
c2.setAttribute("cx", j);
c2.setAttribute("cy", co_y +25*v);
c2.setAttribute("r", "10");
c2.setAttribute("fill", "none");
c2.setAttribute("stroke-width", "1");
c2.setAttribute("stroke", "black");
c2.setAttribute("id", "q"+k+"_"+v+""+(c-1));
//alert(c2.getAttribute("id"));
c2.setAttribute("onclick","check('q"+k+"_"+v+""+(c-1)+"')");

var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
text.setAttribute("x",j-5);
text.setAttribute("y",co_y+25*v +5);
text.setAttribute("font-size","15");
text.setAttribute("font-color","black");
text.setAttribute("onclick","check('q"+k+"_"+v+""+(c-1)+"')");
text.appendChild( document.createTextNode(ch3,ch3));
mySvg.appendChild(c2);
mySvg.appendChild(text);
j+=50;

                               }

                        }
                        co_y+=(25*n_r);
                        co_y+=50;
                }


}

}
  function radio(qid, circle_id, no_ofoption) {
      //this function is called for single correct,numerical answer and match the column type questions
  	for(var i=1;i<=no_ofoption;i++){
            //redraw all the option circles on clicking any one
  		var circle = document.getElementById(qid + i);
		circle.setAttribute("fill", "white");
		circle.setAttribute("stroke", "black");
  	}
        //get the circle_id of the clicked circle and color it black
  	var circle = document.getElementById(qid+circle_id);
  	circle.setAttribute("fill", "black");
  	circle.setAttribute("stroke", "black");
        sel_id=circle.getAttribute("id");//id of selected circle
        q_num=sel_id.charAt(1);//question number, it is the char at position2 in the circle id
        if(total[q_num-1][1]=='1')// for single correct
            {
                op_sel[q_num]=(parseInt(sel_id.charAt(3))-1).toString();//insert the answer into the array op_sel at the question number index
       // alert(op_sel[q_num]);
            }
         if(total[q_num-1][1]=='4')//for match the column
             {

                 var row=sel_id.charAt(3);//get row of selected circle

                 match[row-1]=parseInt(sel_id.charAt(4))-1;//store the answer of the row in array at row index
                 match[row-1]=match[row-1].toString();
                // alert(match[row-1]);
                for(var f=0;f<total[q_num-1][2];f++)
                        {//append answer string to op_sel at question number index
                            if(f==0)
                                 op_sel[q_num]=match[0];
                              else
                                 op_sel[q_num]+=match[f];
                        }
               // alert(op_sel[q_num]);
             }
              if(total[q_num-1][1]=='3')// for numerical answer
             {
              // alert(sel_id);
                 var col=sel_id.charAt(3);//get the digit position

            numerical[col-1]=parseInt(sel_id.charAt(4)+sel_id.charAt(5))-1;//store the selected option at the column's index
            numerical[col-1]=(numerical[col-1]).toString();
            if(numerical[col-1]=='10')// for decimal point
                {
                    numerical[col-1]=String.fromCharCode(46)  ;
                }
               //  alert(numerical[col-1]);
           if(total[q_num-1][3]=='0')// no digits after decimal
                    var tot=(total[q_num-1][2]);
                    else
                        var tot=(parseInt(total[q_num-1][2]) + parseInt(total[q_num-1][3]) +1).toString();
     
                    for(var e=0;e<tot.charAt(0);e++)// append the anwers of column together and finally insert this string in op_sel
                        {
                            if(e==0)
                                 op_sel[q_num]=numerical[0];
                              else
                                 op_sel[q_num]+=numerical[e];
                        }
               // alert(op_sel[q_num]);
             }


  }

  function check(circle_id) {
      /*this function is called whenever a user selects or deselects any option in case of multiple answers or matrix match
       *if a user selects any option,it is appended in the answer string
       *when the same option is deselected ,it has to be removed from answer string
       *
       **/
  	var circle = document.getElementById(circle_id);
    if(circle)
	{
      var waschecked = circle.getAttribute("aria-checked") == "true";//if circle is selected
      circle.setAttribute("aria-checked", waschecked? "false" : "true");
      circle.setAttribute("fill", waschecked ? "white" : "black");
	  var wasblack = circle.getAttribute("stroke") == "black";
      circle.setAttribute("stroke", wasblack? "black" : "black");

          if(!waschecked)// if circle is selected
              {
          sel_id=circle.getAttribute("id");//get id of circle
           q_num=sel_id.charAt(1);//get question number


           if(total[q_num-1][1]=='2')//for multiple answers type
               {

                  multiple[n1]= sel_id.charAt(3);// store the anwer option in the array
                  if(n1==0)
                     op_sel[q_num]=multiple[n1];//append to the final answer string which is then stored at question number's index
                 else
                op_sel[q_num]+=multiple[n1];

                 //alert(op_sel[q_num]);
                n1++;
               }
                if(total[q_num-1][1]=='5')//for matrix match
               {
                  // mat_match[mat_row-1]="";
               //  alert(op_sel[q_num]);
                  var mat_row=sel_id.charAt(3);//get selected row
                  matrix[n2[mat_row-1]]= sel_id.charAt(4);//get selcted option in that row
                  if(n2[mat_row-1]==0)
                     mat_match[mat_row-1]= matrix[n2[mat_row-1]];// append the option selected at the row index
                 else
                 mat_match[mat_row-1]+= matrix[n2[mat_row-1]];
            // alert( mat_match[mat_row-1]);
                 var d=parseInt(total[q_num-1][2]);


                      for(var m=0;m<d;m++)
                          {
                              if(m==0)
                                  {
                                op_sel[q_num]=mat_match[0];//insert the final anwer string at question number's index
                                
                                 op_sel[q_num]+="-";//apppend a '-' after each row's answer

                                  }
                            else
                                {
                                    op_sel[q_num]+=mat_match[m];
                                     op_sel[q_num]+="-";

                            }

                          }
//                          alert(op_sel[q_num]);


                   //  alert(op_sel[q_num]);
                n2[mat_row-1]++;
               }
              }

             if(waschecked)//if circle is deselected
                  {
             sel_id=circle.getAttribute("id");//get id of circle
           q_num=sel_id.charAt(1);


                      if(total[q_num-1][1]=='2')
               {
                 var n=sel_id.charAt(3);


                  var op=new Array();

                  for(var q=0;q<op_sel[q_num].length;q++)
                      {
                          op[q]=op_sel[q_num].charAt(q);
                        //  alert(op);
                      }
                  var s_o=op_sel[q_num].indexOf(n);
                      op[s_o]='';// make the entry at that position in array as empty
                      s1="";
                 for(var q1=0;q1<op.length;q1++)
                      {
                          s1+=op[q1];// now again append the options to the final answer string
                      }
                     // alert(s1);
                  op_sel[q_num]=s1;
                 //alert(op_sel[q_num]);

               }
                if(total[q_num-1][1]=='5')
               {
                 var row_n=sel_id.charAt(3);
                 var  op_n=sel_id.charAt(4);
                     s1="";


                  spl=op_sel[q_num].split('-');//to get number of rows
                  for(var p=0;p<spl.length-1;p++)
                      {alert(spl[p]);
                          var op=new Array();

                  for(var q=0;q<spl[p].length;q++)
                      {
                          op[q]=spl[p].charAt(q);

                         // alert(op);
                      }
                      if(p==row_n-1)
                          {
                  var s_o=spl[row_n-1].indexOf(op_n);
                      op[s_o]='';
                          }


                       for(var q1=0;q1<op.length;q1++)
                      {
                          s1+=op[q1];

                      }
                      s1+="-";
                      }

                  op_sel[q_num]=s1;
                // alert(op_sel[q_num]);
                

               }
                  }


    }
  }
 function getValues()
 {
     /*this function is used to create the final CSV with answers by appending the answer of each question to its corresponding row*/
     confirm("Are you sure you want to submit the answers?");
     final_str="";
     final_str=final_str+s[0]+";";// append first line of previous CSV as it is(first line contains total questions,marks, and time for test)
     for(var fq=1;fq<=numQues;fq++)
         {
             if(total[fq-1][1]=='5')
                 {
                     final_str=final_str+total[fq-1][0]+","+total[fq-1][1]+","+total[fq-1][2]+","+total[fq-1][3]+","+total[fq-1][4]+","+total[fq-1][5]+",";
                     var sel_mat=op_sel[fq].split('-');
                     for(var mat=1;mat<=total[fq-1][2];mat++)
                         {
                             final_str=final_str+sel_mat[mat-1];
                             if(mat<total[fq-1][2])
                                 {
                                     final_str=final_str+"-";
                                 }
                         }
                         final_str=final_str+";";
             }
             else
                 {
                     //final string with question specifications and answer to each question 

            final_str=final_str +total[fq-1][0] + "," +total[fq-1][1]+","+total[fq-1][2]+","+total[fq-1][3]+","+total[fq-1][4]+","+total[fq-1][5]+","+op_sel[fq]+",;";
                 }
         }
       alert(final_str);
         window.location.replace("answer.jsp?final_str="+final_str);
 }
</script>
</head>


<body onLoad="loadXMLDoc()">
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
                <li><a href="teacherIndex.jsp">Home</a></li>
                <li><a href="quizspecifications.jsp"  class="current">Quiz Specifications</a></li>
                <li><a href="selectTest.jsp">Results</a></li>
            </ul>
        </div>
	</div>
    <div id="main_left_column">

            <div id="leftcolumn_box01">
                <div class="leftcolumn_box01_top">
                    <h2>Welcome <%= session.getAttribute("firstName")%> !!</h2>
                </div>
                <div>
                    <form method="post" action="#">
                     <div align="left"><a href="logout.jsp"/></div>
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
                <div id="main_middle_column">

                    <form align="left"><input type="button" value="OMR" class="button"  onClick="start()" ></form>

 

<div id="svgContainer">


</div>
                    <form align="right"><input type="button" value="Submit" class="button" onClick="getValues()" ></form>
                   
                </div>
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
