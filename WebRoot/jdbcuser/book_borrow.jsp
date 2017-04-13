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
			
			String ReaderID = (String) session.getAttribute("read_session");
			String BookId = new String(request.getParameter("bookId")
					.getBytes("iso-8859-1"), "utf-8");	
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            String now=df.format(new Date());// new Date()为获取当前系统时间	
            
            //获取一个月后的时间
Calendar c=Calendar.getInstance();
c.setTime(new Date());
c.add(Calendar.MONTH,1); //将当前日期加一个月
String validityDate=df.format(c.getTime());  //返回String型的时间


			String sql = "select * from borrow where ReaderID=? and BookId=?";
			try {
			pstmt = con.prepareStatement(sql);
pstmt.setString(1,ReaderID);
pstmt.setString(2,BookId);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()){
				out.print("这本书你已经借过了，请重新挑选");
				}else{
				Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from book where BookId='"+BookId+"' and BON =0";
ResultSet rs1 = stmt.executeQuery(query);
String a ="0";
while(rs1.next()) {a=rs1.getString("BkID");}
                out.print("您所借的图书库存号为："+a+"<br>");
                String sql1 = "update book set BON=1 where BkID='"+a+"';";
//out.print(sql1);
pstmt = con.prepareStatement(sql1);
int i1 = pstmt.executeUpdate();
String sql2 = "update book set BookNUM=BookNUM-1 where BookID='"+BookId+"';";
//out.print(sql1);
pstmt = con.prepareStatement(sql2);
int i2 = pstmt.executeUpdate();
//pstmt.setString(1,a);
				String sqlinsert = "insert into borrow(BookId,BkID,ReaderID,BorrowDate,ReturnDate,Memo) values(?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sqlinsert);
pstmt.setString(1,BookId);
pstmt.setString(2,a);					
pstmt.setString(3,ReaderID);
pstmt.setString(4,now);
pstmt.setString(5,validityDate);
pstmt.setString(6,null);
int i = pstmt.executeUpdate();



				if (i > 0) {
				out.print("借书成功");					
				} else {
					out.print("借书不成功");
				}
			} }catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>



	</body>
</html>
