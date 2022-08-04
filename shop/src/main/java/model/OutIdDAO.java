package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OutIdDAO {
	//삭제한 데이터 백업
	//CusetomerServie 실행시 
	public int insertOutId( Connection conn, String customerId ) throws SQLException {
		int row = 0;
		//백업할 아이디 insert sql
		String sql = "INSERT INTO outid (out_id, out_date) VALUES (?, now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		System.out.println(stmt+"<--stmt - insertOutId실행");
		
		row = stmt.executeUpdate();
		System.out.println(row+"<--row - insertOutId실행");
	
		return row;
	}
}
