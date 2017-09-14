package service;

import java.sql.Connection;
import java.util.List;

import bean.Problem;
import dao.ProblemDao;
import dao.ProblemImpl;
import db.SQLConnection;

public class ProblemService implements ProblemDao {

	private Connection conn = SQLConnection.getConnection();
	private ProblemImpl problemImpl = new ProblemImpl(conn);
	
	@Override
	public List<Problem> selectAllProblem() throws Exception {
		
		return problemImpl.selectAllProblem();
	}

	@Override
	public Problem selectProblemByPid(int pid) throws Exception {
		
		return problemImpl.selectProblemByPid(pid);
	}

	@Override
	public boolean insertProblem(Problem problem) throws Exception {
		
		return problemImpl.insertProblem(problem);
	}

	@Override
	public boolean updateProblem(Problem problem) throws Exception {
		
		return problemImpl.updateProblem(problem);
	}

	@Override
	public boolean deleteProblem(Problem problem) throws Exception {
		
		return problemImpl.deleteProblem(problem);
	}

}
