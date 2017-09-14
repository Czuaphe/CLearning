package dao;

import java.util.List;

import bean.Problem;

public interface ProblemDao {
	
	public List<Problem> selectAllProblem() throws Exception;
	
	public Problem selectProblemByPid(int pid) throws Exception;
	
	public boolean insertProblem(Problem problem) throws Exception;
	
	public boolean updateProblem(Problem problem) throws Exception;
	
	public boolean deleteProblem(Problem problem) throws Exception;
	
}
