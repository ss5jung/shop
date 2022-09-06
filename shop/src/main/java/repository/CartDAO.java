package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDAO {
	//// 장바구니에 들어있는 상품의 수
	public int selectCartGoodsCnt(Connection conn, String customerId) throws Exception {
		int cnt = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM cart WHERE customer_id=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- stmt selectCartGoodsCnt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
				System.out.println(cnt + "<-- cnt");
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return cnt;
	}

	// 장바구니에 제품이 이미 들어있을 경우 제품 수량
	public int selectGoodsCntInCart(Connection conn, Cart cart) throws Exception {
		// 파라미터
		System.out.println(cart + "<-- cart");
		// 리턴값
		int qty = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT cart_quantity qty FROM cart WHERE goods_no =? and customer_id=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- stmt selectGoodsCntInCart");
			rs = stmt.executeQuery();
			if (rs.next()) {
				qty = rs.getInt("qty");
				System.out.println(qty + "<-- qty");
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return qty;
	}

	// 동일한 제품 장바구니에 있는지 확인
	public int selectGoodsInCartCk(Connection conn, Cart cart) throws Exception {
		// 파라미터
		System.out.println(cart + "<-- cart");
		// 리턴
		int cnt = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM cart WHERE goods_no = ? and customer_id= ? ";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- stmt selectGoodsInCartCk");
			rs = stmt.executeQuery();
			if (rs.next()) {
				if (rs.getInt("cnt") != 0) {
					System.out.println("장바구니에 이미 들어있는 상품입니다.");
					cnt = 1;
				}
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return cnt;
	}

	// C 장바구니 추가
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			// 디버깅
			System.out.println(stmt + "<-- stmt insertCart");
			row = stmt.executeUpdate();
			System.out.println(row + "<-- row");
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;

	}

	// R 장바구니 리스트
	public List<Map<String, Object>> selectCartList(Connection conn, String customerId) throws Exception {
		// 리턴값
		List<Map<String, Object>> cartList = new ArrayList<>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT c.goods_no goodsNo, c.customer_id customerId, c.cart_quantity cartQuantity, c.update_date updateDate, c.create_date createDate, g.goods_name goodsName,  g.goods_price goodsPrice, gi.filename filename FROM cart c INNER JOIN goods g USING(goods_no) INNER JOIN goods_img gi USING(goods_no) WHERE c.customer_id = ?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println(stmt + "<-- stmt selectCartList");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("customerId", rs.getString("customerId"));
				map.put("cartQuantity", rs.getInt("cartQuantity"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("filename", rs.getString("filename"));
				cartList.add(map);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return cartList;
	}

	// U 장바구니 수량 수정
	public int updateCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE cart SET cart_quantity= ? , update_date= NOW() WHERE goods_no= ? AND customer_id = ? ";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getCartQuantity());
			stmt.setInt(2, cart.getGoodsNo());
			stmt.setString(3, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- stmt updateCart");
			row = stmt.executeUpdate();
			System.out.println(row + "<-- row");
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// D 장바구니 삭제
	public int deleteCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM cart WHERE goods_no = ? and customer_id =?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			// 디버깅
			System.out.println(stmt + "<-- stmt deleteCart");
			row = stmt.executeUpdate();
			System.out.println(row + "<-- row");
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;

	}
}
