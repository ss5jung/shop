package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CounterDao {
	//counter 테이블에 날짜 정보 있는지 확인
	public int selectCounterToday(Connection conn) throws Exception {

		// 리턴값
		int today = 0;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM counter WHERE counter_date = (SELECT DATE_FORMAT((SELECT NOW() FROM DUAL), '%Y/%m/%d'));";
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				today = rs.getInt("cnt");
				System.out.println(today + "<-- today 날짜데이터 유무");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return today;
	}

	// 오늘날짜에 카운트가 없으면
	public void insertCounter(Connection conn) throws Exception {
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "INSERT INTO counter (counter_date,counter_num) VALUES ((SELECT DATE_FORMAT((SELECT NOW() FROM DUAL), '%Y/%m/%d')),1)";
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt #insertCounter");
			rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("오늘 첫 방문");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
	}

	// 오늘날짜에 카운트가 기존에 있을 경우
	public void updateCounter(Connection conn) throws Exception {
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE counter SET counter_num = (counter_num +1) WHERE counter_date = (SELECT DATE_FORMAT((SELECT NOW() FROM DUAL), '%Y/%m/%d'))";
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt #updateCounter");
			rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("오늘 방문자 수 + 1");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
	}

	// IndexController에서 호출
	// 전체접속자 수
	public int selectTotalCount(Connection conn) throws SQLException {
		// 리턴값
		int totalCount = 0;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT sum(counter_num) totalCount FROM counter";
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt #selectTotalCount");
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("totalCount");
				System.out.println("총 방문자수 :" + totalCount);
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalCount;
	}

	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) throws SQLException {
		// 리턴값
		int todayCount = 0;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT counter_num todayCount FROM counter WHERE counter_date = (SELECT DATE_FORMAT((SELECT NOW() FROM DUAL), '%Y/%m/%d') today)";
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt #selectTodayCount");
			rs = stmt.executeQuery();
			if (rs.next()) {
				todayCount = rs.getInt("todayCount");
				System.out.println("오늘 방문자수 :" + todayCount);
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return todayCount;
	}
}
