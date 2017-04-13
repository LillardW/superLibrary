<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'reader233.jsp' starting page</title>
    
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
   <%@include file="conn.jsp"  %>
   <%int i=1; 
   
Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from book where BkId= '"+i+"'";
 try{
 ResultSet rs = stmt.executeQuery(query);
 %>
		      <table border=1 align=center>
		      <caption><h2>图书列表</h2></caption>
		      <tr>		 
		       <th><%out.print("封面");%></th>		           
		      	<th><%out.print("书号");%></th>
		        <th><%out.print("书名");%></th>
		        <th><%out.print("作者");%></th>
		        <th><%out.print("出版社");%></th>
		        <th><%out.print("出版日期");%></th>
		        <th><%out.print("价格");%></th>		
		         <th><%out.print("库存");%></th>		
		        <th><%out.print("内容分类");%></th>
		         <th><%out.print("是否借阅");%></th>	          
		        </tr>
		      <% String a="";
		      while(rs.next()) { if( a.equals(rs.getString("BookId"))){a=rs.getString("BookId");}   else{%>
		      <tr>
		       <td><a href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID") %>"><img src="<%= rs.getString("image")%>"/></a></td>
		    
		           <td><a href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID") %>"><%=rs.getString("BookID") %></a></td>
		  
		      	<td><%out.print(rs.getString("BookName"));%></td>
		        <td><%out.print(rs.getString("Author"));%></td>
		        <td><%out.print(rs.getString("Press") );%></td>
		        <td><%out.print(rs.getDate("PressDate"));%></td>
		         <td><%out.print(rs.getFloat("Price"));%></td>
		          <td><%out.print(rs.getInt("BookNUM"));%></td>
		           <td><%if(rs.getInt("SORT")==1)out.print("计算机类<br> 分类代码："+rs.getInt("SORT"));%></td>
		            <%if(rs.getInt("BookNUM")!=0) {%><td><center><input type="button" value="借阅" onclick="location.href='jdbcuser/book_borrow.jsp?bookId=<%=rs.getString("BookID")%>'"></input></center></td>
		       </tr>
		   <%}else{%><td>零库存</td><%}%>
		      <%a=rs.getString("BookId");}}%>
		      </table>
		      
		      
		      
		      
		      
		        <!--  
		         -->
		      <%}catch(SQLException e){
		      out.print(e.getMessage());
		      }finally{
		      con.close();}
   %><br>
  </body>
</html>
