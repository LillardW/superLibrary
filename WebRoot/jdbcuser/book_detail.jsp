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

<title>My JSP 'bookquery.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="jdbcuser/css/bootstrap.css">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<center>
		<table border="1" class="table table-hover">


			<%@include file="conn.jsp"%>
			<%
				String bookId = request.getParameter("bookId");
				if (bookId == null) {
					response.sendRedirect("books.jsp");
				}

				Statement stmt = con.createStatement();
				ResultSet rs = null;

				String sql = "select * from book,bookintrod where book.BookID = '"
						+ bookId + "' and bookintrod.bookId=book.BookID";
				try {
					rs = stmt.executeQuery(sql);
					if (rs.next()) {
						out.print("<tr align='center'><td COLSPAN='2'>"
								+ rs.getString("book.BookName") + "</td></tr>");
						out.print("<tr><td><image src='"
								+ rs.getString("book.image") + "'/></td>");
						out.print("<td>书号：" + rs.getString("book.BookID") + "<br/>");
						out.print("作者：" + rs.getString("book.Author") + "<br/>");
						out.print("出版社：" + rs.getString("book.Press") + "<br/>");
						out.print("出版日期：" + rs.getDate("book.PressDate") + "<br/>");
						out.print("价格：" + rs.getFloat("book.Price")
								+ rs.getString("book.BookNUM") + "<br/>");
						out.print("<input type='button' value='借阅' onclick=location.href='book_borrow.jsp?bookId="
								+ rs.getString("BookID") + "'></input></td></tr>");
						out.print("<tr><td COLSPAN='2'><br>"
								+ rs.getString("bookintrod.BookIntroduction")
								+ "<br><br></td></tr><br>");
						out.print("<tr><td COLSPAN='2'><br>"
								+ "推荐："
								+ "<input type='button' value='当前热门' onclick=location.href='jdbcuser/Hotcurrent.jsp'></input>&nbsp;<input type='button' value='历史热门' onclick=location.href='jdbcuser/Hothistory.jsp'></input><br><br></td></tr>");
						if (rs.getString("book.BookNUM").equals("0")) {
							String BookID = rs.getString("book.BookID");
							String sql1 = "select * from borrow where  borrow.BookID = '"
									+ bookId + "' order by ReturnDate desc";
							rs = stmt.executeQuery(sql1);
							if (rs.next()) {
								out.print("<tr><td COLSPAN='2'><br><font color=blue>零库存图书最早开放借阅时间(仅供参考)：</font><font color=red>"+rs.getString("borrow.ReturnDate")+"</font><br/><br></td></tr>");

							}
						}
					}
				} catch (SQLException e) {
					out.print(e.getMessage());
				} finally {
					con.close();
				}
			%>
		</table>
	</center>
</body>
</html>
