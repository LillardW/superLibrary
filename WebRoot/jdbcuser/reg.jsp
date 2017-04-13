<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'regr.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style type="text/css">    
 body{    
      background-image: url(jdbc/book_image/05.jpg);    
      background-repeat: repeat-x;    
 }    
 </style> 
  <body>
  <%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;
			//使用以下方式解决表单乱码
			String ReaderID = new String(request.getParameter("readerID").getBytes("iso-8859-1"), "utf-8");
					//out.print(ReaderID);
			String ReaderName = new String(request.getParameter("readerName")
					.getBytes("iso-8859-1"), "utf-8");
					//out.print(ReaderName);
					String Password = new String(request.getParameter("password")
					.getBytes("iso-8859-1"), "utf-8");
					String Sex = new String(request.getParameter("sex").getBytes(
					"iso-8859-1"), "utf-8");
			String Phone = new String(request.getParameter("phone").getBytes(
					"iso-8859-1"), "utf-8");
			String Address = new String(request.getParameter("address").getBytes(
					"iso-8859-1"), "utf-8");
					//out.print(Address);
					if(ReaderName.equals("")||ReaderName==null)ReaderName=null;
		if(Phone.equals("")||Phone==null)Phone=null;
		if(Address.equals("")||Address==null)Address=null;
	

			String sql = "insert into reader(ReaderID,ReaderName,Password,Sex,Phone,Address,Limited) values(?,?,?,?,?,?,?)";
			try {
				pstmt = con.prepareStatement(sql);
pstmt.setString(1,ReaderID);
pstmt.setString(2,ReaderName);
pstmt.setString(3,Password);
pstmt.setString(4,Sex);
pstmt.setString(5,Phone);
pstmt.setString(6,Address);
pstmt.setString(7,"0");

				int i = pstmt.executeUpdate();
				if (i > 0) {
				%><jsp:forward page="dsjs.jsp"/><%
				//out.print("注册成功，<a href='jdbcuser/login.html'>进入登录页面</a>");
					//response.sendRedirect("login.html");
				} else {
					out.print("注册失败，<a href='jdbcuser/reg.html'>返回重新注册</a>");
				}
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		
			%>


			
  </body>
</html>
