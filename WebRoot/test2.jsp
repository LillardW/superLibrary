<%@ page language="java" import="java.util.*,fd.RFIDapi,fd.t" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'read.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body><%
   RFIDapi pi =new RFIDapi();
   pi.testinitreader();
   pi.testreadandwrite();

   out.print(" tags:" +pi.testreadandwrite()+"<br>");
   String Str=pi.testreadandwrite();
   byte[] data=new byte[12];
   
      out.print("data数组长度"+data.length+"<br>");
   t t =new t();
   out.print("str数组长度"+Str.length()+"<br>");
   int i;
   for(i=0;i<=Str.length()-2;i=i+2){
   
   String a = Str.substring(i,i+2);
  // out.print("16进制"+a+"<br>");
   t.HexToDec(a);
   long id =t.HexToDec(a);
   Byte bt =(byte)id; 
   data[i/2]=(byte)id; 
  // out.print("asdasdfsdvfdf"+data[i/2]+"<br>");
 //int x = Integer.parseInt(t.HexToDec(a));
   out.print("10进制"+t.HexToDec(a)+"<br>");
   }
   pi.closeReader();
   int j;
      for(j=0;j<=data.length-1;j++){out.print("data"+data[j]+"<br>");}
   //out.print("zuihou"+data[11]);
    byte s =6;
   s+=16;
   byte[] data1=new byte[]{s,data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8],data[9],data[10],data[11]};
  pi.testreadandwrite1(data1);
   out.print(" tags:" +pi.testreadandwrite1(data1));
   
   %>
  </body>
</html>
