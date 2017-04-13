<%@ page language="java" import="java.util.Date,java.text.SimpleDateFormat" pageEncoding="utf-8"%>

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
			
			String ReaderID = new String(request.getParameter("ReaderID")
					.getBytes("iso-8859-1"), "utf-8");	
			String BookId = new String(request.getParameter("bookId")
					.getBytes("iso-8859-1"), "utf-8");	
					Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from borrow where BookId='"+BookId+"' and ReaderID ='"+ReaderID+"'";
//out.print(query);
ResultSet rs1 = stmt.executeQuery(query);
String a ="0";
while(rs1.next()) {a=rs1.getString("BkID");}
 //out.print(a);
                String sql1 = "update book set BON=0 where BkID='"+a+"';";
//out.print(sql1);
pstmt = con.prepareStatement(sql1);
int i1 = pstmt.executeUpdate();
String sql2 = "update book set BookNUM=BookNUM+1 where BookID='"+BookId+"';";
//out.print(sql1);
pstmt = con.prepareStatement(sql2);
int i2 = pstmt.executeUpdate();
				String sql = "delete from borrow where ReaderID=? and BookId=?";
			try {
			
				pstmt = con.prepareStatement(sql);
pstmt.setString(2,BookId);				
pstmt.setString(1,ReaderID);

int i = pstmt.executeUpdate();
				if (i > 0) {
				out.print("还书成功");					
				} else {
					out.print("还书不成功");
				}
			 }catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
