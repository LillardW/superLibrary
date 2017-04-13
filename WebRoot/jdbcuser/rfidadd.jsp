<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'rfidadd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
function check(){

var  ReaderID=document.login.a1.value;
   var  Password=document.login.b1.value;
  
	if(a1.length=="")
	{
		alert("不能有空");
		document.login.a1.focus();
		return false;
	}
	if(b1.length=="")
    {
    	alert("不能有空！");
    	document.login.b1.focus();
		return false;
    }
   return true;
}

</script>
  <body>
    <%int i=200;
    byte c =(byte)i;
    out.print(c);
     %>
     <form name="login" action="jdbcuser/reader51.jsp" onsubmit="return check();">   
   地址信息1: <input type="text" name="a1" value="0" /> <br/>  
 地址信息2: <input type="text" name="b1" value="0"/><br/>
 库存：<input type="text" name="c1" value="0"/><br/>
 图书分类：<input type="text" name="d1" value="0"/><br/>
 首字母分类1：<input type="text" name="e1" value="0"/><br/>
首字母分类2： <input type="text" name="f1" value="0"/><br/>
 图书编码1<input type="text" name="g1" value="0"/><br/>
 图书编码2<input type="text" name="h1" value="0"/><br/>
 图书编码3<input type="text" name="i1" value="0"/><br/>
 <input type="hidden" name="j1" value="0"/><br/>
  <input type="hidden" name="k1" value="0"/><br/>
   <input type="hidden" name="l1" value="0"/><br/>
       <input type="submit" value="登录" "/>
    </form><br>
  </body>
</html>
