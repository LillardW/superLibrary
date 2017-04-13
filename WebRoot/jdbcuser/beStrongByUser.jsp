<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'beStrong.jsp' starting page</title>
    
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
    String ReaderID = (String)session.getAttribute("read_session");
    String money = request.getParameter("money");
    System.out.print(ReaderID+"123"+money);
    
    PreparedStatement pstmt;
			
			//String ReaderID = (String) session.getAttribute("read_session");
			
			

			String sql = "select * from reader where ReaderID=?";
			try {
				pstmt = con.prepareStatement(sql);

				//ResultSet rs = pstmt.executeQuery();
				
				String sqlup = "update reader set Money=MONEY+? where readerid=?";
				pstmt = con.prepareStatement(sqlup);
pstmt.setString(1,money);
pstmt.setString(2,ReaderID);
int i = pstmt.executeUpdate();
				if (i > 0) {
				out.print("充值成功");					
				} 
				
			
			String sql1 = "update reader set LEVEL=1 where MONEY>0 AND MONEY<=360";
			pstmt = con.prepareStatement(sql1);
			int i1 = pstmt.executeUpdate();
		
			String sql2 = "update reader set LEVEL=2 where MONEY>=720";
			pstmt = con.prepareStatement(sql2);
			int i2 = pstmt.executeUpdate();
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
    
     %>
  </body>
</html>
