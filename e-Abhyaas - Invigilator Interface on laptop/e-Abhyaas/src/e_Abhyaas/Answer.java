/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

/**
 *
 * @author akash
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.StringTokenizer;
import java.util.Arrays;
import java.io.File;
/*this class is used to handle all answer related events
 * this class is used to read anser from csv file into array
 * Evaluate the answer submitted by client
 * write answer back into csv file
 */

public class Answer {

    int numberOfQuestion;
    int totalMarks;
    static String answer[][];                  //Answer is read into a array
 /* this function is used to read answer into array
     *  it stores type of question 
     * this is also used to store marks to be allocated if a particular question is right or wrong 
     */

    public String[][] read(String strFile) {
        // 
        try {
            BufferedReader br = new BufferedReader(new FileReader(strFile)); //buffered output stream is uesd to read file 
            String strLine = "";
            StringTokenizer st = null;
            int lineNumber = 0, tokenNumber = 0;
            int questionType = 0;
            // read comma separated file line by line
            while ((strLine = br.readLine()) != null) {        //reads one line at a time
                lineNumber++;

                st = new StringTokenizer(strLine, ",");       //tokenize data read based ','

                while (st.hasMoreTokens()) {
                    // display csv values
                    tokenNumber++;                            //increment token value for each line

                    if (lineNumber == 1 && tokenNumber == 1) {
                        numberOfQuestion = Integer.parseInt(st.nextToken());           //reads no. of questions 
                        answer = new String[numberOfQuestion][3];
                        // System.out.print(numberOfQuestion+"       ");
                    } else if (lineNumber == 1 && tokenNumber == 3) {
                        totalMarks = Integer.parseInt(st.nextToken());                // reads total marks
                        // System.out.println(totalMarks+"  marks     ");
                    } else if (lineNumber != 1 && tokenNumber == 2) {
                        questionType = Integer.parseInt(st.nextToken());              //reads type of question
                        System.out.print(questionType + "       ");


                    } else if (tokenNumber == 5) {
                        answer[(lineNumber - 2)][0] = (st.nextToken());              //reads marks if correct
                        //  System.out.print(answer[lineNumber-2][0]+" ");

                    } else if (tokenNumber == 6) {
                        answer[(lineNumber - 2)][1] = (st.nextToken());              //reads marks if wrong
                        //  System.out.print(answer[lineNumber-2][0]+"  "+answer[lineNumber-2][1]);
                    } else if (tokenNumber == 7) {

                        answer[(lineNumber - 2)][2] = (st.nextToken());             //reads correct anwer
                        /*sort the answer if multiple choice or matrix row */
                        if (questionType == 2 || questionType == 5) {
                            String ans = answer[lineNumber - 2][2];
                            String finalAns = "";
                            /*if matrix match*/
                            if (questionType == 5) {
                                //  System.out.print(ans);

                                String[] splitArray = ans.split("-");
                                //  System.out.print("  "+splitArray.length+"  ");
                                for (int i = 0; i < splitArray.length; i++) {
                                    char[] ansArray = splitArray[i].toCharArray();

                                    ans = "";
                                    Arrays.sort(ansArray);
                                    for (int j = 0; j < ansArray.length; j++) {

                                        ans += ansArray[j];
                                    }
                                    finalAns += (ans + ".");

                                }
                                answer[lineNumber - 2][2] = finalAns.substring(0, finalAns.length() - 1);
                            } else {
                                char[] ansArray = ans.toCharArray();          //if  multiple choice  

                                ans = "";
                                Arrays.sort(ansArray);
                                for (int i = 0; i < ansArray.length; i++) {

                                    ans += ansArray[i];

                                }

                                answer[lineNumber - 2][2] = (ans);
                            }
                            // System.out.println(answer[lineNumber-2][2]);
                        }

                        // System.out.println(lineNumber+" "+answer[lineNumber-2][0]+"    "+answer[lineNumber-2][1]+"    "+answer[lineNumber-2][2]+"    ");
                    } else {
                        st.nextToken();
                    }

                }
                //print the value of file
                if (lineNumber >= 2) {
                    System.out.println((lineNumber - 2) + " " + answer[lineNumber - 2][0] + "    " + answer[lineNumber - 2][1] + "    " + answer[lineNumber - 2][2] + "    ");
                }

                tokenNumber = 0;   //reset the value on next line


            }
        } catch (Exception e) {
            System.out.println("Exception while reading csv file: " + e);
        }
        return answer;
    }
    /*this function is used to evaluate client answer and return marks he got*/

    public static int result(String studentAnswer) {
        String[] ans = studentAnswer.split(";");  //client answer is split based on ';'
        int marks = 0;
        /*iterate based on no. of question in exam*/
        for (int questionNumber = 0; questionNumber < answer.length; questionNumber++) {
            /*if answer is correct aloocate specified marks*/
            if (ans[questionNumber].equals("" + answer[questionNumber][2])) {

                marks += Integer.parseInt(answer[questionNumber][0]);
                System.out.println(ans[questionNumber] + "   " + answer[questionNumber][2]);

            }/*
             If answer is wrong and not equal to -1 
             * Negative marking is done
             */ else if (!ans[questionNumber].equals("-1")) {
                System.out.println(ans[questionNumber] + "   " + answer[questionNumber][2]);
                marks -= Integer.parseInt(answer[questionNumber][1]);

            }


        }

        return marks;
    }
    /*
     * answer is written back into Answer.csv file
     */

    public static void writeAnswer() {

        String connected[][] = ServerSide.connected;         //currently connected student values is stored
        double totalMarks = 0;

        try {
            File file = new File("Invigilator\\Answer.csv");     //new file with Answer.csv is created
            String writeAnswer = "";
            for (int i = 0; i < connected.length; i++) {
                writeAnswer += ("" + connected[i][0] + "_" + connected[i][3] + ","); //Answer is concatinated with all other answer
            }
            System.out.println(writeAnswer);
            FileWriter fw = new FileWriter(file);
            fw.write(writeAnswer);                              //file writer is used to write back answer
            fw.flush(); // flush before closing
            fw.close();
        } catch (Exception e) {
        }
    }
}
