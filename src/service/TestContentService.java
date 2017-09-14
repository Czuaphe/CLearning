package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import bean.TestContent;
import dao.TestContentDao;
import dao.TestContentImpl;
import dao.UserImpl;
import db.SQLConnection;

public class TestContentService implements TestContentDao {

	private Connection conn = SQLConnection.getConnection();
	private TestContentImpl testContentImpl = new TestContentImpl(conn);
	
	@Override
	public ArrayList<TestContent> selectAllTestContent() throws Exception {
		return testContentImpl.selectAllTestContent();
	}

	@Override
	public ArrayList<TestContent> selectTestContentByTid(int tid) throws Exception {
		return testContentImpl.selectTestContentByTid(tid);
	}

	@Override
	public boolean insertTestContent(TestContent testContent) throws Exception {
		return testContentImpl.insertTestContent(testContent);
	}

	@Override
	public boolean updateTestContent(TestContent testContent) throws Exception {
		return testContentImpl.updateTestContent(testContent);
	}

	@Override
	public boolean deleteTestContent(TestContent testContent) throws Exception {
		return testContentImpl.deleteTestContent(testContent);
	}

	@Override
	public ArrayList<TestContent> selectTestContentByPid(int pid)
			throws Exception {
		
		return testContentImpl.selectTestContentByPid(pid);
	}

}
