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
		PreparedStatement pstmt;
		String BookID = new String(request.getParameter("BookID").getBytes(
				"iso-8859-1"), "utf-8");
		String BookName = new String(request.getParameter("BookName")
				.getBytes("iso-8859-1"), "utf-8");
		String Author = new String(request.getParameter("Author").getBytes(
				"iso-8859-1"), "utf-8");
		String Press = new String(request.getParameter("Press").getBytes(
				"iso-8859-1"), "utf-8");
		String PressDate = new String(request.getParameter("PressDate")
				.getBytes("iso-8859-1"), "utf-8");

		String image = new String(request.getParameter("image").getBytes(
				"iso-8859-1"), "utf-8");

		if (Press.equals("") || Press == null)
			Press = null;
		if (image.equals("") || image == null)
			image = null;

		Float Price = new Float("0");
		if (!request.getParameter("Price").equals("")
				&& request.getParameter("Price") != null) {
			try {
				Price = Float.parseFloat(request.getParameter("Price"));
			} catch (Exception e) {
			}
		}

		String sql = "update book set BookName=?, Author=?,Press=?, PressDate=?,Price=?,image=? where BookID=?";
		try {
			pstmt = con.prepareStatement(sql);

			pstmt.setString(7, BookID);
			pstmt.setString(1, BookName);
			pstmt.setString(2, Author);
			pstmt.setString(3, Press);
			pstmt.setString(4, PressDate);
			pstmt.setFloat(5, Price);
			pstmt.setString(6, image);

			int i = pstmt.executeUpdate();
			if (i > 0) {
				out.print("更新成功");
			} else {
				out.print("更新失败");
			}
		} catch (SQLException e) {
			out.print(e.getMessage());
		} finally {
			con.close();
		}
	%>



</body>
</html>
