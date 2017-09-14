<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test_result.jsp' starting page</title>
    
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

  </head>
  
  <body style="padding-top:70px;">
    <jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>
	
	
	<div class="col-md-6 col-md-offset-3" style="text-align:center;margin-bottom:30px;">
  		<h1>你本次测试的成绩是：</h1><h1 style="color:red;"><%=session.getAttribute("score") %>分</h1>
  	</div>
	<div class="col-md-offset-3 col-md-6">
    	<!-- <form action="" method="post">
    		<button type="submit" class="col-md-offset-3 col-md-2 btn btn-primary">开始测试</a>
    	</form> -->
    	<a href="test_before.jsp" class="col-md-offset-3 col-md-2 btn btn-primary">再测一次</a>
    	<a href="student.jsp" class="col-md-offset-2 col-md-2 btn btn-primary">查看历次成绩</a>
    </div>
  </body>
</html>
