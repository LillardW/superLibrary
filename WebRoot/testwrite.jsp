<%@ page language="java" import="java.util.*,fd.RFIDapi,fd.t" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'testwrite.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
     <%RFIDapi pi =new RFIDapi();
   pi.testinitreader();
  
   byte s =6;
   
   s+=16;//确保两位
   
    byte a1=21;
   byte b1=01;
    byte c1=20;
      out.print(c1+"<br>"); 
   c1+=180;
    byte d1=0;
   byte e1=1;
   byte f1=1;
   byte g1=0;
   byte h1=0;
   byte i1=1;
   byte j1=0;
   byte k1=0;
   byte l1=0;
   int y=100;
        out.print(c1+"<br>");
   byte[] data=new byte[]{a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1};
		 //out.print(data.length+"<br>");
   pi.testreadandwrite1(data);
   out.print(" tags:" +pi.testreadandwrite1(data)+"<br>");
   String Str=pi.testreadandwrite1(data);
   
   t t =new t();
   String a = Str.substring(0,2);
     out.print(a);
   t.HexToDec(a);
   out.print(t.HexToDec(a));
   
   pi.closeReader();
      
   %>
		  <br>
  </body>
</html>
