/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.net.*;
import java.io.*;
import java.net.ServerSocket;

public class ServerSide {

    static String serverip;                                        /* Stores Server IPAddress*/
    public static final int SERVERPORT = 8080;                     /*Stores Server Port Number*/
    static Socket client;                                          /*client socket*/
   // static String macAddress;                                      /**/
    static DataOutputStream out;                                    /*Output Stream for file transfer*/
    static String[] list;                                          /*Store list of MacAddress appearing in exam*/
    static String[] listName;                                      /*Store Student Names who are appearing in exam */
    static String[][] answer;                                      /*Stores answer for evaluation*/
    static volatile String[][] connected;                          /*Stores all currently connected student */
    static String key = "";
 /*Start of main Activity*/
    public static void main(String args[]) {
        // serverip = IPAddress.localIP();
        System.out.println(serverip);
        Answer testans = new Answer();
        /*READS MAC ADDRRESS of all tablets  going to connect*/
        list = new ReadFile().getStudentList("Invigilator\\studentList.csv");
         /*READS Names of All Student whose tablets  going to connect*/
        listName= new ReadFile().getStudentList("Invigilator\\studentNames.csv");
        /*READS answer of all the Questions */
        answer = testans.read("Invigilator\\QuestionsAndAnswers.csv");
        /*READ the key for decryption of question paper*/
        key = new ReadFile().getKey("Invigilator\\Key.csv");
        /*Initialise the array*/
        connected = new String[list.length][5];
        for (int i = 0; i < list.length; i++) {
            connected[i][0] = list[i]; //stores mac address
            connected[i][1] = "false"; //stores  value to change colour of row 
            connected[i][2] = "false"; 
            connected[i][3] = "0";     //Stores the answer send by student
            connected[i][4] = "false"; //stores value to check first time connection 
        }
      
        //Creates table
        NewJFrame n = new NewJFrame(list);
        n.setVisible(true);

        //Creates Server Socket
        ServerSocket server;
        try {
            server = new ServerSocket(SERVERPORT);

            while (true) {
                try {
                    client = server.accept();                  //server aacept client connections
                    new ClientThread(client, list, n).start(); // new thread is called for each client 
                    client = null;                             //client is reset to null
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("Universal error");     //Error  in assigning client socket
                }
            }
        } catch (IOException e) {
            System.out.println("IOException error" + e);       //error in server socket creation
        }
    }

    String[] getlist() {
        return list;                                        //get Student MACADDRESS list
    }
     String[] getNameslist() {
        return listName;                                     //get Student Name list
    }
}
