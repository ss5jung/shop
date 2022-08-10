package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDAO {
	// ajax 버전 아이디 중복검사
	public String selectIdCheck(Connection conn, String idck) throws SQLException {
		//리턴할 id 체크값
		String id = null;
		//DB자원 생성
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT t.id "
				+ "FROM ("
				+ "SELECT customer_id id FROM customer "
				+ "UNION "
				+ "SELECT employee_id id FROM employee "
				+ "UNION "
				+ "SELECT out_id id FROM outid"
				+ ") t "
				+ "WHERE t.id = ?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, idck);
			System.out.println(stmt + "<-- stmt - selectIdCheck");
			
			rs = stmt.executeQuery();
			if(rs.next()){
				System.out.println(rs + "<-- rs 실행됨");
				id = rs.getString("t.id");
			}
		} finally {
			//DB자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		System.out.println(id + "<-- id중복 확인값");
		return id; // 사용가능한 아이디면 null 반환
	}

	// 아이디 중복검사
	public Boolean idCheck(Connection conn, String id) throws SQLException {
		System.out.println(id + "<--id DAO");
		Boolean idCkBoolean = false;
		/*
		 * SELECT * FROM (SELECT customer_id id FROM customer UNION SELECT employee_id
		 * id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ? --> null
		 * 일때 사용가능한 아이디
		 */
		String sql = "SELECT * FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id =  ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		System.out.println(stmt + "<-- SignDAO.stmt ");
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + "<-- SignDAO.rs ");
		if (rs.next()) { // rs가 실행되면 사용중인 아이디
			System.out.println("DAO 사용중인 아이디입니다.");
			idCkBoolean = false;
			rs.close();
		} else { // rs가 실행되지 않아야 사용가능한 아이디
			System.out.println("DAO 사용가능한 아이디입니다.");
			idCkBoolean = true;
		}
		System.out.println(idCkBoolean + "<-- SignDAO.idCheck ");
		return idCkBoolean;
	}
}
