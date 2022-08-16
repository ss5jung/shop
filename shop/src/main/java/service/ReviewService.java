package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.ReviewDAO;

public class ReviewService {
	//리뷰 리스트 : R
	public List<Map<String,Object>> getReviewList(int goodsNo) throws SQLException{
		//리턴할 객체 생성
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		//DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getReviewList DB 연결");
			list = new ReviewDAO().selectReviewList(conn, goodsNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//DB 자원해제
			if(conn != null) {
				conn.close();
			}
		}
		return list;
	}
	//리뷰 삭제 : D
}
