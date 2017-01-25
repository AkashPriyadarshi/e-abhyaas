/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package e_Abhyaas;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.Socket;

/**
 * 
 * @author akash
 */

public class ClientThread extends Thread {
	Socket client;                      //Client Socket
	DataOutputStream out;               //Output Stream
	NewJFrame n;                       //Cass in which table is defined
	String[] list;                     //Student MAC Address list is stored
	int index = 0;                     //MAC Address index
        static String start ="";      //start 
        String macAddress;                //macaddress is read in this variable
       /*Client thread is initialised
        *It takes client socket , MAC Address list and NewJframe as argument 
        * assign it into class variables
        
        */
        
	ClientThread(Socket client, String[] list, NewJFrame n) {
		this.client = client;
		this.list = list;
		this.n = n;

	}
       /*
        *This method creates new thread .All the dedicated  client Related functions are performed in this class
        *In this method clientInput and Output Stream is Initialised .
        * File are transferred to the tablet.
        * Answer is accepted and evaluated .
        * Answer send by student  is written into file.
        *         
        */
	@Override
	public void run() {
		try {
			System.out.println(client.getRemoteSocketAddress().toString());

			out = new DataOutputStream(client.getOutputStream());//client output Stream is initialised

			out.writeUTF("connected");                          //handshake is done

			DataInputStream in = new DataInputStream(client.getInputStream());//input Stream is initialised

			macAddress = in.readUTF();                          //mac Address is read into stream
			/*these lines display the mac address*/
			if (macAddress == null) {                            
				System.out.println("error occurred in mac calculation");
			} else {
				System.out.println("MAC Address is :" + macAddress);
			}
			boolean flag = true;
			for (String check : list) {                           //this line compare student tablet mac address with list
                              
				if (check.equalsIgnoreCase(macAddress)) {            
					System.out.println("String matched : " + check);           
                                         /*if mac Address matches arrray initiaisation  is done*/
                                        if(ServerSide.connected[index][4].equals("false")){
					ServerSide.connected[index][1] = "true";
                                        ServerSide.connected[index][4] = "true";
                                        System.out.println(index+"  "+ServerSide.connected[index][1]);
                                        }else{
                                            /*if mac address  matches but already had connected once thread is killed*/
                                         Thread t = Thread.currentThread();
                                         t.stop();
                                        }
					flag = false;
					n.setVisible(false);
					n.setVisible(true);

					break;
				}
				index++;
			}
                        /*If mac Address does not matches  thread is killed*/
			if (flag) {
				System.out.println("String not matched  ");
				 Thread t = Thread.currentThread();
				 t.stop();
			}
                        String[] mac=macAddress.split(":");  //Mac Address is  split based on ':' 
                         int i =0;
                        String  imageName="";
                        /*Mac Address is generated with '-'*/
                        for(String concat:mac){              
                        imageName +=(concat);
                        i++;
                        if(i==mac.length)
                        {break;}
                        imageName+="-";
                        }
                        System.out.println(imageName);
			Transfer t = new Transfer();
			File file = new File("Invigilator\\Questions.o");      //encrypted file is transferred to client 
			t.fileTransfer(client, file, out);
			file = new File("Invigilator\\"+imageName+".jpg");     //Student pic is transferred 
			// System.out.println(in.readUTF
                       t.fileTransfer(client, file, out);
                         file = new File("Invigilator\\Questions.csv");        //question file  generator transferred
                         t.fileTransfer(client,file, out);
			//System.out.println("hhhhhhhhhhhhhhhhhhh");
			byte buffer;
                      
			this.startTest();
                                           
                        String answer = in.readUTF();                          //answer is read into a string

			System.out.println("answer send by macaddress :" + macAddress
					+ " is :" + answer);
			 System.out.println(Answer.result(answer));            //Answer is evaluated
                       //  ServerSide.connected[index][3] = ""+Answer.result(answer);
                        ServerSide.connected[index][3] = (answer);
                          Answer.writeAnswer();                                //Student answer is written back into file
                          out.writeUTF(""+Answer.result(answer));
                       try {

				client.close();
			} catch (Exception e) {
				System.out.println("hi" + e);
			}

		} catch (IOException e) {
			System.out.println("error " + e);
		} finally {
                     try{
                         ServerSide.connected[index][1] = "false";
                         
			n.setVisible(false);
			n.setVisible(true);
                        //   Thread.sleep(5000);
                        }catch(Exception e){
                        System.out.println("while disconnecting...");
                        }
			
		}

	}
        /*This function is called after file transfer
         *this function checks whether start is clicked or not 
         * if start is clicked . It will transfer the decryption key
         * else it will stop for click on start button
         */
     private void startTest(){
             System.out.println("inside start test ");
                ServerSide.connected[index][2] = "true";      //flag is set true to change colour to blue
		/*table is redrawn*/
                n.setVisible(false);                          
		n.setVisible(true);

         while(true){
          try{
                    
              Thread.sleep(10000);                           //A sleep of 10 sec ond is put in each consecutive cycles
           //checks whether start button is cicked         
           if(start.equals("true"))
           {
           System.out.println("hiiiiiiiii");           
           out.writeUTF(ServerSide.key);                       //key is transferred
           break;
           }
           if(start.equals("false")){
            Thread t = Thread.currentThread();
             t.stop();
            
           }
          }catch(Exception e){
          System.out.println("Error in sleep");
          }
         }
     
     }

}
