package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bean.Knowledge;

public class KnowledgeImpl implements KnowledgeDao {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public KnowledgeImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public ArrayList<Knowledge> selectAllKnowledge() throws Exception {
		ArrayList<Knowledge> list = new ArrayList<Knowledge>();
		
		String sql = "select * from knowledge";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int kid = rs.getInt("kid");
			int chapter = rs.getInt("chapter");
			int section = rs.getInt("section");
			String title = rs.getString("title");
			String details = rs.getString("details");
			list.add(new Knowledge(kid, chapter, section, title, details));
		}
		
		return list;
	}

	@Override
	public Knowledge selectKnowledge(int kid) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Knowledge selectKnowledge(int chapter, int section) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateKnowledge(Knowledge knowledge) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean insertKnowledge(Knowledge knowledge) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteKnowledge(Knowledge knowledge) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	
	

}
