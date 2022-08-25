package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Employee;

public class EmployeeDAO {

	// 라스트 페이지
	public int selectEmployeeLastPage(Connection conn, int rowPerPage) throws Exception {
		// 전송된 값 디버깅
		System.out.println(rowPerPage + "<-- rowPerPage");
		// 리턴할 변수 선언 및 초기화
		int lastPage = 0;
		int totalCount = 0; // 총 직원 수
		String sql = "SELECT count(*) count FROM employee";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt #selectEmployeeLastPage");
			rs = stmt.executeQuery();
			if (rs.next()) { // rs가 실행된다면
				totalCount = rs.getInt("count");
				System.out.println(totalCount + "<--totalCount 전체직원 인원");
				// lastPage 연산 - 올림해서 lastPage구하기
				lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
				System.out.println(lastPage + "<-- lastPage - selectEmployeeLastPage");
			} else {
				System.out.println("selectEmployeeLastPage totalCount 구하기 실패");
				throw new Exception();
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return lastPage;
	}

	// 회원 접근권한 변경
	public int modifyEmployeeActive(Connection conn, String active, String adminId) throws SQLException {
		// 리턴할 변수 선언 및 초기화
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE employee SET active= ? WHERE employee_id = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, active);
			stmt.setString(2, adminId);
			System.out.println(stmt + "<-- stmt -modifyEmployeeActive ");

			row = stmt.executeUpdate();
			// 디버깅
			System.out.println(row + "<-- row - modifyEmployeeActive ");
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 사원 리스트
	public ArrayList<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		// 파라미터 디버깅
		System.out.println(rowPerPage + "<--rowPerPage");
		System.out.println(beginRow + "<--beginRow");
		// DB에서 select한 직원들의 정보를 담을 list객체
		ArrayList<Employee> list = new ArrayList<Employee>();
		// 로그인한 Employee의 정보를 받아오기 위한 sql
		String sql = "SELECT employee_id employeeId, employee_name employeeName, update_date updateDate, create_date createDate, active FROM employee ORDER BY update_date DESC LIMIT ?,?";
		// DB연동
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- stmt -EmployeeDAO.selectEmployeeList ");
			rs = stmt.executeQuery();

			while (rs.next()) {
				System.out.println(rs + "<-- rs 실행됨 -selectEmployeeList ");
				// 정상적으로 연결된다면 employee 객체 생성
				Employee e = new Employee();
				e.setEmployeeId(rs.getString("employeeId"));
				e.setEmployeeName(rs.getString("employeeName"));
				e.setCreateDate(rs.getString("createDate"));
				e.setUpdateDate(rs.getString("updateDate"));
				e.setActive(rs.getString("active"));
				// System.out.println(e + "<-- e Employee 정보");
				list.add(e);
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
		return list;
	}

	// 회원가입
	public int insertEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// DB연동
		System.out.println(conn + "<-- conn - insertEmployee(){}");

		String sql = "INSERT INTO employee (employee_id, employee_pass, employee_name, update_date, create_date) VALUES (?, PASSWORD(?), ?, now(), now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
		stmt.setString(3, paramEmployee.getEmployeeName());
		// 디버깅
		System.out.println(stmt + "<-- stmt - insertEmployee(){}");
		row = stmt.executeUpdate();
		if (stmt != null) {
			stmt.close();
		}
		// 디버깅
		System.out.println(row + "<-- row - insertEmployee");
		return row;
	}

	// 회원 탈퇴
	// EmployeerService.removeEmployee(Employee paramEmployee)가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// DB연동
		System.out.println(conn + "<-- conn - deleteEmployee(){}");

		String sql = "DELETE FROM employee WHERE employee_id=? AND employee_pass=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
		// 디버깅
		System.out.println(stmt + "<-- stmt - deleteEmployee(){}");
		row = stmt.executeUpdate();
		// 디버깅
		System.out.println(row + "<-- row");
		return row;
	}

	// 로그인
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee)
			throws ClassNotFoundException, SQLException {
		// getConnection을 사용하기 위한 DBUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		// 새로 받아오는 객체
		Employee loginEmployee = null;
		// 로그인한 Employee의 정보를 받아오기 위한 sql
		String sql = "SELECT employee_id employeeId, employee_name employeeName, update_date updateDate, create_date createDate, active FROM employee where employee_id=? and employee_pass=PASSWORD(?)";
		// DB연동
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("selectEmployeeByIdAndPw - DB연동 성공");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();

			if (rs.next()) {
				System.out.println(rs + "<-- rs 실행됨");
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
				loginEmployee.setUpdateDate(rs.getString("updateDate"));
				loginEmployee.setCreateDate(rs.getString("createDate"));
				loginEmployee.setActive(rs.getString("active"));
				System.out.println("selectEmployeeByIdAndPw에 데이터 셋팅 성공");
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
			System.out.println("selectEmployeeByIdAndPw.jsp - DB연동 해제");
		}
		return loginEmployee;
	}
}
