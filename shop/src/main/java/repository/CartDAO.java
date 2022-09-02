package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vo.Cart;

public class CartDAO {
	// C 장바구니 추가
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoods_no());
			stmt.setString(2, cart.getCustomer_id());
			stmt.setInt(3, cart.getCart_quantity());
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
	public List<Cart> selectCartList(Connection conn, Cart cart) throws Exception {
		// 리턴값
		List<Cart> cartList = new ArrayList<Cart>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT goods_no goodsNo, customer_id customerId, cart_quantity cartQuantity, update_date updateDate, create_date createDate FROM cart WHERE customer_id=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cart.getCustomer_id());
			// 디버깅
			System.out.println(stmt + "<-- stmt selectCartList");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Cart getCart = new Cart();
				getCart.setGoods_no(rs.getInt("goodsNo"));
				getCart.setCustomer_id(rs.getString("customerId"));
				getCart.setCart_quantity(rs.getInt("cartQuantity"));
				getCart.setUpdateDate(rs.getString("updateDate"));
				getCart.setCreateDate(rs.getString("createDate"));
				cartList.add(getCart);
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
			stmt.setInt(1, cart.getCart_quantity());
			stmt.setInt(2, cart.getGoods_no());
			stmt.setString(3, cart.getCustomer_id());
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
			stmt.setInt(1, cart.getGoods_no());
			stmt.setString(2, cart.getCustomer_id());
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
