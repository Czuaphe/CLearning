package factory;

import service.KnowledgeService;
import service.ProblemService;
import service.TestContentService;
import service.TestService;
import service.UserService;

public class DaoFactory {
	
	private static KnowledgeService knowledgeService = new KnowledgeService();
	private static UserService userService = new UserService();
	private static ProblemService problemService = new ProblemService();
	private static TestService testService = new TestService();
	private static TestContentService testContentService = new TestContentService();
	
	public static KnowledgeService getKnowledgeService() {
		return knowledgeService;
	}
	
	public static UserService getUserService() {
		return userService;
	}
	
	public static ProblemService getProblemService() {
		return problemService;
	}
	
	public static TestService getTestSerivce() {
		return testService;
	}
	
	public static TestContentService getTestContentService() {
		return testContentService;
	}

}
