package dao;

import java.util.ArrayList;
import java.util.List;

import bean.TestContent;

public interface TestContentDao {
	
	public ArrayList<TestContent> selectAllTestContent() throws Exception;
	
	public ArrayList<TestContent> selectTestContentByTid(int tid) throws Exception;
	
	public ArrayList<TestContent> selectTestContentByPid(int pid) throws Exception;

	
	public boolean insertTestContent(TestContent testContent) throws Exception;
	
	public boolean updateTestContent(TestContent testContent) throws Exception;
	
	public boolean deleteTestContent(TestContent testContent) throws Exception;
	
}
