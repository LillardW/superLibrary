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
	<link rel="stylesheet" href="jdbcuser/css/bootstrap.css">
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
.STYLE1 table tr td p strong {
	color: #000;
	font-size: 24px;
	font-weight: bold;
}
.STYLE1 table tr td p {
	font-size: 18px;
}
.STYLE1 table tr td p strong {
	font-size: 24px;
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
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置：高级管理-&gt;图书申请信息</td>
              </tr>
            </table></td>
            <td width="54%">&nbsp;</td>
          </tr>
        </table></td>
        <td width="16">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#FFFFFF" class="STYLE1"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

</table>
		<%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;			
		
			String sql = "select * from note";
			try {
			pstmt = con.prepareStatement(sql);
				ResultSet rs= pstmt.executeQuery();
			if(rs.next()==false) {
			out.print("<br><font size='5'>暂无信息</font>");
			} else {
			%><table border="1" align="center" width="100%" bgcolor="#a8c7ce">
		      <center><font size="5" font-family="微软雅黑">会员所申请的图书列表</font></center>
		      </table>
		      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table table-hover">
		      <tr>
        <td width="20%" height="20" bgcolor="#f5f5f5"><div align="center">用户号</div></td>
        <td width="20%" height="20" bgcolor="#f5f5f5"><div align="center">书名</div></td>
        <td width="20%" height="20" bgcolor="#f5f5f5"><div align="center">申请时间</div></td>
        <td width="40%" height="20" bgcolor="#f5f5f5"><div align="center">具体内容</div></td>
      </tr>
      <%
			}
		      while(rs.next()) {    
			%>
		     
		        
    
      
	<tr>
		<td width="10%" height="20"><div align="center"><%=rs.getString("ReaderID") %></div></td>
        <td width="20%" height="20"><div align="center"><%=rs.getString("BookName")%></div></td>
        <td width="20%" height="20"><div align="center"><%=rs.getString("NoteDate") %></div></td>
        <td width="50%" height="20"><div align="center"><%=rs.getString("Note") %></div></td> 
      </tr>
      
       <% 
		      } 
%>
		</table>      
		       
	      <%}catch(SQLException e){
		      out.print(e.getMessage());
		      }finally{
		      con.close();}%>

	</body>
</html>
