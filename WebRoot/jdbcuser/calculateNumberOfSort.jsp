<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="com.Result" %>
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

<title></title>

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
	<table border=1 align=center width=400px>
		<caption>
			<h2>
				用户<%
				out.print(session.getAttribute("read_session"));
			%>借阅的书的种类数量
			</h2>
		</caption>
		<tr>
			<th>
				<%
					out.print("图书分类编号");
				%>
			</th>
			<th>
				<%
					out.print("书号");
				%>
			</th>
		</tr>
		<%
			ArrayList<Result> arraylist = new ArrayList<Result>();
			PreparedStatement ps = null;
			String readerID = (String) session.getAttribute("read_session");
			System.out.print(readerID);
			String sql = "SELECT DISTINCT BOOK.SORT, borrowrecord.bookid FROM BORROWRECORD, BOOK WHERE book.bookid = borrowrecord.bookid AND borrowrecord.readerID = '"
					+ readerID + "'";
			ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			String a = "";
			while (rs.next()) {
				if (a.equals(rs.getString("BookId"))) {
				Result r = new Result();
				r.setSort(rs.getString("sort"));
				r.setBookid(rs.getString("bookid"));
				arraylist.add(r);
					a = rs.getString("BookId");
				} else {
		%>
		<tr>
			<td>
			<%out.print(rs.getInt("sort")); %>
			</td>

			<td>
				<%
					out.print(rs.getString("BookID"));
				%>
			</td>
			<%out.print(arraylist.get(1).getSort()+" "+arraylist.get(1).getBookid()); %>
			<td>
			
			</td>
		</tr>
		<%
			}
			}
		%>
	</table>
</body>
</html>
