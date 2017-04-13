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
			
			String ReaderID = (String) session.getAttribute("read_session");
			String oldPassword = new String(request.getParameter("oldPassword")
					.getBytes("iso-8859-1"), "utf-8");			
			String Password = new String(request.getParameter("Password").getBytes(
					"iso-8859-1"), "utf-8");
			

			String sql = "select * from reader where ReaderID=?";
			try {
				pstmt = con.prepareStatement(sql);
pstmt.setString(1,ReaderID);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()&&rs.getString("Password").equals(oldPassword)){
				String sqlup = "update reader set Password=? where ReaderID=?";
				pstmt = con.prepareStatement(sqlup);
pstmt.setString(1,Password);
pstmt.setString(2,ReaderID);
int i = pstmt.executeUpdate();
				if (i > 0) {
				out.print("密码更新成功");					
				} 
				}else {
					out.print("原始密码输入错误，请重新修改");
				}
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
