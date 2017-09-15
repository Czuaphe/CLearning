<%@ page language="java"
	import="java.util.*, factory.DaoFactory, bean.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'problem.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- Bootstrap 所需的最少css和js文件 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/echarts.min.js"></script>
<link rel="stylesheet" href="./css/toolbar.css">
<!-- 自定义CSS -->
<link rel="stylesheet" href="./css/problem.css">

</head>

<body style="padding-top:70px;">

	<jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>

	<%
		User user = (User) session.getAttribute("user");
		List<Test> tests = DaoFactory.getTestSerivce().selectTestByUid(user.getUid());
		// 得到每次测试所有题目
		ArrayList<ArrayList<Problem>> tests_problems = new ArrayList<ArrayList<Problem>>();
		// 得到每次测试的答题情况
		ArrayList<ArrayList<TestContent>> tests_testContents = new ArrayList<ArrayList<TestContent>>();
		for(int i = 0 ; i < tests.size(); i ++ ) {
			// 首先，要先得到每次测试的答题情况，就是测试内容，然后才能找到题目
			ArrayList<TestContent> testContent = DaoFactory.getTestContentService().selectTestContentByTid(tests.get(i).getTid());
			// 插入每次测试的答题情况
			tests_testContents.add(testContent);
			// 根据答题情况找到具体的每一道题
			ArrayList<Problem> problems = new ArrayList<Problem>();
			for(int j = 0; j < testContent.size(); j ++) {
				int pid = testContent.get(j).getPid();
				Problem problem = DaoFactory.getProblemService().selectProblemByPid(pid);
				problems.add(problem);
			}
			// 插入每次测试的所有题目
			tests_problems.add(problems);
		}
		// 每次测试的每道题目的正确次数
		ArrayList<ArrayList<Integer>> tests_true_problems = new ArrayList<ArrayList<Integer>>();
		// 每次测试的每道题目的回答总次数
		ArrayList<ArrayList<Integer>> tests_sum_problems = new ArrayList<ArrayList<Integer>>();
	%>

	<div class="row tab-content">
		<div class="btn-group col-md-6 col-md-offset-3">
			<ul class="nav nav-tabs">
				<li class="active" data-toggle="tab"><a href="#content1"
					data-toggle="tab"> 按测试情况 </a></li>
				<li class="" data-toggle="tab"><a href="#content2"
					data-toggle="tab"> 按测试题目 </a></li>
			</ul>
			<div class="tab-content">
				<!--content1-->
				<div class="tab-pane fade in active row" id="content1">
					<div class="col-md-12" style="margin-top: 40px;">
						<div class="panel panel-primary">
							<div class="panel-heading text-center">
								<h3>历次测试情况</h3>
							</div>
							<%
								if(tests.size() == 0) {
							%>
							<div class="panel-body text-center" style="font-size: 20px">
								<p>
									您暂时未进行测试，可以去<a href="test_before.jsp">测试</a>，让我了解您的知识水平
								</p>
							</div>
							<%
								} else {
							%>
							<table class="table" style="width: 100%">
								<tr>
									<th class="table-th">测试名</th>
									<th class="table-th">测试时间</th>
									<th class="table-th">测试耗时</th>
									<th class="table-th">成绩</th>
								</tr>
								<%
									for(int i = 0; i < tests.size(); i ++) {
								%>
								<tr>
									<td class="table-td"><a class="td-a"
										href="<%="#" + tests.get(i).getName()%>" data-toggle="tab"
										style="text-decoration: none"><%=tests.get(i).getName()%></a></td>
									<td class="table-td"><%=tests.get(i).getStart().toLocaleString()%></td>
									<%
										int minutes = tests.get(i).getTrue_time().getMinutes();
										int seconds = tests.get(i).getTrue_time().getSeconds();
									%>
									<td class="table-td"><%=(minutes != 0 ? minutes + "分" : "") + seconds + "秒"%></td>
									<td class="table-td"><%=tests.get(i).getScore()%></td>
								</tr>
								<%
									}
								%>

							</table>
							<%
								}
							%>
						</div>
					</div>
					<!-- 每次测试的具体情况 -->
					<div class="col-md-12 tab-content" >
						<%
							for(int i = 0; i < tests.size(); i ++) {
						%>
						<div class="tab-pane fade" id="<%=tests.get(i).getName() %>">
							<!-- 计算每题正确率 -->
							<%  ArrayList<Integer> true_problems = new ArrayList<Integer>();
								ArrayList<Integer> sum_problems = new ArrayList<Integer>();
								for(int j = 0; j < tests_problems.get(i).size(); j ++) {
									int pid = tests_problems.get(i).get(j).getPid();
									ArrayList<TestContent> list = DaoFactory.getTestContentService().selectTestContentByPid(pid);
									int sum = 0;
									for(int k = 0; k < list.size(); k ++) {
										if(list.get(k).getYour_option() == tests_problems.get(i).get(j).getTrue_option()) {
											sum ++;
										}
									}
									true_problems.add(sum);
									sum_problems.add(list.size());
								}
								tests_true_problems.add(true_problems);
								tests_sum_problems.add(sum_problems);
								
							%> 
							<div class="col-md-6" style="margin-top:40px">
								<div class="panel panel-info">
									<div class="panel-heading text-left">
										<h3>各题正确率:</h3>
									</div>
									<div class="panel-body">
										<ul class="progress-ul" style="padding: 0;">
											<% 	for(int j = 0; j < true_problems.size(); j ++) { %>
											<li>
												<div style="width:5%;float:left;margin-right:30px;">
													<span class="badge"><%=tests_problems.get(i).get(j).getPid() %></span>
												</div>
												<div style="width:5%;float:left;margin-right:10px;">
													<span style="font-size:10px;"><%=true_problems.get(j) + "/" + sum_problems.get(j) %></span>
												</div>
												<div class="progress" style="width: 80%;">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="5" aria-valuemin="0" aria-valuemax="10"
														style="width: <%=(int)((double)true_problems.get(j) / sum_problems.get(j) * 100) %>%;">
														</div>
														
												</div>
												
											</li>
											<%	} %>
											
										</ul>
									</div>
								</div>


							</div>
							<!-- 计算每次测试的总正确率 -->
							<% 	int sum = 0;
								for(int j = 0 ; j < tests_testContents.get(i).size(); j ++) {
									if(tests_testContents.get(i).get(j).getYour_option() == tests_problems.get(i).get(j).getTrue_option()) {
										sum ++;
									}
								}
							%>
							<div class="col-md-6" style="margin-top: 40px">
								<div class="panel panel-danger">
									<div class="panel-heading text-center">
										<h3>总体正确率</h3>
									</div>
									<div class="panel-body" style="padding-top: 85px">
										<div class="" id="<%="AllStatus" + tests.get(i).getName() %>"
											style="width:300px; height: 300px; margin-left: 30px;"></div>
									</div>
								</div>

							</div>
							<script type="text/javascript">
								// 基于准备好的dom，初始化echarts实例
								var <%="myChartAllStatus" + tests.get(i).getName() %> = echarts.init(document
										.getElementById('<%="AllStatus" + tests.get(i).getName() %>'));
								<%="option" + tests.get(i).getName() %> = {
									title : {
										text : '测试题目10道',
										left : 'center'
									},
									tooltip : {
										trigger : 'item',
										formatter : "{a} <br/>{b} : {c} ({d}%)"
									},
									legend : {
										orient : 'vertical',
										left : 'left',
										data : [ '正确', '错误' ]
									},
									series : [ {
										name : '测试整体正确率',
										type : 'pie',
										radius : [ '50%', '70%' ],
										avoidLabelOverlap : false,
										label : {
											normal : {
												show : false,
												position : 'center'
											},
											emphasis : {
												show : true,
												textStyle : {
													fontSize : '30',
													fontWeight : 'bold'
												}
											}
										},
										labelLine : {
											normal : {
												show : false
											}
										},
										data : [ {
											value : <%=sum %>,
											name : '正确'
										}, {
											value : <%=tests_testContents.get(i).size() - sum %>,
											name : '错误'
										} ]
									} ]
								};

								<%="myChartAllStatus" + tests.get(i).getName() %>.setOption(<%="option" + tests.get(i).getName() %>);
							</script>
						</div>
						<%	} %>
					</div>
				</div>



				<!--content2-->
				<div class="tab-pane fade row" id="content2">
					<div class="col-md-12" style="margin-top:40px">
						<div class="panel panel-primary">
							<div class="panel-heading text-center">
								<h3>历次作答题目</h3>
							</div>
							<% 	if(tests.size() == 0) { %>
							<div class="panel-body text-center" style="font-size: 20px">
								<p>
									您暂时未作答任何题目，可以去<a href="test_before.jsp">练习</a>开始测试
								</p>
							</div>
							<%	} else { %>
							<table class="table">
								<tr>
									<th class="table-th" style="width: 20%">题号</th>
									<th class="table-th" style="width: 20%">作答题目</th>
									<th class="table-th" style="width: 20%">作答次数</th>
									<th class="table-th" style="width: 20%">正确率</th>
									<th class="table-th" style="width: 20%">是否收藏</th>
								</tr>
								<% 	// 去重
									LinkedHashSet<ProblemInfo> problems_set = new LinkedHashSet<ProblemInfo>();
									for(int i = 0; i < tests_problems.size(); i++) {
										for(int j = 0; j < tests_problems.get(i).size(); j ++) {
											ProblemInfo problemInfo = new ProblemInfo(tests_problems.get(i).get(j), tests_true_problems.get(i).get(j), tests_sum_problems.get(i).get(j));
											if(!problems_set.contains(problemInfo)) {
												problems_set.add(problemInfo);
											
												
								%>
								<tr>
									<td class="table-td"><%=tests_problems.get(i).get(j).getPid() %></td>
									<td class="table-td"><%="" + tests_problems.get(i).get(j).getChapter() + "_" + tests_problems.get(i).get(j).getSection() + "_" + tests_problems.get(i).get(j).getName() %></td>
									<td class="table-td"><%=tests_sum_problems.get(i).get(j) %></td>
									<td class="table-td"><%=(int)((double)tests_true_problems.get(i).get(j) / tests_sum_problems.get(i).get(j) * 100) + "%" %></td>
									<td class="table-td">
										<div class="btn-group" role="group">
											<button type="button" class="btn btn-primary">收藏</button>
										</div>
									</td>
								</tr>
								<%			} %>
								<%		} %>
								<%	} %>
							</table>
							<%	} %>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
