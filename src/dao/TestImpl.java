package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Knowledge;
import bean.Test;

public class TestImpl implements TestDao {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public TestImpl(Connection conn) {
		this.conn = conn;
	}
	
	@Override
	public List<Test> selectAllTest() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Test> selectTestByUid(String uid) throws Exception {
		
		ArrayList<Test> list = new ArrayList<Test>();
		
		String sql = "select * from test where uid = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, uid);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int tid = rs.getInt("tid");
			String name = rs.getString("name");
			int chapter = rs.getInt("chapter");
			int section = rs.getInt("section");
			Date start = rs.getTimestamp("start");
			Date time = rs.getTimestamp("time");
			Date true_time = rs.getTimestamp("true_time");
			int score = rs.getInt("score");
			list.add(new Test(tid, name, uid, chapter, section, start, time, true_time, score));
		}
		
		return list;
	}

	@Override
	public boolean insertTest(Test test) throws Exception {
		
		String sql = "insert into test(name,uid,chapter,section,start,time,true_time,score) values(?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, test.getName());
		pstmt.setString(2, test.getUid());
		pstmt.setInt(3, test.getChapter());
		pstmt.setInt(4, test.getSection());
		pstmt.setTimestamp(5, new Timestamp(test.getStart().getTime()));
		pstmt.setTimestamp(6, new Timestamp(test.getTime().getTime()));
		pstmt.setTimestamp(7, new Timestamp(test.getTrue_time().getTime()));
		pstmt.setInt(8, test.getScore());
		int flag = pstmt.executeUpdate();
		
		if(flag == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateTest(Test test) throws Exception {
		return false;
	}

	@Override
	public boolean deleteTest(Test test) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Test selectTestByName(String name) throws Exception {
		Test test = new Test();
		
		String sql = "select * from test where name = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int tid = rs.getInt("tid");
			String uid = rs.getString("uid");
			int chapter = rs.getInt("chapter");
			int section = rs.getInt("section");
			Date start = rs.getTimestamp("start");
			Date time = rs.getTimestamp("time");
			Date true_time = rs.getTimestamp("true_time");
			int score = rs.getInt("score");
			test = new Test(tid, name, uid, chapter, section, start, time, true_time, score);
		}
		
		return test;
	}

	@Override
	public boolean updateTestScore(Test test) throws Exception {
		String updatesql = "update test "
				+ "set "
				+ "score = ?"
				+ " where tid = ?";
		this.pstmt = this.conn.prepareStatement(updatesql);
		this.pstmt.setInt(1, test.getScore());
		this.pstmt.setInt(2, test.getTid());
		int flag = this.pstmt.executeUpdate();
		if(flag == 1) {
			return true;
		}else {
			return false;
		}
	}

	

}
