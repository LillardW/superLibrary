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
                <td width="95%" class="STYLE1"><span class="STYLE3">你当前的位置</span>：高级管理-&gt;借阅信息</td>
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
		<%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;	
			PreparedStatement pstmt1;		
		PreparedStatement pstmt2;
			String sql = "select * from borrow,book where borrow.BkID=book.BkID order by borrow.BookID";
			try {
			pstmt = con.prepareStatement(sql);
				ResultSet rs= pstmt.executeQuery();
			String oldBookID=null;
			String oldBookName=null;
			String oldAuthor=null;
			String oldPress=null;
			String oldimage=null;
			//String oldBonNUM=null;
			 int a =0;
			  int b =0;
			 {  String sqldelete = "delete  from tuijian1";
		      pstmt2 =con.prepareStatement(sqldelete);
		      int i2 = pstmt2.executeUpdate();}/*重置推荐表*/
		      while(rs.next()) {    
		      
		    String newBookName=rs.getString("book.BookName");
			String newAuthor=rs.getString("book.Author");
			String newPress=rs.getString("book.Press");
			String newimage=rs.getString("book.image");
		      String newBookID=rs.getString("borrow.BookID");
		      if (!newBookID.equals(oldBookID)){
		      if(b!=0){
		     
		     String sqlinsert = "insert into tuijian1 values(?,?,?,?,?,?)";
				pstmt1 = con.prepareStatement(sqlinsert);
pstmt1.setString(1,oldBookID);
pstmt1.setString(2,oldBookName);					
pstmt1.setString(3,oldAuthor);
pstmt1.setString(4,oldPress);
pstmt1.setString(5,oldimage);
pstmt1.setInt(6,a+1);

int i1 = pstmt1.executeUpdate();}/*写入推荐表*/
		     
		         		       a =0;
		         		       
			%>
		     
		        <table border=1 align=center width="100%">
		     <caption><br><br>书号<%=newBookID %>的书的当前出借情况<br></caption>
		      </table>
		       <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce">
      <tr>
        <td width="15%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">书名</span></div></td>
        <td width="15%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">借阅者ID</span></div></td>
        <td width="5%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">库存号</span></div></td>
        <td width="10%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">作者</span></div></td>
        <td width="15%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">出版社</span></div></td>
        <td width="10%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">出版日期</span></div></td>
        <td width="5%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">价格</span></div></td>
        <td width="10%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">借书时间</span></div></td>
        <td width="10%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">应还时间</span></div></td>
<td width="10%" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">第*本</span></div></td>

      </tr>
		      <tr>
		    	  <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.BookName") %></span></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("borrow.ReaderID") %></span></div></td>
       
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.BkId")%></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.Author") %></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.Press") %></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.PressDate") %></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("book.Price") %></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("borrow.BorrowDate") %></div></td>
        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("borrow.ReturnDate") %></div></td>
         <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=a+1 %></div></td>
        
      </tr>
       <%
		  
		   
		      oldBookID=newBookID;
		      oldBookName=newBookName;
		      oldAuthor=newAuthor;
		      oldPress=newPress;
		        oldimage=newimage;
		      }else{
		       a=a+1;
		        b=a;
		       %>
		      
		       <tr>
	           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getString("book.BookName"));%></td>
	           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=rs.getString("borrow.ReaderID") %></span></div></td>
       
	           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getString("book.BkId"));%></td>
		        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getString("book.Author"));%></td>
		        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getString("book.Press") );%></td>
		        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getDate("book.PressDate"));%></td>
		         <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getFloat("book.Price"));%></td>
		          <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getDate("borrow.BorrowDate"));%></td>
		           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%out.print(rs.getDate("borrow.ReturnDate"));%></td>
		           <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><%=a+1 %></div></td>
		        </tr>
		     <%  oldBookID=newBookID;
		     oldBookName=newBookName;
		      oldAuthor=newAuthor;
		      oldPress=newPress;
		        oldimage=newimage;
		     
		      }
		     //
		    
/*写入推荐表*/

		     b=b+1;
		     //out.print(b); 
		     }
		      if(rs.next()==false){
		     
		     String sqlinsert = "insert into tuijian1 values(?,?,?,?,?,?)";
				pstmt1 = con.prepareStatement(sqlinsert);
pstmt1.setString(1,oldBookID);
pstmt1.setString(2,oldBookName);					
pstmt1.setString(3,oldAuthor);
pstmt1.setString(4,oldPress);
pstmt1.setString(5,oldimage);
pstmt1.setInt(6,a+1);

int i1 = pstmt1.executeUpdate();}%>
		      </table>
		       
	      <%}catch(SQLException e){
		      out.print(e.getMessage());
		      }finally{
		      con.close();}%>

	</body>
</html>
