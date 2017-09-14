package dao;

import java.util.List;

import bean.User;

public interface UserDao {
		
	public User selectUser(String uid, int kind) throws Exception;
	
	public List<User> selectAllUser() throws Exception;

	public List<User> selectUserByClass(String class_) throws Exception;
	
	
	
	public boolean insertUser(User user) throws Exception;
	
	public boolean updateUser(User user) throws Exception;
	
	public boolean deleteUser(User user) throws Exception;
	
	
	
}
