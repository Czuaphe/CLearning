package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.User;

public class UserImpl implements UserDao {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	public UserImpl(Connection conn) {
		this.conn = conn;
	}
	
	@Override
	public User selectUser(String uid, int kind) throws Exception {
		
		String sql = "select * from user where uid = ? && kind = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, uid);
		pstmt.setInt(2, kind);
		ResultSet rs = pstmt.executeQuery();
		if(!rs.next()) {
			return null;
		}
		String name = rs.getString("name");
		String pswd = rs.getString("pswd");
		String class_ = rs.getString("class");
		
		return new User(uid, name, pswd, kind, class_);
	}

	@Override
	public List<User> selectAllUser() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> selectUserByClass(String class_) throws Exception {
		List<User> list = new ArrayList<>();
		String sql = "select * from user where class = ? && kind =1";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,class_);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			String uid = rs.getString("uid");
			String name = rs.getString("name");
			int kind = rs.getInt("kind");
			String pswd = rs.getString("pswd");
			list.add(new User(uid,name,pswd,kind,class_));
		}
		return list;
	}
	
	@Override
	public List<User> selectUserByKind(int kind) throws Exception {
		List<User> list = new ArrayList<>();
		String sql = "select * from user where kind = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, kind);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			String uid = rs.getString("uid");
			String name = rs.getString("name");
			String class_ = rs.getString("class");
			String pswd = rs.getString("pswd");
			list.add(new User(uid,name,pswd,kind,class_));
		}
		return list;
	}
	
	@Override
	public boolean insertUser(User user) throws Exception {
		
		String sql = "insert into user(uid,name,pswd,kind) values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user.getUid());
		pstmt.setString(2, user.getName());
		pstmt.setString(3, user.getPswd());
		pstmt.setInt(4, user.getKind());
		int flag = pstmt.executeUpdate();
		
		if(flag == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	

}
