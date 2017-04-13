<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
  <%@include file="conn.jsp"  %>
  <% 
Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select  *  from book order by BookId asc";
 try{
 ResultSet rs = stmt.executeQuery(query);
 %>
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
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：图书管理-&gt;图书信息</td>
              </tr>
            </table></td>
            <td width="54%">&nbsp;</td>
          </tr>
        </table></td>
        <td width="16">&nbsp;</td>
      </tr>
    </table></td>
    <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="8" background="jdbcuser/images/tab_12.gif">&nbsp;</td>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
          <tr>
            <td height="20" bgcolor="#FFFFFF"><div align="center">
              <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
              <tr>
                <td height="20" bgcolor="#FFFFFF"><div align="center">
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
                  <tr>
                    <td bgcolor="#FFFFFF"><div align="center">
                      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="b5d6e6" onmouseover="changeto()"  onmouseout="changeback()">
                        <tr>
                          <td width="15%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">封面</span></div></td>
                          <td width="8%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">书号</span></div></td>
                          <td width="12%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">书名</span></div></td>
                          <td width="10%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">作者</span></div></td>
                          <td width="10%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">出版社</span></div></td>
                          <td width="12%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">出版日期</span></div></td>
                          <td width="8%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">价格</span></div></td>
                         <td width="5%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">库存</span></div></td>
                          <td width="8%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF"><div align="center"><span class="STYLE1">库存+借出总量</span></div></td>
                          <td width="5%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">更新</div></td>
                          <td width="5%" height="22" background="jdbcuser/images/bg.gif" bgcolor="#FFFFFF" class="STYLE1"><div align="center">删除</div></td>
                        </tr>
    
  </tr>	      
		      <tr> <% String a="";
		      while(rs.next()) {   if( a.equals(rs.getString("BookId"))){a=rs.getString("BookId");} else{%>
		      <tr>
		       <td height="20" bgcolor="#FFFFFF" class="STYLE19"><a href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID") %>"><img src="<%= rs.getString("image")%>"/></a></td>
		    
		           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><a href="jdbcuser/book_detail.jsp?bookId=<%=rs.getString("BookID") %>"><%=rs.getString("BookID") %></a></td>
		  <% Statement stmt1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query1 ="select * from book where BookID='"+rs.getString("BookID")+"' order by BkID desc";
		ResultSet rs1 = stmt1.executeQuery(query1);
		int x =0;
		while(rs1.next()) {x=x+1;}%>
		 <td height="20" bgcolor="#FFFFFF"><div align="center" class="STYLE19">
                            <div align="center" ><%=rs.getString("BookName") %></div>
                          </div></td>
                          <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("Author") %></div></td>
                          <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("Press") %></div></td>
                          <td height="20" bgcolor="#FFFFFF"><div align="center"><%=rs.getString("PressDate") %></div></td>
                          <td height="20" bgcolor="#FFFFFF"><div align="center"><span class="STYLE19"><%=rs.getString("Price") %></span></div></td>
                          <td height="20" bgcolor="#FFFFFF"><div align="center"><span class="STYLE19"><%=rs.getString("BookNUM") %></span></div></td>
                           <td height="20" bgcolor="#FFFFFF"><div align="center"><span class="STYLE19"><%=x %></span></div></td>
                          <td height="20" bgcolor="#FFFFFF"><span class="STYLE1"><center><a href="jdbcuser/manager_bookupdate.jsp?bookId=<%=rs.getString("BookID") %>">更新</a></center></span></td>	
                          <td height="20" bgcolor="#FFFFFF"><span class="STYLE1"><center><a href="jdbcuser/manager_bookdelete.jsp?bookId=<%=rs.getString("BookID") %>">删除</a></center></span></td>	  
		           </tr>
		  
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
