
public class RFIDAPP {
public String obj;



public String getObj() {
	return obj;
}



public void setObj(String obj) {
	this.obj = obj;
}



public static void change16(){
	String ss="ssss";
byte [] b=ss.getBytes();
String hex=null;
System.out.println(b.length+"mmmm");
for (int i = 0; i < b.length; i++) { 
	System.out.println(b[i] & 0xff);
	/* hex = Integer.toHexString(b[i] & 0xff); 
	if (hex.length() == 1) { 
	hex = '0' + hex; 
	} 
	System.out.print(hex.toUpperCase() + "="); 
	}*/
//return hex; 
}
}
public static void main(String args[]){
	change16();
	
}

}
