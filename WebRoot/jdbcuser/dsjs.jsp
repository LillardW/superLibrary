<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>ע��ɹ�</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<title></title>
      
	   
	
  </head>
  <style type="text/css">    
 body{    
      background-image: url(jdbc/book_image/05.jpg);    
      background-repeat: repeat-x;    
 }    
 </style>      
  <body onload="DaoShu()">
   <body>  
                                  
                 <h1 align="center"></h1> 
                         <h3  id="p1">ע��ɹ���
                  <span><font color="red">5</font></span>����Զ���ת<a href='jdbcuser/login.html'>��¼����</a></h3>        
                   <script>           
                     var $ = function(id){                 
                     return document.getElementById(id);  };          
                        var $t = function(tag, cot){                
                         cot = cot || document;                
                          return cot.getElementsByTagName(tag);   };        
                               var o = $t('font', $('p1'))[0];     
                               
                                 var timer = setInterval(function(){          
                                        if(+o.innerHTML  > 1){              
                                               o.innerHTML -= 1;           
                                                     }else{                  
                                                        clearInterval(timer);   
                            location.href = 'jdbcuser/login.html';           
                             }             }, 1000)         </script>     
  </body>
</html>
