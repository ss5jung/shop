package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		//1. 드라이버 연결 
		String url = "jdbc:mariadb://localhost:3306/shop";
		String dbuser = "root";
		String dbpw = "1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		return conn;
	}
}
