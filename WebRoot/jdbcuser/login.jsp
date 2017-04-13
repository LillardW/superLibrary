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

		<%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;
			//使用以下方式解决表单乱码
			String ReaderID = new String(request.getParameter("readerID")
					.getBytes("iso-8859-1"), "utf-8");
			String Password = new String(request.getParameter("password")
					.getBytes("iso-8859-1"), "utf-8");
	
			String sql = "select * from reader where ReaderID=? and Password=?";
			try {
				pstmt = con.prepareStatement(sql);
pstmt.setString(1,ReaderID);
pstmt.setString(2,Password);


				ResultSet rs= pstmt.executeQuery();
				if (rs.next()) {
				session.setAttribute("read_session",ReaderID);
				//out.print(ReaderID);					
				if (rs.getString("Limited").equals("1")) {
				response.sendRedirect("manager1.jsp");
				} else {if(rs.getString("Level").equals("0")){response.sendRedirect("manager2.jsp");}
					else{response.sendRedirect("manager3.jsp");}
				}
				}else{
				response.sendRedirect("relogin.html");
				
				}
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
