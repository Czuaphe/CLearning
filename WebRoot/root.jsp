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
			<li class=""><a href="#content4"
				data-toggle="tab"> 题目管理 </a></li>
		</ul>
		<div class="tab-content">
			<!-- content1 -->
			<!-- 分班管理的主页面 -->
			<%
				// 分班之前的处理
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
										</div>
									</div>
								</form>
								<form method="post"
									action="ClassServlet?Method=delete&&className=<%=list_teachers.get(i).getClass_()%>">
									<button type="submit" class="btn btn-primary"
										style="position:absolute; top:215px; left:800px; margin-left:20px;">删除</button>
								</form>
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
			<!-- content1 end -->
			<!-- content2 start -->
			<!-- 知识点管理页面 -->
			<div class="tab-pane fade row" id="content2">

				<%
					ArrayList<Knowledge> list = DaoFactory.getKnowledgeService()
							.selectAllKnowledge();
					ArrayList<Knowledge> list_chapter = new ArrayList<Knowledge>();
					ArrayList<ArrayList<Knowledge>> list_section = new ArrayList<ArrayList<Knowledge>>();
					ArrayList<Knowledge> section = new ArrayList<Knowledge>();
					for (int i = 1; i < list.size(); i++) {
						if (list.get(i).getSection() == 0) {
							// 禁止第一个空的section添加到list_section中
							if (section.size() != 0) {
								list_section.add(section);
								section = new ArrayList<Knowledge>();
							}
							list_chapter.add(list.get(i));

						} else {
							section.add(list.get(i));
						}
					}
					// 最后一个section在for循环之后加入
					list_section.add(section);
				%>

				<div class="all" style="margin-top:30px;">
					<div class="menu">
						<ul class="nav nav-pills nav-stacked">
							<!-- 目录第一项 -->
							<li class=""><a href="<%="#Chapter_0_0"%>" data-toggle="tab">
									<b><%=list.get(0).getTitle()%></b>
							</a></li>

							<!-- 循环输出目录开始 -->
							<%
								for (int i = 0; i < list_chapter.size(); i++) {
							%>
							<li class="" data-toggle="collapse"
								data-target="<%="#Chapter_" + list_chapter.get(i).getChapter()%>"><a
								href="<%="#Chapter_" + list_chapter.get(i).getChapter() + "_"
						+ list_chapter.get(i).getSection()%>"
								data-toggle="tab"><b><%=list_chapter.get(i).getTitle()%></b></a></li>
							<div id="<%="Chapter_" + list_chapter.get(i).getChapter()%>"
								class="collapse">
								<ul class="nav nav-pills nav-stacked">
									<%
										for (int j = 0; j < list_section.get(i).size(); j++) {
									%>
									<li><a
										href="<%="#Chapter_"
							+ list_section.get(i).get(j).getChapter() + "_"
							+ list_section.get(i).get(j).getSection()%>"
										data-toggle="tab">&nbsp;&nbsp;&nbsp;&nbsp;<%=list_section.get(i).get(j).getTitle()%>
									</a></li>
									<%
										}
									%>
								</ul>
							</div>

							<%
								}
							%>
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
			<!-- content2 end -->
			<!-- content3 start -->
			<!-- 用户管理页面 -->
			<div class="tab-pane fade row" id="content3">
				yyyyyyyyyyyyyyyyyyyyyy</div>
			<!-- content3 end -->
			<!-- content4 start -->
			<!-- 题目管理页面 -->
			<div class="tab-pane fade row" id="content4">
				<%
					List<Problem> list_problems = DaoFactory.getProblemService()
							.selectAllProblem();
				%>
				<div class="col-md-12" style="margin-top:40px">
					<div class="panel panel-primary">
						<div class="panel-heading text-center">
							<h3>所有题目</h3>
						</div>

						<table class="table">
							<tr>
								<th class="table-th">题号</th>
								<th class="table-th">作答题目</th>
								<th class="table-th">作答次数</th>
								<th class="table-th">正确率</th>

							</tr>
							<!-- 循环输出每一题 -->
							<%
								for (int i = 0; i < list_problems.size(); i++) {
									
									int pid = list_problems.get(i).getPid();
									ArrayList<TestContent> list_pid = DaoFactory.getTestContentService().selectTestContentByPid(pid);
									int sum = 0;
									for(int k = 0; k < list_pid.size(); k ++) {
										if(list_pid.get(k).getYour_option() == list_problems.get(i).getTrue_option()) {
											sum ++;
										}
									}
							%>
							<!-- 输出本题目的作答信息 -->
							<tr>
								<td class="table-td"><%=list_problems.get(i).getPid()%></td>
								<td class="table-td"><a
									href="<%="#" + list_problems.get(i).getChapter() + "_"
						+ list_problems.get(i).getSection() + "_" + i%>"
									data-toggle="modal"> <%=(list_problems.get(i).getChapter() == 0 ? "序言" : "第"
						+ list_problems.get(i).getChapter() + "章")
						+ "_" + list_problems.get(i).getName()%></a></td>
								<td class="table-td"><%=list_pid.size() %></td>
								<td class="table-td"><%=list_pid.size() > 0 ? (int)((double)sum / list_pid.size() * 100) + "%" : "-" %></td>
							</tr>
							<%
								}
							%>
							<!-- 循环输出每一题 结束  -->
						</table>
					</div>
				</div>
				<!-- 显示题目详细信息模态框（Modal） -->
				<%
					for (int i = 0; i < list_problems.size(); i++) {
				%>
				<!-- 注册模态框（Modal） -->
				<div class="modal fade" id=<%="" + list_problems.get(i).getChapter() + "_"
						+ list_problems.get(i).getSection() + "_" + i%> tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">题目管理</h4>
							</div>

							<!-- from 表单 -->
							<form class="form-horizontal" role="form" name="myFrom"
								method="post" action="ProblemServlet?Method=udpate&&pid=<%=list_problems.get(i).getPid() %>">
								<div class="modal-body">
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<label for="name" class="control-label"><%="" + list_problems.get(i).getChapter() + "_" + list_problems.get(i).getName() %></label>
										</div>
									</div>
									<div class="form-group">
										<label for="name" class="col-sm-2 control-label">所属章节</label>
										<div class="col-sm-10">
											<select class="form-control" name="chapter">
												<option value="-1">-请选择-</option>
												<%	String[] optionName = {"序言", "第一章", "第二章", "第三章", "第四章", "第五章", "第六章", "第七章"}; 
													for(int j = 0; j < optionName.length; j ++) {
														if(j == list_problems.get(i).getChapter()) {
												%>
												<option selected="selected" value="<%= j %>" ><%="默认-" + optionName[j] %></option>
												<%		} else { %>
												<option value="<%= j %>" ><%=optionName[j] %></option>
												<%		}
													} 
												%>
											</select>
										</div>

									</div>

									<div class="form-group">
										<label for="firstname" class="col-sm-2 control-label">标题</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="title" name="title"
												placeholder="请输入标题" value=<%=list_problems.get(i).getTitle()%>>
										</div>
									</div>

									<div class="form-group">
										<label for="firstname" class="col-sm-2 control-label">选项1</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="option1" name="option1"
												placeholder="请输入选项1" value=<%=list_problems.get(i).getOption1()%>>
										</div>
									</div>

									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">选项2</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="option2" name="option2"
											 placeholder="请输入选项2" value=<%=list_problems.get(i).getOption2()%>>
										</div>
									</div>

									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">选项3</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="option3" name="option3"
											 placeholder="请再次输入选项3" value=<%=list_problems.get(i).getOption3()%>>
										</div>
									</div>
		
									<div class="form-group">
										<label for="lastname" class="col-sm-2 control-label">选项4</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="option4" name="option4"
											 placeholder="请再次输入选项4" value=<%=list_problems.get(i).getOption4()%>>
										</div>
									</div>
									<div class="form-group">
										<label for="name" class="col-sm-2 control-label">正确选项</label>
										<div class="col-sm-10">
											<select class="form-control" name="true_option">
												<%	for(int j = 0; j < 4; j ++) { 
														if(j + 1 == list_problems.get(i).getTrue_option()) {
												%>
												<option selected="selected" value="<%= j + 1 %>"><%="默认-选项" + (j + 1) %></option>
												<%		
														} else {
												%>
												<option value="<%= j + 1 %>"><%="选项" + (j + 1) %></option>
												<% 
														}
													}
												%>
											</select>
										</div>

									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">关闭</button>
									<button type="submit" class="btn btn-primary">修改</button>
								</div>
							</form>

							<!-- from 表单结束  -->

						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal -->
				</div>


				<%
					}
				%>

			</div>
			<!-- content4 end -->
		</div>
	</div>
</body>
</html>
