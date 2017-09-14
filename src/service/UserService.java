package service;

import java.sql.Connection;
import java.util.List;

import bean.User;
import dao.UserDao;
import dao.UserImpl;
import db.SQLConnection;

public class UserService implements UserDao{
	
	private Connection conn = SQLConnection.getConnection();
	private UserImpl userImpl = new UserImpl(conn);
	
	@Override
	public User selectUser(String uid, int kind) throws Exception {
		return userImpl.selectUser(uid, kind);
	}

	@Override
	public List<User> selectAllUser() throws Exception {
		return userImpl.selectAllUser();
	}

	@Override
	public List<User> selectUserByClass(String class_) throws Exception {
		return userImpl.selectUserByClass(class_);
	}

	@Override
	public boolean insertUser(User user) throws Exception {
		
		return userImpl.insertUser(user);
	}

	@Override
	public boolean updateUser(User user) throws Exception {
		return userImpl.updateUser(user);
	}

	@Override
	public boolean deleteUser(User user) throws Exception {
		return userImpl.deleteUser(user);
	}

}
