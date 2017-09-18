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
      List<List<TestContent>> userTestsTid = new ArrayList<>();
      List<Problem> userTestContentPid = new ArrayList<>();

      //获取每个人的测试，并装入list
      for(int i = 0;i < userList.size();i++) {
           List<Test> test = DaoFactory.getTestSerivce().selectTestByUid(userList.get(i).getUid());
           allUserTests.add(test);
      }
  %>
  <div class="row">
      <ul class="nav nav-tabs col-md-6 col-md-offset-3" id="myTab">
          <li class="active">
              <a data-toggle="tab" href="#content1">按班级查看</a>
          </li>
          <li>
              <a data-toggle="tab" href="#content2">按章节查看</a>
          </li>
      </ul>
      <div class="col-md-6 col-md-offset-3 tab-content">
          <!--按班级查看-->
          <div class="tab-pane fade in active" id="content1">
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
                          <th>平均成绩</th>
                      </tr>
                      <% for (int i=0;i<userList.size();i++) {
                          int sum = 0;
                      %>
                      <tr>
                          <td><%=userList.get(i).getUid()%></td>
                          <td>
                              <a href="#<%=userList.get(i).getName()%>" data-toggle="tab">
                                  <%=userList.get(i).getName()%>
                              </a>
                          </td>
                          <td><%=userList.get(i).getClass_()%></td>
                          <%for(int j = 0;j < allUserTests.get(i).size();j++){

                              sum = allUserTests.get(i).get(j).getScore() + sum;
                          }%>
                          <td><%=sum/allUserTests.get(i).size()%></td>
                      </tr>
                      <% }                                       %>
                  </table>
                  <% } %>

              </div>
              <!--左下各人总体正确率-->
              <div class="col-md-6" style="margin-top:40px">
                      <div class="panel panel-info">
                          <div class="panel-heading text-left">
                              <h3>各人总体正确率:</h3>
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
                                          //List<Problem> userProblem = new ArrayList<>();
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
              <!--右下扇形统计图-->
              <div class="col-md-6 tab-content"  style="margin-top: 40px">
                      <%for(int i = 0;i < userList.size();i++){%>
                      <div class="tab-pane fade" id="<%=userList.get(i).getName()%>">
                          <div class="panel panel-danger">
                          <%
                                  int sum = 0;
                                  List<Test> userTest = DaoFactory.getTestSerivce().selectTestByUid(userList.get(i).getUid());
                                  for (int j = 0; j < userTest.size(); j++) {
                                      List<TestContent> userTestContent = DaoFactory.getTestContentService().selectTestContentByTid(userTest.get(j).getTid());
                                      for (int m = 0; m < userTestContent.size(); m++) {
                                          Problem problem = DaoFactory.getProblemService().selectProblemByPid(userTestContent.get(m).getPid());
                                          if (problem.getTrue_option() == userTestContent.get(m).getYour_option()) {
                                              sum++;
                                          }
                                      }
                                  }
                          %>
                              <div class="panel-heading text-center">
                                  <h3><%=userList.get(i).getName()%>做题统计</h3>
                              </div>
                              <div class="panel-body tab-pane fade" style="padding-top: 15px">
                                  <div class="" id="<%=userList.get(i).getUid()%>" style="height: 300px; margin-left: 10px">
                                  </div>
                                  <script type="text/javascript">
                                      var <%="myChartAllStatus"+ userList.get(i).getUid() %> = echarts.init(document
                                          .getElementById('<%=userList.get(i).getUid()%>'));
                                      <%="option"+userList.get(i).getUid()%>={
                                          title: {
                                              text: '测试题目<%=(userTest.size())*10%>道',
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
                                                  value : <%=sum%>,
                                                  name : '正确'
                                              } ,{
                                                  value: <%=userTest.size()*10-sum%>,
                                                  name:'错误'
                                              }]
                                          } ]
                                      };
                                      <%="myChartAllStatus"+ userList.get(i).getUid()%>.setOption(<%="option" + userList.get(i).getUid()%>);
                                  </script>
                              </div>
                          </div>

                      </div>

                  <%}%>
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