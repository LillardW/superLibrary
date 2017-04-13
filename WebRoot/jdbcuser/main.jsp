<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 
    <base href="<%=basePath%>">
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<LINK href="css/admin.css" type="text/css" rel="stylesheet">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
 <body>
  <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  <TR height=20>
    <TD background= jdbcuser/images/title_bg1.jpg>当前位置: </TD></TR>
  <TR>
    <TD bgColor=#b1ceef height=1></TD></TR>
  <TR height=20>
    <TD background=jdbcuser/images/shadow_bg.jpg></TD></TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="90%" align=center border=0>
  <TR height=100>
    <TD align=middle width=100><IMG height=100 src="jdbcuser/images/admin_p.gif" 
      width=90></TD>
    <TD width=60>&nbsp;</TD>
    <TD>
      <TABLE height=100 cellSpacing=0 cellPadding=0 width="100%" border=0>
        
        <TR>
          <TD> 当前时间：<%=(new java.util.Date()).toLocaleString()%></TD></TR>
        <TR>
          <TD style="FONT-WEIGHT: bold; FONT-SIZE: 16px">
          <%String read_session=(String)session.getAttribute("read_session");
	if (read_session==null){
	 out.print("<a href='jdbcuser/login.html' target='_top'>你还没有登录</a>");
	}else{
	out.print("<h1>欢迎管理员"+read_session +"进入图书管理后台！</h1>	");
	%></TD></TR>
	</TABLE>
  <TR>
    <TD colSpan=3 height=10></TD></TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
  <TR height=20>
    <TD></TD></TR>
  <TR height=22>
    <TD style="PADDING-LEFT: 20px; FONT-WEIGHT: bold; COLOR: #ffffff" 
    align=middle background=images/title_bg2.jpg>您的相关信息</TD></TR>
  <TR bgColor=#ecf4fc height=12>
    <TD></TD></TR>
  <TR height=20>
    <TD></TD></TR></TABLE>
<TABLE cellSpacing=0 cellPadding=2 width="95%" align=center border=0>
<%@include file="conn.jsp"%>
		<%
			String ReaderID = (String) session.getAttribute("read_session");
			PreparedStatement pstmt;
			String sql = "select * from reader where ReaderID=?";
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ReaderID);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					%>
  <TR>
    <TD align=right width=100>登陆帐号：</TD>
    <TD style="COLOR: #880000"><%=read_session %></TD></TR>
  <TR>
    <TD align=right>性别：</TD>
    <TD style="COLOR: #880000"><%=rs.getString("Sex") %></TD></TR>	
    <TR>
    <TD align=right>手机号：</TD>
    <TD style="COLOR: #880000"><%=rs.getString("Phone") %></TD></TR><%
				} 
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>
  <TR>
    <TD align=right>上线时间：</TD>
    <TD style="COLOR: #880000"><%=(new java.util.Date()).toLocaleString()%></TD></TR><%}%>
  </TABLE>
</html>
