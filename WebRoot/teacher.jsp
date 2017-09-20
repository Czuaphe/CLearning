<%@ page language="JAVA" import="java.util.*, factory.DaoFactory, bean.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.RoundingMode" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
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
      List<User> userList= DaoFactory.getUserService().selectUserByClassAndKind(user.getUid(),1);
      List<List<Test>> allUserTests = new ArrayList<>();

      //获取每个人的测试，并装入list
      for(int i = 0;i < userList.size();i++) {
           List<Test> test = DaoFactory.getTestSerivce().selectTestByUid(userList.get(i).getUid());
           allUserTests.add(test);
      }
  %>
  <div class="row">
      <div class="col-md-6 col-md-offset-3">
              <!-- 显示班级所有学生 -->
          <div class="panel panel-primary" style="margin-top: 40px">

                  <div class="panel-heading text-center panel-heading-style">
                      班级学生
                  </div>
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
                          <th>测试次数</th>
                          <th>平均成绩</th>
                      </tr>
                      <% for (int i=0;i<userList.size();i++) {
                          int sum = 0;
                      %>
                      <tr>
                          <td><%=userList.get(i).getUid()%></td>
                          <td>
                              <a href="#<%=userList.get(i).getUid()%>" data-toggle="tab">
                                  <%=userList.get(i).getName()%>
                              </a>
                          </td>
                          <td><%=userList.get(i).getClass_()%></td>
                          <%for(int j = 0;j < allUserTests.get(i).size();j++){

                              sum = allUserTests.get(i).get(j).getScore() + sum;
                          }%>
                          <td><%=allUserTests.get(i).size()%></td>
                          <td><%=sum/allUserTests.get(i).size()%></td>
                      </tr>
                      <% }                                       %>
                  </table>
                  <% } %>

              </div>
              <!--左下各人总体正确率-->
          <div class="col-md-12" style="margin-top:40px">
                      <div class="panel panel-info">
                          <div class="panel-heading text-left">
                              <h3>总体正确率:</h3>
                          </div>
                          <div class="panel-body">
                              <ul class="progress-ul">
                                  <%!
                                      public String accuracy(double num, double total, int scale){
                                      DecimalFormat df = (DecimalFormat) NumberFormat.getInstance();
                                      //可以设置精确几位小数
                                      df.setMaximumFractionDigits(scale);
                                      //模式 例如四舍五入
                                      df.setRoundingMode(RoundingMode.HALF_UP);
                                      double accuracy_num = num / total * 100;
                                      return df.format(accuracy_num)+"%";
                                      }

                                  %>
                                  <%
                                      for(int i = 0;i < userList.size();i++)
                                      {
                                          int sum = 0;
                                          List<Test> userTest = DaoFactory.getTestSerivce().selectTestByUid(userList.get(i).getUid());
                                          for(int j = 0;j < userTest.size();j++)
                                          {
                                              List<TestContent> userTestContent = DaoFactory.getTestContentService().selectTestContentByTid(userTest.get(j).getTid());
                                              for (int m = 0; m < userTestContent.size(); m++) {
                                                  Problem problem = DaoFactory.getProblemService().selectProblemByPid(userTestContent.get(m).getPid());
                                                  if (problem.getTrue_option() == userTestContent.get(m).getYour_option()) {
                                                      sum++;
                                                  }
                                              }
                                          }

                                  %>
                                  <li>
                                      <div style="width:10%;float:left;margin-right: 10px">
                                          <span class="badge"><%=userList.get(i).getName()%></span>
                                      </div>
                                      <div class="progress" style="width: 80%">
                                          <div class="progress-bar" role="progressbar" aria-valuenow=""
                                               aria-valuemin="0" aria-valuemax="100" style="width:<%=accuracy(sum,(userTest.size())*10,1)%>">
                                              <%=accuracy(sum,(userTest.size())*10,1)%>
                                          </div>
                                      </div>
                                  </li>
                                  <%
                                  }%>
                              </ul>
                          </div>
                      </div>
              </div>
              <!--统计图-->
          <div class="col-md-12">
              <div class="tab-content"  style="margin-top: 40px">
                  <%for(int i = 0;i < userList.size();i++){%>
                  <!--<%
                      /*int sum = 0;
                      List<Test> userTest = DaoFactory.getTestSerivce().selectTestByUid(userList.get(i).getUid());
                      for (int j = 0; j < userTest.size(); j++) {
                          List<TestContent> userTestContent = DaoFactory.getTestContentService().selectTestContentByTid(userTest.get(j).getTid());
                          for (int m = 0; m < userTestContent.size(); m++) {
                              Problem problem = DaoFactory.getProblemService().selectProblemByPid(userTestContent.get(m).getPid());
                              if (problem.getTrue_option() == userTestContent.get(m).getYour_option()) {
                                  sum++;
                              }
                          }
                      }*/
                  %>-->
                  <div class="tab-pane fade" id="<%=userList.get(i).getUid()%>" style="height: 400px">
                      <div class="panel panel-success">
                          <div class="panel-heading">
                              <h3><%=userList.get(i).getName()%>的做题情况</h3>
                          </div>
                          <div class="panel-body">
                              <div id="allStatues<%=userList.get(i).getUid()%>"
                                   style="height: 300px; margin-left: 10px;">
                              </div>
                          </div>
                      </div>
                  </div>
                  <script type="text/javascript">
                      require.config({
                          paths: {
                              echarts: 'http://echarts.baidu.com/build/dist'
                          }
                      });
                      require(
                          [
                              'echarts/chart/bar',
                          ],
                          function (ec) {
                              var myChartAllStatus<%=userList.get(i).getUid()%> = ec.init(document
                                  .getElementById('allStatues<%=userList.get(i).getUid()%>'));
                              option<%=userList.get(i).getUid()%> = {
                                  title: {
                                      text: '某学生的正确量和错误量',
                                      subtext: '纯属虚构'
                                  },
                                  tooltip: {
                                      trigger: 'axis'
                                  },
                                  legend: {
                                      data: ['正确量', '错误量']
                                  },
                                  toolbox: {
                                      show: true,
                                      feature: {
                                          mark: {show: true},
                                          dataView: {show: true, readOnly: false},
                                          magicType: {show: true, type: ['line', 'bar']},
                                          restore: {show: true},
                                          saveAsImage: {show: true}
                                      }
                                  },
                                  calculable: true,
                                  xAxis: [
                                      {
                                          type: 'category',
                                          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
                                      }
                                  ],
                                  yAxis: [
                                      {}
                                  ],
                                  series: [
                                      {
                                          name: '正确量',
                                          type: 'bar',
                                          data: [2, 4, 7, 2, 9, 7, 5, 6, 3, 2, 8, 6],
                                          markPoint: {
                                              data: [
                                                  {type: 'max', name: '最大值'},
                                                  {type: 'min', name: '最小值'}
                                              ]
                                          },
                                          markLine: {
                                              data: [
                                                  {type: 'average', name: '平均值'}
                                              ]
                                          }
                                      },
                                      {
                                          name: '错误量',
                                          type: 'bar',
                                          data: [8, 6, 3, 8, 1, 3, 5, 4, 7, 8, 2, 4],
                                          markPoint: {
                                              data: [
                                                  {name: '年最高', value: 9, xAxis: 4, yAxis: 9,},
                                                  {name: '年最低', value: 2, xAxis: 0, yAxis: 2}
                                              ]
                                          },
                                          markLine: {
                                              data: [
                                                  {type: 'average', name: '平均值'}
                                              ]
                                          }
                                      }
                                  ]
                              };
                              myChartAllStatus<%=userList.get(i).getUid()%>.setOption(option<%=userList.get(i).getUid()%>);
                          });
                  </script>
                  <%}%>
              </div>
          </div>

      </div>
  </div>
  </body>
</html>