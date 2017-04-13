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
   byte s =5;
   s+=16;//确保两位
   byte[] data=new byte[]{s,0x12,0x36,0x46,0x56,0x66,0x76,(byte)0x86,(byte)
		 0x96,(byte) 0xaa,(byte) 0xbb,(byte) 0xcc};
   pi.testreadandwrite1(data);
   out.print(" tags:" +pi.testreadandwrite2(data));
   String Str=pi.testreadandwrite2(data);
   
   t t =new t();
   String a = Str.substring(18,20);
     out.print(a);
   t.HexToDec(a);
   out.print(t.HexToDec(a));
   
   pi.closeReader();
      
   %>
		  <br>
  </body>
</html>
