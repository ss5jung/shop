package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import repository.DBUtil;
import repository.GoodsDAO;
import repository.NoticeDAO;
import vo.Notice;

public class NoticeService {
	//last 페이지 구하기
	public int getNoticeLastPage(int rowPerPage) throws SQLException {
		int lastPage = 0;
		Connection conn = null;
		try {
			// DB연동
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 - getNoticeLastPage");
			// lastPage
			lastPage = new NoticeDAO().selectNoticeLastPage(conn, rowPerPage);
			System.out.println(lastPage + "lastPage - getNoticeLastPage");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 해제
			if (conn != null) {
				conn.close();
				System.out.println("conn 연결 해제");
			}
		}
		return lastPage;
	}

	
	// 1개의 공지정보 가져오는 메소드
	public Notice getNoticeOne(int noticeNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println(noticeNo + "<-- noticeNo - getNoticeOne");
		// DB driver
		Connection conn = null;
		// 리턴할 값을 담은 Notice 객체 생성
		Notice notice = new Notice();
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getNoticeOne- DB Driver 연결");
			notice = new NoticeDAO().selectNoticeOne(conn, noticeNo);
		} catch (Exception e) {
			// DB 자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return notice;
	}

	// 공지 리스트
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) throws SQLException {
		// 파라미터 디버깅
		System.out.println("getNoticeList >" + rowPerPage + "<-- rowPerPage / " + currentPage + "<-- currentPage");
		// 공지사항 받아올 List 객체 생성
		List<Notice> list = new ArrayList<Notice>();
		// DB driver 연결
		Connection conn = null;
		// beginRow 선언 및 초기화
		int beginRow = (currentPage - 1) * rowPerPage;
		System.out.println(beginRow + "<-- beginRow");
		try {
			conn = new DBUtil().getConnection();
			System.out.println("DB Driver shop 연결");
			list = new NoticeDAO().selectNoticeList(conn, rowPerPage, beginRow);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	}
}
