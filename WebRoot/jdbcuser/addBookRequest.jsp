<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'addBookRequest.jsp' starting page</title>

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
		String readerid = (String) session.getAttribute("read_session");

		PreparedStatement pstmt;
		//使用以下方式解决表单乱码
		String bookname = new String(request.getParameter("bookname")
				.getBytes("iso-8859-1"), "utf-8");
		String reason = new String(request.getParameter("reason").getBytes(
				"iso-8859-1"), "utf-8");

		String sql = "insert into note(ReaderID,bookname,notedate,NOTE) values (?,?,now(),?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, readerid);
			pstmt.setString(2, bookname);
			pstmt.setString(3, reason);
			int i = pstmt.executeUpdate();
			if (i == 1) {
				out.print("提交成功！");
			} else {
				out.print("提交失败");
			}
		} catch (SQLException e) {
			out.print(e.getMessage());
		} finally {
			con.close();
		}
	%>
</body>
</html>
