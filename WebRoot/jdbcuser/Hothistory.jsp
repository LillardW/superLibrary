<%@ page language="java"
	import="java.util.*,java.sql.*,java.text.SimpleDateFormat"
	pageEncoding="utf-8"%>
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
<link rel="stylesheet" href="jdbcuser/css/bootstrap.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

.STYLE1 {
	font-size: 12px
}

.STYLE3 {
	font-size: 12px;
	font-weight: bold;
}

.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
-->
</style>



</head>

<body>


	<%@include file="conn.jsp"%>
	<%
		Statement stmt = con.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		String query = "select * from tuijian2 order by BonNUM desc limit 2";
		try {
			ResultSet rs = stmt.executeQuery(query);
	%>
	<table class="table table-hover" align=center>
		<caption>
			<h2>
				<center>历史热门</center>
			</h2>
		</caption>
		<tr>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("封面");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("书号");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("书名");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("作者");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("出版社");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("已借出数量");
					%>
				</div></th>
			<th bgcolor="f5f5f5"><div align="center">
					<%
						out.print("是否借阅");
					%>
				</div></th>
		</tr>
		<%
			String a = "";
				while (rs.next()) {
					if (a.equals(rs.getString("BookId"))) {
						a = rs.getString("BookId");
					} else {
		%>
		<tr>
			<td><div align="center">
					<a
						href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID")%>"><img
						src="<%=rs.getString("image")%>" /></a>
				</div></td>

			<td><div align="center">
					<a
						href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID")%>"><%=rs.getString("BookID")%></a>
				</div></td>

			<td><div align="center">
					<%
						out.print(rs.getString("BookName"));
					%>
				</div></td>
			<td><div align="center">
					<%
						out.print(rs.getString("Author"));
					%>
				</div></td>
			<td><div align="center">
					<%
						out.print(rs.getString("Press"));
					%>
				</div></td>
			<td><div align="center">
					<%
						out.print(rs.getInt("BonNUM"));
					%>
				</div></td>
			<%
				if (rs.getInt("BonNUM") != 0) {
			%><td><center>
					<input type="button" value="借阅"
						onclick="location.href='jdbcuser/book_borrow.jsp?bookId=<%=rs.getString("BookID")%>'"></input>
				</center></td>
		</tr>
		<%
			} else {
		%><td><div align="center">零库存</div></td>
		<%
			}
		%>
		<%
			a = rs.getString("BookId");
					}
				}
		%>
	</table>


	<%
		} catch (SQLException e) {
			out.print(e.getMessage());
		} finally {
			con.close();
		}
	%>


</body>
</html>
