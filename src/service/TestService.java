package service;

import java.sql.Connection;
import java.util.List;

import bean.Test;
import dao.TestDao;
import dao.TestImpl;
import dao.UserImpl;
import db.SQLConnection;

public class TestService implements TestDao {

	private Connection conn = SQLConnection.getConnection();
	private TestImpl testImpl = new TestImpl(conn);
	
	@Override
	public List<Test> selectAllTest() throws Exception {
		
		return testImpl.selectAllTest();
	}

	

	@Override
	public boolean insertTest(Test test) throws Exception {
		return testImpl.insertTest(test);
	}

	@Override
	public boolean updateTest(Test test) throws Exception {
		return testImpl.updateTest(test);
	}

	@Override
	public boolean deleteTest(Test test) throws Exception {
		return testImpl.deleteTest(test);
	}



	@Override
	public List<Test> selectTestByUid(String uid) throws Exception {
		return testImpl.selectTestByUid(uid);
	}



	@Override
	public Test selectTestByName(String name) throws Exception {
		
		return testImpl.selectTestByName(name);
	}



	@Override
	public boolean updateTestScore(Test test) throws Exception {
		return testImpl.updateTestScore(test);
	}

}
