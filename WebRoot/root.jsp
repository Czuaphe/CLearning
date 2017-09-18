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
<link rel="stylesheet" href="./css/root.css">
</head>

<body>
	<jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>

	<div class="btn-group col-md-6 col-md-offset-3">
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
							<%
								for (int i = 0; i < list_teachers.size(); i++) {
							%>
							<%
								if (list_teachers.get(i).getClass_() != null
											&& !list_teachers.get(i).getClass_().equals("0")) {
							%>
							<li class=""><a
								href="<%="#" + list_teachers.get(i).getClass_()%>"
								data-toggle="tab"><%=list_teachers.get(i).getClass_()%></a></li>
							<!-- <button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button> -->
							<%
								}
							%>
							<%
								}
							%>
							<li class=""><a href="#addClass" data-toggle="tab"><b>添加班级</b></a></li>
						</ul>
					</div>
					<!-- 右栏显示班级的详细信息 -->
					<div id="myTabContent" class="tab-content">
						<!-- 普通右栏-显示班级的所有信息 -->
						<%
							for (int i = 0; i < list_teachers.size(); i++) {
						%>
						<%
							if (list_teachers.get(i).getClass_() != null) {
						%>
						<div class="panel panel-default tab-pane fade in"
							id="<%=list_teachers.get(i).getClass_()%>"
							style="float:left; width:650px;margin-left:50px;">
							<div class="panel-heading">
								<h3 class="panel-title">班级的详细信息（可修改）</h3>
							</div>
							<div class="panel-body">
								<form class="form-horizontal" role="form" method="post"
									action="ClassServlet?Method=update&&className=<%=list_teachers.get(i).getClass_()%>">
									<div class="form-group">
										<label for="firstname" class="col-sm-2 control-label">班级名称</label>
										<label for="firstname" class="col-sm-2 control-label"
											style="margin-left:-15px;"><%=list_teachers.get(i).getClass_()%></label>

									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">修改老师</label>
										<div class="col-sm-10">
											<select class="form-control" name="classTeacher"
												id="classTeacher">
												<option value="<%=list_teachers.get(i).getUid()%>"><%="默认：" + list_teachers.get(i).getName() + "-"
							+ list_teachers.get(i).getUid()%></option>
												<%
													for (int j = 0; j < list_teachers.size(); j++) {
																if (list_teachers.get(j).getClass_() == null
																		|| list_teachers.get(j).getClass_().equals("0")) {
												%>
												<option value="<%=list_teachers.get(j).getUid()%>"><%=list_teachers.get(j).getName() + "-"
									+ list_teachers.get(j).getUid()%></option>
												<%
													}
															}
												%>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">增减学生</label>
										<div class="col-sm-10">
											<!-- 找到当前班级中的所有学生 -->
											<%
												List<User> list_classStudents = DaoFactory.getUserService()
																.selectUserByClassAndKind(
																		list_teachers.get(i).getClass_(), 1);
														for (int j = 0; j < list_classStudents.size(); j++) {
											%>
											<label class="checkbox"
												style="float:left;margin-left:30px;width:130px;"> <input
												checked="checked" type="checkbox" id="classStudents"
												name="classStudents[]"
												value="<%=list_classStudents.get(j).getUid()%>"> <%=list_classStudents.get(j).getName() + "-"
								+ list_classStudents.get(j).getUid()%>
											</label>
											<%
												}
											%>
											<!-- 显示所有没有加入班级的学生 -->
											<%
												for (int j = 0; j < list_students.size(); j++) {
															if (list_students.get(j).getClass_() == null
																	|| list_students.get(j).getClass_().equals("0")) {
											%>
											<label class="checkbox"
												style="float:left;margin-left:30px;width:130px;"> <input
												type="checkbox" id="classStudents" name="classStudents[]"
												value="<%=list_students.get(j).getUid()%> "> <%=list_students.get(j).getName() + "-"
									+ list_students.get(j).getUid()%>
											</label>
											<%
												}
														}
											%>


										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-8 col-md-4">
											<button type="submit" class="btn btn-primary"
												style="float:left;margin-left:20px;">修改</button>
								</form>
								<form method="post"
									action="ClassServlet?Method=delete&&className=<%=list_teachers.get(i).getClass_()%>">
									<button type="submit" class="btn btn-primary"
										style="float:left;margin-left:20px;">删除</button>
								</form>

							</div>
						</div>

					</div>
				</div>
				<%
					}
				%>
				<%
					}
				%>
				<!-- 特殊右栏-添加班级的页面 -->
				<div class="panel panel-default tab-pane fade in active"
					id="addClass" style="float:left; width:650px;margin-left:50px;">
					<div class="panel-heading">
						<h3 class="panel-title">添加班级</h3>
					</div>
					<div class="panel-body" style="">
						<form class="form-horizontal" role="form" method="post"
							action="ClassServlet?Method=insert">
							<div class="form-group">
								<label for="firstname" class="col-sm-2 control-label">班级名称</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="className"
										name="className" placeholder="请输入班级名称">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-2 control-label">选择老师</label>
								<div class="col-sm-10">
									<select class="form-control" name="classTeacher"
										id="classTeacher">
										<option>--请选择老师--</option>
										<%
											for (int i = 0; i < list_teachers.size(); i++) {
												if (list_teachers.get(i).getClass_() == null
														|| list_teachers.get(i).getClass_().equals("0")) {
										%>
										<option value="<%=list_teachers.get(i).getUid()%>"><%=list_teachers.get(i).getName() + "-"
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
											if (list_students.get(i).getClass_() == null
													|| list_students.get(i).getClass_().equals("0")) {
									%>
									<label class="checkbox"
										style="float:left;margin-left:30px;width:130px;"> <input
										type="checkbox" id="classStudents" name="classStudents[]"
										value="<%=list_students.get(i).getUid()%> "> <%=list_students.get(i).getName() + "-"
							+ list_students.get(i).getUid()%>
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
	<div class="tab-pane fade " id="content2">
		<div class="col-md-12" style="margin-top:40px">
			<%
				ArrayList<Knowledge> list = DaoFactory.getKnowledgeService()
						.selectAllKnowledge();
			%>

			<div class="all">
				<div class="menu">
					<ul class="nav nav-pills nav-stacked">
						<li class=""><a href="<%="#Chapter_0_0"%>" data-toggle="tab">
								<b><%=list.get(0).getTitle()%></b>
						</a></li>

						<!-- 循环输出目录开始 -->
						<%
							for (int i = 1; i < list.size(); i++) {
						%>
						<%
							if (list.get(i).getSection() == 0) {
						%>
						<%
							if (i != 1) {
						%>
					</ul>
				</div>
				<%
					}
				%>
				<li class="" data-toggle="collapse"
					data-target="<%="#Chapter_" + list.get(i).getChapter()%>"><a
					href="<%="#Chapter_" + list.get(i).getChapter() + "_"
							+ list.get(i).getSection()%>"
					data-toggle="tab"><b><%=list.get(i).getTitle()%></b></a></li>
				<div id="<%="Chapter_" + list.get(i).getChapter()%>"
					class="collapse">
					<ul class="nav nav-pills nav-stacked">
						<%
							} else {
						%>
						<li><a
							href="<%="#Chapter_" + list.get(i).getChapter() + "_"
							+ list.get(i).getSection()%>"
							data-toggle="tab">&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(i).getTitle()%></a></li>
						<%
							}
						%>
						<%
							}
						%>
					</ul>
				</div>
				<!-- 循环输出目录结束 -->
				</ul>
			</div>
			<div class="content">
				<div id="myTabContent" class="tab-content">
					<!-- 循环输出内容开始 -->
					<%
						for (int i = 0; i < list.size(); i++) {
					%>
					<div class="tab-pane fade in <%=i == 0 ? "active" : ""%>"
						id="<%="Chapter_" + list.get(i).getChapter() + "_"
						+ list.get(i).getSection()%>">
						<%=list.get(i).getDetails()%>
					</div>
					<%
						}
					%>
					<!-- 循环输出内容结束 -->
				</div>
			</div>

		</div>
	</div>

	
	
</body>
</html>
