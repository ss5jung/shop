package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewDAO {
	//리뷰 작성한 적 있는지 확인
	public int selectReviewCk(Connection conn, String loginId, int goodsNo) throws Exception {
		//리턴값
		int row =0;
		// DB자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM (SELECT * FROM orders WHERE customer_id =? AND goods_no = ?) d inner JOIN review r ON r.order_no = d.order_no";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginId);
			stmt.setInt(2, goodsNo);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt("cnt");
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
		System.out.println(row + "<-- row");
		return row;
	}
	// 리뷰 리스트 : R
	public List<Map<String,Object>> selectReviewList(Connection conn, int goodsNo) throws SQLException{
			//리턴할 객체 생성
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			//DB
			String sql = "SELECT r.order_no orderNo, r.review_content reviewContent, r.star star, r.update_date updateDate, r.create_date createDate, o.customer_id customerId FROM review r INNER JOIN orders o USING (order_no) WHERE o.goods_no = ?";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, goodsNo);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object>  m = new HashMap<String, Object>();
					m.put("orderNo", rs.getInt("orderNo"));
					m.put("star", rs.getInt("star"));
					m.put("reviewContent", rs.getString("reviewContent"));
					m.put("updateDate", rs.getString("updateDate"));
					m.put("createDate", rs.getString("createDate"));
					m.put("customerId", rs.getString("customerId"));
					list.add(m);
				}
			} finally {
				//DB 자원 해제
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			return list;
		}
	
	//리뷰 삭제
	public int deleteReview(Connection conn, int orderNo) throws Exception{
		//리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql ="DELETE FROM review WHERE  order_no=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			System.out.println(stmt + "<-- stmt -deleteReview");
			row = stmt.executeUpdate();
			if(row == 0) {
				System.out.println("리뷰 삭제 실패!");
			}
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
