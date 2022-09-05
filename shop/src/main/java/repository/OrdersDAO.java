package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;

public class OrdersDAO {

	// 주문 취소(삭제)
	public int deleteOrder(Connection conn, int orderNo) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM orders WHERE  order_no = ? AND (order_state='결제대기' OR order_state='주문완료')";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println(stmt + "<-- stmt - deleteOrder");
			row = stmt.executeUpdate();
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 주문하기
	public int insertOrder(Connection conn, Orders order) throws Exception {
		// 리턴값
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO orders (goods_no, customer_id, order_quantity, order_price, order_addr, order_state, update_date, create_date) VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, order.getGoodsNo());
			stmt.setString(2, order.getCustomerId());
			stmt.setInt(3, order.getOrderQuantity());
			stmt.setInt(4, order.getOrderPrice());
			stmt.setString(5, order.getOrderAddr());
			stmt.setString(6, order.getOrderState());
			// 디버깅
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 특정 상품을 고객1이 구매한 적이 있는지 확인 -> 리뷰 작성
	public int selectOrderCk(Connection conn, String customerId, int goodsNo) throws Exception {
		// 리턴값
		int orderNo = 0;
		// 아이디가 null값이면 예외처리
		if (customerId == null) {
			System.out.println("고객아이디가 null값입니다.");
			throw new Exception();
		}
		// DB자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT order_no orderNo FROM orders WHERE goods_no = ? AND customer_id = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			stmt.setString(2, customerId);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				orderNo = rs.getInt("orderNo");
				if (orderNo == 0) {
					System.out.println("주문내역이 없습니다.");
					throw new Exception();
				}
				System.out.println(orderNo + "<-- orderNo");
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
		return orderNo;
	}

