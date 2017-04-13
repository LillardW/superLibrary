<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：用户信息管理-&gt;用户信息更新</td>
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
				请输入修改信息：
		<form name="reg" action="jdbcuser/user_regupdateok.jsp">
			读者号:
			<%=ReaderID%><br />
			读者名:
			<input type="text" name="ReaderName" value="<%=rs.getString("ReaderName") %>"/>
			<br />	
			<%if (rs.getString("Sex").equals("男")){ %>		
			性别:
			<input type="radio" name="Sex" value="男" checked="checked" />
			男
			<input type="radio" name="Sex" value="女" />
			女
			<br />
			<%}else if(rs.getString("Sex").equals("女")){ %>	
			性别:
			<input type="radio" name="Sex" value="男" />
			男
			<input type="radio" name="Sex" value="女" checked="checked" />
			女
			<br />
			<%} %>
			电话:
			<input type="text" name="Phone" value="<%=rs.getString("Phone") %>"/>
			<br />
			地址:
			<input type="text" name="Address" value="<%=rs.getString("Address") %>"/>
			<br />
			<input type="submit" value="更新" name="goto2" />
		</form>	
				
					<%
				} 
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				con.close();
			}
		%>

		

	</body>
</html>
