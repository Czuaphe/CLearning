package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import factory.DaoFactory;

public class ClassServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ClassServlet() {
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

		HttpSession session = request.getSession();
		String method = request.getParameter("Method");
		
		if(method.equals("insert")) {
			insert(request, response);
		} else if(method.equals("update")) {
			try {
				update(request, response);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		} else if(method.equals("delete")){
			try {
				delete(request, response);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
	
	}

	private void insert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String className = request.getParameter("className");
		String classTeacher = request.getParameter("classTeacher");
		String[] classStudents = request.getParameterValues("classStudents[]");
		
		// 更新老师信息
		User teacher = new User();
		try {
			teacher = DaoFactory.getUserService().selectUser(classTeacher, 2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		teacher.setClass_(className);
		boolean flag = false;
		try {
			flag = DaoFactory.getUserService().updateUser(teacher);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 更新学生信息
		for(int i = 0; i < classStudents.length; i ++) {
			User student = new User();
			try {
				student = DaoFactory.getUserService().selectUser(classStudents[i], 1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			student.setClass_(className);
			boolean flag_student = false;
			try {
				flag_student = DaoFactory.getUserService().updateUser(student);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		if(flag) {
			response.sendRedirect("root.jsp");
		}
		
		
		
		
	}
	
	private void update(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		boolean flag = true;   // 标志位，表示更新数据是否成功
		// 要修改的班级的名字
		String className = request.getParameter("className");
		// 新老师的UID
		String classTeacher = request.getParameter("classTeacher");
		// 修改之后的所有学生UID
		String[] classStudents = request.getParameterValues("classStudents[]");
		
		// 首先，通过className找到原来的老师和原来的所有学生
		List<User> oldStudents = DaoFactory.getUserService().selectUserByClassAndKind(className, 1);
		User oldTeacher = DaoFactory.getUserService().selectUserByClassAndKind(className, 2).get(0);
		
		// 然后，修改新旧老师信息并更新
			// 找到新老师的对象并修改class，更新
		User newTeacher = DaoFactory.getUserService().selectUser(classTeacher, 2);
		newTeacher.setClass_(className);
		flag = flag && DaoFactory.getUserService().updateUser(newTeacher);
			// 修改旧老师的class为null，更新
		oldTeacher.setClass_("0");
		flag = flag && DaoFactory.getUserService().updateUser(oldTeacher);
		
		// 最后，修改新旧学生的信息
			// 通过新学生的UID找到所有的新学生对象
		List<User> newStudents = new ArrayList<>();
		for(int i = 0; i < classStudents.length; i ++) {
			newStudents.add(DaoFactory.getUserService().selectUser(classStudents[i], 1));
		}
			// 将新旧学生List中相同的部分去掉，因为相同的不需要修改
		for(int i = 0; i < oldStudents.size(); i ++) {
			for(int j = 0; j < newStudents.size(); j ++) {
				// i -- 是因为oldStudents删除第i项后，第i+1项就变成了第i项，所以第i项需要重新测试
				if(oldStudents.get(i).getUid() == newStudents.get(j).getUid()) {
					oldStudents.remove(i);
					newStudents.remove(j);
					i --;
					break;
				}
			}
		}
			// 将旧学生List中剩余的数据的class置空，更新
		for(User user : oldStudents) {
			user.setClass_("0");
			flag = flag && DaoFactory.getUserService().updateUser(user);
		}
			// 将新学生List中剩余的数据的class改为className，更新
		for(User user : newStudents) {
			user.setClass_(className);
			flag = flag && DaoFactory.getUserService().updateUser(user);
		}
		
		// 根据flag的值决定跳转
		response.sendRedirect("root.jsp");
		if(flag) {
			
		} else {
			response.sendRedirect("error.jsp");
		}
		
		
	}
	
	private void delete(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		boolean flag = true;
		// 要删除的班级的名字
		String className = request.getParameter("className");
		// 首先，通过className找到原来的老师和原来的所有学生
		List<User> oldStudents = DaoFactory.getUserService().selectUserByClassAndKind(className, 1);
		User oldTeacher = DaoFactory.getUserService().selectUserByClassAndKind(className, 2).get(0);
		// 然后，将学生和老师的class置为0，更新
		for(User user : oldStudents) {
			user.setClass_("0");
			flag = flag && DaoFactory.getUserService().updateUser(user);
		}
		oldTeacher.setClass_("0");
		flag = flag && DaoFactory.getUserService().updateUser(oldTeacher);
		
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
		out.println("delete");
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
