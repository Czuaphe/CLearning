package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Problem;
import bean.TestContent;

public class TestContentImpl implements TestContentDao {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public TestContentImpl(Connection conn) {
		
		this.conn = conn;
	}
	
	@Override
	public ArrayList<bean.TestContent> selectAllTestContent() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<bean.TestContent> selectTestContentByTid(int tid) throws Exception {
		
		ArrayList<TestContent> list = new ArrayList<TestContent>();
		
		String sql = "select * from test_content where tid = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, tid);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int cid = rs.getInt("cid");
			int pid = rs.getInt("pid");
			int your_option= rs.getInt("your_option");
			list.add(new TestContent(cid, tid, pid, your_option ));
		}
		
		return list;
	}

	@Override
	public boolean insertTestContent(bean.TestContent testContent)
			throws Exception {
		
		String sql = "insert into test_content(tid, pid, your_option) values(?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, testContent.getTid());
		pstmt.setInt(2, testContent.getPid());
		pstmt.setInt(3, testContent.getYour_option());
		int flag = pstmt.executeUpdate();
		
		if(flag == 1) {
			return true;
		} else {
			return false;
		}
		
	}

	@Override
	public boolean updateTestContent(bean.TestContent testContent)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteTestContent(bean.TestContent testContent)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<TestContent> selectTestContentByPid(int pid)
			throws Exception {
ArrayList<TestContent> list = new ArrayList<TestContent>();
		
		String sql = "select * from test_content where pid = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pid);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int cid = rs.getInt("cid");
			int tid = rs.getInt("tid");
			int your_option= rs.getInt("your_option");
			list.add(new TestContent(cid, tid, pid, your_option ));
		}
		
		return list;
	}

}
