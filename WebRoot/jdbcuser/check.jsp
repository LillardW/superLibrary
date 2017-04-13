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
<style type="text/css">    
 body{    
      background-image: url(jdbc/book_image/05.jpg);    
      background-repeat: repeat-x;    
 }    
 </style> 
	<body>

		<%@include file="conn.jsp"%>
		<%	
			//使用以下方式解决表单乱码
			String ReaderID = new String(request.getParameter("readerID")
					.getBytes("iso-8859-1"), "utf-8");
	Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);		

			String sql = "select * from reader where ReaderID='"+ReaderID+"'";
			try {
				ResultSet rs = stmt.executeQuery(sql);
				if(!rs.next()) {out.print("账户"+ReaderID+"可以使用，<a href='jdbcuser/reg.html'>返回注册</a>");}
				else{out.print("账号"+ReaderID+"重复，<a href='jdbcuser/reg.html'>返回注册</a>");}
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
