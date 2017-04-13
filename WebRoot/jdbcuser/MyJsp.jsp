<%@ page language="java" import="java.util.Date,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
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
  <%@include file="conn.jsp"%>
   <%PreparedStatement pstmt;
   String sql = "update book set BON=1 where BkID=2";
   try {
out.print(sql);
pstmt = con.prepareStatement(sql);
int i = pstmt.executeUpdate();
				if (i > 0) {
				out.print("更新成功");					
				} else {
					out.print("更新失败");
				}}catch (SQLException e) {
				out.print("wsqw");
			} finally {
				con.close();
			} %> <br>
  </body>
</html>
