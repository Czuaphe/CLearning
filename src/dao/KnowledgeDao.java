package dao;

import java.util.ArrayList;

import bean.Knowledge;

public interface KnowledgeDao {
	
	public ArrayList<Knowledge> selectAllKnowledge() throws Exception;
	
	public Knowledge selectKnowledge(int kid) throws Exception;
	
	public Knowledge selectKnowledge(int chapter, int section) throws Exception;
	
	public boolean updateKnowledge(Knowledge knowledge) throws Exception;
	
	public boolean insertKnowledge(Knowledge knowledge) throws Exception;
	
	public boolean deleteKnowledge(Knowledge knowledge) throws Exception;
	
	
}
