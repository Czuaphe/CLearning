<%@ page language="java"
	import="java.util.*, factory.DaoFactory, bean.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'root.jsp' starting page</title>

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

<body>
	<jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>

	<div class="btn-group col-md-6 col-md-offset-3"
		style="padding-top:70px;">
		<ul class="nav nav-tabs">
			<li class="active" data-toggle="tab"><a href="#content1"
				data-toggle="tab"> 分班管理 </a></li>
			<li class="" data-toggle="tab"><a href="#content2"
				data-toggle="tab"> 知识点管理 </a></li>
			<li class="" data-toggle="tab"><a href="#content3"
				data-toggle="tab"> 用户管理 </a></li>
			<li class="" data-toggle="tab"><a href="#content4"
				data-toggle="tab"> 题目管理 </a></li>
		</ul>
		<div class="tab-content">
			<!--content1-->
			<!-- 分班管理的主页面 -->
			<%
				// 找到所有的老师
				List<User> list_teachers = DaoFactory.getUserService()
						.selectUserByKind(2);
				// 找到所有的学生
				List<User> list_students = DaoFactory.getUserService()
						.selectUserByKind(1);
			%>
			<div class="tab-pane fade in active row" id="content1">
				<!--  -->
				<div class="col-md-12" style="margin-top: 40px;;">
					<!-- 左栏显示所有班级 -->
					<div class="panel panel-default" style="float:left;width:200px">
						<div class="panel-heading" style="text-align:center;">
							<h3 class="panel-title">
								<b>所有班级</b>
							</h3>
						</div>
						<ul class="nav nav-pills nav-stacked" style="text-align:center;">
							<%	for(int i = 0; i < list_teachers.size(); i ++) { %>
							<%		if(list_teachers.get(i).getClass_() != null) { %>
							<li class="">
							<a href="<%="#" + list_teachers.get(i).getClass_() %>" data-toggle="tab"><%=list_teachers.get(i).getClass_() %></a>
							</li>
							<!-- <button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button> -->
							<%		} %>
							<%	} %>
							<li class=""><a href="#addClass" data-toggle="tab"><b>添加班级</b></a></li>
						</ul>
					</div>
					<!-- 右栏显示班级的详细信息 -->
					<div id="myTabContent" class="tab-content">
						<!-- 普通右栏-显示班级的所有信息 -->
						<%	for(int i = 0; i < list_teachers.size(); i ++) { %>
						<%		if(list_teachers.get(i).getClass_() != null) { %>
						<div class="panel panel-default tab-pane fade in" id="<%=list_teachers.get(i).getClass_() %>"
							style="float:left; width:650px;margin-left:50px;">
							<div class="panel-heading">
								<h3 class="panel-title">班级的详细信息（可修改）</h3>
							</div>
							<div class="panel-body">
								<form class="form-horizontal" role="form" method="post" action="ClassServlet?Method=insert">
									<div class="form-group">
										<label for="firstname" class="col-sm-2 control-label">班级名称</label>
										<label for="firstname" class="col-sm-2 control-label" style="margin-left:-15px;"><%=list_teachers.get(i).getClass_() %></label>

									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">修改老师</label>
										<div class="col-sm-10">
											<select class="form-control" name="classTeacher" id="classTeacher">
												<option value="<%=list_teachers.get(i).getUid() %>"><%="默认：" + list_teachers.get(i).getName() + "-"
							+ list_teachers.get(i).getUid()%></option>
												<%	for(int j = 0; j < list_teachers.size(); j ++) { 
														if(list_teachers.get(j).getClass_() == null) {
												%>
												<option value="<%=list_teachers.get(j).getUid() %>"><%=list_teachers.get(j).getName() + "-"
							+ list_teachers.get(j).getUid()%></option>
												<%		} 
													}
												%>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">增减学生</label>
										<div class="col-sm-10">
											<!-- 找到当前班级中的所有学生 -->
											<%	List<User> list_classStudents = DaoFactory.getUserService().selectUserByClass(list_teachers.get(i).getClass_());
												for(int j = 0; j < list_classStudents.size(); j ++) {
											 %>
											<label class="checkbox"
												style="float:left;margin-left:30px;width:130px;"> <input checked="checked"
												type="checkbox" id="classStudents" name="classStudents[]" value="<%=list_classStudents.get(j).getUid() %>">
												<%=list_classStudents.get(j).getName() + "-" + list_classStudents.get(j).getUid() %>
											</label>
											<%	} %>

										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-8 col-md-4">
											<button type="button" class="btn btn-defult"
												style="float:left;">恢复默认</button>
											<button type="submit" class="btn btn-primary"
												style="float:left;margin-left:20px;">修改</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						<%		} %>
						<%	} %>
						<!-- 特殊右栏-添加班级的页面 -->
						<div class="panel panel-default tab-pane fade" id="addClass"
							style="float:left; width:650px;margin-left:50px;">
							<div class="panel-heading">
								<h3 class="panel-title">添加班级</h3>
							</div>
							<div class="panel-body" style="">
								<form class="form-horizontal" role="form" method="post" action="ClassServlet?Method=insert">
									<div class="form-group">
										<label for="firstname" class="col-sm-2 control-label">班级名称</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="className" name="className"
												placeholder="请输入班级名称">
										</div>
									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">选择老师</label>
										<div class="col-sm-10">
											<select class="form-control" name="classTeacher" id="classTeacher">
												<option>--请选择老师--</option>
												<%
													for (int i = 0; i < list_teachers.size(); i++) {
														if (list_teachers.get(i).getClass_() == null) {
												%>
												<option value="<%=list_teachers.get(i).getUid() %>"><%=list_teachers.get(i).getName() + "-"
							+ list_teachers.get(i).getUid()%></option>
												<%
													}
													}
												%>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">选择学生</label>
										<div class="col-sm-10">
											<%
												for (int i = 0; i < list_students.size(); i++) {
													if (list_students.get(i).getClass_() == null) {
											%>
											<label class="checkbox"
												style="float:left;margin-left:30px;width:130px;"> <input
												type="checkbox" id="classStudents" name="classStudents[]" value="<%=list_students.get(i).getUid() %> ">
												<%=list_students.get(i).getName() + "-" + list_students.get(i).getUid()%>
											</label>
											<%
													}
												}
											%>

										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-8 col-md-4">
											<button type="button" class="btn btn-defult"
												style="float:left;">清空</button>
											<button type="submit" class="btn btn-primary"
												style="float:left;margin-left:20px;">添加</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--content2-->
			<div class="tab-pane fade row" id="content2">
				<div class="col-md-12" style="margin-top:40px">
					<div class="panel panel-primary">
						<div class="panel-heading text-center">
							<h3>历次作答题目</h3>
						</div>

						<div class="panel-body text-center" style="font-size: 20px">
							<p>
								您暂时未作答任何题目，可以去<a href="test_before.jsp">练习</a>开始测试
							</p>
						</div>

						<table class="table">
							<tr>
								<th class="table-th" style="width: 20%">题号</th>
								<th class="table-th" style="width: 20%">作答题目</th>
								<th class="table-th" style="width: 20%">作答次数</th>
								<th class="table-th" style="width: 20%">正确率</th>
								<th class="table-th" style="width: 20%">是否收藏</th>
							</tr>

						</table>


					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>
