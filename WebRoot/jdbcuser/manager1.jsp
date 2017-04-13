<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP '1.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>
	 <%@include file="conn.jsp"%>
	<%String read_session=(String)session.getAttribute("read_session");
	 PreparedStatement pstmt;
          Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from reader where ReaderID='"+read_session+"'";
ResultSet rs1 = stmt.executeQuery(query);
String s ="";
while(rs1.next()) {s=rs1.getString("Limited");}
out.print(s);
	if (read_session==null || s.equals("0")){response.sendRedirect("weidlu2.jsp");
	}else{response.sendRedirect("manager.jsp");}%>

	
</html>
