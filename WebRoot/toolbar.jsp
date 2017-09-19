<%@ page language="java" import="java.util.*, bean.User" pageEncoding="UTF-8"%>

<%
	String status = (String) session.getAttribute("status");
	String signupStatus = (String) session.getAttribute("signupStatus");
	User user = (User) session.getAttribute("user");
%>

<!-- 判断登录状态 -->
<%
 	if(status == null) {
%>
<%
	} else if (status.equals("NotUser")) {
%>
<script type="text/javascript">
	window.alert("该用户还没有注册");
</script>
<%
	} else if (status.equals("PswdError")) {
%>
<script type="text/javascript">
	window.alert("密码错误");
</script>
<%
	} else if (status.equals("Success")) {
		session.setAttribute("status", new String("Normal"));
%>
<script type="text/javascript">
	window.alert("登录成功");
</script>
<%
	} else {
		if(user == null) {
			session.setAttribute("status", new String(""));
		}
	}
%>

<!-- 判断注册状态 -->
<% 	if(signupStatus != null) { %>
<%		if(signupStatus.equals("Success")) { 
			session.setAttribute("signupStatus", new String("Normal"));
%>
<script>
	window.alert("注册成功");
</script>
<%		} %>
<%		if(signupStatus.equals("Fail")) { %>
<script>
	window.alert("注册失败，请重新注册");
</script>
<% 		} %>
<%		if(signupStatus.equals("HadUser")) { %>
<script>
	window.alert("该用户已经注册，请直接登录！");
</script>
<% 		} %>
<%		if(signupStatus.equals("PswdNotSame")) { 
			session.setAttribute("signupStatus", new String("Normal"));
%>s		
<script>
	window.alert("两次密码不同，请重新注册");
</script>
<% 		} %>
<%	} %>


<!-- 使用Bootstrap编写的导航栏 -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container-fluid" style="width:1000px">
		<div class="navbar-header">
			<a class="navbar-brand" href="index.jsp">C语言跟踪平台</a>
		</div>
		<div>
			<ul class="nav navbar-nav">
				<li class=""><a href="knowledge.jsp">教程</a></li>
				<li><a href="problem.jsp">题库</a></li>
				
				<%		if(status != null && (status.equals("Success") || status.equals("Normal"))&& user != null) { %>
				<%			if(user.getKind() == 1) { %>
				<li><a href="test_before.jsp">测试</a></li>
				<%			} %>
				<%		} %>
				
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<%	if(status != null && (status.equals("Success") || status.equals("Normal"))&& user != null) { %>
				<li><a href="<%=user.getKind() == 1 ? "student.jsp" : user.getKind() == 0 ? "root.jsp" : "teacher.jsp" %>" >&nbsp;<%=user.getName() %></a></li>
				<li><a href="#exit" data-toggle="modal">&nbsp;注销</a></li>
				<%	} else { %>
				<li><a href="#signup" data-toggle="modal"><span
						class="glyphicon glyphicon-user"></span>&nbsp;注册</a></li>
				<li><a href="#login" data-toggle="modal"><span
						class="glyphicon glyphicon-log-in"></span>&nbsp;登录</a></li>
				<%	} %>
			</ul>
		</div>
	</div>
</nav>
<!-- 导航栏结束 -->

<!-- 注册模态框（Modal） -->
<div class="modal fade" id="signup" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">注册用户</h4>
			</div>
			
			<!-- from 表单 -->  
			<form class="form-horizontal" role="form" name="myFrom" method="post" action = "SignupServlet">
				<div class="modal-body">
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<label for="name" class="control-label">欢迎注册C语言跟踪测试平台</label>	
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">类别</label>
						<div class="col-sm-10">
							<select class="form-control" name="kind" >
								<option value = "-1">-请选择-</option>
								<option value = "1">学生</option>
								<option value = "2">教师</option>
								<option value = "0">管理员</option>
							</select>
						</div>

					</div>

					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">学号/工号</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="uid" name="uid"
								placeholder="请输入学号或工号">
						</div>
					</div>
					
					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">名字</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="name" name="name"
								placeholder="请输入您的真实姓名">
						</div>
					</div>
					
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="pswd" name="pswd"
								placeholder="请输入密码">
						</div>
					</div>
					
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">再次密码</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="pswd_again" name="pswd_again"
								placeholder="请再次输入密码">
						</div>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary">注册</button>
				</div>
			</form>
			
			<!-- from 表单结束  -->
			
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<!-- 登录模态框（Modal） -->
<div class="modal fade" id="login" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">用户登录</h4>
			</div>

			<!-- from 表单 -->  
			<form class="form-horizontal" role="form" name="myFrom" method="post" action = "LoginServlet">
				<div class="modal-body">
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<label for="name" class="control-label">欢迎登录C语言跟踪测试平台</label>	
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">类别</label>
						<div class="col-sm-10">
							<select class="form-control" name="kind" >
								<option value = "-1">-请选择-</option>
								<option value = "1">学生</option>
								<option value = "2">教师</option>
								<option value = "0">管理员</option>
							</select>
						</div>

					</div>

					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">学号/工号</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="uid" name="uid"
								placeholder="请输入学号或工号">
						</div>
					</div>
					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="pswd" name="pswd"
								placeholder="请输入密码">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary" onclick="startRequest">登录</button>
				</div>
			</form>
			
			<!-- from 表单结束  -->
			

		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<!-- 注销模态框（Modal） -->
<div class="modal fade" id="exit" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">注销用户</h4>
			</div>
			<div class="modal-footer">
				<form action="ExitServlet" method="post">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary">注销</button>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>





