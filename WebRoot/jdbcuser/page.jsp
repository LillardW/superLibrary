<%@ page language="Java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Math.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
<title>分页显示数据库信息</title>
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
<style type="text/css">    
 body{    
      background-image: url(http://localhost:8080/aaa/jdbc/book_image/p11.png);    
      background-repeat: repeat-x;    
 }    
 </style>
<body bgcolor=white>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" background="images/tab_05.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="30"><img src="images/tab_03.gif" width="12" height="30" /></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="46%" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><div align="center"><img src="images/tb.gif" width="16" height="16" /></div></td>
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：读者管理-&gt;读者基本信息</td>
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
    <td colspan="4" bgcolor="#FFFFFF" class="STYLE1"><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">

</table>
<br><hr>
 <table border=1 width="100%" align=center>
		      <tr>		 
		       <th>读者号</th>		           
		      	<th>读者名</th>
		        <th>性别</th>
		        <th>电话</th>
		        <th>地址</th>
		        <th>权限</th>		       
		         <th>修改权限</th>	
		          <th>删除</th>	             
		        </tr>

<%

//驱动程序名
try
{

   String sDBDriver = "com.mysql.jdbc.Driver";
Class.forName(sDBDriver);
String sConnStr = "jdbc:mysql://localhost:3306/bookdb?useUnicode=true&amp;characterEncoding=UTF-8";    
String username="root";
String password="123456";
Connection con = DriverManager.getConnection(sConnStr,username,password);
Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from reader";  
ResultSet rs = stmt.executeQuery(query);
   //一页显示的记录数
int intPageSize; 
int intRowCount;      //记录的总数
int intPageCount;     //总页数
int intPage;         //待显示的页码
String strPage;
int i;
//设置一页显示的记录数
intPageSize=5;
//取得待显示的页码
strPage=request.getParameter("page");
//判断strPage是否等于null,如果是，显示第一页数据
if(strPage==null)
{
intPage=1;
}else{
//将字符串转换为整型
intPage=java.lang.Integer.parseInt(strPage);
}
if(intPage<1)
{
intPage=1;
}
//获取记录总数
rs.last();
intRowCount=rs.getRow();
//计算机总页数
intPageCount=(intRowCount+intPageSize-1)/intPageSize;
//调整待显示的页码
if(intPage>intPageCount) intPage=intPageCount;
if(intPageCount>0)
{
//将记录指针定位到待显示页的第一条记录上
rs.absolute((intPage-1)*intPageSize+1);
}
//下面用于显示数据
i=0;
String a="";
while(i<intPageSize && !rs.isAfterLast())
{%>
<tr>
		     
		      	<td><center><%out.print(rs.getString("ReaderID"));%></center></td>
		        <td><center><%out.print(rs.getString("ReaderName"));%></center></td>
		        <td><center><%out.print(rs.getString("Sex") );%></center></td>
		        <td><center><%out.print(rs.getString("Phone"));%></center></td>
		         <td><center><%out.print(rs.getString("Address"));%></center></td>
		          <td><center><%out.print(rs.getString("Limited"));%></center></td>
		      <td><center><a href="manager_userlimit.jsp?ReaderID=<%=rs.getString("ReaderID") %>">升级为管理员</a></center></td>	
		          <td><center><a href="manager_userdelete.jsp?ReaderID=<%=rs.getString("ReaderID") %>">删除</a></center></td>	  
		           </tr>
<%
rs.next();
i++;}
//关闭连接、释放资源
rs.close();
stmt.close();
con.close();
%>
<div align="center">
共<%=intRowCount%>个记录，分<%=intPageCount%>页显示，当前页是：第<%=intPage%>页
<%
for(int j=1;j<=intPageCount;j++)
{
out.print("&nbsp;&nbsp;<a href='page.jsp?page="+j+"'>"+j+"</a>");
}
%>
</div>
<%
}
catch(Exception e)
{
e.printStackTrace();
}
%>

</table>
</body>
</html>
