package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;

public class CustomerDAO {
	//회원 탈퇴
	//CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int deleteCustomer(Connection conn,Customer paramCustomer) throws SQLException {
		//리턴할 변수 선언
		int row = 0;
		//DB연동
		System.out.println(conn + "<-- conn - deleteCustomer(){}");
		
		String sql = "DELETE FROM customer WHERE customer_id=? AND customer_pass=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		//디버깅
		System.out.println(stmt+"<-- stmt - deleteCustomer(){}");
		row = stmt.executeUpdate();
		//디버깅
		System.out.println(row+"<-- row");
		return row;	
	}
	
	// 로그인
	public Customer selectCustomerByIdAndPw(Customer customer) throws ClassNotFoundException, SQLException {
		// getConnection을 사용하기 위한 DBUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		// 새로 받아오는 객체
		Customer selectCustomerByIdAndPw = null;
		// 로그인한 customer의 정보를 받아오기 위한 sql
		String sql = "SELECT customer_id customerId, customer_pass customerPass, customer_name customerName FROM customer where customer_id=? and customer_pass=PASSWORD(?)";
		// DB연동
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("selectCustomerByIdAndPw.jsp - DB연동 성공");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			if (rs.next()) { // rs가 실행된다면
				System.out.println(rs + "<-- rs 실행됨");
				selectCustomerByIdAndPw = new Customer();
				selectCustomerByIdAndPw.setCustomerId(rs.getString("customerId"));
				selectCustomerByIdAndPw.setCustomerName(rs.getString("customerName"));
				System.out.println("selectCustomerByIdAndPw에 데이터 셋팅 성공");
			}
		} finally {
			// DB연동 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			System.out.println("selectCustomerByIdAndPw.jsp - DB연동 해제");
		}
		return selectCustomerByIdAndPw;
	}
}
