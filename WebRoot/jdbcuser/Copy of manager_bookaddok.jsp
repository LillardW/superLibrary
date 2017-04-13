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

	</head>

	<body>

		<%@include file="conn.jsp"%>
		<%	PreparedStatement pstmt;			
			String BookID = new String(request.getParameter("BookID").getBytes("iso-8859-1"), "utf-8");			
			String BookName = request.getParameter("BookName");
					
			
				
					int BookNUM = Integer.parseInt(BookName);
					//out.print(BookNUM);
					//int SORT1 = Integer.parseInt(SORT);
					//SSSint ATZ1 = Integer.parseInt(ATZ);
					//out.print(image);
			
		
		Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String query ="select * from book where BookID='"+BookID+"' order by BkID desc";
		ResultSet rs = stmt.executeQuery(query);
		
	if(rs.next()){out.print(rs.getString("Author"));out.println(rs.getString("BookName")+"<br>");out.print("原库存："+rs.getString("BookNUM"));}else{out.print("书本不存在");}
//while(rs.next()) {}
int k=BookNUM+rs.getInt("BookNUM");
out.println("   现库存："+k+"<br>");
			for(int j=1;j<=BookNUM;j++){
			String sql = "insert into book( BookID,BookName, Author, Press, PressDate, Price, image,loc,BookNUM,SORT,ATZ,BON) values(?,?,?,?,?,?,?,?,?,?,?,0)";
			
			
			try {
			
			
			
				pstmt = con.prepareStatement(sql);
pstmt.setString(1,BookID);
pstmt.setString(2,rs.getString("BookName"));
pstmt.setString(3,rs.getString("Author"));
pstmt.setString(4,rs.getString("Press"));
pstmt.setDate(5,rs.getDate("PressDate"));
pstmt.setFloat(6,rs.getFloat("Price"));
pstmt.setString(7,rs.getString("image"));
pstmt.setInt(8,rs.getInt("loc"));
pstmt.setInt(9,k);
pstmt.setInt(10,rs.getInt("SORT"));
pstmt.setInt(11,rs.getInt("ATZ"));

				int i = pstmt.executeUpdate();
				if (i > 0 &&j==BookNUM) {
				out.print("添加成功");					
				} else {if (i > 0 &&j==BookNUM)
					out.print("添加失败");
				}
				
				
				
			} catch (SQLException e) {
				out.print(e.getMessage());
			} finally {
				
			}
			}
			 String sql1 = "update book set BookNUM='"+k+"' where BookID='"+BookID+"';";
//out.print(sql1);
pstmt = con.prepareStatement(sql1);
int i1 = pstmt.executeUpdate();
			con.close();
		%>



	</body>
</html>
