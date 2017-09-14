package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import factory.DaoFactory;
import bean.Problem;
import bean.Test;
import bean.TestContent;
import bean.User;

public class TestServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TestServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// 获得用户信息
		User user = (User) session.getAttribute("user");
		// 获得题目pid
		@SuppressWarnings("unchecked")
		List<Integer> list_pid = (List<Integer>) session
				.getAttribute("list_pid");
		// 获得答案
		String[] values = new String[10];
		for (int i = 0; i < values.length; i++) {
			values[i] = request.getParameter("question_" + i);
		}
		// 获得测试的开始时间
		Date start = (Date) session.getAttribute("start");
		// 获得测试的结束时间
		Date end = new Date();
		// 设置理论结束时间
		Date time = new Date();
		time.setMinutes(20);
		time.setSeconds(0);
		// 计算测试的实际时间
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		String time_end = formatter.format(end);
		String time_start = formatter.format(start);
		// 分隔成字符串数组
		String[] num_end = time_end.split(":");
		String[] num_start = time_start.split(":");
		// 计算总秒数
		long sum_start = Integer.valueOf(num_start[0]) * 3600
				+ Integer.valueOf(num_start[1]) * 60
				+ Integer.valueOf(num_start[2]);
		long sum_end = Integer.valueOf(num_end[0]) * 3600
				+ Integer.valueOf(num_end[1]) * 60
				+ Integer.valueOf(num_end[2]);
		;
		// 测试经历的时间，几分，几秒
		int minutes = (int) ((sum_end - sum_start) / 60);
		int seconds = (int) ((sum_end - sum_start) % 60);
		// 包装成Date类
		Date true_time = new Date();
		true_time.setMinutes((int) minutes);
		true_time.setSeconds(seconds);

		// 通过用户uid找到用户以前的测试次数，生成本次测试的测试名
		String testName = new String();
		try {
			List<Test> tests = DaoFactory.getTestSerivce().selectTestByUid(
					user.getUid());
			testName = "Test" + (tests.size() + 1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 插入测试表
		int score = 0;
		Test test = new Test(-1, testName, user.getUid(), -1, -1, start, time,
				true_time, score);
		boolean flag_test = false;
		try {
			flag_test = DaoFactory.getTestSerivce().insertTest(test);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 得到本次测试的tid
		try {
			test = DaoFactory.getTestSerivce().selectTestByName(testName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int tid = test.getTid();
		// 计算得分，并插入测试内容表
		boolean flag_content = false;
		for (int i = 0; i < list_pid.size(); i++) {
			int pid = list_pid.get(i);
			int your_option = Integer.valueOf(values[i]);
			try {
				flag_content = DaoFactory.getTestContentService().insertTestContent(new TestContent(-1, tid, pid, your_option));
				if(!flag_content) {
					break;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 找到对应题目的正确选项，比较结果，最后加分
			try {
				Problem problem = DaoFactory.getProblemService().selectProblemByPid(pid);
				if(problem.getTrue_option() == your_option) {
					score += problem.getScore();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 将得分更新到Test表
		test.setScore(score);
		try {
			flag_test = DaoFactory.getTestSerivce().updateTestScore(test);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		// 跳转网页
		if (flag_test) {
			// 返回得分，到test_result.jsp
			session.setAttribute("score", score);
			response.sendRedirect("test_result.jsp");
		} else {
			response.sendRedirect("test_error.jsp");
		}

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		for (int pid : list_pid)
			out.println(pid);
		for (String value : values)
			out.println(value);
		out.println(start.toLocaleString());
		out.println(end.toLocaleString());
		out.println(true_time.toLocaleString());
		out.println("<br>");
		out.println(tid);
		out.println(testName);
		out.println(flag_test);
		out.println(score);
		//out.println(flag_content);
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
