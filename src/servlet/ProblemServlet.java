package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import factory.DaoFactory;
import bean.Problem;

public class ProblemServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ProblemServlet() {
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
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
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
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		String pid = request.getParameter("pid");
		String chapter = request.getParameter("chapter");
		String title = request.getParameter("title");
		title = new String(title.getBytes("iso-8859-1"),"utf-8");
		String option1 = request.getParameter("option1");
		option1 = new String(option1.getBytes("iso-8859-1"),"utf-8");
		String option2 = request.getParameter("option2");
		option2 = new String(option2.getBytes("iso-8859-1"),"utf-8");
		String option3 = request.getParameter("option3");
		option3 = new String(option3.getBytes("iso-8859-1"),"utf-8");
		String option4 = request.getParameter("option4");
		option4 = new String(option4.getBytes("iso-8859-1"),"utf-8");
		String true_option = request.getParameter("true_option");
		
		Problem problem = new Problem(Integer.valueOf(pid), "", 0, Integer.valueOf(chapter), 0, title, option1, option2, option3, option4, Integer.valueOf(true_option));
		
		boolean flag = false;
		
		try {
			flag = DaoFactory.getProblemService().updateProblem(problem);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(flag) {
			response.sendRedirect("root.jsp");
		} else {
			response.sendRedirect("error.jsp");
		}
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.println(problem.getTitle());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
