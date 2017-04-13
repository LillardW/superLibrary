<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：图书借阅-&gt;借书</td>
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
    
    <h2>搜索</h2>
     <form name="books.jsp" action="jdbcuser/books1.jsp">   
    请输入书名：&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" name="readerID" />  
  
       <input type="submit" value="确认" "/>
    </form>
     <form name="books2.jsp" action="jdbcuser/books2.jsp">   
    按分类代码搜索：&nbsp&nbsp<input type="text" name="readerID" />  
  
       <input type="submit" value="确认" "/>
    </form>
    <form name="books3.jsp" action="jdbcuser/books3.jsp">   
    按大写首字母搜索：<input type="text" name="readerID" />  
       <input type="submit" value="确认" "/>
    </form>
    
  <%@include file="conn.jsp"  %>
    <% 
Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from book order by BookId asc";
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
		        <th><%out.print("内容分类代码");%></th>
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
		           <td><%out.print(rs.getInt("SORT"));%></td>
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
		      con.close();}%>
		      
		    
  </body>
</html>
