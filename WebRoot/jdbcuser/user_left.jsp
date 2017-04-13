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

	<body>

	<%String read_session=(String)session.getAttribute("read_session");
	if (read_session==null){
	out.print("<a href='jdbcuser/login.html' target='_top'>你还没有登录</a>");
	}else{
	out.print("<h1>欢迎用户"+read_session +"进入图书管理后台！</h1>	");
	
	%>
	<br/>
<a   href="jdbcuser/books.jsp" target=right>借书</a> <br/>
 <a   href="jdbcuser/user_regupdate.jsp" target=right>用户信息更新</a> <br/>
 <a   href="jdbcuser/user_passupdate.jsp" target=right>用户密码修改</a> <br/>
 <a   href="jdbcuser/user_borrow.jsp" target=right>借阅查看</a> <br/>
  <a   href="jdbcuser/login_out.jsp" target="_top">退出登录</a> <br/>
	
		
<%} %>


	</body>
</html>
