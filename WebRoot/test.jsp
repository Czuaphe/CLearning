<%@ page language="java"
	import="java.util.*,factory.DaoFactory, bean.Problem"
	pageEncoding="UTF-8"
%>
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

<title>测试网页</title>




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
<!-- 自定义CSS文件 -->
<link rel="stylesheet" href="./css/test.css">
</head>

<body style="padding-top:70px;">
	<!-- 测试网页 -->

	<jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>

	<%	// 
		List<Problem> list_all = DaoFactory.getProblemService()
		.selectAllProblem();
		List<Problem> list = new ArrayList<Problem>();
		Random random = new Random();
		// 将随机题目放入列表中
		for(int i = 0; i < 10; i ++) {
			int num = random.nextInt(list_all.size());
			// 判断是否重复
			boolean flag = true;
			for(int j = 0; j < list.size(); j ++) {
				if(list.get(j).getPid() == list_all.get(num).getPid()) {
					flag = false;
					break;
				}
			}
			if(flag) {
				list.add(list_all.get(num));
			} else {
				i --;
			}
		}
		// 将题目的PID放入Session中
		List<Integer> list_pid = new ArrayList<Integer>();
		for(int i = 0; i < list.size(); i ++) {
			list_pid.add(list.get(i).getPid());
		}
		session.setAttribute("list_pid", list_pid);
	%>
	<!-- 测试主体 -->
	<div class="col-md-6 col-md-offset-3" style="margin-top: 40px">
		<div class="panel panel-info">
			<!-- info panel contents -->
			<div class="panel-heading text-center panel-heading-font">随机测试</div>
			<!--  
            <div class="panel-body panel-body-font">
                <p style="float:left">测试时间</p>
                <p style="float: right">倒计时</p>
            </div>
			-->

			<form class="form-inline" role="form" method="post"
				action="TestServlet">
				<!-- List group -->
				<%
					for (int i = 0; i < 10; i++) {
				%>
				<ul class="list-group mylist">
					<!-- 题目1 -->
					<li class="list-group-item list-group-item-height">
						<ul class="list-group" style="height:auto">
							<!--题目-->
							<li class="list-group-item list-group-item-li">
								<h4>
									<p>
										<%="" + (i + 1) + "、"%>
										<span style="color:blue;"><%="（" + list.get(i).getScore() + "分）"%></span>
										<%=list.get(i).getTitle()%>
									</p>
								</h4>
							</li>
							<!--选项-->

							<li class="list-group-item list-group-item-li">
								<div class="radio">
									<label><input type="radio" id="<%="question_" + i%>"
										name="<%="question_" + i%>" value="1">&nbsp;&nbsp;<%=list.get(i).getOption1()%>
									</label>

								</div>
							</li>
							<li class="list-group-item list-group-item-li">
								<div class="radio">
									<label><input type="radio" id="<%="question_" + i%>"
										name="<%="question_" + i%>" value="2">&nbsp;&nbsp;<%=list.get(i).getOption2()%>
									</label>
								</div>
							</li>
							<li class="list-group-item list-group-item-li">
								<div class="radio">
									<label><input type="radio" id="<%="question_" + i%>"
										name="<%="question_" + i%>" value="3">&nbsp;&nbsp;<%=list.get(i).getOption3()%>
									</label>
								</div>
							</li>
							<li class="list-group-item list-group-item-li">
								<div class="radio">
									<label> <input type="radio" id="<%="question_" + i%>"
										name="<%="question_" + i%>" value="4">&nbsp;&nbsp;<%=list.get(i).getOption4()%>
									</label>
								</div>
							</li>
						</ul>
					</li>
				</ul>
				<%
					}
				%>
			
		</div>
		<!--  提交按钮  -->
		<div class="col-md-offset-5 col-md-2 btn-group" role="group"
			aria-label="...">
			<button type="submit" class="btn btn-primary" onclick="submit();"
				style="width: 100%; margin-bottom:30px;">提交</button>
		</div>

		</form>

	</div>

	<!-- 测试悬浮框 -->
	<div class="mytab" style="background-color:white;">
		<span id="time_last"
			style="display:block;width=:300px; height:100px;font-size:20px;">
		</span>
	</div>

	<script>
		var myVar = setInterval(function() {
			myTimer()
		}, 1000);
		function myTimer() {
			var d = new Date();
			var year = d.getFullYear();
			var month = d.getMonth();
			var day = d.getDate();
			var hour = d.getHours();
			var minute = d.getMinutes();
			var second = d.getSeconds();
			document.getElementById("time_now").innerHTML = year + "年"
					+ (month + 1) + "月" + day + "日" + hour + "时" + minute + "分"
					+ second + "秒";
		}
	</script>

	<script>
		var d = new Date(20 * 60 * 1000);
		var time_last = setInterval(function() {
			var minute = d.getMinutes();
			var second = d.getSeconds();
			if (second != 0) {
				d.setSeconds(second - 1, 0);
			} else {
				if (minute != 0) {
					d.setMinutes(minute - 1, 59, 0);
				} else {
					window.alert("time is out.");
				}
			}
			document.getElementById("time_last").innerHTML = "剩余时间为：" + minute
					+ ":" + second;
		}, 1000);
		function Submit() {
			
		}
	</script>

</body>
</html>