	// 고객1의 주문 내역
	public List<Map<String, Object>> selectCustomerOrdersList(Connection conn, String customerId) throws SQLException {
		// 파라미터 디버깅
		System.out.println(customerId + "<-- customerId - selectCustomerOrdersList");
		// DAO에서 주문내역을 받아올 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT  c.customer_id cutomerId, o.order_no orderNo, g.goods_name goodsName, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState, c.customer_name customerName, c.customer_telephone customerTelephone, o.create_date createDate FROM orders o INNER JOIN goods g USING (goods_no) INNER JOIN customer c USING (customer_id) WHERE o.customer_id = ? ORDER BY o.create_date DESC";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			while (rs.next()) { // rs가 실행된다면
				// 1개의 주문내역을 넣을 Map 객체 생성
				Map<String, Object> map = new HashMap<>();
				// 데이터 셋팅하기
				map.put("cutomerId", rs.getString("cutomerId"));
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderTotalPrice", rs.getInt("orderPrice") * rs.getInt("orderQuantity"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("orderState", rs.getString("orderState"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				map.put("createDate", rs.getString("createDate"));
				list.add(map);
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

	// 주문 수정 - 고객버전
	public int updateOrderByCustomer(Connection conn, Orders order) throws SQLException {
		// 리턴할 변수
		int row = 0;
		// DB 자원 생성
		PreparedStatement stmt = null;
		String sql = "UPDATE orders SET order_quantity = ? WHERE  order_no = ? AND (order_state='결제대기' OR order_state='주문완료')";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, (int) order.getOrderQuantity());
			stmt.setInt(2, (int) order.getOrderNo());
			System.out.println(stmt + "<-- stmt - updateOrderByCustomer");
			row = stmt.executeUpdate();
			System.out.println(row + "<-- updateOrderByCustomer에서 실행된 row의 수");
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 주문 내역 수정하기 - 직원버전
	public int insertOrdersOne(Connection conn, Map<String, Object> map) throws SQLException {
		// 리턴할 변수
		int row = 0;
		// DB 자원 생성
		PreparedStatement stmt = null;
		String sql = "UPDATE orders "
				+ "SET goods_no = ?, order_addr = ?, order_quantity = ?, order_price = ?, order_state = ?, update_date = NOW() "
				+ "WHERE order_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, (int) map.get("orderNo"));
			stmt.setString(2, (String) map.get("orderAddr"));
			stmt.setInt(3, (int) map.get("orderQuantity"));
			stmt.setInt(4, (int) map.get("orderPrice"));
			stmt.setString(5, (String) map.get("orderState"));
			stmt.setInt(6, (int) map.get("orderNo"));
			System.out.println(stmt + "<-- stmt - insertOrdersOne");
			row = stmt.executeUpdate();
			System.out.println(row + "<-- insertOrdersOne에서 실행된 row의 수");
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 주문 상세 보기
	public Map<String, Object> selectOrdersOne(Connection conn, int orderNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println("selectOrdersOne 파라미터 디버깅 --> orderNo :" + orderNo);
		// 리턴하려는 변수 생성
		Map<String, Object> map = null; // 다형성
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT "
				+ "o.order_no orderNo, o.customer_id customerId,  o.order_addr orderAddr, o.order_state orderState, "
				+ "o.update_date updateDate, o.create_date createDate "
				+ ", o.order_quantity orderQuantity, o.order_price orderPrice, g.goods_name goodsName, g.sold_out soldOut "
				+ ", c.customer_name customerName, c.customer_telephone customerTelephone " + "FROM orders o "
				+ "INNER JOIN goods g USING (goods_no) " + "INNER JOIN customer c USING (customer_id) "
				+ "WHERE o.order_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			System.out.println(stmt + "<-- stmt - selectOrdersOne");
			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs - selectOrdersOne");
			if (rs.next()) { // 정상적으로 실행된다면
				// HashMap 객체로 생성
				map = new HashMap<>();
				// map에 key와 value 데이터 셋팅
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("orderState", rs.getString("orderState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderTotal", rs.getInt("orderQuantity") * rs.getInt("orderPrice"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				System.out.println(map + "<-- map - selectOrdersOne");
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
		return map;
	}

	// 라스트 페이지
	public int selectOrdersLastPage(Connection conn, int rowPerPage) throws SQLException {
		// 파라미터 디버깅
		System.out.println(rowPerPage + "<-- rowPerPage");
		// 리턴할 변수 선언 및 초기화
		int lastPage = 0;

		String sql = "SELECT count(*) count FROM orders";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			// 디버깅
			if (rs.next()) {
				totalCount = rs.getInt("count");
				System.out.println(totalCount + "<--totalCount 상품 전체갯수");
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
		if (totalCount % rowPerPage == 0) { // 30/10 = 3
			lastPage = totalCount / rowPerPage;
		} else { // 32/10 =4
			lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
		}
		return lastPage;
	}

	// 전체 주문 목록 - 관리자 페이지
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow)
			throws SQLException {
		// 파라미터 디버깅
		System.out.println("selectOrdersList 파라미터 디버깅 --> rowPerPage :" + rowPerPage + "  beginRow : " + beginRow);
		// 주문 목록을 담을 list 생성
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT o.order_no orderNo, g.goods_no goodsNo, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_state orderState, o.customer_id customerId, o.update_date updateDate, o.create_date createDate "
				+ "FROM orders o " + "INNER JOIN goods g " + "USING (goods_no) " + "ORDER BY o.create_date DESC "
				+ "LIMIT ?,?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- stmt - selectOrdersList.jsp ");
			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs - selectOrdersList.jsp ");
			while (rs.next()) { // rs가 실행된다면
				// Key, Value가 String,Object 타입인 HashMap인스턴스를 만듬
				Map<String, Object> map = new HashMap<String, Object>();
				// map에 데이터 넣기
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("orderTotal", rs.getInt("orderQuantity") * rs.getInt("orderPrice"));
				map.put("orderState", rs.getString("orderState"));
				map.put("customerId", rs.getString("customerId"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				// 리스트에 map데이터 삽입
				list.add(map);
			}
		} finally {
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
