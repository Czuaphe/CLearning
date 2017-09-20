package service;

import java.sql.Connection;
import java.util.ArrayList;

import bean.Knowledge;
import dao.KnowledgeDao;
import dao.KnowledgeImpl;
import db.SQLConnection;

public class KnowledgeService implements KnowledgeDao{
	private Connection conn = SQLConnection.getConnection();
	private KnowledgeImpl knowledgeImpl = new KnowledgeImpl(conn);
	
	@Override
	public ArrayList<Knowledge> selectAllKnowledge() throws Exception {
		
		return knowledgeImpl.selectAllKnowledge();
	}

	@Override
	public ArrayList<Knowledge> selectSectionIsZero() throws Exception {

		return knowledgeImpl.selectSectionIsZero();
	}

	@Override
	public Knowledge selectKnowledge(int kid) throws Exception {
		
		return knowledgeImpl.selectKnowledge(kid);
	}

	@Override
	public Knowledge selectKnowledge(int chapter, int section) throws Exception  {
		
		return knowledgeImpl.selectKnowledge(chapter, section);
	}

	@Override
	public boolean updateKnowledge(Knowledge knowledge) throws Exception  {
		
		return knowledgeImpl.updateKnowledge(knowledge);
	}

	@Override
	public boolean insertKnowledge(Knowledge knowledge) throws Exception  {
		
		return knowledgeImpl.insertKnowledge(knowledge);
	}

	@Override
	public boolean deleteKnowledge(Knowledge knowledge) throws Exception  {
		
		return knowledgeImpl.deleteKnowledge(knowledge);
	}

}
