package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.DBUtil;
import repository.SignDAO;

public class SignService {
	//SignDAO signDAO = new SignDAO(); --> 이 상황에서는 개별적으로 갖는 것보다 멤버변수로 갖는게 더 낫다.
	private SignDAO signDAO;
	/*
	 * 아이디 중복검사 
	 * return : 
	 * true이면 사용가능한 아이디 
	 * false이면 사용불가능한 아이디
	 */
	public Boolean idCheck(String id) throws SQLException {
		//리턴할 변수 선언 및 초기화
		Boolean idCkBoolean = false;
		this.signDAO = new SignDAO();
		Connection conn = null;
		try {
			//DB 연동하기
			conn = new DBUtil().getConnection();
			//DAO에서 처리하도록 전송
			if(signDAO.idCheck(conn, id) == true ) {	//return 함수는 Boolean /Boolean가 true이면
				idCkBoolean = true;	//사용가능하므로 true
			} 
			conn.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
		}finally {
			conn.close();
		}
		System.out.println(idCkBoolean + "<-- SignService.idCheck ");
		return idCkBoolean;
	}
}

