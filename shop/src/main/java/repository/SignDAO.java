package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDAO {
	//아이디 중복검사
	public Boolean idCheck(Connection conn, String id) throws SQLException {
		System.out.println(id+"<--id DAO");
		Boolean idCkBoolean = false;
		/*
		 SELECT *
		 FROM (SELECT customer_id id FROM customer
		 		UNION
		 		SELECT employee_id id FROM employee
		 		UNION
		 		SELECT out_id id FROM outid) 
		 		t
		 WHERE t.id = ?
		--> null 일때 사용가능한 아이디
		*/
		String sql="SELECT * FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id =  ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		System.out.println(stmt + "<-- SignDAO.stmt ");
		ResultSet rs = stmt.executeQuery();	
		System.out.println(rs + "<-- SignDAO.rs ");
		if(rs.next()) {	//rs가 실행되면 사용중인 아이디
			System.out.println("DAO 사용중인 아이디입니다.");
			idCkBoolean = false;
			rs.close();
		} else {		//rs가 실행되지 않아야 사용가능한 아이디
			System.out.println("DAO 사용가능한 아이디입니다.");
			idCkBoolean = true;
		}
		System.out.println(idCkBoolean + "<-- SignDAO.idCheck ");
		return idCkBoolean;
	}
}
