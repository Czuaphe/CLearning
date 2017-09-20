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
  
  <body style="padding-top:50px;">
  	<jsp:include page="toolbar.jsp">
  			<jsp:param value="0" name="flag"/>
  	</jsp:include>
  	
    <!-- lunbo start -->
    <div id="myCarousel" class="carousel slide" >
        <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
        </ol>
        <!-- 轮播（Carousel）项目 -->
        <div class="carousel-inner">
            <div class="item active">
                <img src="./img/banner_img01.jpg" alt="First slide">
            </div>
            <div class="item">
                <img src="./img/banner_img02.jpg" alt="Second slide">
            </div>
            <div class="item">
                <img src="./img/banner_img03.jpg" alt="Third slide">
            </div>
            <div class="item">
                <img src="./img/banner_img04.jpg" alt="Fourth slide">
            </div>
        </div>
        <!-- 轮播（Carousel）导航 -->
        <a class="carousel-control left" href="#myCarousel"
           data-slide="prev">&lsaquo;</a>
        <a class="carousel-control right" href="#myCarousel"
           data-slide="next">&rsaquo;</a>
    </div>
    <!-- lunbo end -->
    
    <jsp:include page="footer.jsp">
  			<jsp:param value="0" name="flag"/>
  	</jsp:include>
    
  </body>
</html>
