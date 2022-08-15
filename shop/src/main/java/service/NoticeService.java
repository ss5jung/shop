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

	// 공지사항 추가하기
	public int insertNotice(Notice notice) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// 파라미터 디버깅
		System.out.println("########insertNotice" + notice);
		// DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("insertNotice DB 연결");
			// DAO
			row = new NoticeDAO().insertNotice(conn, notice);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	}

	// 공지사항 삭제
	public int deleteNotice(int noticeNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println(noticeNo + "<-- noticeNo -deleteNotice NoticeService");
		// DB연결
		Connection conn = null;
		// 리턴할 변수 선언
		int row = 0;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("deleteNotice Driver 연동 성공");
			row = new NoticeDAO().deleteNotice(conn, noticeNo);
		} catch (Exception e) {
			// 오류 보여주기
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	}

	// NoticeOne 수정하기
	public int setNotice(Notice notice) {
		System.out.println("###########setNotice - NoticeService");
		// 파라미터 디버깅
		System.out.println(notice);
		// 리턴값 변수 선언
		int row = 0;
		// 객체 선언
		Connection conn = null;
		try {
			// 2. DB 연결
			conn = new DBUtil().getConnection();
			System.out.println("DB 연결 성공");
			// DAO에서 리턴 값 받아오기
			row = new NoticeDAO().updateNotice(conn, notice);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
		return row;
	}

	// last 페이지 구하기
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
