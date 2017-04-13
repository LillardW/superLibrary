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
		<%
			String BookID = (String) request.getParameter("bookId");

			PreparedStatement pstmt;
			String sql = "select * from book where BookID=?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, BookID);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					%>
				请输入修改信息：
		<form name="update" action="jdbcuser/manager_bookupdateok.jsp">
			书号*:
			<input type="text" name="BookID" value="<%=rs.getString("BookID") %>"  readonly="readonly"/>
			<br />
			书名*:
			<input type="text" name="BookName" value="<%=rs.getString("BookName") %>" />
			<br />
			作者:
			<input type="text" name="Author" value="<%=rs.getString("Author") %>" />
			<br />	
			出版社:
			<input type="text" name="Press" value="<%=rs.getString("Press") %>"/>
			<br />	
			出版日期:
			<input type="text" name="PressDate" value="<%=rs.getDate("PressDate") %>"/>
			<br />	
			价格:
			<input type="text" name="Price" value="<%=rs.getString("Price") %>"/>
			<br />	
			
			图片:
			<input type="text" name="image" value="<%=rs.getString("image") %>"  size="30" />
			<br />
			
			<input type="submit" value="更新"  />
		</form>	
					
					<%
				} 
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>

		

	</body>
</html>
