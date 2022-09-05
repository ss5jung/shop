package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.ReviewDAO;
import vo.Review;

public class ReviewService {
	private DBUtil dbUtil;
	private ReviewDAO reviewDAO;

	// 리뷰 하나
	public Review getReviewOne(int orderNo) throws SQLException {
		// 리턴할 객체 생성
		Review review = new Review();
		// DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getReviewList DB 연결");
			review = new ReviewDAO().selectReviewOne(conn, orderNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return review;
	}

	// 리뷰 작성여부
	public int getReviewCk(int orderNo) throws Exception {
		// 리턴값
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getReviewCk DB 연결");
			row = new ReviewDAO().selectReviewCk(conn, orderNo); // 리뷰가 작성되어 있으면 1 없으면 0
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		System.out.println("리뷰 작성 여부 row --> " + row);
		return row;
	}

	// 리뷰 작성
	public int addReview(Review review) {
		// 리턴값
		int row = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		reviewDAO = new ReviewDAO();
		try {
			conn = dbUtil.getConnection();
			System.out.println("addReview DB 연결 성공");
			// DAO call
			row = reviewDAO.insertReview(conn, review);
			// 디버깅
			if (row != 0) {
				System.out.println("리뷰 작성 성공!");
			} else {
				System.out.println("리뷰 작성 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 해제
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 리뷰 리스트 : R
	public List<Map<String, Object>> getReviewList(int goodsNo) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getReviewList DB 연결");
			list = new ReviewDAO().selectReviewList(conn, goodsNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	}

	// 리뷰 수정
	public int modifyReview(Review review) {
		// 리턴값
		int row = 0;
		Connection conn = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			System.out.println("modifyReview DB 연결 성공");
			reviewDAO = new ReviewDAO();
			row = reviewDAO.updateReview(conn, review);
			// 디버깅
			if (row != 0) {
				System.out.println("리뷰 수정 성공!");
			} else {
				System.out.println("리뷰 수정 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 해제
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// 리뷰 삭제 : D
	public int removeReview(int orderNo) throws Exception {
		// 리턴값
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("removeReview DB 연결");
			row = new ReviewDAO().deleteReview(conn, orderNo);
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	}
}
