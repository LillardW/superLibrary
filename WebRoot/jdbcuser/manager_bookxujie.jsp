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
try {
String query ="select * from borrow where BookId='"+BookId+"' and ReaderID ='"+ReaderID+"'";
//out.print(query);
ResultSet rs1 = stmt.executeQuery(query);
String a ="0";
String b ="0";
String c ="0";
while(rs1.next()) {a=rs1.getString("BkID");
b=rs1.getString("Memo");}


String query2 ="select * from borrow where BookId='"+BookId+"' and ReaderID ='"+ReaderID+"' and DATE_ADD(BorrowDate,INTERVAL 1 MONTH)>now()";
//out.print(query);
ResultSet rs2 = stmt.executeQuery(query);
while(rs2.next()){c="1";}
if(c.equals("1")){out.print("还未超过一个月，不能续借");}
else{

if(b.equals("1")){out.print("已经续借，无法再次续借");}
 //out.print(a);
 else{
                String sql1 = "update borrow set Memo=1,ReturnDate =DATE_ADD(ReturnDate,INTERVAL 1 MONTH) where BkID='"+a+"';";
//out.print(sql1);

//pstmt.setString(1,rs1.getString("BorrowDate"));
pstmt = con.prepareStatement(sql1);
int i1 = pstmt.executeUpdate();
out.print("续借成功，借阅时间延长一个月");
			
			} }}catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
