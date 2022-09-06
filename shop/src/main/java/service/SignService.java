package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.DBUtil;
import repository.SignDAO;

public class SignService {
	// SignDAO signDAO = new SignDAO(); --> 이 상황에서는 개별적으로 갖는 것보다 멤버변수로 갖는게 더 낫다.
	private SignDAO signDAO;
	private DBUtil dbUtil;
	
	// ajax 버전 아이디 중복검사
	public String getIdCheck(String idck) {
		// 파라미터 디버깅
		System.out.println(idck + "<-- idck - getIdCheck");
		// 리턴할 변수 선언
		String id = null;
		// DB자원
		Connection conn = null;
		try {
			// DB driver 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			this.signDAO = new SignDAO();
			// DAO에서 리턴받은 값 저장
			id = signDAO.selectIdCheck(conn, idck);
		} catch (Exception e) { // 오류가 발생했을 경우
			e.printStackTrace();
			if (conn != null) {
				try {
					conn.rollback(); // rollback하기
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println(id + "<-- id");
		return id;
	}

	// 아이디 중복검사
	public Boolean idCheck(String id) throws SQLException {
		/*
		 * 아이디 중복검사 return : true이면 사용가능한 아이디 false이면 사용불가능한 아이디
		 */
		// 리턴할 변수 선언 및 초기화
		Boolean idCkBoolean = false;
		this.signDAO = new SignDAO();
		Connection conn = null;
		try {
			// DB 연동하기
			conn = new DBUtil().getConnection();
			// DAO에서 처리하도록 전송
			if (signDAO.idCheck(conn, id) == true) { // return 함수는 Boolean /Boolean가 true이면
				idCkBoolean = true; // 사용가능하므로 true
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
		} finally {
			conn.close();
		}
		System.out.println(idCkBoolean + "<-- SignService.idCheck ");
		return idCkBoolean;
	}
}
