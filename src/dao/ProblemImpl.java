package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Knowledge;
import bean.Problem;
import bean.Test;

public class ProblemImpl implements ProblemDao{

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public ProblemImpl(Connection conn) {
		this.conn = conn;
	}
	
	@Override
	public List<Problem> selectAllProblem() throws Exception {
		ArrayList<Problem> list = new ArrayList<Problem>();
		
		String sql = "select * from problem";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int pid = rs.getInt("pid");
			String name = rs.getString("name");
			int score = rs.getInt("score");
			int chapter = rs.getInt("chapter");
			int section = rs.getInt("section");
			String title = rs.getString("title");
			String option1 = rs.getString("option1");
			String option2 = rs.getString("option2");
			String option3 = rs.getString("option3");
			String option4 = rs.getString("option4");
			int true_option = rs.getInt("true_option");
			list.add(new Problem(pid, name, score, chapter, section, title, option1, option2, option3, option4, true_option));
		}
		
		return list;
	}

	@Override
	public Problem selectProblemByPid(int pid) throws Exception {
		Problem problem = new Problem();
		
		String sql = "select * from problem where pid = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pid);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			
			String name = rs.getString("name");
			int score = rs.getInt("score");
			int chapter = rs.getInt("chapter");
			int section = rs.getInt("section");
			String title = rs.getString("title");
			String option1 = rs.getString("option1");
			String option2 = rs.getString("option2");
			String option3 = rs.getString("option3");
			String option4 = rs.getString("option4");
			int true_option = rs.getInt("true_option");
			problem = new Problem(pid, name, score, chapter, section, title, option1, option2, option3, option4, true_option);
		}
		
		return problem;
	}

	@Override
	public boolean insertProblem(Problem problem) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateProblem(Problem problem) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteProblem(Problem problem) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	
	
}
