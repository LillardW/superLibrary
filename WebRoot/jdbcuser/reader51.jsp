<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'reader51.jsp' starting page</title>
    
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
    <% int a1=Integer.parseInt(request.getParameter("a1"));
    byte a2 =(byte)a1;
    out.print(a1);
    int b1=Integer.parseInt(request.getParameter("b1"));
    byte b2 =(byte)b1;
    int c1=Integer.parseInt(request.getParameter("c1"));
    byte c2 =(byte)c1;
    int d1=Integer.parseInt(request.getParameter("d1"));
    byte d2 =(byte)d1;
    int e1=Integer.parseInt(request.getParameter("e1"));
    byte e2 =(byte)e1;
    int f1=Integer.parseInt(request.getParameter("f1"));
    byte f2 =(byte)f1;
    int h1=Integer.parseInt(request.getParameter("h1"));
    byte h2 =(byte)h1;
    int i1=Integer.parseInt(request.getParameter("i1"));
    byte i2 =(byte)i1;
    int j1=Integer.parseInt(request.getParameter("j1"));
    byte j2 =(byte)j1;
    int k1=Integer.parseInt(request.getParameter("k1"));
    byte k2 =(byte)k1;
    int l1=Integer.parseInt(request.getParameter("l1"));
    byte l2 =(byte)l1;
     out.print(i1);
    
    %> <br>
  </body>
</html>
