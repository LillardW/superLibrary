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
		//使用以下方式解决表单乱码
		String ReaderID = (String) session.getAttribute("read_session");
		String ReaderName = new String(request.getParameter("ReaderName")
				.getBytes("iso-8859-1"), "utf-8");
		String Sex = new String(request.getParameter("Sex").getBytes(
				"iso-8859-1"), "utf-8");
		String Phone = new String(request.getParameter("Phone").getBytes(
				"iso-8859-1"), "utf-8");
		String Address = new String(request.getParameter("Address")
				.getBytes("iso-8859-1"), "utf-8");
		if (ReaderName.equals("") || ReaderName == null)
			ReaderName = null;
		if (Phone.equals("") || Phone == null)
			Phone = null;
		if (Address.equals("") || Address == null)
			Address = null;

		String sql = "update reader set ReaderName=?,Sex=?,Phone=?,Address=? where ReaderID=?";
		try {
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, ReaderName);
			pstmt.setString(2, Sex);
			pstmt.setString(3, Phone);
			pstmt.setString(4, Address);
			pstmt.setString(5, ReaderID);

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
