package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class SQLConnection  {
	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/clearning";
	private static final String USER = "root";
	private static final String PASSWORD = "0509";
	
	private static Connection con = null;
	
	public static void connection() {
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
		
	}
	
	public static boolean isConnection() {
		
		return con == null ? false : true;
	}
	
	public static Connection getConnection() {
		if(!isConnection()) {  
			connection();  
		} 
		return con;
	}
	
	public static void close() {
		try {
			
			con.close();
			
		} catch (SQLException e) {
		
			e.printStackTrace();
			
		}
	}
}
