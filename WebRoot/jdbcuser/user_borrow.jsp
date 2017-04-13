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
	<link rel="stylesheet" type="text/css" href="jdbcuser/css/bootstrap.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {font-size: 12px}
.STYLE3 {font-size: 12px; font-weight: bold; }
.STYLE4 {
	color: #03515d;
	font-size: 12px;
}
-->
</style>

<script>
var  highlightcolor='#c1ebff';
//此处clickcolor只能用win系统颜色代码才能成功,如果用#xxxxxx的代码就不行,还没搞清楚为什么:(
var  clickcolor='#51b2f6';
function  changeto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=highlightcolor&&source.id!="nc"&&cs[1].style.backgroundColor!=clickcolor)
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=highlightcolor;
}
}

function  changeback(){
if  (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="nc")
return
if  (event.toElement!=source&&cs[1].style.backgroundColor!=clickcolor)
//source.style.backgroundColor=originalcolor
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}

function  clickto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[1].style.backgroundColor!=clickcolor&&source.id!="nc")
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=clickcolor;
}
else
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}
</script>
	</head>

	<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" background="jdbcuser/images/tab_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="30"><img src="jdbcuser/images/tab_03.gif" width="12" height="30" /></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="46%" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><div align="center"><img src="jdbcuser/images/tb.gif" width="16" height="16" /></div></td>
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：借阅信息-&gt;查看借阅信息</td>
              </tr>
            </table></td>
            <td width="54%">&nbsp;</td>
          </tr>
        </table></td>
        <td width="16">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
    </table>
		<%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;			
			String ReaderID = (String) session.getAttribute("read_session");
			String sql = "select * from borrow,book where borrow.BkID=book.BkID and borrow.ReaderID=? ";
			try {
			pstmt = con.prepareStatement(sql);
pstmt.setString(1,ReaderID);
				ResultSet rs= pstmt.executeQuery();
				
			%>
		      <table class="table table-hover">
		      <caption><br><strong><center>你所借的图书列表</center></strong></caption>
		      <tr>		 
		       <th bgcolor="f5f5f5"><%out.print("封面");%></th>
		        <th bgcolor="f5f5f5"><%out.print("书名");%></th>
		        <th bgcolor="f5f5f5"><%out.print("作者");%></th>
		        <th bgcolor="f5f5f5"><%out.print("出版社");%></th>
		        <th bgcolor="f5f5f5"><%out.print("出版日期");%></th>
		        <th bgcolor="f5f5f5"><%out.print("价格");%></th>		
		               <th bgcolor="f5f5f5"><%out.print("借书时间");%></th>		
		                 <th bgcolor="f5f5f5"><%out.print("还书时间");%></th>	
		                  <th bgcolor="f5f5f5"><%out.print("续借");%></th>		
		        </tr>
		      <%
		      while(rs.next()) {    %>
		      <tr>
		       <td><a href="jdbcuser\book_detail.jsp?bookId=<%=rs.getString("BookID") %>"><img src="<%= rs.getString("image")%>"/></a></td>
		    
		      	<td><%out.print(rs.getString("book.BookName"));%></td>
		        <td><%out.print(rs.getString("book.Author"));%></td>
		        <td><%out.print(rs.getString("book.Press") );%></td>
		        <td><%out.print(rs.getDate("book.PressDate"));%></td>
		         <td><%out.print(rs.getFloat("book.Price"));%></td>
		          <td><%out.print(rs.getDate("borrow.BorrowDate"));%></td>
		           <td><%out.print(rs.getDate("borrow.ReturnDate"));%></td>
		            <td><input type="button" value="续借"
									onclick="location.href='jdbcuser/manager_bookxujie.jsp?bookId=<%=rs.getString("BookID")%>&ReaderID=<%=ReaderID%> '"></input></td>
		        </tr>
		  
		      <%}%>
		      </table>
	      <%}catch(SQLException e){
		      out.print(e.getMessage());
		      }finally{
		      con.close();}%>

	</body>
</html>
