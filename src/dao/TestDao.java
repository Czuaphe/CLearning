package dao;

import java.util.List;

import bean.Test;

public interface TestDao {
	
	public List<Test> selectAllTest() throws Exception ;
	
	public List<Test> selectTestByUid(String uid) throws Exception;
	
	public Test selectTestByName(String name) throws Exception;
	
	public boolean insertTest(Test test) throws Exception;
	
	public boolean updateTest(Test test) throws Exception;
	
	public boolean updateTestScore(Test test) throws Exception;
	
	public boolean deleteTest(Test test) throws Exception;
}
