package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDAO {
	//공지사항 추가하기
	public int insertNotice(Connection conn, Notice notice) throws SQLException {
		//리턴할 변수 선언
		int row = 0;
		//파라미터 디버깅
		System.out.println("###NoticeDAO insertNotice"+notice);
		//DB
		PreparedStatement stmt = null;
		String sql = "INSERT INTO notice (notice_title, notice_content, update_date, create_date) VALUES (?, ?, now(), now())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNotice_title());
			stmt.setString(2, notice.getNotice_content());
			row = stmt.executeUpdate();
		} finally {
			//DB자원 해제
			if(stmt != null) {stmt.close();}
		}
		return row;
	}
	// 공지사항 삭제하기
	public int deleteNotice(Connection conn, int noticeNo) throws SQLException {
		//파라미터 디버깅
		System.out.println(noticeNo + "<-- noticeNo - deleteNotice");
		//리턴할 변수 선언
		int row =0;
		//DB 자원 
		PreparedStatement stmt = null;
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
		} finally {
			//DB 자원 해제
			if(stmt !=  null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// NoticeOne 수정하기
	public int updateNotice(Connection conn, Notice notice) throws SQLException {
		System.out.println("###########updateNotice - NoticeDAO");
		// 파라미터 디버깅
		System.out.println(notice);
		// 리턴값 선언
		int row = 0;
		// 객체
		PreparedStatement stmt = null;
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ? WHERE  notice_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNotice_title());
			stmt.setString(2, notice.getNotice_content());
			stmt.setInt(3, notice.getNotice_no());
			System.out.println(stmt + "<-- stmt");
			row= stmt.executeUpdate();
		} finally {
			//DB자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 라스트 페이지
	public int selectNoticeLastPage(Connection conn, int rowPerPage) throws SQLException {
		// 전송된 값 디버깅
		System.out.println(rowPerPage + "<-- rowPerPage");
		// 리턴할 변수 선언 및 초기화
		int lastPage = 0;

		String sql = "SELECT count(*) count FROM notice";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 전체공지의 개수
		int totalCount = 0;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			// 디버깅
			if (rs.next()) {
				totalCount = rs.getInt("count");
				System.out.println(totalCount + "<--totalCount 공지");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		// lastPage 연산 - 올림해서 lastPage구하기
		if(totalCount%rowPerPage == 0) {
			lastPage = totalCount / rowPerPage;
		} else {
			lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
		}
		return lastPage;
	}

	// 1개의 공지정보 가져오는 메소드
	public Notice selectNoticeOne(Connection conn, int noticeNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println(noticeNo + "<-- noticeNo - getNoticeOne");
		// 리턴할 값을 담은 Notice 객체 생성
		Notice notice = new Notice();
		// DB 연동
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate, create_date createDate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			System.out.println(stmt + "<-- stmt - selectNoticeOne");
			rs = stmt.executeQuery();
			if (rs.next()) { // rs가 실행된다면
				// 데이터 셋팅
				notice.setNotice_no(rs.getInt("noticeNo"));
				notice.setNotice_title(rs.getString("noticeTitle"));
				notice.setNotice_content(rs.getString("noticeContent"));
				notice.setUpdate_date(rs.getString("updateDate"));
				notice.setCreate_date(rs.getString("createDate"));
			}
		} finally {
			// DB 자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return notice;
	}

	// 공지 리스트
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		// 파라미터 디버깅
		System.out.println("selectNoticeList >" + rowPerPage + "<-- rowPerPage / " + beginRow + "<-- beginRow");
		// 공지사항 받아올 List 객체 생성
		List<Notice> list = new ArrayList<Notice>();
		// DB자원
		String sql = "SELECT  notice_no noticeNo,  notice_title noticeTitle, create_date createDate FROM notice ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- stmt - selectNoticeList");
			rs = stmt.executeQuery();
			while (rs.next()) {
				// 하나의 공지 사항을 담을 noticer객체 생성
				Notice notice = new Notice();
				// 데이터 셋팅
				notice.setNotice_no(rs.getInt("noticeNo"));
				notice.setNotice_title(rs.getString("noticeTitle"));
				notice.setCreate_date(rs.getString("createDate"));
				// 리스트에 1개의 notice add하기
				list.add(notice);
			}
		} finally {
			// DB자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}
}
