package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;

public class CustomerDAO {
	// 로그인
	public Customer loginAction(Customer customer) throws ClassNotFoundException, SQLException {
		DBUtil dbUtil = new DBUtil();
		// 새로 받아오는 객체
		Customer customer2 = null;
		String sql = "SELECT customer_id customerId, customer_pass customerPass, customer_name customerName FROM customer where customer_id=? and customer_pass=PASSWORD(?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("DB연동 성공");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println(rs + "<-- rs 실행됨");
				customer2 = new Customer();
				customer2.setCustomerId(rs.getString("customerId"));
				customer2.setCustomerName(rs.getString("customerName"));
				System.out.println("customer2에 데이터 셋팅 성공");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return customer2;
	}
}
