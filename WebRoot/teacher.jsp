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
    
    <title>My JSP 'teacher.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
      <!-- Bootstrap 所需的最少css和js文件 -->
      <link rel="stylesheet" href="./css/bootstrap.min.css">
      <script src="./js/jquery.min.js"></script>
      <script src="./js/bootstrap.min.js"></script>
      <script src="./js/echarts.min.js"></script>
      <link rel="stylesheet" href="./css/toolbar.css">
      <!-- 自定义CSS -->
      <link rel="stylesheet" href="./css/teacher.css">
  </head>
  
  <body style="padding-top: 70px">
  <jsp:include page="toolbar.jsp"></jsp:include>
  <!--获取对应班级的所有学生selectUserByClass-->
  <%
        User user =(User)session.getAttribute("user");

        List<User> userList = DaoFactory.getUserService().selectUserByClass(user.getClass_());
  %>
  <div class="row">
      <ul class="nav nav-tabs col-md-8 col-md-offset-2" id="myTab">
          <li class="active">
              <a data-toggle="tab" href="#content1">按班级查看</a>
          </li>
          <li>
              <a data-toggle="tab" href="#content2">按章节查看</a>
          </li>
      </ul>
      <div class="col-md-8 col-md-offset-2 tab-content" id="myTabContent">
          <!--按班级查看-->
          <div class="tab-pane fade in active" id="content1">
              <div class="panel panel-primary" style="margin-top: 40px">
                  <!-- Default panel contents -->
                  <div class="panel-heading text-center panel-heading-style">班级学生</div>
                  <% if(userList.size()==0) {%>
                  <div class="panel-body">
                      <p>班级暂时没有学生，请等待管理员分配</p>
                  </div>
                  <% }  else{                     %>
                  <!-- Table -->
                  <table class="table">
                      <tr>
                          <th>学号</th>
                          <th>姓名</th>
                          <th>班级</th>
                          <th>成绩</th>
                      </tr>
                      <% for (int i=0;i<userList.size();i++) {  %>
                      <tr>
                          <td><%=userList.get(i).getUid()%></td>
                          <td><%=userList.get(i).getName()%></td>
                          <td><%=userList.get(i).getClass_()%></td>
                          <td>10</td>
                      </tr>
                      <% }                                       %>
                  </table>
                  <% } %>
                  <div class="col-md-6" style="margin-top:40px">
                      <div class="panel panel-info">
                          <div class="panel-heading text-left">
                              <h3>各题正确率:</h3>
                          </div>
                          <div class="panel-body">
                              <ul class="progress-ul">
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">1</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">
                                              80%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">2</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">3</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">4</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">5</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">6</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">7</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">8</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">9</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                                  <li>
                                      <div style="width:5%;float:left;margin-right: 10px">
                                          <span class="badge">10</span>
                                      </div>
                                      <div class="progress" style="width: 90%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                              60%
                                          </div>
                                      </div>
                                  </li>
                              </ul>
                          </div>
                      </div>


                  </div>
                  <div class="col-md-6"  style="margin-top: 40px">
                      <div class="panel panel-danger">
                          <div class="panel-heading text-center">
                              <h3>总体正确率</h3>
                          </div>
                          <div class="panel-body" style="padding-top: 115px">
                              <div class="" id="AllStatus"
                                   style="height: 300px; margin-left: 10px;">
                              </div>
                          </div>
                      </div>

                  </div>
                  <script type="text/javascript">

                      // 基于准备好的dom，初始化echarts实例
                      var myChartAllStatus = echarts.init(document
                          .getElementById('AllStatus'));
                      optionA = {
                          title: {
                              text: '测试题目10道',
                              left: 'center'
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
                                  value : 80,
                                  name : '正确'
                              } ,{
                                  value: 25,
                                  name:'错误'
                              }]
                          } ]
                      };

                      myChartAllStatus.setOption(optionA);
                  </script>
              </div>
          </div>
          <!--按章节查看-->
          <div class="tab-pane fade" id="content2">
              <div class="tab-pane fade">
                  <div class="col-md-3 " style="background-color: #2aabd2;height:800px">

                  </div>
              <!--右侧表格显示学生信息-->
              <div class="col-md-8">
                  <div class="panel panel-primary">
                      <!-- Default panel contents -->
                      <div class="panel-heading text-center panel-heading-style">学生测试情况</div>
                      <div class="panel-body">
                          <p>暂时没有学生完成该章节测试</p>
                      </div>

                      <!-- Table -->
                      <table class="table">
                          <tr>
                              <th>学号</th>
                              <th>姓名</th>
                              <th>测试次数</th>
                              <th>测试成绩</th>
                          </tr>
                          <tr>
                              <td>1407064252</td>
                              <td>胖虎</td>
                              <td>2</td>
                              <td>10</td>
                          </tr>
                          <tr>
                              <td>1407064249</td>
                              <td>静香</td>
                              <td>2</td>
                              <td>10</td>
                          </tr>
                      </table>
                  </div>
              </div>
          </div>
      </div>
  </div>
  </body>
</html>