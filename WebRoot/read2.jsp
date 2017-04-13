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
   /*RFIDapi pi =new RFIDapi();
   pi.testinitreader();
   pi.testreadandwrite3();
   out.print(" tags:" +pi.testreadandwrite3()+"<br>");
   //String Str=pi.testreadandwrite3();
   
   t t =new t();
   String a = Str.substring(22,24);
     out.print(a+"<br>");
   t.HexToDec(a);
   out.print(t.HexToDec(a));
   
   pi.closeReader();
      */
   
   
   %>
  </body>
</html>
