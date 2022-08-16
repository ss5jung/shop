package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;

public class CustomerDAO {
	//임시 비밀번호 정보 수정
	public int updateCustomerPass(Connection conn, Customer customer) throws Exception {
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE  customer SET customer_pass=PASSWORD(?) WHERE customer_id= ? ";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerPass());
			stmt.setString(2, customer.getCustomerId());
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
			if(row == 0) {
				throw new Exception();
			}
		} finally {
			// DB자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	// 회원 강제 탈퇴
	public int deleteCustomerOne(Connection conn, String customerId) throws Exception {
		//리턴변수 생성
		int row = 0;
		//DB 
		String sql ="DELETE FROM customer WHERE customer_id= ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
			if(row == 0) {
				throw new Exception();
			}
		} finally {
			//DB 자원 해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	// 회원 정보 가져오기
		public Customer selectCustomerOne(Connection conn, String customerId) throws SQLException {
			//리턴객체 만들기
			Customer customer = new Customer();
			//DB 자원
			String sql ="SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer WHERE customer_id = ?";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				System.out.println(stmt + "<-- stmt");
				rs = stmt.executeQuery();
				if(rs.next()) {
					customer.setCustomerId(rs.getString("customerId"));
					customer.setCustomerName(rs.getString("customerName"));
					customer.setCustomerAddress(rs.getString("customerAddress"));
					customer.setCustomerTelephone(rs.getString("customerTelephone"));
					customer.setUpdateDate(rs.getString("updateDate"));
					customer.setCreateDate(rs.getString("createDate"));
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
			return customer;
		}
		
	// 라스트 페이지
	public int selectCustomerLastPage(Connection conn, int rowPerPage) throws SQLException {
		// 파라미터 디버깅
		System.out.println(rowPerPage + "<-- rowPerPage - selectCustomerLastPage");
		// 리턴할 변수 선언 및 초기화
		int lastPage = 0;

		String sql = "SELECT count(*) count FROM customer";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs");
			// 디버깅
			if (rs.next()) {
				totalCount = rs.getInt("count");
				System.out.println(totalCount + "<--totalCount 전체 고객수");
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

		// lastPage 연산 - 올림해서 lastPage구하기
		lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
		return lastPage;
	}

	// 고객 목록
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		// 파라미터 디버깅
		System.out.println("selectCustomerList 파라미터 : rowPerPage ->" + rowPerPage + "beginRow ->" + beginRow);
		// DB자원 생성
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate FROM customer ORDER BY create_date DESC LIMIT ?,?";
		// 고객 리스트를 담을 ArrayList객체 생성
		List<Customer> list = new ArrayList<>();
		try {
			// DB 객체 설정
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- stmt - selectCustomerList");
			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs");
			while (rs.next()) {
				// 한 명의 고객 정보를 넣을 customer 객체 생성
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setUpdateDate(rs.getString("updateDate"));
				customer.setCreateDate(rs.getString("createDate"));
				list.add(customer);
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 회원가입
	public int insertCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// DB연동
		System.out.println(conn + "<-- conn - insertCustomer(){}");

		String sql = "INSERT INTO customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES (?, PASSWORD(?), ?, ?, ?, now(), now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		stmt.setString(3, paramCustomer.getCustomerName());
		stmt.setString(4, paramCustomer.getCustomerAddress());
		stmt.setString(5, paramCustomer.getCustomerTelephone());
		// 디버깅
		System.out.println(stmt + "<-- stmt - insertCustomer(){}");
		row = stmt.executeUpdate();
		if (stmt != null) {
			stmt.close();
		}
		// 디버깅
		System.out.println(row + "<-- row - insertCustomer");
		return row;
	}

	// 회원 탈퇴
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// DB연동
		System.out.println(conn + "<-- conn - deleteCustomer(){}");

		String sql = "DELETE FROM customer WHERE customer_id=? AND customer_pass=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		// 디버깅
		System.out.println(stmt + "<-- stmt - deleteCustomer(){}");
		row = stmt.executeUpdate();
		if (stmt != null) {
			stmt.close();
		}
		// 디버깅
		System.out.println(row + "<-- row");
		return row;
	}

	// 로그인
	public Customer selectCustomerByIdAndPw(Connection conn, Customer customer)
			throws ClassNotFoundException, SQLException {
		// getConnection을 사용하기 위한 DBUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		// 새로 받아오는 객체
		Customer selectCustomerByIdAndPw = null;
		// 로그인한 customer의 정보를 받아오기 위한 sql
		String sql = "SELECT customer_id customerId, customer_pass customerPass, customer_name customerName FROM customer where customer_id=? and customer_pass=PASSWORD(?)";
		// DB연동
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
