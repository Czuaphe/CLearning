package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import factory.DaoFactory;

public class SignupServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public SignupServlet() {
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

		//response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String signupStatus = new String("");
		User user = new User();
		boolean flag = false;
		
		String kind = (String) request.getParameter("kind");
		String uid = (String) request.getParameter("uid");
		String name = (String) request.getParameter("name");
		name = new String(name.getBytes("iso-8859-1"),"utf-8");
		String pswd = (String) request.getParameter("pswd");
		String pswd_again = (String) request.getParameter("pswd_again");
		
		// 首先，判断用户是否存在，然后，判断两次密码是否相同，最后，插入用户
		
		try {
			user = DaoFactory.getUserService().selectUser(uid, Integer.parseInt(kind));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(user != null) {
			signupStatus = "HadUser";
		} else if(!pswd.equals(pswd_again)) {
			signupStatus = "PswdNotSame";
		} else {
			
			user = new User(uid, name, pswd, Integer.parseInt(kind));
			try {
				flag = DaoFactory.getUserService().insertUser(user);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
		if(signupStatus.equals("")) {
			if(flag) {
				signupStatus = "Success";
			} else {
				signupStatus = "Fail";
			}
		}
		
		session.setAttribute("signupStatus", signupStatus);
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.println(signupStatus);
		out.println(user.getName());
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
