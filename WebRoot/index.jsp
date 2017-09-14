<%@ page language="java" import="java.util.*, db.SQLConnection" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- Bootstrap 所需的最少css和js文件 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
    <script src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/toolbar.css">
	<!--  -->
	
	
	
  </head>
  
  <body style="padding-top:70px;">
  	<jsp:include page="toolbar.jsp">
  			<jsp:param value="0" name="flag"/>
  	</jsp:include>
  	
    This is my JSP page. <br>
    <%=SQLConnection.isConnection() %>
    <input type="button" value="按钮" onClick="hello();"/>
    
  </body>
</html>
