<%@ page language="java"
	import="java.util.*, factory.DaoFactory, bean.Knowledge"
	pageEncoding="UTF-8"%>
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
<!-- 自定义的css文件 -->
<link rel="stylesheet" href="./css/knowledge.css">


</head>

<body>

	<jsp:include page="toolbar.jsp">
		<jsp:param value="0" name="flag" />
	</jsp:include>
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

	<div class="all">
		<div class="menu">
			<ul class="nav nav-pills nav-stacked">
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
							</a>
						</li>
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
	
	<%-- <jsp:include page="footer.jsp">
  			<jsp:param value="0" name="flag"/>
  	</jsp:include> --%>
	
</body>
</html>
