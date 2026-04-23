/*Server Side Code*/
import java.io.*;
import java.net.*;
class dserver
{
public static DatagramSocket ds;
public static int clientport=1789,severport=1790;
public static void main(String args[])throws Exception
{
byte buffer[]=new byte[1024];
int ret=0;
String temp=" ";
ds=new DatagramSocket(severport);
BufferedReader b= new BufferedReader(new InputStreamReader(System.in));
InetAddress ia=InetAddress.getByName("localHost");
while(true)
{
DatagramPacket p= new DatagramPacket(buffer,buffer.length);
ds.receive(p);
String psx=new String(p.getData(),0,p.getLength());
ret = Integer.parseInt(psx);
if(ret%2==0)
{
temp=psx.concat("is even");
}
else
{
temp=psx.concat("is odd");
}
buffer=temp.getBytes();
ret=temp.length();
ds.send(new DatagramPacket(buffer,ret,ia,clientport));
}
}
}
Client1.java:-
/*Client Side Code*/
import java.io.*;
import java.net.*;
class dclient
{
public static DatagramSocket ds;
public static int clientport = 1789,serverport=1790;
public static byte buffer[] = new byte[1024];
public static byte bufferr[] = new byte[1024];
public static int a = 0;
public static void main(String args[]) throws Exception
{
ds= new DatagramSocket(clientport);
BufferedReader b= new BufferedReader(new InputStreamReader(System.in));
InetAddress ia=InetAddress.getByName("localHost");
System.out.println("Enter the no:");
try
{
String str= new String(b.readLine());
buffer =str.getBytes();
a=str.length();
ds.send(new DatagramPacket(buffer,a,ia,serverport));
a = bufferr.length;
DatagramPacket p=new DatagramPacket(bufferr,a);
ds.receive(p);
String psx =new String(p.getData(),0,p.getLength());
System.out.println(psx);
b.close();
ds.close();
}catch(Exception e)
{
} 
}
}

