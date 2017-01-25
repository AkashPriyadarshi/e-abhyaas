/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.io.*;
/*Read file class is used to no. of student MAC ID or name in file in */
public class ReadFile {
	String[] list;
	private int noOfSudent;
	private int counter = 0;
	private String integerTemp = "";
	private String concatinate = "";

	String[] getStudentList(String fileName) {
		char[] temp = new char[200];         //Array to store value

		boolean flag = true;
		try {
			File file = new File(fileName);    //new file type is created 
			FileReader fileReader = new FileReader(file);
			fileReader.read(temp);             //file is read into  array
                      /*loop is used to iterate array
                       * flag is used to read no. of elements in file and initialise array for id aor name
                       * when flag is false it is used read name
                       */
                       
                       
			for (char c : temp) {
				if (flag) {
					if (c != ',') {

						integerTemp += c;

					} else {

						flag = false;
						noOfSudent = Integer.parseInt(integerTemp);
						list = new String[noOfSudent];                //array is initialised
						System.out.println("no. of student in text "
								+ integerTemp);

					}
				} else {

					if (c != ',') {
						concatinate += c;           //charater are concatinated if not ','
					} else {

						list[counter] = concatinate; //if ',' is found value is assigned to array
						concatinate = "";            //concat is re initialised
						counter++;                   //array Index is incremented
					}

				}

			}
			fileReader.close();      //After iteration file reader is closed
		} catch (IOException e) {
			System.out.println("Error in reading file due to " + e);
		} catch (Exception e) {
			System.out.println("Error");
		}
		for (String name : list)
			System.out.println(name);

		return list;
	}

/* This method is used to read decyption key from file .It  
 * takes file name as argument and return string as key 
 */
        
        String getKey(String fileName){
        char[] tem = new char[100];
        String key="";
		
		try {
			File file = new File(fileName);
			FileReader fileReader = new FileReader(file);
			fileReader.read(tem);
                        concatinate="";
                       // System.out.println(concatinate);
			for (char c : tem) {
				
					if (c != ',') {
                         		concatinate += c;           //read file till ',' is found
                                                

					} else {
                                             key =concatinate;     //if ','is found value is assigned into key and came out of loop
                                             break;
					}
				
                        }
			fileReader.close();       //file reader is closed
		} catch (IOException e) {
			System.out.println("Error in reading file due to " + e);
		} catch (Exception e) {
			System.out.println("Error");
		}
		
		return key;                       //key required for decryption is returned
	}
        
        
        }

